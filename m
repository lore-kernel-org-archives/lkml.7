Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F5CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A8720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJ3Ppn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:45:43 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:50832 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfJ3Ppl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:45:41 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id E0FF51C1B57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:45:36 +0000 (GMT)
Received: (qmail 7265 invoked from network); 30 Oct 2019 15:45:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 15:45:36 -0000
Date:   Wed, 30 Oct 2019 15:45:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
Message-ID: <20191030154534.GJ3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:26:31PM +0200, Vincent Guittot wrote:
> The load_balance algorithm contains some heuristics which have become
> meaningless since the rework of the scheduler's metrics like the
> introduction of PELT.
> 
> Furthermore, load is an ill-suited metric for solving certain task
> placement imbalance scenarios. For instance, in the presence of idle CPUs,
> we should simply try to get at least one task per CPU, whereas the current
> load-based algorithm can actually leave idle CPUs alone simply because the
> load is somewhat balanced. The current algorithm ends up creating virtual
> and meaningless value like the avg_load_per_task or tweaks the state of a
> group to make it overloaded whereas it's not, in order to try to migrate
> tasks.
> 

I do not think this is necessarily 100% true. With both the previous
load-balancing behaviour and the apparent behaviour of this patch, it's
still possible to pull two communicating tasks apart and across NUMA
domains when utilisation is low. Specifically, a load difference of less
than SCHED_CAPACITY_SCALE between NUMA codes can be enough too migrate
task to level out load.

So, load might be ill-suited for some cases but that does not make it
completely useless either.

The type of behaviour can be seen by running netperf via mmtests
(configuration file configs/config-network-netperf-unbound) on a NUMA
machine and noting that the local vs remote NUMA hinting faults are roughly
50%. I had prototyped some fixes around this that took imbalance_pct into
account but it was too special-cased and was not a universal win. If
I was reviewing my own patch I would have naked it on the "you added a
special-case hack into the load balancer for one load". I didn't get back
to it before getting cc'd on this series.

> load_balance should better qualify the imbalance of the group and clearly
> define what has to be moved to fix this imbalance.
> 
> The type of sched_group has been extended to better reflect the type of
> imbalance. We now have :
> 	group_has_spare
> 	group_fully_busy
> 	group_misfit_task
> 	group_asym_packing
> 	group_imbalanced
> 	group_overloaded
> 
> Based on the type of sched_group, load_balance now sets what it wants to
> move in order to fix the imbalance. It can be some load as before but also
> some utilization, a number of task or a type of task:
> 	migrate_task
> 	migrate_util
> 	migrate_load
> 	migrate_misfit
> 
> This new load_balance algorithm fixes several pending wrong tasks
> placement:
> - the 1 task per CPU case with asymmetric system
> - the case of cfs task preempted by other class
> - the case of tasks not evenly spread on groups with spare capacity
> 

On the last one, spreading tasks evenly across NUMA domains is not
necessarily a good idea. If I have 2 tasks running on a 2-socket machine
with 24 logical CPUs per socket, it should not automatically mean that
one task should move cross-node and I have definitely observed this
happening. It's probably bad in terms of locality no matter what but it's
especially bad if the 2 tasks happened to be communicating because then
load balancing will pull apart the tasks while wake_affine will push
them together (and potentially NUMA balancing as well). Note that this
also applies for some IO workloads because, depending on the filesystem,
the task may be communicating with workqueues (XFS) or a kernel thread
(ext4 with jbd2).

> Also the load balance decisions have been consolidated in the 3 functions
> below after removing the few bypasses and hacks of the current code:
> - update_sd_pick_busiest() select the busiest sched_group.
> - find_busiest_group() checks if there is an imbalance between local and
>   busiest group.
> - calculate_imbalance() decides what have to be moved.
> 
> Finally, the now unused field total_running of struct sd_lb_stats has been
> removed.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 611 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 402 insertions(+), 209 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e004841..5ae5281 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7068,11 +7068,26 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
>  
>  enum fbq_type { regular, remote, all };
>  
> +/*
> + * group_type describes the group of CPUs at the moment of the load balance.
> + * The enum is ordered by pulling priority, with the group with lowest priority
> + * first so the groupe_type can be simply compared when selecting the busiest
> + * group. see update_sd_pick_busiest().
> + */

s/groupe_type/group_type/

>  enum group_type {
> -	group_other = 0,
> +	group_has_spare = 0,
> +	group_fully_busy,
>  	group_misfit_task,
> +	group_asym_packing,
>  	group_imbalanced,
> -	group_overloaded,
> +	group_overloaded
> +};
> +

