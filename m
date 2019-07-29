Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A093DC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA42070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfG2Wc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:32:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbfG2Wcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:32:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TMVm1c156877;
        Mon, 29 Jul 2019 18:32:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u29gcgbfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 18:32:37 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6TMVlWe156836;
        Mon, 29 Jul 2019 18:32:37 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u29gcgbex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 18:32:37 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6TMUYOx010031;
        Mon, 29 Jul 2019 22:32:36 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2u0e86jewu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 22:32:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6TMWZc239911904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 22:32:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EDC1B2066;
        Mon, 29 Jul 2019 22:32:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21839B205F;
        Mon, 29 Jul 2019 22:32:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jul 2019 22:32:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C4C8B16C9987; Mon, 29 Jul 2019 15:32:38 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:32:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org, paulmckrcu@gmail.com
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Message-ID: <20190729223238.GF14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190724115331.GA29059@linux.ibm.com>
 <20190724132257.GA1029@lenoir>
 <20190724135219.GY14271@linux.ibm.com>
 <20190724143012.GB1029@lenoir>
 <20190725011243.GZ14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725011243.GZ14271@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:12:43PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 24, 2019 at 04:30:13PM +0200, Frederic Weisbecker wrote:
> > On Wed, Jul 24, 2019 at 06:52:19AM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 24, 2019 at 03:22:59PM +0200, Frederic Weisbecker wrote:
> > > > On Wed, Jul 24, 2019 at 04:53:31AM -0700, Paul E. McKenney wrote:
> > > > > Hello!
> > > > > 
> > > > > One of the callback-invocation forward-progress issues turns out to
> > > > > be nohz_full CPUs not turning their scheduling-clock interrupt back on
> > > > > when running in kernel mode.  Given that callback floods can cause RCU's
> > > > > callback-invocation loop to run for some time, it would be good for this
> > > > > loop to re-enable this interrupt.  Of course, this problem applies to
> > > > > pretty much any kernel code that might loop for an extended time period,
> > > > > not just RCU.
> > > > > 
> > > > > I took a quick look at kernel/time/tick-sched.c and the closest thing
> > > > > I found was tick_nohz_full_kick_cpu(), except that (1) it isn't clear
> > > > > that this does much when invoked on the current CPU and (2) it doesn't
> > > > > help in rcutorture TREE04.  In contrast, disabling NO_HZ_FULL and using
> > > > > RCU_NOCB_CPU instead works quite well.
> > > > > 
> > > > > So what should I be calling instead of tick_nohz_full_kick_cpu() to
> > > > > re-enable the current CPU's scheduling-clock interrupt?
> > > > 
> > > > Indeed, kernel code is assumed to be quick enough (between two extended grace
> > > > periods) to avoid running the tick for RCU. But some long lasting kernel code
> > > > may require to tick temporarily.
> > > > 
> > > > You can use tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU) with the
> > > > following:
> > > > 
> > > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > > index f92a10b5e112..3f476e2a4bf7 100644
> > > > --- a/include/linux/tick.h
> > > > +++ b/include/linux/tick.h
> > > > @@ -108,7 +108,8 @@ enum tick_dep_bits {
> > > >  	TICK_DEP_BIT_POSIX_TIMER	= 0,
> > > >  	TICK_DEP_BIT_PERF_EVENTS	= 1,
> > > >  	TICK_DEP_BIT_SCHED		= 2,
> > > > -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> > > > +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> > > > +	TICK_DEP_BIT_RCU		= 4
> > > >  };
> > > >  
> > > >  #define TICK_DEP_MASK_NONE		0
> > > > @@ -116,6 +117,7 @@ enum tick_dep_bits {
> > > >  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
> > > >  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
> > > >  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> > > > +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> > > >  
> > > >  #ifdef CONFIG_NO_HZ_COMMON
> > > >  extern bool tick_nohz_enabled;
> > > 
> > > I will give this a try, thank you!  (Testing will take a few days.)
> > 
> > Sure!
> > 
> > For the background: expect a self-IPI to fire which then restart the tick on IRQ exit.
> > Once you're later done with the work, don't forget to remove the tick dependency:
> > 
> >      tick_nohz_dep_clear_cpu(cpu, TICK_DEP_MASK_RCU);
> 
> Does this get cleared automatically if preempted, or should I clear
> this is one of RCU's scheduler hooks?  (My guess is the latter, but
> I figured I should ask.)

The patch below (which includes your patch) does help considerably.
However, it does have some shortcomings:

1.	Adds an atomic operation (albeit a cache-local one) to
	the scheduler fastpath.  One approach would be to have
	a way of testing this bit and clearing it only if set.

	Another approach would be to instead clear it on the
	transition to nohz_full userspace or to idle.

