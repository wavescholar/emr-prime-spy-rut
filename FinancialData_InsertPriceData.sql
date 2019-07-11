use financial_data;

drop table if exists price_temp;

create table price_temp(
DateOfPrice Date,
Open double,
High double,
Low double,
Close double,
Volume double,
AdjClose double
)ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE tblproperties ("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '${hiveconf:fileName}' OVERWRITE INTO TABLE price_temp;

insert into table ${hiveconf:basketTable}
select 
'${hiveconf:tickerName}' as tickerName,
DateOfPrice as Date,
Open as Open,
High as High,
Low as Low,
Close as Close,
Volume as Volume,
AdjClose as AdjClose 
from price_temp;



insert into table '${hiveconf:basketTable}_extern'
select 
'${hiveconf:tickerName}' as tickerName,
DateOfPrice,
Open as Open,
High as High,
Low as Low,
Close as Close,
Volume as Volume,
AdjClose as AdjClose 
from price_temp;

