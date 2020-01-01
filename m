Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A575FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850782072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgAASz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:55:59 -0500
Received: from foss.arm.com ([217.140.110.172]:41758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgAASz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:55:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF9F31B;
        Wed,  1 Jan 2020 10:55:58 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BF523F68F;
        Wed,  1 Jan 2020 10:55:56 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix sgc->{min,max}_capacity miscalculate
To:     Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
 <ec390ddb-c015-a467-2f88-47c00f23e27b@arm.com>
 <20200101141329.GA12809@iZj6chx1xj0e0buvshuecpZ>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e41793bc-daaf-b224-1f3d-a3e468072592@arm.com>
Date:   Wed, 1 Jan 2020 18:55:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200101141329.GA12809@iZj6chx1xj0e0buvshuecpZ>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/2020 14:13, Peng Liu wrote:
>> ---
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 08a233e97a01..9f6c015639ef 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7773,8 +7773,8 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>>  		 */
>>  
>>  		for_each_cpu(cpu, sched_group_span(sdg)) {
>> -			struct sched_group_capacity *sgc;
>>  			struct rq *rq = cpu_rq(cpu);
>> +			unsigned long cpu_cap;
>>  
>>  			/*
>>  			 * build_sched_domains() -> init_sched_groups_capacity()
>> @@ -7787,15 +7787,15 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>>  			 * This avoids capacity from being 0 and
>>  			 * causing divide-by-zero issues on boot.
>>  			 */
>> -			if (unlikely(!rq->sd)) {
>> -				capacity += capacity_of(cpu);
>> -			} else {
>> -				sgc = rq->sd->groups->sgc;
>> -				capacity += sgc->capacity;
>> -			}
>> +			if (unlikely(!rq->sd))
>> +				cpu_cap = capacity_of(cpu);
> 
> --------------------------------------------------------------
>> +			else
>> +				cpu_cap = rq->sd->groups->sgc->capacity;
> 
> sgc->capacity is the *sum* of all CPU's capacity in that group, right?

Right

> {min,max}_capacity are per CPU variables(*part* of a group). So we can't
> compare *part* to *sum*. Am I overlooking something? Thanks.
> 

AIUI rq->sd->groups->sgc->capacity should be the capacity of the rq's CPU
(IOW the groups here should be made of single CPUs).

This should be true regardless of overlapping domains, since they sit on top
of the regular domains. Let me paint an example with a simple 2-core SMT2
system:

  MC  [          ]
  SMT [    ][    ]
       0  1  2  3

cpu_rq(0)->sd will point to the sched_domain of CPU0 at SMT level (it is the
"base domain", IOW the lowest domain in the topology hierarchy). Its groups
will be:

  {0} ----> {1}
    ^       /
     `-----'

and sd->groups will point at the group spanning the "local" CPU, in our case
CPU0, and thus here will be a group containing only CPU0.


I do not know why sched_group_capacity is used here however. As I understand
things, we could use cpu_capacity() unconditionally.


>> +
>> +			min_capacity = min(cpu_cap, min_capacity);
>> +			max_capacity = max(cpu_cap, max_capacity);
>>  
>> -			min_capacity = min(capacity, min_capacity);
>> -			max_capacity = max(capacity, max_capacity);
>> +			capacity += cpu_cap;
>>  		}
>>  	} else  {
>>  		/*