While not your fault, it would be nice to comment on the meaning of each
group type. From a glance, it's not obvious to me why a misfit task should
be a high priority to move a task than a fully_busy (but not overloaded)
group given that moving the misfit task might make a group overloaded.

> +enum migration_type {
> +	migrate_load = 0,
> +	migrate_util,
> +	migrate_task,
> +	migrate_misfit
>  };
>  

Could do with a comment explaining what migration_type is for because
the name is unhelpful. I *think* at a glance it's related to what sort
of imbalance is being addressed which is partially addressed by the
group_type. That understanding may change as I continue reading the series
but now I have to figure it out which means it'll be forgotten again in
6 months.

>  #define LBF_ALL_PINNED	0x01
> @@ -7105,7 +7120,7 @@ struct lb_env {
>  	unsigned int		loop_max;
>  
>  	enum fbq_type		fbq_type;
> -	enum group_type		src_grp_type;
> +	enum migration_type	migration_type;
>  	struct list_head	tasks;
>  };
>  
> @@ -7328,7 +7343,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
>  static const unsigned int sched_nr_migrate_break = 32;
>  
>  /*
> - * detach_tasks() -- tries to detach up to imbalance runnable load from
> + * detach_tasks() -- tries to detach up to imbalance load/util/tasks from
>   * busiest_rq, as part of a balancing operation within domain "sd".
>   *
>   * Returns number of detached tasks if successful and 0 otherwise.
> @@ -7336,8 +7351,8 @@ static const unsigned int sched_nr_migrate_break = 32;
>  static int detach_tasks(struct lb_env *env)
>  {
>  	struct list_head *tasks = &env->src_rq->cfs_tasks;
> +	unsigned long util, load;
>  	struct task_struct *p;
> -	unsigned long load;
>  	int detached = 0;
>  
>  	lockdep_assert_held(&env->src_rq->lock);
> @@ -7370,19 +7385,51 @@ static int detach_tasks(struct lb_env *env)
>  		if (!can_migrate_task(p, env))
>  			goto next;
>  
> -		load = task_h_load(p);
> +		switch (env->migration_type) {
> +		case migrate_load:
> +			load = task_h_load(p);
>  
> -		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> -			goto next;
> +			if (sched_feat(LB_MIN) &&
> +			    load < 16 && !env->sd->nr_balance_failed)
> +				goto next;
>  
> -		if ((load / 2) > env->imbalance)
> -			goto next;
> +			if ((load / 2) > env->imbalance)
> +				goto next;
> +
> +			env->imbalance -= load;
> +			break;
> +
> +		case migrate_util:
> +			util = task_util_est(p);
> +
> +			if (util > env->imbalance)
> +				goto next;
> +
> +			env->imbalance -= util;
> +			break;
> +
> +		case migrate_task:
> +			env->imbalance--;
> +			break;
> +
> +		case migrate_misfit:
> +			load = task_h_load(p);
> +
> +			/*
> +			 * load of misfit task might decrease a bit since it has
> +			 * been recorded. Be conservative in the condition.
> +			 */
> +			if (load / 2 < env->imbalance)
> +				goto next;
> +
> +			env->imbalance = 0;
> +			break;
> +		}
>  

So, no problem with this but it brings up another point. migration_type
also determines what env->imbalance means (e.g. load, utilisation,
nr_running etc). That was true before your patch too but now it's much
more explicit, which is nice, but could do with a comment.

