Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEDFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9392086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6ovzVGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF1WUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:20:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1WUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:20:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMEvxp069447;
        Fri, 28 Jun 2019 22:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wlA5yIE3KkyPJRHt5+JVLcfxxUTSji5m9V7l5Fy6b0w=;
 b=G6ovzVGNiMApS+ZuW2zu25VN8j/QUTwpKRSifGTlTdPPiFJ6LCdrxtoy7JNAUemshGHH
 Q0uQ4qKK8MLNyiDHkiUGZ4EorpZDWTQZ4vRu1OjqObX6nrtYapbE+fmt5uO0a+A+Th/H
 FbllWqZeSYii6+/oV1zrQLC+BaRMGmYUpKKZYt7vrM1UcpvYz5WsxVZLESriF5FJ260z
 B421Rz25NFWT/9zXZQsw/1RNo4CFN6zEvPnu+HDyQ4Mb/57DhfQIfv+7jhvAAEwTm0wP
 3nVSq2T3+R4hqqfYuqU2ac5OED3VSgbG9xaWq8CSbOdH/+wFlZpGcZVs060peMXjaKMp xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqym48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:19:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SMJXOx078821;
        Fri, 28 Jun 2019 22:19:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7e62sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:19:33 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SMJQTg023167;
        Fri, 28 Jun 2019 22:19:26 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 15:19:26 -0700
Subject: Re: [PATCH v3 3/7] sched: rotate the cpu search window for better
 spread
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-4-subhra.mazumdar@oracle.com>
 <f8b185ca-ae3e-8c54-5381-e9104be4954c@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <0550623d-f8f5-ac73-7baa-7506636d952a@oracle.com>
Date:   Fri, 28 Jun 2019 15:14:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f8b185ca-ae3e-8c54-5381-e9104be4954c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280255
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 11:36 AM, Parth Shah wrote:
> Hi Subhra,
>
> I ran your patch series on IBM POWER systems and this is what I have observed.
>
> On 6/27/19 6:59 AM, subhra mazumdar wrote:
>> Rotate the cpu search window for better spread of threads. This will ensure
>> an idle cpu will quickly be found if one exists.
>>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   kernel/sched/fair.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b58f08f..c1ca88e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   	u64 avg_cost, avg_idle;
>>   	u64 time, cost;
>>   	s64 delta;
>> -	int cpu, limit, floor, nr = INT_MAX;
>> +	int cpu, limit, floor, target_tmp, nr = INT_MAX;
>>
>>   	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>   	if (!this_sd)
>> @@ -6219,9 +6219,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   		}
>>   	}
>>
>> +	if (per_cpu(next_cpu, target) != -1)
>> +		target_tmp = per_cpu(next_cpu, target);
>> +	else
>> +		target_tmp = target;
>> +
>>   	time = local_clock();
>>
>> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
>> +	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
>> +		per_cpu(next_cpu, target) = cpu;
> This leads to a problem of cache hotness.
> AFAIU, in most cases, `target = prev_cpu` of the task being woken up and
> selecting an idle CPU nearest to the prev_cpu is favorable.
> But since this doesn't keep track of last idle cpu per task, it fails to find the
> nearest possible idle CPU in cases when the task is being woken up after other
> scheduled task.
>
I had tested hackbench on SPARC SMT8 (see numbers in cover letter) and
showed improvement with this. Firstly it's a tradeoff between cache effects
vs time spent in searching idle CPU, and both x86 and SPARC numbers showed
tradeoff is worth it. Secondly there is a lot of cache affinity logic
in the beginning of select_idle_sibling. If select_idle_cpu is still called
that means we are past that and want any idle cpu. I don't think waking up
close to the prev cpu is the intention for starting search from there,
rather it is to spread threads across all cpus so that no cpu gets
victimized as there is no atomicity. Prev cpu just acts a good seed to do
the spreading.

Thanks,
Subhra
