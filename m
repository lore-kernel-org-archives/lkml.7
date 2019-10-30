Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F23D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJ3QQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:16:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfJ3QQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:16:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 535081F1;
        Wed, 30 Oct 2019 09:16:23 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DEC13F6C4;
        Wed, 30 Oct 2019 09:16:19 -0700 (PDT)
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <31e5de01-9f18-674d-9917-ab0ac360a6b5@arm.com>
Date:   Wed, 30 Oct 2019 17:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030154534.GJ3016@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 16:45, Mel Gorman wrote:
> On Fri, Oct 18, 2019 at 03:26:31PM +0200, Vincent Guittot wrote:
>> The load_balance algorithm contains some heuristics which have become
>> meaningless since the rework of the scheduler's metrics like the
>> introduction of PELT.
>>
>> Furthermore, load is an ill-suited metric for solving certain task
>> placement imbalance scenarios. For instance, in the presence of idle CPUs,
>> we should simply try to get at least one task per CPU, whereas the current
>> load-based algorithm can actually leave idle CPUs alone simply because the
>> load is somewhat balanced. The current algorithm ends up creating virtual
>> and meaningless value like the avg_load_per_task or tweaks the state of a
>> group to make it overloaded whereas it's not, in order to try to migrate
>> tasks.
>>
> 
> I do not think this is necessarily 100% true. With both the previous
> load-balancing behaviour and the apparent behaviour of this patch, it's
> still possible to pull two communicating tasks apart and across NUMA
> domains when utilisation is low. Specifically, a load difference of less
> than SCHED_CAPACITY_SCALE between NUMA codes can be enough too migrate
> task to level out load.
> 
> So, load might be ill-suited for some cases but that does not make it
> completely useless either.
> 

For sure! What we're trying to get to is that load is much less relevant
at low task count than at high task count.

A pathological case for asymmetric systems (big.LITTLE et al) is if you spawn
as many tasks as you have CPUs and they're not all spread out straight from
wakeup (so you have at least one rq coscheduling 2 tasks), the load balancer
might never solve that imbalance and leave a CPU idle for the duration of the
workload.

The problem there is that the current LB tries to balance avg_load, which is
screwy when asymmetric capacities are involved.

Take the h960 for instance, which is 4+4 big.LITTLE (LITTLEs are 462 capacity,
bigs 1024). Say you end up with 3 tasks on the LITTLEs (one is idle), and 5
tasks on the bigs (none idle). The tasks are CPU hogs, so they won't go
through new wakeups.                                                                                                                                                                   

You have something like 3072 load on the LITTLEs vs 5120 on the bigs. The
thing is, a group's avg_load scales inversely with capacity:
                                                                            
sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
				sgs->group_capacity;                                          

That means the LITTLEs group ends up with 1702 avg_load, whereas the bigs
group gets 1280 - the LITTLEs group is seen as more "busy" despite having an
idle CPU. This kind of imbalance usually ends up in fix_small_imbalance()
territory, which is random at best.

>> @@ -8022,9 +8076,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>  		/*
>>  		 * No need to call idle_cpu() if nr_running is not 0
>>  		 */
>> -		if (!nr_running && idle_cpu(i))
>> +		if (!nr_running && idle_cpu(i)) {
>>  			sgs->idle_cpus++;
>> +			/* Idle cpu can't have misfit task */
>> +			continue;
>> +		}
>> +
>> +		if (local_group)
>> +			continue;
>>  
>> +		/* Check for a misfit task on the cpu */
>>  		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>>  		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>>  			sgs->group_misfit_task_load = rq->misfit_task_load;
> 
> So.... why exactly do we not care about misfit tasks on CPUs in the
> local group? I'm not saying you're wrong because you have a clear idea
> on how misfit tasks should be treated but it's very non-obvious just
> from the code.
> 

Misfit tasks need to be migrated away to CPUs of higher capacity. We let that
happen through the usual load-balance pull - there's little point in pulling
from ourselves.

> I didn't see anything obvious after this point but I also am getting a
> bit on the fried side trying to hold this entire patch in my head and
> got hung up on the NUMA domain balancing in particular.
> 

I share the feeling, I've done it by chunks but need to have another go at it.
