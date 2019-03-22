Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D91C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8886E2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EQiiCmOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCVXsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:48:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41056 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCVXsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:48:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so2518596pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vHvq6U/bu2QphuZFkVgKwByLM9T8nHXPrLHdpKD4+2c=;
        b=EQiiCmOH1/xnATb91Zenve+zm3UeDL5ZLsok2b8cJ8FfbLnw3eLAc7y9TH/dV1qi6q
         OvxFy4ZpMUiK4nl3Tm7+a42W3WnmqJjvsVfSHcoe/4dSBnka2jIQEv6Mb67by49kj1Du
         OWp5HPvvGKmAhWlYGkPWvF3iVAt3W7gojVLCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vHvq6U/bu2QphuZFkVgKwByLM9T8nHXPrLHdpKD4+2c=;
        b=oOfzWgoqXaqQiR3QFUUespiIXbPviWUwFo96nTkmJcDGcfe9C8E9TkKVKeId+Qt4FD
         juPsN7GaGhfgPoiZ2c7qmn6FwLveS8NWtz90LQZiwJDBccdJFIrbZ86o8HjFPLAoO4ed
         39E+6zrG8UwZjnX2ZTWt8a3WfcTj3+l+7F4t+PysQD6z3jNSg8JmAOPclkdLHJPPDkuw
         NgfVpVTRsw3Hw4KJGe7FzvVUedVAbq3/k+YFcN9dkrhu4/mzaO3EubcqPhZXi1UqYvWn
         lDUsiVvfa5A89BKMwtmmL2+lK1Vv8bLVXhSfx4+VOUAz1FEJoK4Reu1Ck/T/MkRlG6/A
         W+4A==
X-Gm-Message-State: APjAAAWaiboXoZoTnzfbWHqde8Ac27rj8RbwsMx9+TcAevY1SMHn1/5m
        sWqjvpN9N0l1vuwX6UF/z6tg7A==
X-Google-Smtp-Source: APXvYqy65OcSKc+8B8gy0SABTb+pZKxhBZidWMVfysaffuzQSUSP3pQdkc3fmbnUivE8wTFZ5UCt6A==
X-Received: by 2002:a17:902:e40a:: with SMTP id ci10mr12309212plb.77.1553298502262;
        Fri, 22 Mar 2019 16:48:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j9sm14640657pfc.67.2019.03.22.16.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 16:48:21 -0700 (PDT)
Date:   Fri, 22 Mar 2019 19:48:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Message-ID: <20190322234819.GA99360@google.com>
References: <20190320152146.GH4102@linux.ibm.com>
 <20190320154440.GA16332@linux.ibm.com>
 <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320211333.eq7pwxnte7la67ph@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:13:33PM +0100, Sebastian Andrzej Siewior wrote:
> Running RCU out of softirq is a problem for some workloads that would
> like to manage RCU core processing independently of other softirq
> work, for example, setting kthread priority.  This commit therefore
> introduces the `rcunosoftirq' option which moves the RCU core work
> from softirq to a per-CPU/per-flavor SCHED_OTHER kthread named rcuc.
> The SCHED_OTHER approach avoids the scalability problems that appeared
> with the earlier attempt to move RCU core processing to from softirq
> to kthreads.  That said, kernels built with RCU_BOOST=y will run the
> rcuc kthreads at the RCU-boosting priority.
[snip]
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0f31b79eb6761..05a1e42fdaf10 100644
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
> @@ -92,6 +98,9 @@ struct rcu_state rcu_state = {
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
>  static bool dump_tree;
>  module_param(dump_tree, bool, 0444);
> +/* Move RCU_SOFTIRQ to rcuc kthreads. */
> +static bool use_softirq = 1;
> +module_param(use_softirq, bool, 0444);
>  /* Control rcu_node-tree auto-balancing at boot time. */
>  static bool rcu_fanout_exact;
>  module_param(rcu_fanout_exact, bool, 0444);
> @@ -2253,7 +2262,7 @@ void rcu_force_quiescent_state(void)
>  EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
>  
>  /* Perform RCU core processing work for the current CPU.  */
> -static __latent_entropy void rcu_core(struct softirq_action *unused)
> +static __latent_entropy void rcu_core(void)
>  {
>  	unsigned long flags;
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> @@ -2295,6 +2304,34 @@ static __latent_entropy void rcu_core(struct softirq_action *unused)
>  	trace_rcu_utilization(TPS("End RCU core"));
>  }
>  
> +static void rcu_core_si(struct softirq_action *h)
> +{
> +	rcu_core();
> +}
> +
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
> +static void invoke_rcu_core_kthread(void)
> +{
> +	struct task_struct *t;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> +	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> +	if (t != NULL && t != current)
> +		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> +	local_irq_restore(flags);
> +}
> +
>  /*
>   * Schedule RCU callback invocation.  If the running implementation of RCU
>   * does not support RCU priority boosting, just do a direct call, otherwise
> @@ -2306,19 +2343,95 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
>  {
>  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
>  		return;
> -	if (likely(!rcu_state.boost)) {
> -		rcu_do_batch(rdp);
> -		return;
> -	}
> -	invoke_rcu_callbacks_kthread();
> +	if (rcu_state.boost || !use_softirq)
> +		invoke_rcu_core_kthread();
> +	rcu_do_batch(rdp);

Shouldn't there be an else before the rcu_do_batch? If we are waking up the
rcuc thread, then that will do the rcu_do_batch when it runs right?

Something like:
	if (rcu_state.boost || !use_softirq)
		invoke_rcu_core_kthread();
	else
		rcu_do_batch(rdp);

Previous code similarly had a return; also.

>  }
>  
> +/*
> + * Wake up this CPU's rcuc kthread to do RCU core processing.
> + */
>  static void invoke_rcu_core(void)
>  {
> -	if (cpu_online(smp_processor_id()))
> +	if (!cpu_online(smp_processor_id()))
> +		return;
> +	if (use_softirq)
>  		raise_softirq(RCU_SOFTIRQ);
> +	else
> +		invoke_rcu_core_kthread();
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
[snip]
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
> index f46b4af96ab95..b807204ffd83f 100644
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
> @@ -94,6 +72,8 @@ static void __init rcu_bootup_announce_oddness(void)
>  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
>  	if (gp_cleanup_delay)
>  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
> +	if (!use_softirq)
> +		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
>  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
>  		pr_info("\tRCU debug extended QS entry/exit.\n");
>  	rcupdate_announce_bootup_oddness();
> @@ -629,7 +609,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		/* Need to defer quiescent state until everything is enabled. */
>  		if (irqs_were_disabled) {
>  			/* Enabling irqs does not reschedule, so... */
> -			raise_softirq_irqoff(RCU_SOFTIRQ);
> +			if (!use_softirq)
> +				raise_softirq_irqoff(RCU_SOFTIRQ);

I believe this exclamation has been corrected in Paul's tree so that's Ok.

> +			else
> +				invoke_rcu_core();

But why not just directly call invoke_rcu_core() here? That will do the
appropriate use_softirq check right?

thanks,

 - Joel


>  		} else {
>  			/* Enabling BH or preempt does reschedule, so... */
>  			set_tsk_need_resched(current);
> @@ -944,18 +927,21 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
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
> @@ -1093,23 +1079,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
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
> @@ -1163,59 +1132,6 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
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
> @@ -1246,27 +1162,13 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
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
> @@ -1289,11 +1191,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
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
