Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F07206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCSP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:58:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbfCSP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:58:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JFpGi6001545
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:58:40 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb33vhgq2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:58:40 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 19 Mar 2019 15:58:38 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 15:58:34 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JFwYSe23920834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 15:58:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FE9B2067;
        Tue, 19 Mar 2019 15:58:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61366B2065;
        Tue, 19 Mar 2019 15:58:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 15:58:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9DEF916C2A37; Tue, 19 Mar 2019 08:59:23 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:59:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190318022434.GE4102@linux.ibm.com>
 <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031915-0068-0000-0000-000003A802EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010786; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176665; UDB=6.00615474; IPR=6.00957352;
 MB=3.00026056; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-19 15:58:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031915-0069-0000-0000-000047DED81D
Message-Id: <20190319155923.GY4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:44:19PM +0100, Sebastian Andrzej Siewior wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> Running RCU out of softirq is a problem for some workloads that would
> like to manage RCU core processing independently of other softirq work,
> for example, setting kthread priority.
> This commit therefore introduces the `rcunosoftirq' option which moves
> the RCU core work from softirq to a per-CPU/per-flavor SCHED_OTHER
> kthread named rcuc.
> The SCHED_OTHER approach avoids the scalability problems that appeared
> with the earlier attempt to move RCU core processing to from softirq to
> kthreads.
> That said, kernels built with RCU_BOOST=y will run the rcuc kthreads at
> the RCU-boosting priority.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [bigeasy: add rcunosoftirq option]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>        - rebased to Paul's rcu/dev tree/branch

Which is way better than an answer to my question, so thank you very
much!  ;-)

I doubt that there is any code left from my original, so I set you as
author.  I queued this and am starting tests without setting rcunosoftirq,
and will run more later setting it, courtesy of --bootargs.

Steve Rostedt did raise a good question about adding event tracing to
the park functions.  I haven't really settled on an answer yet.  Thoughts?

							Thanx, Paul

>        - Replaced Mike's email with @gmx.de since the @online.de does
> 	 not work anymore.
> 
>  kernel/rcu/tree.c        | 129 +++++++++++++++++++++++++++++++++---
>  kernel/rcu/tree.h        |   2 +-
>  kernel/rcu/tree_plugin.h | 137 +++++----------------------------------
>  3 files changed, 138 insertions(+), 130 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0f31b79eb6761..0a719f726e149 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -51,6 +51,12 @@
>  #include <linux/tick.h>
>  #include <linux/sysrq.h>
>  #include <linux/kprobes.h>
> +#include <linux/gfp.h>
> +#include <linux/oom.h>
> +#include <linux/smpboot.h>
> +#include <linux/jiffies.h>
> +#include <linux/sched/isolation.h>
> +#include "../time/tick-internal.h"
>  
>  #include "tree.h"
>  #include "rcu.h"
> @@ -2253,7 +2259,7 @@ void rcu_force_quiescent_state(void)
>  EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
>  
>  /* Perform RCU core processing work for the current CPU.  */
> -static __latent_entropy void rcu_core(struct softirq_action *unused)
> +static __latent_entropy void rcu_core(void)
>  {
>  	unsigned long flags;
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> @@ -2295,6 +2301,11 @@ static __latent_entropy void rcu_core(struct softirq_action *unused)
>  	trace_rcu_utilization(TPS("End RCU core"));
>  }
>  
> +static void rcu_core_si(struct softirq_action *h)
> +{
> +	rcu_core();
> +}
> +
>  /*
>   * Schedule RCU callback invocation.  If the running implementation of RCU
>   * does not support RCU priority boosting, just do a direct call, otherwise
> @@ -2306,19 +2317,120 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
>  {
>  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
>  		return;
> -	if (likely(!rcu_state.boost)) {
> -		rcu_do_batch(rdp);
> -		return;
> -	}
> -	invoke_rcu_callbacks_kthread();
> +	rcu_do_batch(rdp);
>  }
>  
> +static void rcu_wake_cond(struct task_struct *t, int status)
> +{
> +	/*
> +	 * If the thread is yielding, only wake it when this
> +	 * is invoked from idle
> +	 */
> +	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
> +		wake_up_process(t);
> +}
> +
> +static bool rcu_softirq_enabled = true;
> +
> +static int __init rcunosoftirq_setup(char *str)
> +{
> +	rcu_softirq_enabled = false;
> +	return 0;
> +}
> +__setup("rcunosoftirq", rcunosoftirq_setup);
> +
> +/*
> + * Wake up this CPU's rcuc kthread to do RCU core processing.
> + */
>  static void invoke_rcu_core(void)
>  {
> -	if (cpu_online(smp_processor_id()))
> +	unsigned long flags;
> +	struct task_struct *t;
> +
> +	if (!cpu_online(smp_processor_id()))
> +		return;
> +	if (rcu_softirq_enabled) {
>  		raise_softirq(RCU_SOFTIRQ);
> +	} else {
> +		local_irq_save(flags);
> +		__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> +		t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> +		if (t != NULL && t != current)
> +			rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> +		local_irq_restore(flags);
> +	}
>  }
>  
> +static void rcu_cpu_kthread_park(unsigned int cpu)
> +{
> +	per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
> +}
> +
> +static int rcu_cpu_kthread_should_run(unsigned int cpu)
> +{
> +	return __this_cpu_read(rcu_data.rcu_cpu_has_work);
> +}
> +
> +/*
> + * Per-CPU kernel thread that invokes RCU callbacks.  This replaces
> + * the RCU softirq used in configurations of RCU that do not support RCU
> + * priority boosting.
> + */
> +static void rcu_cpu_kthread(unsigned int cpu)
> +{
> +	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
> +	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
> +	int spincnt;
> +
> +	for (spincnt = 0; spincnt < 10; spincnt++) {
> +		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
> +		local_bh_disable();
> +		*statusp = RCU_KTHREAD_RUNNING;
> +		local_irq_disable();
> +		work = *workp;
> +		*workp = 0;
> +		local_irq_enable();
> +		if (work)
> +			rcu_core();
> +		local_bh_enable();
> +		if (*workp == 0) {
> +			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
> +			*statusp = RCU_KTHREAD_WAITING;
> +			return;
> +		}
> +	}
> +	*statusp = RCU_KTHREAD_YIELDING;
> +	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
> +	schedule_timeout_interruptible(2);
> +	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
> +	*statusp = RCU_KTHREAD_WAITING;
> +}
> +
> +static struct smp_hotplug_thread rcu_cpu_thread_spec = {
> +	.store			= &rcu_data.rcu_cpu_kthread_task,
> +	.thread_should_run	= rcu_cpu_kthread_should_run,
> +	.thread_fn		= rcu_cpu_kthread,
> +	.thread_comm		= "rcuc/%u",
> +	.setup			= rcu_cpu_kthread_setup,
> +	.park			= rcu_cpu_kthread_park,
> +};
> +
> +/*
> + * Spawn per-CPU RCU core processing kthreads.
> + */
> +static int __init rcu_spawn_core_kthreads(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> +	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
> +		return 0;
> +	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
> +	return 0;
> +}
> +early_initcall(rcu_spawn_core_kthreads);
> +
>  /*
>   * Handle any core-RCU processing required by a call_rcu() invocation.
>   */
> @@ -3355,7 +3467,8 @@ void __init rcu_init(void)
>  	rcu_init_one();
>  	if (dump_tree)
>  		rcu_dump_rcu_node_tree();
> -	open_softirq(RCU_SOFTIRQ, rcu_core);
> +	if (rcu_softirq_enabled)
> +		open_softirq(RCU_SOFTIRQ, rcu_core_si);
>  
>  	/*
>  	 * We don't need protection against CPU-hotplug here because
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index e253d11af3c49..a1a72a1ecb026 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -407,8 +407,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
>  static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
>  static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
>  static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
> -static void invoke_rcu_callbacks_kthread(void);
>  static bool rcu_is_callbacks_kthread(void);
> +static void rcu_cpu_kthread_setup(unsigned int cpu);
>  static void __init rcu_spawn_boost_kthreads(void);
>  static void rcu_prepare_kthreads(int cpu);
>  static void rcu_cleanup_after_idle(void);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index f46b4af96ab95..eb99e750a9306 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -11,29 +11,7 @@
>   *	   Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> -#include <linux/delay.h>
> -#include <linux/gfp.h>
> -#include <linux/oom.h>
> -#include <linux/sched/debug.h>
> -#include <linux/smpboot.h>
> -#include <linux/sched/isolation.h>
> -#include <uapi/linux/sched/types.h>
> -#include "../time/tick-internal.h"
> -
> -#ifdef CONFIG_RCU_BOOST
>  #include "../locking/rtmutex_common.h"
> -#else /* #ifdef CONFIG_RCU_BOOST */
> -
> -/*
> - * Some architectures do not define rt_mutexes, but if !CONFIG_RCU_BOOST,
> - * all uses are in dead code.  Provide a definition to keep the compiler
> - * happy, but add WARN_ON_ONCE() to complain if used in the wrong place.
> - * This probably needs to be excluded from -rt builds.
> - */
> -#define rt_mutex_owner(a) ({ WARN_ON_ONCE(1); NULL; })
> -#define rt_mutex_futex_unlock(x) WARN_ON_ONCE(1)
> -
> -#endif /* #else #ifdef CONFIG_RCU_BOOST */
>  
>  #ifdef CONFIG_RCU_NOCB_CPU
>  static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
> @@ -629,7 +607,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		/* Need to defer quiescent state until everything is enabled. */
>  		if (irqs_were_disabled) {
>  			/* Enabling irqs does not reschedule, so... */
> -			raise_softirq_irqoff(RCU_SOFTIRQ);
> +			if (rcu_softirq_enabled)
> +				raise_softirq_irqoff(RCU_SOFTIRQ);
> +			else
> +				invoke_rcu_core();
>  		} else {
>  			/* Enabling BH or preempt does reschedule, so... */
>  			set_tsk_need_resched(current);
> @@ -944,18 +925,21 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> -#ifdef CONFIG_RCU_BOOST
> -
> -static void rcu_wake_cond(struct task_struct *t, int status)
> +/*
> + * If boosting, set rcuc kthreads to realtime priority.
> + */
> +static void rcu_cpu_kthread_setup(unsigned int cpu)
>  {
> -	/*
> -	 * If the thread is yielding, only wake it when this
> -	 * is invoked from idle
> -	 */
> -	if (status != RCU_KTHREAD_YIELDING || is_idle_task(current))
> -		wake_up_process(t);
> +#ifdef CONFIG_RCU_BOOST
> +	struct sched_param sp;
> +
> +	sp.sched_priority = kthread_prio;
> +	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
> +#endif /* #ifdef CONFIG_RCU_BOOST */
>  }
>  
> +#ifdef CONFIG_RCU_BOOST
> +
>  /*
>   * Carry out RCU priority boosting on the task indicated by ->exp_tasks
>   * or ->boost_tasks, advancing the pointer to the next task in the
> @@ -1093,23 +1077,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>  	}
>  }
>  
> -/*
> - * Wake up the per-CPU kthread to invoke RCU callbacks.
> - */
> -static void invoke_rcu_callbacks_kthread(void)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> -	if (__this_cpu_read(rcu_data.rcu_cpu_kthread_task) != NULL &&
> -	    current != __this_cpu_read(rcu_data.rcu_cpu_kthread_task)) {
> -		rcu_wake_cond(__this_cpu_read(rcu_data.rcu_cpu_kthread_task),
> -			      __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> -	}
> -	local_irq_restore(flags);
> -}
> -
>  /*
>   * Is the current CPU running the RCU-callbacks kthread?
>   * Caller must have preemption disabled.
> @@ -1163,59 +1130,6 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  	return 0;
>  }
>  
> -static void rcu_cpu_kthread_setup(unsigned int cpu)
> -{
> -	struct sched_param sp;
> -
> -	sp.sched_priority = kthread_prio;
> -	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
> -}
> -
> -static void rcu_cpu_kthread_park(unsigned int cpu)
> -{
> -	per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
> -}
> -
> -static int rcu_cpu_kthread_should_run(unsigned int cpu)
> -{
> -	return __this_cpu_read(rcu_data.rcu_cpu_has_work);
> -}
> -
> -/*
> - * Per-CPU kernel thread that invokes RCU callbacks.  This replaces
> - * the RCU softirq used in configurations of RCU that do not support RCU
> - * priority boosting.
> - */
> -static void rcu_cpu_kthread(unsigned int cpu)
> -{
> -	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
> -	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
> -	int spincnt;
> -
> -	for (spincnt = 0; spincnt < 10; spincnt++) {
> -		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
> -		local_bh_disable();
> -		*statusp = RCU_KTHREAD_RUNNING;
> -		local_irq_disable();
> -		work = *workp;
> -		*workp = 0;
> -		local_irq_enable();
> -		if (work)
> -			rcu_do_batch(this_cpu_ptr(&rcu_data));
> -		local_bh_enable();
> -		if (*workp == 0) {
> -			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
> -			*statusp = RCU_KTHREAD_WAITING;
> -			return;
> -		}
> -	}
> -	*statusp = RCU_KTHREAD_YIELDING;
> -	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
> -	schedule_timeout_interruptible(2);
> -	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
> -	*statusp = RCU_KTHREAD_WAITING;
> -}
> -
>  /*
>   * Set the per-rcu_node kthread's affinity to cover all CPUs that are
>   * served by the rcu_node in question.  The CPU hotplug lock is still
> @@ -1246,27 +1160,13 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  	free_cpumask_var(cm);
>  }
>  
> -static struct smp_hotplug_thread rcu_cpu_thread_spec = {
> -	.store			= &rcu_data.rcu_cpu_kthread_task,
> -	.thread_should_run	= rcu_cpu_kthread_should_run,
> -	.thread_fn		= rcu_cpu_kthread,
> -	.thread_comm		= "rcuc/%u",
> -	.setup			= rcu_cpu_kthread_setup,
> -	.park			= rcu_cpu_kthread_park,
> -};
> -
>  /*
>   * Spawn boost kthreads -- called as soon as the scheduler is running.
>   */
>  static void __init rcu_spawn_boost_kthreads(void)
>  {
>  	struct rcu_node *rnp;
> -	int cpu;
>  
> -	for_each_possible_cpu(cpu)
> -		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> -	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
> -		return;
>  	rcu_for_each_leaf_node(rnp)
>  		(void)rcu_spawn_one_boost_kthread(rnp);
>  }
> @@ -1289,11 +1189,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>  
> -static void invoke_rcu_callbacks_kthread(void)
> -{
> -	WARN_ON_ONCE(1);
> -}
> -
>  static bool rcu_is_callbacks_kthread(void)
>  {
>  	return false;
> -- 
> 2.20.1
> 

