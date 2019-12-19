Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F26C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A17222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSL4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:56:12 -0500
Received: from foss.arm.com ([217.140.110.172]:37512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfLSL4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:56:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9924F31B;
        Thu, 19 Dec 2019 03:56:11 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11EBB3F719;
        Thu, 19 Dec 2019 03:56:09 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191218154402.GF3178@techsingularity.net>
 <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
 <20191218225023.GG3178@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <383de0cc-ad84-4cc1-48d6-512e7d3ddaa8@arm.com>
Date:   Thu, 19 Dec 2019 11:56:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218225023.GG3178@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 22:50, Mel Gorman wrote:
>> I'm quite sure you have reasons to have written it that way, but I was
>> hoping we could squash it down to something like:
> 
> I wrote it that way to make it clear exactly what has changed, the
> thinking behind the checks and to avoid 80-col limits to make review
> easier overall. It's a force of habit and I'm happy to reformat it as
> you suggest except....
> 

I tend to disregard the 80 col limit, so I might not be the best example
here :D

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
> 
> This last line is not exactly equivalent to what I wrote. It would need
> to be
> 
> 	(busiest->sum_nr_running < (busiest->group_weight >> 1) - imbalance_adj) &&
> 

Right, I was implicitly suggesting that maybe we could forgo the
imbalance_adj computation and just roll with the imbalance_pct (with perhaps
and extra shift here and there). IMO the important thing here is the 
half-way cutoff.

> I can test as you suggest to see if it's roughly equivalent in terms of
> performance. The intent was to have a cutoff just before we reached 50%
> running tasks / busy CPUs.
> 

I think that cutoff makes sense; it's also important that it isn't purely
busy CPU-based because we're not guaranteed to have 1 task per CPU (due to
affinity or else), so I think the "half as many tasks as available CPUs"
thing has some merit.
