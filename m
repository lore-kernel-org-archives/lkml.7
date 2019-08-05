Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A5CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85548216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfHERHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:07:07 -0400
Received: from foss.arm.com ([217.140.110.172]:52498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfHERHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:07:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31192344;
        Mon,  5 Aug 2019 10:07:06 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 125A03F694;
        Mon,  5 Aug 2019 10:07:04 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ee4ac9c8-ac70-e56a-2aa9-9cce2e5aa25b@arm.com>
Date:   Mon, 5 Aug 2019 18:07:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Here's another batch of comments, still need to go through some more of it.

On 01/08/2019 15:40, Vincent Guittot wrote:
> The load_balance algorithm contains some heuristics which have becomes

s/becomes/become/

> meaningless since the rework of metrics and the introduction of PELT.
                               ^^^^^^^^^^
Which metrics? I suppose you mean the s*_lb_stats structs?

> 
> Furthermore, it's sometimes difficult to fix wrong scheduling decisions
> because everything is based on load whereas some imbalances are not
> related to the load.

Hmm, well, they don't start as wrong decisions, right? It's just that
certain imbalance scenarios can't be solved by looking only at load.

What about something along those lines?

"""
Furthermore, load is an ill-suited metric for solving certain task
placement imbalance scenarios. For instance, in the presence of idle CPUs,
we should simply try to get at least one task per CPU, whereas the current
load-based algorithm can actually leave idle CPUs alone simply because the
load is somewhat balanced.
"""

> The current algorithm ends up to create virtual and

s/to create/creating/

> meaningless value like the avg_load_per_task or tweaks the state of a
> group to make it overloaded whereas it's not, in order to try to migrate
> tasks.
> 
> load_balance should better qualify the imbalance of the group and define
> cleary what has to be moved to fix this imbalance.

s/define cleary/clearly define/

> 
> The type of sched_group has been extended to better reflect the type of
> imbalance. We now have :
> 	group_has_spare
> 	group_fully_busy
> 	group_misfit_task
> 	group_asym_capacity
> 	group_imbalanced
> 	group_overloaded
> 
> Based on the type of sched_group, load_balance now sets what it wants to
> move in order to fix the imnbalance. It can be some load as before but

s/imnbalance/imbalance/

> also some utilization, a number of task or a type of task:
> 	migrate_task
> 	migrate_util
> 	migrate_load
> 	migrate_misfit
> 
> This new load_balance algorithm fixes several pending wrong tasks
> placement:
> - the 1 task per CPU case with asymetrics system

s/asymetrics/asymmetric/

> - the case of cfs task preempted by other class
> - the case of tasks not evenly spread on groups with spare capacity
> 
> The load balance decisions have been gathered in 3 functions:
> - update_sd_pick_busiest() select the busiest sched_group.
> - find_busiest_group() checks if there is an imabalance between local and

s/imabalance/imbalance/

>   busiest group.
> - calculate_imbalance() decides what have to be moved.

That's nothing new, isn't it? I think what you mean there is that the
decisions have been consolidated in those areas, rather than being spread
all over the place.

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 581 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 379 insertions(+), 202 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7f4a7e..a8681c3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7136,13 +7136,28 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
>  
>  enum fbq_type { regular, remote, all };
>  
> +/*
> + * group_type describes the group of CPUs at the moment of the load balance.
> + * The enum is ordered by pulling priority, with the group with lowest priority
> + * first so the groupe_type can be simply compared when selecting the busiest
> + * group. see update_sd_pick_busiest().
> + */
>  enum group_type {
> -	group_other = 0,
> +	group_has_spare = 0,
> +	group_fully_busy,
>  	group_misfit_task,
> +	group_asym_capacity,

That one got me confused - it's about asym packing, not asym capacity, and
the name should reflect that. I'd vote for group_asym_packing to stay in
line with what Quentin did for the sd shortcut pointers in

  011b27bb5d31 ("sched/topology: Add lowest CPU asymmetry sched_domain level pointer")

>  	group_imbalanced,
>  	group_overloaded,
>  };
>  
> +enum migration_type {
> +	migrate_task = 0,
> +	migrate_util,
> +	migrate_load,
> +	migrate_misfit,

nitpicking here: AFAICT the ordering of this doesn't really matter,
could we place migrate_misfit next to migrate_task? As you call out in the
header, we can migrate a number of tasks or a type of task, so these should
be somewhat together.

If we're afraid that we'll add other types of tasks later on and that this
won't result in a neat append-to-the-end, we could reverse the order like
so:

migrate_load
migrate_util
migrate_task
migrate_misfit

[...]
> @@ -7745,10 +7793,10 @@ struct sg_lb_stats {
>  struct sd_lb_stats {
>  	struct sched_group *busiest;	/* Busiest group in this sd */
>  	struct sched_group *local;	/* Local group in this sd */
> -	unsigned long total_running;

Could be worth calling out in the log that this gets snipped out. Or it
could go into its own small cleanup patch, since it's just an unused field.

[...]> @@ -8147,11 +8223,67 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (sgs->group_type < busiest->group_type)
>  		return false;
>  
> -	if (sgs->avg_load <= busiest->avg_load)
> +	/*
> +	 * The candidate and the current busiest group are the same type of
> +	 * group. Let check which one is the busiest according to the type.
> +	 */
> +
> +	switch (sgs->group_type) {
> +	case group_overloaded:
> +		/* Select the overloaded group with highest avg_load. */
> +		if (sgs->avg_load <= busiest->avg_load)
> +			return false;
> +		break;
> +
> +	case group_imbalanced:
> +		/* Select the 1st imbalanced group as we don't have
> +		 * any way to choose one more than another
> +		 */
>  		return false;
> +		break;

You already have an unconditional return above.

>  
> -	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> -		goto asym_packing;
> +	case group_asym_capacity:
> +		/* Prefer to move from lowest priority CPU's work */
> +		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> +			 return false;
                        ^
		Stray whitespace

[...]
> @@ -8438,17 +8581,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	local = &sds.local_stat;
>  	busiest = &sds.busiest_stat;
>  
> -	/* ASYM feature bypasses nice load balance check */
> -	if (busiest->group_asym_capacity)
> -		goto force_balance;
> -
>  	/* There is no busy sibling group to pull tasks from */
>  	if (!sds.busiest || busiest->sum_h_nr_running == 0)
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
That can go, since you now filter this in update_sd_pick_busiest()

[...]
> @@ -8459,59 +8602,71 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  		goto force_balance;
>  
>  	/*
> -	 * When dst_cpu is idle, prevent SMP nice and/or asymmetric group
> -	 * capacities from resulting in underutilization due to avg_load.
> -	 */
> -	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> -	    busiest->group_no_capacity)
> -		goto force_balance;
> -
> -	/* Misfit tasks should be dealt with regardless of the avg load */
> -	if (busiest->group_type == group_misfit_task)
> -		goto force_balance;
> -
> -	/*
>  	 * If the local group is busier than the selected busiest group
>  	 * don't try and pull any tasks.
>  	 */
> -	if (local->avg_load >= busiest->avg_load)
> +	if (local->group_type > busiest->group_type)
>  		goto out_balanced;
>  
>  	/*
> -	 * Don't pull any tasks if this group is already above the domain
> -	 * average load.
> +	 * When groups are overloaded, use the avg_load to ensure fairness
> +	 * between tasks.
>  	 */
> -	if (local->avg_load >= sds.avg_load)
> -		goto out_balanced;
> +	if (local->group_type == group_overloaded) {
> +		/*
> +		 * If the local group is more loaded than the selected
> +		 * busiest group don't try and pull any tasks.
> +		 */
> +		if (local->avg_load >= busiest->avg_load)
> +			goto out_balanced;
> +
> +		/* XXX broken for overlapping NUMA groups */
> +		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
> +				sds.total_capacity;
>  
> -	if (env->idle == CPU_IDLE) {
>  		/*
> -		 * This CPU is idle. If the busiest group is not overloaded
> -		 * and there is no imbalance between this and busiest group
> -		 * wrt idle CPUs, it is balanced. The imbalance becomes
> -		 * significant if the diff is greater than 1 otherwise we
> -		 * might end up to just move the imbalance on another group
> +		 * Don't pull any tasks if this group is already above the
> +		 * domain average load.
>  		 */
> -		if ((busiest->group_type != group_overloaded) &&
> -				(local->idle_cpus <= (busiest->idle_cpus + 1)))
> +		if (local->avg_load >= sds.avg_load)
>  			goto out_balanced;
> -	} else {
> +
>  		/*
> -		 * In the CPU_NEWLY_IDLE, CPU_NOT_IDLE cases, use
> -		 * imbalance_pct to be conservative.
> +		 * If the busiest group is more loaded, use imbalance_pct to be
> +		 * conservative.
>  		 */
>  		if (100 * busiest->avg_load <=
>  				env->sd->imbalance_pct * local->avg_load)
>  			goto out_balanced;
> +
>  	}
>  
> +	/* Try to move all excess tasks to child's sibling domain */
> +	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> +	    busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
> +		goto force_balance;
> +
> +	if (busiest->group_type != group_overloaded &&
> +	     (env->idle == CPU_NOT_IDLE ||
> +	      local->idle_cpus <= (busiest->idle_cpus + 1)))
> +		/*
> +		 * If the busiest group is not overloaded
> +		 * and there is no imbalance between this and busiest group
> +		 * wrt idle CPUs, it is balanced. The imbalance
> +		 * becomes significant if the diff is greater than 1 otherwise
> +		 * we might end up to just move the imbalance on another
> +		 * group.
> +		 */
> +		goto out_balanced;
> +
>  force_balance:
>  	/* Looks like there is an imbalance. Compute it */
> -	env->src_grp_type = busiest->group_type;
>  	calculate_imbalance(env, &sds);
> +

Stray newline?

>  	return env->imbalance ? sds.busiest : NULL;
>  
>  out_balanced:
> +

Ditto?

>  	env->imbalance = 0;
>  	return NULL;
>  }
[...]