>  		detach_task(p, env);
>  		list_add(&p->se.group_node, &env->tasks);
>  
>  		detached++;
> -		env->imbalance -= load;
>  
>  #ifdef CONFIG_PREEMPTION
>  		/*
> @@ -7396,7 +7443,7 @@ static int detach_tasks(struct lb_env *env)
>  
>  		/*
>  		 * We only want to steal up to the prescribed amount of
> -		 * runnable load.
> +		 * load/util/tasks.
>  		 */
>  		if (env->imbalance <= 0)
>  			break;
> @@ -7661,7 +7708,6 @@ struct sg_lb_stats {
>  	unsigned int idle_cpus;
>  	unsigned int group_weight;
>  	enum group_type group_type;
> -	int group_no_capacity;
>  	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
>  	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING

Glad to see group_no_capacity go away, that had some "interesting"
treatment in update_sd_lb_stats.

> @@ -7677,10 +7723,10 @@ struct sg_lb_stats {
>  struct sd_lb_stats {
>  	struct sched_group *busiest;	/* Busiest group in this sd */
>  	struct sched_group *local;	/* Local group in this sd */
> -	unsigned long total_running;
>  	unsigned long total_load;	/* Total load of all groups in sd */
>  	unsigned long total_capacity;	/* Total capacity of all groups in sd */
>  	unsigned long avg_load;	/* Average load across all groups in sd */
> +	unsigned int prefer_sibling; /* tasks should go to sibling first */
>  
>  	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
>  	struct sg_lb_stats local_stat;	/* Statistics of the local group */
> @@ -7691,19 +7737,18 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>  	/*
>  	 * Skimp on the clearing to avoid duplicate work. We can avoid clearing
>  	 * local_stat because update_sg_lb_stats() does a full clear/assignment.
> -	 * We must however clear busiest_stat::avg_load because
> -	 * update_sd_pick_busiest() reads this before assignment.
> +	 * We must however set busiest_stat::group_type and
> +	 * busiest_stat::idle_cpus to the worst busiest group because
> +	 * update_sd_pick_busiest() reads these before assignment.
>  	 */
>  	*sds = (struct sd_lb_stats){
>  		.busiest = NULL,
>  		.local = NULL,
> -		.total_running = 0UL,
>  		.total_load = 0UL,
>  		.total_capacity = 0UL,
>  		.busiest_stat = {
> -			.avg_load = 0UL,
> -			.sum_h_nr_running = 0,
> -			.group_type = group_other,
> +			.idle_cpus = UINT_MAX,
> +			.group_type = group_has_spare,
>  		},
>  	};
>  }
> @@ -7945,19 +7990,26 @@ group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  }
>  
>  static inline enum
> -group_type group_classify(struct sched_group *group,
> +group_type group_classify(struct lb_env *env,
> +			  struct sched_group *group,
>  			  struct sg_lb_stats *sgs)
>  {
> -	if (sgs->group_no_capacity)
> +	if (group_is_overloaded(env, sgs))
>  		return group_overloaded;
>  
>  	if (sg_imbalanced(group))
>  		return group_imbalanced;
>  
> +	if (sgs->group_asym_packing)
> +		return group_asym_packing;
> +
>  	if (sgs->group_misfit_task_load)
>  		return group_misfit_task;
>  
> -	return group_other;
> +	if (!group_has_capacity(env, sgs))
> +		return group_fully_busy;
> +
> +	return group_has_spare;
>  }
>  
>  static bool update_nohz_stats(struct rq *rq, bool force)
> @@ -7994,10 +8046,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  				      struct sg_lb_stats *sgs,
>  				      int *sg_status)
>  {
> -	int i, nr_running;
> +	int i, nr_running, local_group;
>  
>  	memset(sgs, 0, sizeof(*sgs));
>  
> +	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
> +
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
>  
> @@ -8022,9 +8076,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		/*
>  		 * No need to call idle_cpu() if nr_running is not 0
>  		 */
> -		if (!nr_running && idle_cpu(i))
> +		if (!nr_running && idle_cpu(i)) {
>  			sgs->idle_cpus++;
> +			/* Idle cpu can't have misfit task */
> +			continue;
> +		}
> +
> +		if (local_group)
> +			continue;
>  
> +		/* Check for a misfit task on the cpu */
>  		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>  		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>  			sgs->group_misfit_task_load = rq->misfit_task_load;

So.... why exactly do we not care about misfit tasks on CPUs in the
local group? I'm not saying you're wrong because you have a clear idea
on how misfit tasks should be treated but it's very non-obvious just
from the code.

> <SNIP>
>
> @@ -8079,62 +8154,80 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (sgs->group_type < busiest->group_type)
>  		return false;
>  
> -	if (sgs->avg_load <= busiest->avg_load)
> -		return false;
> -
> -	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> -		goto asym_packing;
> -
>  	/*
> -	 * Candidate sg has no more than one task per CPU and
> -	 * has higher per-CPU capacity. Migrating tasks to less
> -	 * capable CPUs may harm throughput. Maximize throughput,
> -	 * power/energy consequences are not considered.
> +	 * The candidate and the current busiest group are the same type of
> +	 * group. Let check which one is the busiest according to the type.
>  	 */
> -	if (sgs->sum_h_nr_running <= sgs->group_weight &&
> -	    group_smaller_min_cpu_capacity(sds->local, sg))
> -		return false;
>  
> -	/*
> -	 * If we have more than one misfit sg go with the biggest misfit.
> -	 */
> -	if (sgs->group_type == group_misfit_task &&
> -	    sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> +	switch (sgs->group_type) {
> +	case group_overloaded:
> +		/* Select the overloaded group with highest avg_load. */
> +		if (sgs->avg_load <= busiest->avg_load)
> +			return false;
> +		break;
> +
> +	case group_imbalanced:
> +		/*
> +		 * Select the 1st imbalanced group as we don't have any way to
> +		 * choose one more than another.
> +		 */
>  		return false;
>  
> -asym_packing:
> -	/* This is the busiest node in its class. */
> -	if (!(env->sd->flags & SD_ASYM_PACKING))
> -		return true;
> +	case group_asym_packing:
> +		/* Prefer to move from lowest priority CPU's work */
> +		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> +			return false;
> +		break;
>  

Again, I'm not seeing what prevents a !SD_ASYM_PACKING domain checking
sched_asym_prefer.

> <SNIP>
> +	case group_fully_busy:
> +		/*
> +		 * Select the fully busy group with highest avg_load. In
> +		 * theory, there is no need to pull task from such kind of
> +		 * group because tasks have all compute capacity that they need
> +		 * but we can still improve the overall throughput by reducing
> +		 * contention when accessing shared HW resources.
> +		 *
> +		 * XXX for now avg_load is not computed and always 0 so we
> +		 * select the 1st one.
> +		 */
> +		if (sgs->avg_load <= busiest->avg_load)
> +			return false;
> +		break;
> +

With the exception that if we are balancing between NUMA domains and they
were communicating tasks that we've now pulled them apart. That might
increase the CPU resources available at the cost of increased remote
memory access cost.

> +	case group_has_spare:
> +		/*
> +		 * Select not overloaded group with lowest number of
> +		 * idle cpus. We could also compare the spare capacity
> +		 * which is more stable but it can end up that the
> +		 * group has less spare capacity but finally more idle
> +		 * cpus which means less opportunity to pull tasks.
> +		 */
> +		if (sgs->idle_cpus >= busiest->idle_cpus)
> +			return false;
> +		break;
>  	}
>  
> -	return false;
> +	/*
> +	 * Candidate sg has no more than one task per CPU and has higher
> +	 * per-CPU capacity. Migrating tasks to less capable CPUs may harm
> +	 * throughput. Maximize throughput, power/energy consequences are not
> +	 * considered.
> +	 */
> +	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> +	    (sgs->group_type <= group_fully_busy) &&
> +	    (group_smaller_min_cpu_capacity(sds->local, sg)))
> +		return false;
> +
> +	return true;
>  }
>  
>  #ifdef CONFIG_NUMA_BALANCING
> @@ -8172,13 +8265,13 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
>   * @env: The load balancing environment.
>   * @sds: variable to hold the statistics for this sched_domain.
>   */
> +

Spurious whitespace change.

>  static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
>  {
>  	struct sched_domain *child = env->sd->child;
>  	struct sched_group *sg = env->sd->groups;
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
> -	bool prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
>  	int sg_status = 0;
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -8205,22 +8298,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		if (local_group)
>  			goto next_group;
>  
> -		/*
> -		 * In case the child domain prefers tasks go to siblings
> -		 * first, lower the sg capacity so that we'll try
> -		 * and move all the excess tasks away. We lower the capacity
> -		 * of a group only if the local group has the capacity to fit
> -		 * these excess tasks. The extra check prevents the case where
> -		 * you always pull from the heaviest group when it is already
> -		 * under-utilized (possible with a large weight task outweighs
> -		 * the tasks on the system).
> -		 */
> -		if (prefer_sibling && sds->local &&
> -		    group_has_capacity(env, local) &&
> -		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
> -			sgs->group_no_capacity = 1;
> -			sgs->group_type = group_classify(sg, sgs);
> -		}
>  
>  		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
>  			sds->busiest = sg;
> @@ -8229,13 +8306,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  
>  next_group:
>  		/* Now, start updating sd_lb_stats */
> -		sds->total_running += sgs->sum_h_nr_running;
>  		sds->total_load += sgs->group_load;
>  		sds->total_capacity += sgs->group_capacity;
>  
>  		sg = sg->next;
>  	} while (sg != env->sd->groups);
>  
> +	/* Tag domain that child domain prefers tasks go to siblings first */
> +	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> +
>  #ifdef CONFIG_NO_HZ_COMMON
>  	if ((env->flags & LBF_NOHZ_AGAIN) &&
>  	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> @@ -8273,69 +8352,149 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>   */
>  static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> -	unsigned long max_pull, load_above_capacity = ~0UL;
>  	struct sg_lb_stats *local, *busiest;
>  
>  	local = &sds->local_stat;
>  	busiest = &sds->busiest_stat;
>  
> -	if (busiest->group_asym_packing) {
> -		env->imbalance = busiest->group_load;
> +	if (busiest->group_type == group_misfit_task) {
> +		/* Set imbalance to allow misfit task to be balanced. */
> +		env->migration_type = migrate_misfit;
> +		env->imbalance = busiest->group_misfit_task_load;
> +		return;
> +	}
> +
> +	if (busiest->group_type == group_asym_packing) {
> +		/*
> +		 * In case of asym capacity, we will try to migrate all load to
> +		 * the preferred CPU.
> +		 */
> +		env->migration_type = migrate_task;
> +		env->imbalance = busiest->sum_h_nr_running;
> +		return;
> +	}
> +
> +	if (busiest->group_type == group_imbalanced) {
> +		/*
> +		 * In the group_imb case we cannot rely on group-wide averages
> +		 * to ensure CPU-load equilibrium, try to move any task to fix
> +		 * the imbalance. The next load balance will take care of
> +		 * balancing back the system.
> +		 */
> +		env->migration_type = migrate_task;
> +		env->imbalance = 1;
>  		return;
>  	}
>  
>  	/*
> -	 * Avg load of busiest sg can be less and avg load of local sg can
> -	 * be greater than avg load across all sgs of sd because avg load
> -	 * factors in sg capacity and sgs with smaller group_type are
> -	 * skipped when updating the busiest sg:
> +	 * Try to use spare capacity of local group without overloading it or
> +	 * emptying busiest
>  	 */
> -	if (busiest->group_type != group_misfit_task &&
> -	    (busiest->avg_load <= sds->avg_load ||
> -	     local->avg_load >= sds->avg_load)) {
> -		env->imbalance = 0;
> +	if (local->group_type == group_has_spare) {
> +		if (busiest->group_type > group_fully_busy) {
> +			/*
> +			 * If busiest is overloaded, try to fill spare
> +			 * capacity. This might end up creating spare capacity
> +			 * in busiest or busiest still being overloaded but
> +			 * there is no simple way to directly compute the
> +			 * amount of load to migrate in order to balance the
> +			 * system.
> +			 */

busiest may not be overloaded, it may be imbalanced. Maybe the
distinction is irrelevant though.

> +			env->migration_type = migrate_util;
> +			env->imbalance = max(local->group_capacity, local->group_util) -
> +					 local->group_util;
> +
> +			/*
> +			 * In some case, the group's utilization is max or even
> +			 * higher than capacity because of migrations but the
> +			 * local CPU is (newly) idle. There is at least one
> +			 * waiting task in this overloaded busiest group. Let
> +			 * try to pull it.
> +			 */
> +			if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
> +				env->migration_type = migrate_task;
> +				env->imbalance = 1;
> +			}
> +

Not convinced this is a good thing to do across NUMA domains. If it was
tied to the group being definitely overloaded then I could see the logic.

> +			return;
> +		}
> +
> +		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> +			unsigned int nr_diff = busiest->sum_h_nr_running;
> +			/*
> +			 * When prefer sibling, evenly spread running tasks on
> +			 * groups.
> +			 */
> +			env->migration_type = migrate_task;
> +			lsub_positive(&nr_diff, local->sum_h_nr_running);
> +			env->imbalance = nr_diff >> 1;
> +			return;
> +		}

Comment is slightly misleading given that it's not just preferring
siblings but for when balancing across single CPU domains.

> +
> +		/*
> +		 * If there is no overload, we just want to even the number of
> +		 * idle cpus.
> +		 */
> +		env->migration_type = migrate_task;
> +		env->imbalance = max_t(long, 0, (local->idle_cpus -
> +						 busiest->idle_cpus) >> 1);
>  		return;
>  	}

Why do we want an even number of idle CPUs unconditionally? This goes back
to the NUMA domain case. 2 communicating tasks running on a 2-socket system
should not be pulled apart just to have 1 task running on each socket.

I didn't see anything obvious after this point but I also am getting a
bit on the fried side trying to hold this entire patch in my head and
got hung up on the NUMA domain balancing in particular.

-- 
Mel Gorman
SUSE Labs
