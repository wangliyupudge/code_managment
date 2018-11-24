select 
count (distinct user_id) as user_id_cnt
,(sum(calcu_credit)-sum(baitiao_credit))/count(user_id) as avg_credit_promote
,case when baitiao_credit >= 0  and baitiao_credit <= 500 then '0~500'
      when baitiao_credit >=501 and baitiao_credit <= 1000 then '500~1000'
      when baitiao_credit >=1001 and baitiao_credit <= 1500 then '1000~1500'
      when baitiao_credit >=1501 and baitiao_credit <= 2000 then '1500~2000'
      when baitiao_credit >=2001 and baitiao_credit <= 2500 then '2000~2500'
      when baitiao_credit >=2501 and baitiao_credit <= 3000 then '2500~3000'
      when baitiao_credit >=3001 and baitiao_credit <= 3500 then '3000~3500'
      when baitiao_credit >=3501 and baitiao_credit <= 4000 then '3500~4000'
      when baitiao_credit >=4001 and baitiao_credit <= 4500 then '4000~4500'
      when baitiao_credit >=4501 and baitiao_credit <= 5000 then '4500~5000'
      when baitiao_credit >=5001 and baitiao_credit <= 5500 then '5000~5500'
      when baitiao_credit >=5501 and baitiao_credit <= 6000 then '5500~6000'
      when baitiao_credit >=6001 and baitiao_credit <= 6500 then '6000~6500'
      when baitiao_credit >=6501 and baitiao_credit <= 7000 then '6500~7000'
      when baitiao_credit >=7001 and baitiao_credit <= 7500 then '7000~7500'
      when baitiao_credit >=7501 and baitiao_credit <= 8000 then '7500~8000'
      when baitiao_credit >=8001 and baitiao_credit <= 8500 then '8000~8500'
      when baitiao_credit >=8501 and baitiao_credit <= 9000 then '8500~9000'
      when baitiao_credit >=9001 and baitiao_credit <= 9500 then '9000~9500'
      when baitiao_credit >=9500 and baitiao_credit <= 10000 then '9500~10000'
      else 'other' end as baitiao_credit_type
,case when calcu_credit >= 0  and calcu_credit <= 500 then '0~500'
      when calcu_credit >=501 and calcu_credit <= 1000 then '500~1000'
      when calcu_credit >=1001 and calcu_credit <= 1500 then '1000~1500'
      when calcu_credit >=1501 and calcu_credit <= 2000 then '1500~2000'
      when calcu_credit >=2001 and calcu_credit <= 2500 then '2000~2500'
      when calcu_credit >=2501 and calcu_credit <= 3000 then '2500~3000'
      when calcu_credit >=3001 and calcu_credit <= 3500 then '3000~3500'
      when calcu_credit >=3501 and calcu_credit <= 4000 then '3500~4000'
      when calcu_credit >=4001 and calcu_credit <= 4500 then '4000~4500'
      when calcu_credit >=4501 and calcu_credit <= 5000 then '4500~5000'
      when calcu_credit >=5001 and calcu_credit <= 5500 then '5000~5500'
      when calcu_credit >=5501 and calcu_credit <= 6000 then '5500~6000'
      when calcu_credit >=6001 and calcu_credit <= 6500 then '6000~6500'
      when calcu_credit >=6501 and calcu_credit <= 7000 then '6500~7000'
      when calcu_credit >=7001 and calcu_credit <= 7500 then '7000~7500'
      when calcu_credit >=7501 and calcu_credit <= 8000 then '7500~8000'
      when calcu_credit >=8001 and calcu_credit <= 8500 then '8000~8500'
      when calcu_credit >=8501 and calcu_credit <= 9000 then '8500~9000'
      when calcu_credit >=9001 and calcu_credit <= 9500 then '9000~9500'
      when calcu_credit >=9500 and calcu_credit <= 10000 then '9500~10000'
      else 'other' end as calcu_credit_type
