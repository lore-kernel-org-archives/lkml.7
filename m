Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F64BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE458214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbfJWMeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:34:24 -0400
Received: from [217.140.110.172] ([217.140.110.172]:50552 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389459AbfJWMeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:34:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5725F497;
        Wed, 23 Oct 2019 05:34:07 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D991E3F6C4;
        Wed, 23 Oct 2019 05:34:05 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:34:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, qperret@google.com,
        balsini@android.com
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191023123403.oo5m2fgkiem2qnsc@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009104611.15363-1-qais.yousef@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding some Android folks who might be interested.

Steven/Peter, in case this has dropped off your queue; it'd be great to get
some feedback when you get a chance to look at it.

Thanks

--
Qais Yousef

On 10/09/19 11:46, Qais Yousef wrote:
> Capacity Awareness refers to the fact that on heterogeneous systems
> (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> when placing tasks we need to be aware of this difference of CPU
> capacities.
> 
> In such scenarios we want to ensure that the selected CPU has enough
> capacity to meet the requirement of the running task. Enough capacity
> means here that capacity_orig_of(cpu) >= task.requirement.
> 
> The definition of task.requirement is dependent on the scheduling class.
> 
> For CFS, utilization is used to select a CPU that has >= capacity value
> than the cfs_task.util.
> 
> 	capacity_orig_of(cpu) >= cfs_task.util
> 
> DL isn't capacity aware at the moment but can make use of the bandwidth
> reservation to implement that in a similar manner CFS uses utilization.
> The following patchset implements that:
> 
> https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> 
> 	capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> 
> For RT we don't have a per task utilization signal and we lack any
> information in general about what performance requirement the RT task
> needs. But with the introduction of uclamp, RT tasks can now control
> that by setting uclamp_min to guarantee a minimum performance point.
> 
> ATM the uclamp value are only used for frequency selection; but on
> heterogeneous systems this is not enough and we need to ensure that the
> capacity of the CPU is >= uclamp_min. Which is what implemented here.
> 
> 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> 
> Note that by default uclamp.min is 1024, which means that RT tasks will
> always be biased towards the big CPUs, which make for a better more
> predictable behavior for the default case.
> 
> Must stress that the bias acts as a hint rather than a definite
> placement strategy. For example, if all big cores are busy executing
> other RT tasks we can't guarantee that a new RT task will be placed
> there.
> 
> On non-heterogeneous systems the original behavior of RT should be
> retained. Similarly if uclamp is not selected in the config.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
> 
> Changes in v2:
> 	- Use cpupri_find() to check the fitness of the task instead of
> 	  sprinkling find_lowest_rq() with several checks of
> 	  rt_task_fits_capacity().
> 
> 	  The selected implementation opted to pass the fitness function as an
> 	  argument rather than call rt_task_fits_capacity() capacity which is
> 	  a cleaner to keep the logical separation of the 2 modules; but it
> 	  means the compiler has less room to optimize rt_task_fits_capacity()
> 	  out when it's a constant value.
> 
> The logic is not perfect. For example if a 'small' task is occupying a big CPU
> and another big task wakes up; we won't force migrate the small task to clear
> the big cpu for the big task that woke up.
> 
> IOW, the logic is best effort and can't give hard guarantees. But improves the
> current situation where a task can randomly end up on any CPU regardless of
> what it needs. ie: without this patch an RT task can wake up on a big or small
> CPU, but with this it will always wake up on a big CPU (assuming the big CPUs
> aren't overloaded) - hence provide a consistent performance.
> 
> I'm looking at ways to improve this best effort, but this patch should be
> a good start to discuss our Capacity Awareness requirement. There's a trade-off
> of complexity to be made here and I'd like to keep things as simple as
> possible and build on top as needed.
> 
> 
>  kernel/sched/cpupri.c | 23 ++++++++++--
>  kernel/sched/cpupri.h |  4 ++-
>  kernel/sched/rt.c     | 81 +++++++++++++++++++++++++++++++++++--------
>  3 files changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index b7abca987d94..799791c01d60 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -57,7 +57,8 @@ static int convert_prio(int prio)
>   * Return: (int)bool - CPUs were found
>   */
>  int cpupri_find(struct cpupri *cp, struct task_struct *p,
> -		struct cpumask *lowest_mask)
> +		struct cpumask *lowest_mask,
> +		bool (*fitness_fn)(struct task_struct *p, int cpu))
>  {
>  	int idx = 0;
>  	int task_pri = convert_prio(p->prio);
> @@ -98,6 +99,8 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>  			continue;
>  
>  		if (lowest_mask) {
> +			int cpu;
> +
>  			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
>  
>  			/*
> @@ -108,7 +111,23 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>  			 * condition, simply act as though we never hit this
>  			 * priority level and continue on.
>  			 */
> -			if (cpumask_any(lowest_mask) >= nr_cpu_ids)
> +			if (cpumask_empty(lowest_mask))
> +				continue;
> +
> +			if (!fitness_fn)
> +				return 1;
> +
> +			/* Ensure the capacity of the CPUs fit the task */
> +			for_each_cpu(cpu, lowest_mask) {
> +				if (!fitness_fn(p, cpu))
> +					cpumask_clear_cpu(cpu, lowest_mask);
> +			}
> +
> +			/*
> +			 * If no CPU at the current priority can fit the task
> +			 * continue looking
> +			 */
> +			if (cpumask_empty(lowest_mask))
>  				continue;
>  		}
>  
> diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
> index 7dc20a3232e7..32dd520db11f 100644
> --- a/kernel/sched/cpupri.h
> +++ b/kernel/sched/cpupri.h
> @@ -18,7 +18,9 @@ struct cpupri {
>  };
>  
>  #ifdef CONFIG_SMP
> -int  cpupri_find(struct cpupri *cp, struct task_struct *p, struct cpumask *lowest_mask);
> +int  cpupri_find(struct cpupri *cp, struct task_struct *p,
> +		 struct cpumask *lowest_mask,
> +		 bool (*fitness_fn)(struct task_struct *p, int cpu));
>  void cpupri_set(struct cpupri *cp, int cpu, int pri);
>  int  cpupri_init(struct cpupri *cp);
>  void cpupri_cleanup(struct cpupri *cp);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ebaa4e619684..3a68054e15b3 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -437,6 +437,45 @@ static inline int on_rt_rq(struct sched_rt_entity *rt_se)
>  	return rt_se->on_rq;
>  }
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +/*
> + * Verify the fitness of task @p to run on @cpu taking into account the uclamp
> + * settings.
> + *
> + * This check is only important for heterogeneous systems where uclamp_min value
> + * is higher than the capacity of a @cpu. For non-heterogeneous system this
> + * function will always return true.
> + *
> + * The function will return true if the capacity of the @cpu is >= the
> + * uclamp_min and false otherwise.
> + *
> + * Note that uclamp_min will be clamped to uclamp_max if uclamp_min
> + * > uclamp_max.
> + */
> +inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> +{
> +	unsigned int min_cap;
> +	unsigned int max_cap;
> +	unsigned int cpu_cap;
> +
> +	/* Only heterogeneous systems can benefit from this check */
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +		return true;
> +
> +	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
> +	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> +
> +	cpu_cap = capacity_orig_of(cpu);
> +
> +	return cpu_cap >= min(min_cap, max_cap);
> +}
> +#else
> +static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> +{
> +	return true;
> +}
> +#endif
> +
>  #ifdef CONFIG_RT_GROUP_SCHED
>  
>  static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
> @@ -1391,6 +1430,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
>  	struct task_struct *curr;
>  	struct rq *rq;
> +	bool test;
>  
>  	/* For anything but wake ups, just return the task_cpu */
>  	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
> @@ -1422,10 +1462,16 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  	 *
>  	 * This test is optimistic, if we get it wrong the load-balancer
>  	 * will have to sort it out.
> +	 *
> +	 * We take into account the capacity of the cpu to ensure it fits the
> +	 * requirement of the task - which is only important on heterogeneous
> +	 * systems like big.LITTLE.
>  	 */
> -	if (curr && unlikely(rt_task(curr)) &&
> -	    (curr->nr_cpus_allowed < 2 ||
> -	     curr->prio <= p->prio)) {
> +	test = curr &&
> +	       unlikely(rt_task(curr)) &&
> +	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
> +
> +	if (test || !rt_task_fits_capacity(p, cpu)) {
>  		int target = find_lowest_rq(p);
>  
>  		/*
> @@ -1449,7 +1495,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
>  	 * let's hope p can move out.
>  	 */
>  	if (rq->curr->nr_cpus_allowed == 1 ||
> -	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
> +	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL, NULL))
>  		return;
>  
>  	/*
> @@ -1457,7 +1503,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
>  	 * see if it is pushed or pulled somewhere else.
>  	 */
>  	if (p->nr_cpus_allowed != 1
> -	    && cpupri_find(&rq->rd->cpupri, p, NULL))
> +	    && cpupri_find(&rq->rd->cpupri, p, NULL, NULL))
>  		return;
>  
>  	/*
> @@ -1600,7 +1646,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_fla
>  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
>  {
>  	if (!task_running(rq, p) &&
> -	    cpumask_test_cpu(cpu, p->cpus_ptr))
> +	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> +	    rt_task_fits_capacity(p, cpu))
>  		return 1;
>  
>  	return 0;
> @@ -1642,7 +1689,8 @@ static int find_lowest_rq(struct task_struct *task)
>  	if (task->nr_cpus_allowed == 1)
>  		return -1; /* No other targets possible */
>  
> -	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask))
> +	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask,
> +			 rt_task_fits_capacity))
>  		return -1; /* No targets found */
>  
>  	/*
> @@ -2146,12 +2194,14 @@ static void pull_rt_task(struct rq *this_rq)
>   */
>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
>  {
> -	if (!task_running(rq, p) &&
> -	    !test_tsk_need_resched(rq->curr) &&
> -	    p->nr_cpus_allowed > 1 &&
> -	    (dl_task(rq->curr) || rt_task(rq->curr)) &&
> -	    (rq->curr->nr_cpus_allowed < 2 ||
> -	     rq->curr->prio <= p->prio))
> +	bool need_to_push = !task_running(rq, p) &&
> +			    !test_tsk_need_resched(rq->curr) &&
> +			    p->nr_cpus_allowed > 1 &&
> +			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
> +			    (rq->curr->nr_cpus_allowed < 2 ||
> +			     rq->curr->prio <= p->prio);
> +
> +	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
>  		push_rt_tasks(rq);
>  }
>  
> @@ -2223,7 +2273,10 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  	 */
>  	if (task_on_rq_queued(p) && rq->curr != p) {
>  #ifdef CONFIG_SMP
> -		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
> +		bool need_to_push = rq->rt.overloaded ||
> +				    !rt_task_fits_capacity(p, cpu_of(rq));
> +
> +		if (p->nr_cpus_allowed > 1 && need_to_push)
>  			rt_queue_push_tasks(rq);
>  #endif /* CONFIG_SMP */
>  		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
> -- 
> 2.17.1
> 
