Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF8BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBB322DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfIDLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfIDLZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:25:34 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB9B22CED;
        Wed,  4 Sep 2019 11:25:30 +0000 (UTC)
Date:   Wed, 4 Sep 2019 07:25:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alessio Balsini <balsini@android.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: rt: Make RT capacity aware
Message-ID: <20190904072524.09de28aa@oasis.local.home>
In-Reply-To: <20190903103329.24961-1-qais.yousef@arm.com>
References: <20190903103329.24961-1-qais.yousef@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 11:33:29 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

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

Nice change log. It clearly describes what you are trying to do with
the patch, and gives an idea of what is still needed to be done.

> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
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
>  kernel/sched/rt.c | 112 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 92 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a532558a5176..7c3bcbef692b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -436,6 +436,45 @@ static inline int on_rt_rq(struct sched_rt_entity *rt_se)
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
> +static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> +{
> +	unsigned int min_cap;
> +	unsigned int max_cap;
> +	unsigned int cpu_cap;
> +
> +	/* Only heterogeneous systems can benefit from this check */
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))

OK, so this is optimized for the case that UCLAMP_TASK is compiled in
but for an homogeneous system.

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
> @@ -1390,6 +1429,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
>  	struct task_struct *curr;
>  	struct rq *rq;
> +	bool test;
>  
>  	/* For anything but wake ups, just return the task_cpu */
>  	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
> @@ -1421,10 +1461,16 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
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
> @@ -1614,7 +1660,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
>  {
>  	if (!task_running(rq, p) &&
> -	    cpumask_test_cpu(cpu, p->cpus_ptr))
> +	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> +	    rt_task_fits_capacity(p, cpu))

Hmm, so if a CPU goes idle, and looks for CPUS with more than one RT
task queued (overloaded), it will skip pulling RT tasks if they are
below capacity. Is that the desired effect? I think we could end up
with a small idle CPUs with RT tasks waiting to run.


>  		return 1;
>  
>  	return 0;
> @@ -1648,6 +1695,7 @@ static int find_lowest_rq(struct task_struct *task)
>  	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
>  	int this_cpu = smp_processor_id();
>  	int cpu      = task_cpu(task);
> +	bool test;
>  
>  	/* Make sure the mask is initialized first */
>  	if (unlikely(!lowest_mask))
> @@ -1666,16 +1714,23 @@ static int find_lowest_rq(struct task_struct *task)
>  	 *
>  	 * We prioritize the last CPU that the task executed on since
>  	 * it is most likely cache-hot in that location.
> +	 *
> +	 * Assuming the task still fits the capacity of the last CPU.
>  	 */
> -	if (cpumask_test_cpu(cpu, lowest_mask))
> +	if (cpumask_test_cpu(cpu, lowest_mask) &&
> +	    rt_task_fits_capacity(task, cpu)) {
>  		return cpu;
> +	}
>  
>  	/*
>  	 * Otherwise, we consult the sched_domains span maps to figure
>  	 * out which CPU is logically closest to our hot cache data.
>  	 */
> -	if (!cpumask_test_cpu(this_cpu, lowest_mask))
> -		this_cpu = -1; /* Skip this_cpu opt if not among lowest */
> +	if (!cpumask_test_cpu(this_cpu, lowest_mask) ||
> +	    !rt_task_fits_capacity(task, this_cpu)) {
> +		/* Skip this_cpu opt if not among lowest or doesn't fit */
> +		this_cpu = -1;
> +	}
>  
>  	rcu_read_lock();
>  	for_each_domain(cpu, sd) {
> @@ -1692,11 +1747,15 @@ static int find_lowest_rq(struct task_struct *task)
>  				return this_cpu;
>  			}
>  
> -			best_cpu = cpumask_first_and(lowest_mask,
> -						     sched_domain_span(sd));
> -			if (best_cpu < nr_cpu_ids) {
> -				rcu_read_unlock();
> -				return best_cpu;
> +			for_each_cpu_and(best_cpu, lowest_mask,
> +					 sched_domain_span(sd)) {
> +				if (best_cpu >= nr_cpu_ids)

Can that happen in this loop?

> +					break;
> +
> +				if (rt_task_fits_capacity(task, best_cpu)) {
> +					rcu_read_unlock();
> +					return best_cpu;
> +				}
>  			}
>  		}
>  	}
> @@ -1711,7 +1770,15 @@ static int find_lowest_rq(struct task_struct *task)
>  		return this_cpu;
>  
>  	cpu = cpumask_any(lowest_mask);
> -	if (cpu < nr_cpu_ids)
> +
> +	/*
> +	 * Make sure that the fitness on @cpu doesn't change compared to the
> +	 * cpu we're currently running on.
> +	 */
> +	test = rt_task_fits_capacity(task, cpu) ==
> +	       rt_task_fits_capacity(task, task_cpu(task));

But what if the new CPU is a better fit, and we are running on a CPU
that's not fit?

-- Steve


> +
> +	if (cpu < nr_cpu_ids && test)
>  		return cpu;
>  
>  	return -1;
> @@ -2160,12 +2227,14 @@ static void pull_rt_task(struct rq *this_rq)
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
> +			    (dl_task(rq->curr) || rt_task(rq->curr))
> &&
> +			    (rq->curr->nr_cpus_allowed < 2 ||
> +			     rq->curr->prio <= p->prio);
> +
> +	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
>  		push_rt_tasks(rq);
>  }
>  
> @@ -2237,7 +2306,10 @@ static void switched_to_rt(struct rq *rq,
> struct task_struct *p) */
>  	if (task_on_rq_queued(p) && rq->curr != p) {
>  #ifdef CONFIG_SMP
> -		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
> +		bool need_to_push = rq->rt.overloaded ||
> +				    !rt_task_fits_capacity(p,
> cpu_of(rq)); +
> +		if (p->nr_cpus_allowed > 1 && need_to_push)
>  			rt_queue_push_tasks(rq);
>  #endif /* CONFIG_SMP */
>  		if (p->prio < rq->curr->prio &&
> cpu_online(cpu_of(rq)))

