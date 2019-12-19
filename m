Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC51C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD5206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSPQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:16:30 -0500
Received: from foss.arm.com ([217.140.110.172]:39878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLSPQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:16:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F761FB;
        Thu, 19 Dec 2019 07:16:29 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1B73F718;
        Thu, 19 Dec 2019 07:16:27 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191218154402.GF3178@techsingularity.net>
 <20191219144539.GA19614@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <29bf4c69-b961-0482-7582-d6f1e09e997a@arm.com>
Date:   Thu, 19 Dec 2019 15:16:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219144539.GA19614@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 14:45, Vincent Guittot wrote:
>> @@ -8680,7 +8676,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>  			env->migration_type = migrate_task;
>>  			lsub_positive(&nr_diff, local->sum_nr_running);
>>  			env->imbalance = nr_diff >> 1;
>> -			return;
>> +			goto out_spare;
> 
> Why are you doing this only for prefer_sibling case ? That's probably the default case of most of numa system but you should also consider others case too.
> 

I got confused by that as well but it's not just prefer_sibling actually;
there are cases where we enter the group_has_spare but none of its
nested if blocks, so we fall through to out_spare.

>> @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>  		env->migration_type = migrate_task;
>>  		env->imbalance = max_t(long, 0, (local->idle_cpus -
>>  						 busiest->idle_cpus) >> 1);
>> +
>> +out_spare:
>> +		/*
>> +		 * Whether balancing the number of running tasks or the number
>> +		 * of idle CPUs, consider allowing some degree of imbalance if
>> +		 * migrating between NUMA domains.
>> +		 */
>> +		if (env->sd->flags & SD_NUMA) {
>> +			unsigned int imbalance_adj, imbalance_max;
>> +
>> +			/*
>> +			 * imbalance_adj is the allowable degree of imbalance
>> +			 * to exist between two NUMA domains. It's calculated
>> +			 * relative to imbalance_pct with a minimum of two
>> +			 * tasks or idle CPUs.
>> +			 */
>> +			imbalance_adj = (busiest->group_weight *
>> +				(env->sd->imbalance_pct - 100) / 100) >> 1;
>> +			imbalance_adj = max(imbalance_adj, 2U);
>> +
>> +			/*
>> +			 * Ignore imbalance unless busiest sd is close to 50%
>> +			 * utilisation. At that point balancing for memory
>> +			 * bandwidth and potentially avoiding unnecessary use
>> +			 * of HT siblings is as relevant as memory locality.
>> +			 */
>> +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
>> +			if (env->imbalance <= imbalance_adj &&
>> +			    busiest->sum_nr_running < imbalance_max) {i
> 
> Shouldn't you consider the number of busiest->idle_cpus instead of the busiest->sum_nr_running ?
> 

I think it's better to hinge the cutoff on the busiest->sum_nr_running than
on busiest->idle_cpus. If you're balancing between big NUMA groups, you
could end up with a busiest->group_type == group_has_spare despite having
*some* of its CPUs overloaded (but still with
sg->sum_nr_running > sg->group_weight; simply because there's tons of CPUs).

> and you could simplify by 
> 
> 
> 	if ((env->sd->flags & SD_NUMA) &&
> 		((100 * busiest->group_weight) <= (env->sd->imbalance_pct * (busiest->idle_cpus << 1)))) {
> 			env->imbalance = 0;
> 			return;
> 	}
> 
> And otherwise it will continue with the current path
> 
> Also I'm a bit worry about using a 50% threshold that look a bit like a
> heuristic which can change depending of platform and the UCs that run of the
> system.
> 
> In fact i was hoping that we could use the numa_preferred_nid ? During the
> detach of tasks, we don't detach the task if busiest has spare capacity and
> preferred_nid of the task is busiest.
> 
> I'm going to run some tests to see the impact on my platform 
> 
> Regards,
> Vincent
> }
> 
> 
>> +				env->imbalance = 0;
>> +			}
>> +		}
>>  		return;
>>  	}
>>  
>>
>> -- 
>> Mel Gorman
>> SUSE Labs