2.	There are a lot of other places in the kernel that are in
	need of this bit being set.  I am therefore considering making
	multi_cpu_stop() or its callers set this bit on all CPUs upon
	entry and clear it upon exit.  While in this state, it is
	likely necessary to disable clearing this bit.  Or it would
	be necessary to make multi_cpu_stop() repeat clearing the bit
	every so often.

	As it stands, I have CPU hotplug removal operations taking
	more than 400 seconds.

3.	It was tempting to ask for this bit to be tracked on a per-task
	basis, but from what I can see that adds at least as much
	complexity as it removes.

Thoughts?

							Thanx, Paul

PS.  Outage on @linux.ibm.com, hence the CC of my gmail address.

------------------------------------------------------------------------

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 196a0a7bfc4f..0dea6fb33a11 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -108,7 +108,8 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_POSIX_TIMER	= 0,
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
-	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
+	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
+	TICK_DEP_BIT_RCU		= 4
 };
 
 #define TICK_DEP_MASK_NONE		0
@@ -116,6 +117,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
+#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
@@ -258,6 +260,9 @@ static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
+static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
 static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca1eab1..e6a74b9fb0b8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -44,6 +44,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
+#include <linux/tick.h>
 
 #include "rcu.h"
 
@@ -1353,6 +1354,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 static int
 rcu_torture_reader(void *arg)
 {
+	unsigned long i = 0;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
 	int mynumonline = myid;
@@ -1363,26 +1365,31 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
 				mod_timer(&t, jiffies + 1);
 		}
-		if (!rcu_torture_one_read(&rand))
+		if (!rcu_torture_one_read(&rand) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
-		if (time_after(jiffies, lastsleep)) {
+		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			schedule_timeout_interruptible(1);
 			lastsleep = jiffies + 10;
 		}
 		while (num_online_cpus() < mynumonline && !torture_must_stop())
 			schedule_timeout_interruptible(HZ / 5);
+		if (IS_ENABLED(CONFIG_NO_HZ_FULL) && i++ & 0x1f)
+			tick_nohz_dep_set_cpu(raw_smp_processor_id(),
+					      TICK_DEP_MASK_RCU);
 		stutter_wait("rcu_torture_reader");
 	} while (!torture_must_stop());
 	if (irqreader && cur_ops->irq_capable) {
 		del_timer_sync(&t);
 		destroy_timer_on_stack(&t);
 	}
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_clear_cpu(raw_smp_processor_id(),
+					TICK_DEP_MASK_RCU);
 	torture_kthread_stopping("rcu_torture_reader");
 	return 0;
 }
@@ -1729,10 +1736,12 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
-	} else {
-		// No userspace emulation: CB invocation throttles call_rcu()
-		cond_resched();
+		return;
 	}
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_set_cpu(smp_processor_id(), TICK_DEP_MASK_RCU);
+	// No userspace emulation: CB invocation throttles call_rcu()
+	cond_resched();
 }
 
 /*
@@ -1760,6 +1769,9 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
 	}
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_clear_cpu(raw_smp_processor_id(),
+					TICK_DEP_MASK_RCU);
 	return freed;
 }
 
@@ -1826,6 +1838,9 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		destroy_rcu_head_on_stack(&fcs.rh);
 	}
 	schedule_timeout_uninterruptible(HZ / 10); /* Let kthreads recover. */
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_clear_cpu(raw_smp_processor_id(),
+					TICK_DEP_MASK_RCU);
 	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 256622168356..4f0eb24d986e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2178,6 +2178,10 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			cond_resched_tasks_rcu_qs();
 			lockdep_assert_irqs_enabled();
 			local_bh_disable();
+			if (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
+			    !likely(-rcl.len & 31))
+				tick_nohz_dep_set_cpu(smp_processor_id(),
+						      TICK_DEP_MASK_RCU);
 		}
 	}
 
@@ -2217,6 +2221,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
 	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_clear_cpu(raw_smp_processor_id(),
+					TICK_DEP_MASK_RCU);
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 379cb7e50a62..7d285adc34c6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -329,6 +329,8 @@ void rcu_note_context_switch(bool preempt)
 	rcu_qs();
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_clear_cpu(smp_processor_id(), TICK_DEP_MASK_RCU);
 	trace_rcu_utilization(TPS("End context switch"));
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
@@ -853,6 +855,8 @@ void rcu_note_context_switch(bool preempt)
 	if (!preempt)
 		rcu_tasks_qs(current);
 out:
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_nohz_dep_clear_cpu(smp_processor_id(), TICK_DEP_MASK_RCU);
 	trace_rcu_utilization(TPS("End context switch"));
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f4ee1a3428ae..e617421a2c97 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -324,6 +324,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 		preempt_enable();
 	}
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_set_cpu);
 
 void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 {
@@ -331,6 +332,7 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 
 	atomic_andnot(BIT(bit), &ts->tick_dep_mask);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
  * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
