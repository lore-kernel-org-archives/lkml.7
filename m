Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A4124672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfLSLqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:46:13 -0500
Received: from foss.arm.com ([217.140.110.172]:37406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfLSLqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:46:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60F131B;
        Thu, 19 Dec 2019 03:46:11 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 940973F719;
        Thu, 19 Dec 2019 03:46:08 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191218154402.GF3178@techsingularity.net>
 <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
 <20191219100232.GY2844@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <83a9363b-a044-845a-d37c-bf2ca7c8a09e@arm.com>
Date:   Thu, 19 Dec 2019 11:46:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219100232.GY2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 10:02, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 06:50:52PM +0000, Valentin Schneider wrote:
>> I'm quite sure you have reasons to have written it that way, but I was
>> hoping we could squash it down to something like:
>> ---
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 08a233e97a01..f05d09a8452e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8680,16 +8680,27 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>  			env->migration_type = migrate_task;
>>  			lsub_positive(&nr_diff, local->sum_nr_running);
>>  			env->imbalance = nr_diff >> 1;
>> -			return;
>> +		} else {
>> +
>> +			/*
>> +			 * If there is no overload, we just want to even the number of
>> +			 * idle cpus.
>> +			 */
>> +			env->migration_type = migrate_task;
>> +			env->imbalance = max_t(long, 0, (local->idle_cpus -
>> +							 busiest->idle_cpus) >> 1);
>>  		}
>>  
>>  		/*
>> -		 * If there is no overload, we just want to even the number of
>> -		 * idle cpus.
>> +		 * Allow for a small imbalance between NUMA groups; don't do any
>> +		 * of it if there is at least half as many tasks / busy CPUs as
>> +		 * there are available CPUs in the busiest group
>>  		 */
>> -		env->migration_type = migrate_task;
>> -		env->imbalance = max_t(long, 0, (local->idle_cpus -
>> -						 busiest->idle_cpus) >> 1);
>> +		if (env->sd->flags & SD_NUMA &&
>> +		    (busiest->sum_nr_running < busiest->group_weight >> 1) &&
>> +		    (env->imbalance < busiest->group_weight * (env->sd->imbalance_pct - 100) / 100))
> 
> Note that this form allows avoiding the division. Every time I see that
> /100 I'm thinking we should rename and make imbalance_pct a base-2
> thing.
> 

Right, I kept the original form but we can turn that into

  env->imbalance * 100 < busiest->group_weight * (env->sd->imbalance_pct - 100)



As for the base-2 imbalance; I think you've mentioned that in the past.
Looking at check_cpu_capacity() as a lambda imbalance_pct user, we could
turn that from:

  rq->cpu_capacity * sd->imbalance_pct < rq->cpu_capacity_orig * 100

to:

  rq->cpu_capacity_orig - rq->cpu_capacity < rq->cpu_capacity_orig >> sd->imbalance_shift


And here we could just go with

  env->imbalance < busiest->group_weight >> sd->imbalance_shift


As for picking values, right now we have

  125 (default) / 117 (LLC domain) / 110 (SMT domain)

We could have

  >> 2 (25%), >> 3 (12.5%), >> 4 (6.25%).

It's not strictly equivalent but IMO the whole imbalance_pct thing isn't
very precise anyway; just needs to be good enough on a sufficient number of
topologies.



>> +				env->imbalance = 0;
>> +
>>  		return;
>>  	}
>>  
