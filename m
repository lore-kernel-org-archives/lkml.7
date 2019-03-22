Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC68218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Pvbp4elE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfCVNmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:42:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfCVNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:42:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so1581591pfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eUh2dsJ7Rqlwc+KeDqID6cAhiQ76iSAdtd1vGliLhuM=;
        b=Pvbp4elEDqJ2xb2QvOeOsAABwECez77tHXcTybawmZ6ANWhg2qQ+tZFbKxZ5lFOv4A
         JHSBntUYU7zJFRZ4jaaNnCJbC5FQFmv4m0CeRA7cg0PFUasdlaTeUpTC9QSne1XkuGkP
         mgXMCJLVh/fWPhwdtdBtMKyf18wLngYii3168=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eUh2dsJ7Rqlwc+KeDqID6cAhiQ76iSAdtd1vGliLhuM=;
        b=pdsetxoobo8nrkquKKME3TQLR8ke7YbJlsbUclNwudrW1nVteGYLVRbxRi9ZwolMvp
         a6OcmlLNhBYJ0Ry1f5DiOTJo8EvJIeFI1mmINDhDTOQkzeIK7L8/3YLGVlpGp8p4P7GC
         6ERjHmCSEAG6yd6Kz7mkYoARhMfMDQqn71/SyDaLtRiqSFKf/Z8Lcye8dlWE4g0E1QBQ
         KVxJHt7YHCS8P2QNmnfKPMALIeWfpr+6W772Lt/sGGDh6U3ge/iQQmx16QUyJXG1buv5
         QVos0a3X+eHLqDp6a16iAZ6iZZTqC34nAL+hOSjou5s6A71hOwpRffGw7x/CKDjxSU6S
         +6fQ==
X-Gm-Message-State: APjAAAU7By/BkTwl4b+yAso4iaoq3acdhYvHUXseEY11BwVR4osXBxwC
        q6CrlEtquZEmPPDvvMop+9zHdw==
X-Google-Smtp-Source: APXvYqwMLFLpyMZeWHOeIHh0GeUJi2lzNzaQOB3wqsA79CLDUMq9RYYJ1BQAkyoU6kh2uXW5knaNPw==
X-Received: by 2002:a17:902:2989:: with SMTP id h9mr9675026plb.26.1553262129235;
        Fri, 22 Mar 2019 06:42:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 14sm12278989pft.137.2019.03.22.06.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 06:42:08 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:42:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Message-ID: <20190322134207.GA56461@google.com>
References: <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190320234601.GQ4102@linux.ibm.com>
 <20190321233244.GA11476@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321233244.GA11476@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:32:44PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 20, 2019 at 04:46:01PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 20, 2019 at 10:13:33PM +0100, Sebastian Andrzej Siewior wrote:
