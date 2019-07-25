Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94422C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B4D2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfGYRRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:17:42 -0400
Received: from foss.arm.com ([217.140.110.172]:33268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGYRRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:17:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B49174E;
        Thu, 25 Jul 2019 10:17:41 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A80C3F71A;
        Thu, 25 Jul 2019 10:17:39 -0700 (PDT)
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d55f906e-6e91-9f49-5c2c-7ec2e6bd68b0@arm.com>
Date:   Thu, 25 Jul 2019 18:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

first batch of questions/comments here...

On 19/07/2019 08:58, Vincent Guittot wrote:
[...]
>  kernel/sched/fair.c | 539 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 289 insertions(+), 250 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 67f0acd..472959df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3771,7 +3771,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  		return;
>  	}
>  
> -	rq->misfit_task_load = task_h_load(p);
> +	rq->misfit_task_load = task_util_est(p);

Huh, interesting. Why go for utilization?

Right now we store the load of the task and use it to pick the "biggest"
misfit (in terms of load) when there are more than one misfit tasks to
choose:

update_sd_pick_busiest():
,----
| /*
|  * If we have more than one misfit sg go with the biggest misfit.
|  */
| if (sgs->group_type == group_misfit_task &&
|     sgs->group_misfit_task_load < busiest->group_misfit_task_load)
| 	return false;
`----

I don't think it makes much sense to maximize utilization for misfit tasks:
they're over the capacity margin, which exactly means "I can't really tell
you much on that utilization other than it doesn't fit".

At the very least, this rq field should be renamed "misfit_task_util".

[...]

> @@ -7060,12 +7048,21 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
>  enum fbq_type { regular, remote, all };
>  
>  enum group_type {
> -	group_other = 0,
> +	group_has_spare = 0,
> +	group_fully_busy,
>  	group_misfit_task,
> +	group_asym_capacity,
>  	group_imbalanced,
>  	group_overloaded,
>  };
>  
> +enum group_migration {
> +	migrate_task = 0,
> +	migrate_util,
> +	migrate_load,
> +	migrate_misfit,

Can't we have only 3 imbalance types (task, util, load), and make misfit
fall in that first one? Arguably it is a special kind of task balance,
since it would go straight for the active balance, but it would fit a
`migrate_task` imbalance with a "go straight for active balance" flag
somewhere.

[...]

> @@ -7361,19 +7357,46 @@ static int detach_tasks(struct lb_env *env)
>  		if (!can_migrate_task(p, env))
>  			goto next;
>  
> -		load = task_h_load(p);
> +		if (env->src_grp_type == migrate_load) {
> +			unsigned long load = task_h_load(p);
>  
> -		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> -			goto next;
> +			if (sched_feat(LB_MIN) &&
> +			    load < 16 && !env->sd->nr_balance_failed)
> +				goto next;
> +
> +			if ((load / 2) > env->imbalance)
> +				goto next;
> +
> +			env->imbalance -= load;
> +		} else	if (env->src_grp_type == migrate_util) {
> +			unsigned long util = task_util_est(p);
> +
> +			if (util > env->imbalance)
> +				goto next;
> +
> +			env->imbalance -= util;
> +		} else if (env->src_grp_type == migrate_misfit) {
> +			unsigned long util = task_util_est(p);
> +
> +			/*
> +			 * utilization of misfit task might decrease a bit
> +			 * since it has been recorded. Be conservative in the
> +			 * condition.
> +			 */
> +			if (2*util < env->imbalance)
> +				goto next;

Other than I'm not convinced we should track utilization for misfit tasks,
can the utilization of the task really be halved between the last
update_misfit_status() and here?

> +
> +			env->imbalance = 0;
> +		} else {
> +			/* Migrate task */
> +			env->imbalance--;
> +		}
>  
> -		if ((load / 2) > env->imbalance)
> -			goto next;
>  
>  		detach_task(p, env);
>  		list_add(&p->se.group_node, &env->tasks);
>  
>  		detached++;
> -		env->imbalance -= load;
>  
>  #ifdef CONFIG_PREEMPT
>  		/*

[...]

> @@ -8357,72 +8318,115 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  	if (busiest->group_type == group_imbalanced) {
>  		/*
>  		 * In the group_imb case we cannot rely on group-wide averages
> -		 * to ensure CPU-load equilibrium, look at wider averages. XXX
> +		 * to ensure CPU-load equilibrium, try to move any task to fix
> +		 * the imbalance. The next load balance will take care of
> +		 * balancing back the system.
>  		 */
> -		busiest->load_per_task =
> -			min(busiest->load_per_task, sds->avg_load);
> +		env->src_grp_type = migrate_task;
> +		env->imbalance = 1;
> +		return;
>  	}
>  
> -	/*
> -	 * Avg load of busiest sg can be less and avg load of local sg can
> -	 * be greater than avg load across all sgs of sd because avg load
> -	 * factors in sg capacity and sgs with smaller group_type are
> -	 * skipped when updating the busiest sg:
> -	 */
> -	if (busiest->group_type != group_misfit_task &&
> -	    (busiest->avg_load <= sds->avg_load ||
> -	     local->avg_load >= sds->avg_load)) {
> -		env->imbalance = 0;
> -		return fix_small_imbalance(env, sds);
> +	if (busiest->group_type == group_misfit_task) {
> +		/* Set imbalance to allow misfit task to be balanced. */
> +		env->src_grp_type = migrate_misfit;
> +		env->imbalance = busiest->group_misfit_task_load;
> +		return;
>  	}
>  
>  	/*
> -	 * If there aren't any idle CPUs, avoid creating some.
> +	 * Try to use spare capacity of local group without overloading it or
> +	 * emptying busiest
>  	 */
> -	if (busiest->group_type == group_overloaded &&
> -	    local->group_type   == group_overloaded) {
> -		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
> -		if (load_above_capacity > busiest->group_capacity) {
> -			load_above_capacity -= busiest->group_capacity;
> -			load_above_capacity *= scale_load_down(NICE_0_LOAD);
> -			load_above_capacity /= busiest->group_capacity;
> -		} else
> -			load_above_capacity = ~0UL;
> +	if (local->group_type == group_has_spare) {
> +		long imbalance;
> +
> +		/*
> +		 * If there is no overload, we just want to even the number of
> +		 * idle cpus.
> +		 */
> +		env->src_grp_type = migrate_task;
> +		imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
> +
> +		if (sds->prefer_sibling)
> +			/*
> +			 * When prefer sibling, evenly spread running tasks on
> +			 * groups.
> +			 */
> +			imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
> +
> +		if (busiest->group_type > group_fully_busy) {
> +			/*
> +			 * If busiest is overloaded, try to fill spare
> +			 * capacity. This might end up creating spare capacity
> +			 * in busiest or busiest still being overloaded but
> +			 * there is no simple way to directly compute the
> +			 * amount of load to migrate in order to balance the
> +			 * system.
> +			 */
> +			env->src_grp_type = migrate_util;
> +			imbalance = max(local->group_capacity, local->group_util) -
> +				    local->group_util;

Rather than filling the local group, shouldn't we follow the same strategy
as for load, IOW try to reach an average without pushing local above nor
busiest below ?

We could build an sds->avg_util similar to sds->avg_load.

> +		}
> +
> +		env->imbalance = imbalance;
> +		return;
>  	}
[...]
> +/*
> + * Decision matrix according to the local and busiest group state
> + *
> + * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> + * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> + * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> + * misfit_task      force     N/A        N/A    N/A  force      force
> + * asym_capacity    force     force      N/A    N/A  force      force
> + * imbalanced       force     force      N/A    N/A  force      force
> + * overloaded       force     force      N/A    N/A  force      avg_load
> + *
> + * N/A :      Not Applicable because already filtered while updating
> + *            statistics.
> + * balanced : The system is balanced for these 2 groups.
> + * force :    Calculate the imbalance as load migration is probably needed.
> + * avg_load : Only if imbalance is significant enough.
> + * nr_idle :  dst_cpu is not busy and the number of idle cpus is quite
> + *            different in groups.
> + */
> +

Nice!
