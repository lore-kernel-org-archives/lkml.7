Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57450C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DEF208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z73awaPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfF1W0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:26:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF1W0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:26:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMOl0S075632;
        Fri, 28 Jun 2019 22:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=oqSUoiJdWLE36BvKu2xAdYA8FMkDEKWgkJvdTjKfEHY=;
 b=z73awaPo3Rlm5lk1iPDx25iqF0jquEENOqT1y1Cw4S1KmS89toWRr5Q4gu0U+jz0PjiP
 ZvBtaiwhJTBKKOh4Pe1ac2iKrKbBNSFcUrAXZjdWzLKrZFcHYOgXdokaLmYbrRVjhGwo
 VSIOn05/wEj0yW682HoO/8TZ28xyqYuYeZj359GbDtAN1i/6BXUAwstzT7No6JkPDFFY
 F5EuftxCmnAfM2dhRoL02TQ3cEqre6lRq0klHJQObMwRL0K5Efc5Qlf9M3KQYmOOzfBh
 Diii/tydU2yDq9bj3mHSjUL3f/S8gH83ooRCLgJFrswRS2dqwcfO7erabdRb+PiWU4nb vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqymh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:26:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMPXBL090087;
        Fri, 28 Jun 2019 22:26:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7e64ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:26:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SMQEq0026256;
        Fri, 28 Jun 2019 22:26:14 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 15:26:13 -0700
Subject: Re: [PATCH v3 1/7] sched: limit cpu search in select_idle_cpu
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-2-subhra.mazumdar@oracle.com>
 <68baf89b-6d77-4eff-3aac-f96b72f98bae@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e8dc35a9-f46a-b83d-fb7d-f8284ba712c6@oracle.com>
Date:   Fri, 28 Jun 2019 15:21:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <68baf89b-6d77-4eff-3aac-f96b72f98bae@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280256
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 11:47 AM, Parth Shah wrote:
>
> On 6/27/19 6:59 AM, subhra mazumdar wrote:
>> Put upper and lower limit on cpu search of select_idle_cpu. The lower limit
>> is amount of cpus in a core while upper limit is twice that. This ensures
>> for any architecture we will usually search beyond a core. The upper limit
>> also helps in keeping the search cost low and constant.
>>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   kernel/sched/fair.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index f35930f..b58f08f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   	u64 avg_cost, avg_idle;
>>   	u64 time, cost;
>>   	s64 delta;
>> -	int cpu, nr = INT_MAX;
>> +	int cpu, limit, floor, nr = INT_MAX;
>>
>>   	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>   	if (!this_sd)
>> @@ -6206,10 +6206,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>
>>   	if (sched_feat(SIS_PROP)) {
>>   		u64 span_avg = sd->span_weight * avg_idle;
>> -		if (span_avg > 4*avg_cost)
>> +		floor = cpumask_weight(topology_sibling_cpumask(target));
>> +		if (floor < 2)
>> +			floor = 2;
>> +		limit = floor << 1;
> Is upper limit an experimental value only or it has any arch specific significance?
> Because, AFAIU, systems like POWER9 might have benefit for searching for 4-cores
> due to its different cache model. So it can be tuned for arch specific builds then.
The lower bound and upper bound were 1 core and 2 core respectively. That
is done as to search beyond one core and at the same time not to search
too much. It is heuristic that seemed to work well on all archs coupled
with the moving window mechanism. Does 4 vs 2 make any difference on your
POWER9? AFAIR it didn't on SPARC SMT8.
>
> Also variable names can be changed for better readability.
> floor -> weight_clamp_min
> limit -> weight_clamp_max
> or something similar
OK.

Thanks,
Subhra
>
>
>> +		if (span_avg > floor*avg_cost) {
>>   			nr = div_u64(span_avg, avg_cost);
>> -		else
>> -			nr = 4;
>> +			if (nr > limit)
>> +				nr = limit;
>> +		} else {
>> +			nr = floor;
>> +		}
>>   	}
>>
>>   	time = local_clock();
>>
>
> Best,
> Parth
>