> > > Running RCU out of softirq is a problem for some workloads that would
> > > like to manage RCU core processing independently of other softirq
> > > work, for example, setting kthread priority.  This commit therefore
> > > introduces the `rcunosoftirq' option which moves the RCU core work
> > > from softirq to a per-CPU/per-flavor SCHED_OTHER kthread named rcuc.
> > > The SCHED_OTHER approach avoids the scalability problems that appeared
> > > with the earlier attempt to move RCU core processing to from softirq
> > > to kthreads.  That said, kernels built with RCU_BOOST=y will run the
> > > rcuc kthreads at the RCU-boosting priority.
> > > 
> > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > Tested-by: Mike Galbraith <efault@gmx.de>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Thank you!  I reverted v2 and applied this one with the same sort of
> > update.  Testing is going well thus far aside from my failing to add
> > the required "=0" after the rcutree.use_softirq.  I will probably not
> > be the only one who will run afoul of this, so I updated the commit log
> > and the documentation accordingly, as shown below.
> 
> And I took a look, please see updates/questions interspersed.
[snip]
> 
> > ------------------------------------------------------------------------
> > 
> > commit 5971694b716d34baa86f3f1dd44f8e587a17d8f0
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Wed Mar 20 22:13:33 2019 +0100
> > 
> >     rcu: Enable elimination of Tree-RCU softirq processing
> >     
> >     Some workloads need to change kthread priority for RCU core processing
> >     without affecting other softirq work.  This commit therefore introduces
> >     the rcutree.use_softirq kernel boot parameter, which moves the RCU core
> >     work from softirq to a per-CPU SCHED_OTHER kthread named rcuc.  Use of
> >     SCHED_OTHER approach avoids the scalability problems that appeared
> >     with the earlier attempt to move RCU core processing to from softirq
> >     to kthreads.  That said, kernels built with RCU_BOOST=y will run the
> >     rcuc kthreads at the RCU-boosting priority.
> >     
> >     Note that rcutree.use_softirq=0 must be specified to move RCU core
> >     processing to the rcuc kthreads: rcutree.use_softirq=1 is the default.
> >     
> >     Reported-by: Thomas Gleixner <tglx@linutronix.de>
> >     Tested-by: Mike Galbraith <efault@gmx.de>
> >     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index d377a2166b79..e2ffb1d9de03 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3672,6 +3672,12 @@
> >  			the propagation of recent CPU-hotplug changes up
> >  			the rcu_node combining tree.
> >  
> > +	rcutree.use_softirq=	[KNL]
> > +			If set to zero, move all RCU_SOFTIRQ processing to
> > +			per-CPU rcuc kthreads.  Defaults to a non-zero
> > +			value, meaning that RCU_SOFTIRQ is used by default.
> > +			Specify rcutree.use_softirq=0 to use rcuc kthreads.
> > +
> >  	rcutree.rcu_fanout_exact= [KNL]
> >  			Disable autobalancing of the rcu_node combining
> >  			tree.  This is used by rcutorture, and might
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ec77ec336f58..6bd05c9918cc 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -51,6 +51,12 @@
> >  #include <linux/tick.h>
> >  #include <linux/sysrq.h>
> >  #include <linux/kprobes.h>
> > +#include <linux/gfp.h>
> > +#include <linux/oom.h>
> > +#include <linux/smpboot.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/sched/isolation.h>
> > +#include "../time/tick-internal.h"
> >  
> >  #include "tree.h"
> >  #include "rcu.h"
> > @@ -92,6 +98,9 @@ struct rcu_state rcu_state = {
> >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> >  static bool dump_tree;
> >  module_param(dump_tree, bool, 0444);
> > +/* Move RCU_SOFTIRQ to rcuc kthreads. */
> 
> I am replacing this with:
> 
> +/* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
> 
> > +static bool use_softirq = 1;
> > +module_param(use_softirq, bool, 0444);
> >  /* Control rcu_node-tree auto-balancing at boot time. */
> >  static bool rcu_fanout_exact;
> >  module_param(rcu_fanout_exact, bool, 0444);
> > @@ -2253,7 +2262,7 @@ void rcu_force_quiescent_state(void)
> >  EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
> >  
> >  /* Perform RCU core processing work for the current CPU.  */
> > -static __latent_entropy void rcu_core(struct softirq_action *unused)
> > +static __latent_entropy void rcu_core(void)
> >  {
> >  	unsigned long flags;
> >  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> > @@ -2295,6 +2304,34 @@ static __latent_entropy void rcu_core(struct softirq_action *unused)
> >  	trace_rcu_utilization(TPS("End RCU core"));
> >  }
> >  
> > +static void rcu_core_si(struct softirq_action *h)
> > +{
> > +	rcu_core();
> > +}
> > +
> > +static void rcu_wake_cond(struct task_struct *t, int status)
> > +{
> > +	/*
> > +	 * If the thread is yielding, only wake it when this
> > +	 * is invoked from idle
> > +	 */
> > +	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
> > +		wake_up_process(t);
> > +}
> > +
> > +static void invoke_rcu_core_kthread(void)
> > +{
> > +	struct task_struct *t;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> > +	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> > +	if (t != NULL && t != current)
> > +		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> > +	local_irq_restore(flags);
> > +}
> > +
> >  /*
> >   * Schedule RCU callback invocation.  If the running implementation of RCU
> >   * does not support RCU priority boosting, just do a direct call, otherwise
> > @@ -2306,18 +2343,94 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
> >  {
> >  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> >  		return;
> > -	if (likely(!rcu_state.boost)) {
> > -		rcu_do_batch(rdp);
> > -		return;
> > -	}
> > -	invoke_rcu_callbacks_kthread();
> > +	if (rcu_state.boost || !use_softirq)
> > +		invoke_rcu_core_kthread();
> > +	rcu_do_batch(rdp);
> >  }
> >  
> > +/*
> > + * Wake up this CPU's rcuc kthread to do RCU core processing.
> > + */
> >  static void invoke_rcu_core(void)
> >  {
> > -	if (cpu_online(smp_processor_id()))
> > +	if (!cpu_online(smp_processor_id()))
> > +		return;
> > +	if (use_softirq)
> >  		raise_softirq(RCU_SOFTIRQ);
> > +	else
> > +		invoke_rcu_core_kthread();
> > +}
> > +
> > +static void rcu_cpu_kthread_park(unsigned int cpu)
> > +{
> > +	per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
> > +}
> > +
> > +static int rcu_cpu_kthread_should_run(unsigned int cpu)
> > +{
> > +	return __this_cpu_read(rcu_data.rcu_cpu_has_work);
> > +}
> > +
> > +/*
> > + * Per-CPU kernel thread that invokes RCU callbacks.  This replaces
> > + * the RCU softirq used in configurations of RCU that do not support RCU
> > + * priority boosting.
> > + */
> > +static void rcu_cpu_kthread(unsigned int cpu)
> > +{
> > +	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
> > +	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
> > +	int spincnt;
> > +
> > +	for (spincnt = 0; spincnt < 10; spincnt++) {
> > +		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
> > +		local_bh_disable();
> > +		*statusp = RCU_KTHREAD_RUNNING;
> > +		local_irq_disable();
> > +		work = *workp;
> > +		*workp = 0;
> > +		local_irq_enable();
> > +		if (work)
> > +			rcu_core();
> > +		local_bh_enable();
> > +		if (*workp == 0) {
> > +			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
> > +			*statusp = RCU_KTHREAD_WAITING;
> > +			return;
> > +		}
> > +	}
> > +	*statusp = RCU_KTHREAD_YIELDING;
> > +	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
> > +	schedule_timeout_interruptible(2);
> > +	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
> > +	*statusp = RCU_KTHREAD_WAITING;
> > +}
> > +
> > +static struct smp_hotplug_thread rcu_cpu_thread_spec = {
> > +	.store			= &rcu_data.rcu_cpu_kthread_task,
> > +	.thread_should_run	= rcu_cpu_kthread_should_run,
> > +	.thread_fn		= rcu_cpu_kthread,
> > +	.thread_comm		= "rcuc/%u",
> > +	.setup			= rcu_cpu_kthread_setup,
> > +	.park			= rcu_cpu_kthread_park,
> > +};
> > +
> > +/*
> > + * Spawn per-CPU RCU core processing kthreads.
> > + */
> > +static int __init rcu_spawn_core_kthreads(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> > +	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
> > +		return 0;
> > +	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
> > +		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
> > +	return 0;
> >  }
> > +early_initcall(rcu_spawn_core_kthreads);
> >  
> >  /*
> >   * Handle any core-RCU processing required by a call_rcu() invocation.
> > @@ -3355,7 +3468,8 @@ void __init rcu_init(void)
> >  	rcu_init_one();
> >  	if (dump_tree)
> >  		rcu_dump_rcu_node_tree();
> > -	open_softirq(RCU_SOFTIRQ, rcu_core);
> > +	if (use_softirq)
> > +		open_softirq(RCU_SOFTIRQ, rcu_core_si);
> >  
> >  	/*
> >  	 * We don't need protection against CPU-hotplug here because
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index e253d11af3c4..a1a72a1ecb02 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -407,8 +407,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
> >  static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
> >  static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
> >  static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
> > -static void invoke_rcu_callbacks_kthread(void);
> >  static bool rcu_is_callbacks_kthread(void);
> > +static void rcu_cpu_kthread_setup(unsigned int cpu);
> >  static void __init rcu_spawn_boost_kthreads(void);
> >  static void rcu_prepare_kthreads(int cpu);
> >  static void rcu_cleanup_after_idle(void);
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index f46b4af96ab9..b807204ffd83 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -11,29 +11,7 @@
> >   *	   Paul E. McKenney <paulmck@linux.ibm.com>
> >   */
> >  
> > -#include <linux/delay.h>
> > -#include <linux/gfp.h>
> > -#include <linux/oom.h>
> > -#include <linux/sched/debug.h>
> > -#include <linux/smpboot.h>
> > -#include <linux/sched/isolation.h>
> > -#include <uapi/linux/sched/types.h>
> > -#include "../time/tick-internal.h"
> > -
> > -#ifdef CONFIG_RCU_BOOST
> >  #include "../locking/rtmutex_common.h"
> > -#else /* #ifdef CONFIG_RCU_BOOST */
> > -
> > -/*
> > - * Some architectures do not define rt_mutexes, but if !CONFIG_RCU_BOOST,
> > - * all uses are in dead code.  Provide a definition to keep the compiler
> > - * happy, but add WARN_ON_ONCE() to complain if used in the wrong place.
> > - * This probably needs to be excluded from -rt builds.
> > - */
> > -#define rt_mutex_owner(a) ({ WARN_ON_ONCE(1); NULL; })
> > -#define rt_mutex_futex_unlock(x) WARN_ON_ONCE(1)
> > -
> > -#endif /* #else #ifdef CONFIG_RCU_BOOST */
> >  
> >  #ifdef CONFIG_RCU_NOCB_CPU
> >  static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
> > @@ -94,6 +72,8 @@ static void __init rcu_bootup_announce_oddness(void)
> >  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
> >  	if (gp_cleanup_delay)
> >  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
> > +	if (!use_softirq)
> > +		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
> >  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
> >  		pr_info("\tRCU debug extended QS entry/exit.\n");
> >  	rcupdate_announce_bootup_oddness();
> > @@ -629,7 +609,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		/* Need to defer quiescent state until everything is enabled. */
> >  		if (irqs_were_disabled) {
> >  			/* Enabling irqs does not reschedule, so... */
> > -			raise_softirq_irqoff(RCU_SOFTIRQ);
> > +			if (!use_softirq)
> > +				raise_softirq_irqoff(RCU_SOFTIRQ);
> > +			else
> > +				invoke_rcu_core();
> 
> This can result in deadlock.  This happens when the scheduler invokes
> rcu_read_unlock() with one of the rq or pi locks held, which means that
> interrupts are disabled.  And it also means that the wakeup done in
> invoke_rcu_core() could go after the same rq or pi lock.
> 
> What we really need here is some way to make soemthing happen on this
> CPU just after interrupts are re-enabled.  Here are the options I see:
> 
> 1.	Do set_tsk_need_resched() and set_preempt_need_resched(),
> 	just like in the "else" clause below.  This sort of works, but
> 	relies on some later interrupt or similar to get things started.
> 	This is just fine for normal grace periods, but not so much for
> 	expedited grace periods.
> 
> 2.	IPI some other CPU and have it IPI us back.  Not such a good plan
> 	when running an SMP kernel on a single CPU.
> 
> 3.	Have a "stub" RCU_SOFTIRQ that contains only the following:
> 
> 	/* Report any deferred quiescent states if preemption enabled. */
> 	if (!(preempt_count() & PREEMPT_MASK)) {
> 		rcu_preempt_deferred_qs(current);
> 	} else if (rcu_preempt_need_deferred_qs(current)) {
> 		set_tsk_need_resched(current);
> 		set_preempt_need_resched();
> 	}
> 
> 4.	Except that raise_softirq_irqoff() could potentially have this
> 	same problem if rcu_read_unlock() is invoked at process level
> 	from the scheduler with either rq or pi locks held.  :-/
> 
> 	Which raises the question "why aren't I seeing hangs and
> 	lockdep splats?"

Interesting, could it be you're not seeing a hang in the regular case,
because enqueuing ksoftirqd on the same CPU as where the rcu_read_unlock is
happening is a rare event? First, ksoftirqd has to even be awakened in the
first place. On the other hand, with the new code the thread is always awaked
and is more likely to run into the issue you found?

The lockdep splats should be a more common occurence though IMO. If you could
let me know which RCU config is hanging, I can try to debug this at my end as
well.

> Assuming that this really is a problem, perhaps I need to do something
> like the following:
> 
> 		if (in_interrupt()) {
> 			/* In interrupt, so catch softirq on the way out. */
> 			if (use_softirq)
> 				raise_softirq_irqoff(RCU_SOFTIRQ);
> 			else
> 				invoke_rcu_core();
> 		} else {
> 			/* Force resschedule, perhaps quite a bit later. */
> 			set_tsk_need_resched(current);
> 			set_preempt_need_resched();
> 		}
> 
> This can delay the quiescent state when rcu_read_unlock() is invoked from
> process level with interrupts disabled.  I suppose I could post a very
> short-timeout hrtimer, but would that be lightweight enough?  I cannot
> use self-targeted smp_call_function_single() because it wants interrupts
> enabled and because it will just do a direct call, which won't help here.
> I could use a timer, though the latency is larger than would be good.

I was thinking for some time, we should have statistics counters for this
sort of thing. So we run rcutorture and then sample the stats counters from
/proc or something to see how long all of these things took (longest grace
period etc). Would that be something of interest to make this task easier?

> Also, having lots of non-migratable timers might be considered unfriendly,
> though they shouldn't be -that- heavily utilized.  Yet, anyway...
> I could try adding logic to local_irq_enable() and local_irq_restore(),
> but that probably wouldn't go over all that well.  Besides, sometimes
> interrupt enabling happens in assembly language.
> 
> It is quite likely that delays to expedited grace periods wouldn't
> happen all that often.  First, the grace period has to start while
> the CPU itself (not some blocked task) is in an RCU read-side critical
> section, second, that critical section cannot be preempted, and third
> the rcu_read_unlock() must run with interrupts disabled.
> 
> Ah, but that sequence of events is not supposed to happen with the
> scheduler lock!
> 
> From Documentation/RCU/Design/Requirements/Requirements.html:
> 
> 	It is forbidden to hold any of scheduler's runqueue or
> 	priority-inheritance spinlocks across an rcu_read_unlock()
> 	unless interrupts have been disabled across the entire RCU
> 	read-side critical section, that is, up to and including the
> 	matching rcu_read_lock().
> 
> Here are the reasons we even get to rcu_read_unlock_special():
> 
> 1.	The just-ended RCU read-side critical section was preempted.
> 	This clearly cannot happen if interrupts are disabled across
> 	the entire critical section.
> 
> 2.	The scheduling-clock interrupt noticed that this critical
> 	section has been taking a long time.  But scheduling-clock
> 	interrupts also cannot happen while interrupts are disabled.
> 
> 3.	An expedited grace periods started during this critical
> 	section.  But if that happened, the corresponding IPI would
> 	have waited until this CPU enabled interrupts, so this
> 	cannot happen either.
> 
> So the call to invoke_rcu_core() should be OK after all.
> 
> Which is a bit of a disappointment, given that I am still seeing hangs!

Oh ok, discount whatever I just said then ;-) Indeed I remember this
requirement too now. Your neat documentation skills are indeed life saving :D

> I might replace this invoke_rcu_core() with set_tsk_need_resched() and
> set_preempt_need_resched() to see if that gets rid of the hangs, but
> first...

Could we use the NMI watchdog to dump the stack at the time of the hang? May
be a deadlock will present on the stack (I think its config is called
HARDLOCKUP_DETECTOR or something).

thanks,

 - Joel

