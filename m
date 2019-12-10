Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC80AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A387F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950529;
	bh=6VAQ1U2rnpuLdZeDT9xVjPxKpUozILPc+bcz3+w2kEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2XtVCUzEGfRFCgAJ4UhLEDR2/j3zVoSxO0wxYze+oqQv69DTxbCkGgE7S2kvdw355
	 VHXkZvzz7+hRonfcvBhVIMuyA2nINMpGZmIORGvEqw3zyTySmwDli+r8IzkyRPrwfW
	 pBYTZN5tLNZXk9el7I9jh5bRCujdH34/QZH9tnKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfLJECI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLJECD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:02:03 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BE824654;
        Tue, 10 Dec 2019 04:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950522;
        bh=6VAQ1U2rnpuLdZeDT9xVjPxKpUozILPc+bcz3+w2kEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLq4IfVVuhI1DOVpl+TvFCR4PT8XBDiY0ep5Vwgk89BI8/pKoyTUkE9HuEUiZ5Cfo
         EGPKH7XI26esWk/htI3rjpYE4j4BdFjocrBpWegscALQ0OdRe+jBuXj8k+Aulo5c04
         tJBKbCcq0ov7VKJU8NZLw1nmD2ggvcwP6eCkb8qI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/10] rcu: Enable tick for nohz_full CPUs slow to provide expedited QS
Date:   Mon,  9 Dec 2019 20:01:54 -0800
Message-Id: <20191210040154.2498-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

An expedited grace period can be stalled by a nohz_full CPU looping
in kernel context.  This possibility is currently handled by some
carefully crafted checks in rcu_read_unlock_special() that enlist help
from ksoftirqd when permitted by the scheduler.  However, it is exactly
these checks that require the scheduler avoid holding any of its rq or
pi locks across rcu_read_unlock() without also having held them across
the entire RCU read-side critical section.

It would therefore be very nice if expedited grace periods could
handle nohz_full CPUs looping in kernel context without such checks.
This commit therefore adds code to the expedited grace period's wait
and cleanup code that forces the scheduler-clock interrupt on for CPUs
that fail to quickly supply a quiescent state.  "Quickly" is currently
a hard-coded single-jiffy delay.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/tick.h  |  5 ++++-
 kernel/rcu/tree.h     |  1 +
 kernel/rcu/tree_exp.h | 52 ++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7896f792d3..7340613 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -109,8 +109,10 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
 	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
-	TICK_DEP_BIT_RCU		= 4
+	TICK_DEP_BIT_RCU		= 4,
+	TICK_DEP_BIT_RCU_EXP		= 5
 };
+#define TICK_DEP_BIT_MAX TICK_DEP_BIT_RCU_EXP
 
 #define TICK_DEP_MASK_NONE		0
 #define TICK_DEP_MASK_POSIX_TIMER	(1 << TICK_DEP_BIT_POSIX_TIMER)
@@ -118,6 +120,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
 #define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
+#define TICK_DEP_MASK_RCU_EXP		(1 << TICK_DEP_BIT_RCU_EXP)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 055c317..f9253ed 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -182,6 +182,7 @@ struct rcu_data {
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
+	bool rcu_forced_tick_exp;	/*   ... provide QS to expedited GP. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
 	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
 	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 081a179..30b2a02 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -230,7 +230,9 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
 static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 				    unsigned long mask, bool wake)
 {
+	int cpu;
 	unsigned long flags;
+	struct rcu_data *rdp;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	if (!(rnp->expmask & mask)) {
@@ -238,6 +240,13 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 		return;
 	}
 	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
+	for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
+		rdp = per_cpu_ptr(&rcu_data, cpu);
+		if (!IS_ENABLED(CONFIG_NO_HZ_FULL) || !rdp->rcu_forced_tick_exp)
+			continue;
+		rdp->rcu_forced_tick_exp = false;
+		tick_dep_clear_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+	}
 	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
 }
 
@@ -450,6 +459,26 @@ static void sync_rcu_exp_select_cpus(void)
 }
 
 /*
+ * Wait for the expedited grace period to elapse, within time limit.
+ * If the time limit is exceeded without the grace period elapsing,
+ * return false, otherwise return true.
+ */
+static bool synchronize_rcu_expedited_wait_once(long tlimit)
+{
+	int t;
+	struct rcu_node *rnp_root = rcu_get_root();
+
+	t = swait_event_timeout_exclusive(rcu_state.expedited_wq,
+					  sync_rcu_exp_done_unlocked(rnp_root),
+					  tlimit);
+	// Workqueues should not be signaled.
+	if (t > 0 || sync_rcu_exp_done_unlocked(rnp_root))
+		return true;
+	WARN_ON(t < 0);  /* workqueues should not be signaled. */
+	return false;
+}
+
+/*
  * Wait for the expedited grace period to elapse, issuing any needed
  * RCU CPU stall warnings along the way.
  */
@@ -460,22 +489,31 @@ static void synchronize_rcu_expedited_wait(void)
 	unsigned long jiffies_start;
 	unsigned long mask;
 	int ndetected;
+	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
-	int ret;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		if (synchronize_rcu_expedited_wait_once(1))
+			return;
+		rcu_for_each_leaf_node(rnp) {
+			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+				rdp = per_cpu_ptr(&rcu_data, cpu);
+				if (rdp->rcu_forced_tick_exp)
+					continue;
+				rdp->rcu_forced_tick_exp = true;
+				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+			}
+		}
+		WARN_ON_ONCE(1);
+	}
 
 	for (;;) {
-		ret = swait_event_timeout_exclusive(
-				rcu_state.expedited_wq,
-				sync_rcu_exp_done_unlocked(rnp_root),
-				jiffies_stall);
-		if (ret > 0 || sync_rcu_exp_done_unlocked(rnp_root))
+		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
 			return;
-		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
 		if (rcu_cpu_stall_suppress)
 			continue;
 		panic_on_rcu_stall();
-- 
2.9.5

