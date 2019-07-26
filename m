Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CD4C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B808022C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGZVYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:24:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfGZVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:24:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7h9-00030k-3Z; Fri, 26 Jul 2019 23:24:07 +0200
Message-Id: <20190726212124.210156346@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 23:19:38 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 2/8] rcu: Use CONFIG_PREEMPTION
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the conditionals in RCU to use CONFIG_PREEMPTION.

That's the first step towards RCU on RT. The further tweaks are work in
progress. This neither touches the selftest bits which need a closer look
by Paul.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
---
 arch/Kconfig             |    2 +-
 include/linux/rcupdate.h |    2 +-
 include/linux/rcutree.h  |    2 +-
 include/linux/torture.h  |    2 +-
 kernel/rcu/Kconfig       |    8 ++++----
 kernel/rcu/tree.c        |    6 +++---
 kernel/rcu/tree_stall.h  |    6 +++---
 kernel/trace/Kconfig     |    2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -103,7 +103,7 @@ config STATIC_KEYS_SELFTEST
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
-	select TASKS_RCU if PREEMPT
+	select TASKS_RCU if PREEMPTION
 
 config KPROBES_ON_FTRACE
 	def_bool y
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -578,7 +578,7 @@ do {									      \
  *
  * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
  * it is illegal to block while in an RCU read-side critical section.
- * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPT
+ * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
  * kernel builds, RCU read-side critical sections may be preempted,
  * but explicit blocking is illegal.  Finally, in preemptible RCU
  * implementations in real-time (with -rt patchset) kernel builds, RCU
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -53,7 +53,7 @@ void rcu_scheduler_starting(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
 #endif
 
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -86,7 +86,7 @@ void _torture_stop_kthread(char *m, stru
 #define torture_stop_kthread(n, tp) \
 	_torture_stop_kthread("Stopping " #n " task", &(tp))
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 #define torture_preempt_schedule() preempt_schedule()
 #else
 #define torture_preempt_schedule()
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -7,7 +7,7 @@ menu "RCU Subsystem"
 
 config TREE_RCU
 	bool
-	default y if !PREEMPT && SMP
+	default y if !PREEMPTION && SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP system with hundreds or
@@ -16,7 +16,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPT
+	default y if PREEMPTION
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP systems with hundreds or
@@ -28,7 +28,7 @@ config PREEMPT_RCU
 
 config TINY_RCU
 	bool
-	default y if !PREEMPT && !SMP
+	default y if !PREEMPTION && !SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for UP systems from which real-time response
@@ -70,7 +70,7 @@ config TREE_SRCU
 	  This option selects the full-fledged version of SRCU.
 
 config TASKS_RCU
-	def_bool PREEMPT
+	def_bool PREEMPTION
 	select SRCU
 	help
 	  This option enables a task-based RCU implementation that uses
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1881,7 +1881,7 @@ rcu_report_unblock_qs_rnp(struct rcu_nod
 	struct rcu_node *rnp_p;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT)) ||
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
 	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
 	    rnp->qsmask != 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2205,7 +2205,7 @@ static void force_qs_rnp(int (*f)(struct
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPT) ||
+			if (!IS_ENABLED(CONFIG_PREEMPTION) ||
 			    rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
@@ -2622,7 +2622,7 @@ static int rcu_blocking_is_gp(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_PREEMPT))
+	if (IS_ENABLED(CONFIG_PREEMPTION))
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_wo
 //
 // Printing RCU CPU stall warnings
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 
 /*
  * Dump detailed information for all tasks blocking the current RCU
@@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct r
 	return ndetected;
 }
 
-#else /* #ifdef CONFIG_PREEMPT */
+#else /* #ifdef CONFIG_PREEMPTION */
 
 /*
  * Because preemptible RCU does not exist, we never have to check for
@@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct r
 {
 	return 0;
 }
-#endif /* #else #ifdef CONFIG_PREEMPT */
+#endif /* #else #ifdef CONFIG_PREEMPTION */
 
 /*
  * Dump stacks of all tasks running on stalled CPUs.  First try using
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -146,7 +146,7 @@ config FUNCTION_TRACER
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
-	select TASKS_RCU if PREEMPT
+	select TASKS_RCU if PREEMPTION
 	help
 	  Enable the kernel to trace every kernel function. This is done
 	  by using a compiler feature to insert a small, 5-byte No-Operation


