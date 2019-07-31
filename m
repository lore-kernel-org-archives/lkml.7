Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F64206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JoBGD1Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGaR4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:56:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfGaR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:56:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHu6Mm3777279
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 10:56:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHu6Mm3777279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564595766;
        bh=kKmJDvHrIvqktLBPMUlU3D1J4ekTJDl3Zwave7tFyAA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JoBGD1Z4Gwg+KmGnm7x03SUPAWfPPs9WkVBblwlKFWkyfAaFwMnSC1fWLM03BxxiW
         e0I2P/UrRmUonacfyj3y+L6SUZpwYAxe6pWaUL/Kon/Y1EpXnFTOP4YwdHS2CuMoql
         gQr/+eVp4UYc35i0rY0fdCrMmb5pLiFF9DPKZc1+/xSYRGv0LEmnQAT0T8BCn1FiRL
         9Os42BcyNNP2KTgYRarg+abIR7dalvuiaQc+LRGu65TYrElGZrfaE/Djgcj3BMUpy3
         qr8mIa2/+tx7tt+yjG8I0hrrVYyxhtScUJ8qC863jv/4P846rRid+n9yzYUZqZZbW8
         KugbCr6/y06wg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHu6kX3777276;
        Wed, 31 Jul 2019 10:56:06 -0700
Date:   Wed, 31 Jul 2019 10:56:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-01b1d88b09824bea1a75b0bac04dcf50d9893875@git.kernel.org>
Cc:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        pbonzini@redhat.com, hpa@zytor.com, paulmck@linux.ibm.com
Reply-To: pbonzini@redhat.com, hpa@zytor.com, paulmck@linux.ibm.com,
          mhiramat@kernel.org, rostedt@goodmis.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190726212124.210156346@linutronix.de>
References: <20190726212124.210156346@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] rcu: Use CONFIG_PREEMPTION
Git-Commit-ID: 01b1d88b09824bea1a75b0bac04dcf50d9893875
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  01b1d88b09824bea1a75b0bac04dcf50d9893875
Gitweb:     https://git.kernel.org/tip/01b1d88b09824bea1a75b0bac04dcf50d9893875
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:38 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:35 +0200

rcu: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the conditionals in RCU to use CONFIG_PREEMPTION.

That's the first step towards RCU on RT. The further tweaks are work in
progress. This neither touches the selftest bits which need a closer look
by Paul.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.210156346@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig             | 2 +-
 include/linux/rcupdate.h | 2 +-
 include/linux/rcutree.h  | 2 +-
 include/linux/torture.h  | 2 +-
 kernel/rcu/Kconfig       | 8 ++++----
 kernel/rcu/tree.c        | 6 +++---
 kernel/rcu/tree_stall.h  | 6 +++---
 kernel/trace/Kconfig     | 2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..c7efbc018f4f 100644
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
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8f7167478c1d..c4f76a310443 100644
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
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 735601ac27d3..18b1ed9864b0 100644
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
 
diff --git a/include/linux/torture.h b/include/linux/torture.h
index a620118385bb..6241f59e2d6f 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -86,7 +86,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #define torture_stop_kthread(n, tp) \
 	_torture_stop_kthread("Stopping " #n " task", &(tp))
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 #define torture_preempt_schedule() preempt_schedule()
 #else
 #define torture_preempt_schedule()
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 480edf328b51..7644eda17d62 100644
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
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a14e5fbbea46..5962636502bc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1881,7 +1881,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
 	struct rcu_node *rnp_p;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT)) ||
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
 	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
 	    rnp->qsmask != 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2205,7 +2205,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
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
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 065183391f75..9b92bf18b737 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
 //
 // Printing RCU CPU stall warnings
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 
 /*
  * Dump detailed information for all tasks blocking the current RCU
@@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	return ndetected;
 }
 
-#else /* #ifdef CONFIG_PREEMPT */
+#else /* #ifdef CONFIG_PREEMPTION */
 
 /*
  * Because preemptible RCU does not exist, we never have to check for
@@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 {
 	return 0;
 }
-#endif /* #else #ifdef CONFIG_PREEMPT */
+#endif /* #else #ifdef CONFIG_PREEMPTION */
 
 /*
  * Dump stacks of all tasks running on stalled CPUs.  First try using
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 98da8998c25c..d2c1fe0b451d 100644
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