from
(select 
user_id,
 case when baitiao_credit*gue_xishu*td_xishu*inloan_xishu <= 200 then 200
      when baitiao_credit*gue_xishu*td_xishu*inloan_xishu >= 3000 then 3000
      else baitiao_credit*gue_xishu*td_xishu*inloan_xishu 
      end as calcu_credit 
,baitiao_credit
 
from
(select
    user_id,
    case WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '1~10' and zm_score_type = '600~650' then 0.2
     when qd_type = 'A1~A3' and fina_order_cnt_type = '11~30' and zm_score_type = '600~650' then 0.4
     when qd_type = 'A1~A3' and fina_order_cnt_type = '30+' and zm_score_type = '600~650' then 0.7
     WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '1~10' and zm_score_type = '650~700' then 0.4
     WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '11~30' and zm_score_type = '650~700' then 0.6
     WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '30+' and zm_score_type = '650~700' then 0.8
     WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '1~10' and zm_score_type = '700+' then 0.7
     WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '11~30' and zm_score_type = '700+' then 0.9
     WHEN qd_type = 'A1~A3' and fina_order_cnt_type = '30+' and zm_score_type = '700+' then 1.0
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '1~10' and zm_score_type = '600~650' then 0
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '11~30' and zm_score_type = '600~650' then 0.2
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '30+' and zm_score_type = '600~650' then 0.4
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '1~10' and zm_score_type = '650~700' then 0.1
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '11~30' and zm_score_type = '650~700' then 0.3
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '30+' and zm_score_type = '650~700' then 0.5
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '1~10' and zm_score_type = '700+' then 0.4
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '11~30' and zm_score_type = '700+' then 0.5
     WHEN qd_type = 'A4~A5' and fina_order_cnt_type = '30+' and zm_score_type = '700+' then 0.6
     else 0 end as gue_xishu
     , baitiao_credit
     , case when td_type = '0~5' then 1.0
           when td_type = '6~10' then 0.7
           else 0 end as td_xishu
     , case when inloan_type = '在贷' then 1
           when inloan_type = '非在贷' then 1-fix_limit_usage end as inloan_xishu
from
    (select
        risk.user_id
, huabei_type
, td_type
, qd_type
, fina_order_cnt_type
, inloan_type
, zm_score_type
, das_type
, bank_type
, fix_limit_usage
, baitiao_credit
    from
        (select
            user_id
    , case when huabei_credit is null then '无花呗'
    else '有花呗' end as huabei_type
        , case when td_multi_cnt is null or td_multi_cnt <= 5 then '0~5'
        when td_multi_cnt >= 6 and td_multi_cnt <= 10 then '6~10'
        else '>10'
        end as td_type
        , case when qd_level in ('A1','A2','A3') then 'A1~A3'
        when qd_level IN ('A4','A5') then 'A4~A5'
        else 'other' end as qd_type
    , case when (fina_order_cnt is null or fina_order_cnt = 0) then '0'
    when fina_order_cnt >= 1 and fina_order_cnt <= 10 then '1~10'
    when fina_order_cnt >= 11 and fina_order_cnt <= 30 then '11~30'
    else '30+' end as fina_order_cnt_type
    , case when (inloan_capital is null or inloan_capital = 0) then '非在贷'
    else '在贷' end as inloan_type
    , case when  (zm_score is null or zm_score = 0) then '0'
    when zm_score >= 700 then '>700'
    when zm_score >= 650 and zm_score <= 699 then '650~700'
    when zm_score >= 600 and zm_score <= 649 then '600~650'
    when zm_score >= 550 and zm_score <= 599 then '550~600'
    else '<550' end as zm_score_type
        from dw.mds_user_risk_info_a
        where plat_type = 2
            and
            dt = '2018-11-14'
)
risk
        right JOIN
        (
    select user_id
    , is_pass
        from
            tmp.tmp_risk_rule_wangliyu_20181115_181023kxd
        where is_pass = 1
)
kexiadan_type
        on kexiadan_type.user_id = risk.user_id
        left JOIN
        (
            select dt
            , user_id
            , case when last_6m_avg_asset_total_value is null then '无das'
            else '有das' end as das_type
        from
            (select user_id 
      , dt
        ---取出DAS分数，根据字段长度来区分长短两种情况
      , case when length(result_param) < 700 then        ---小于700的情况
       cast(json_extract(result_param,'$.vars[3].value') as varchar )  
       when length(result_param) >=700 and length(result_param) <1000  ---大于700小于1000的情况
       then cast(json_extract(result_param,'$.vars[4].value') as varchar )
       else cast(json_extract(result_param,'$.vars[20].value') as varchar )    
       end as last_6m_avg_asset_total_value
            from dw.dwd_risk_res_log_d
            where provider_code = 'p080005'
 ) )
as das
        on das.user_id = risk.user_id

        left JOIN

        (
            select distinct user_id
            , case when tradeamount is null then '无银行卡'
            else '有银行卡' end as bank_type
        from
            tmp.tmp_risk_crawl_bank_log_in_20180830
            inner JOIN(
            select distinct user_id as usr_id
            from
                tmp.tmp_risk_crawl_bank_log_ex_20180830
           )m
            on user_id =m.usr_id

        )
bank

        on bank.user_id = risk.user_id

        left JOIN
        (
            select fix_use_limit/fix_limit as fix_limit_usage
            , user_id
            , fix_limit as baitiao_credit 
            from dw.mds_user_credit_info_a
            where dt = '2018-11-14'
                and plat_type = 2
                and biz_kind = 1
                and fix_limit != 0
)
credit
on risk.user_id = credit.user_id
group by risk.user_id
, huabei_type
, td_type
, qd_type
, fina_order_cnt_type
, inloan_type
, zm_score_type
, das_type
, bank_type
, fix_limit_usage
, baitiao_credit
)
)
)
group by 
case when calcu_credit >= 0  and calcu_credit <= 500 then '0~500'
      when calcu_credit >=501 and calcu_credit <= 1000 then '500~1000'
      when calcu_credit >=1001 and calcu_credit <= 1500 then '1000~1500'
      when calcu_credit >=1501 and calcu_credit <= 2000 then '1500~2000'
      when calcu_credit >=2001 and calcu_credit <= 2500 then '2000~2500'
      when calcu_credit >=2501 and calcu_credit <= 3000 then '2500~3000'
      when calcu_credit >=3001 and calcu_credit <= 3500 then '3000~3500'
      when calcu_credit >=3501 and calcu_credit <= 4000 then '3500~4000'
      when calcu_credit >=4001 and calcu_credit <= 4500 then '4000~4500'
      when calcu_credit >=4501 and calcu_credit <= 5000 then '4500~5000'
      when calcu_credit >=5001 and calcu_credit <= 5500 then '5000~5500'
      when calcu_credit >=5501 and calcu_credit <= 6000 then '5500~6000'
      when calcu_credit >=6001 and calcu_credit <= 6500 then '6000~6500'
      when calcu_credit >=6501 and calcu_credit <= 7000 then '6500~7000'
      when calcu_credit >=7001 and calcu_credit <= 7500 then '7000~7500'
      when calcu_credit >=7501 and calcu_credit <= 8000 then '7500~8000'
      when calcu_credit >=8001 and calcu_credit <= 8500 then '8000~8500'
      when calcu_credit >=8501 and calcu_credit <= 9000 then '8500~9000'
      when calcu_credit >=9001 and calcu_credit <= 9500 then '9000~9500'
      when calcu_credit >=9500 and calcu_credit <= 10000 then '9500~10000'
      else 'other' end