Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FCC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDA42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950540;
	bh=ObLbG95x9eAGieFyHKsQrW0vM0boU/BiidF/qNBqnBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkEztQZEg0sy8jaJBsCP6X1KyV8ia6sDo3BT7xWiY6PPSQNa7EEx61Z+lsxBZGu49
	 wwusF7/MrAeApONlfBQdYN7IWe0Tad1sQdSpLm7ImUYfoZRRir+NjXpO6PjPJxaRDx
	 u6oRyZ6lwooxdecMllycQOmA4Q56a31Lkem+VWhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLJECT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLJECB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:02:01 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1414B214AF;
        Tue, 10 Dec 2019 04:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950520;
        bh=ObLbG95x9eAGieFyHKsQrW0vM0boU/BiidF/qNBqnBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+IU/jhlvp9Fl00DYNdw8dcWdbHj9ILYFHTpWF99J3aQk8WmQ3gIotoJHkVccOGT9
         hu9FgUAUBfmpjOoInMXVAUhU1+iJKa+Xi+Xd+sfRhxwkxO1fv9xWGLWjUOIABUd9J2
         Jo/PM52veJcstRUE+YTQlciY3LCPEDDFy6WAQt/c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/10] rcu: Rename sync_rcu_preempt_exp_done() to sync_rcu_exp_done()
Date:   Mon,  9 Dec 2019 20:01:51 -0800
Message-Id: <20191210040154.2498-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that the RCU flavors have been consolidated, there is one common
function for checking to see if an expedited RCU grace period has
completed, namely sync_rcu_preempt_exp_done().  Because this function is
no longer specific to RCU-preempt, this commit removes the "_preempt" from
its name.  This commit also changes sync_rcu_preempt_exp_done_unlocked()
to sync_rcu_exp_done_unlocked() for the same reason.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 19 +++++++++----------
 kernel/rcu/tree_plugin.h |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7a1f093..3923c07 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -148,7 +148,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
  *
  * Caller must hold the specificed rcu_node structure's ->lock
  */
-static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
+static bool sync_rcu_exp_done(struct rcu_node *rnp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -157,17 +157,16 @@ static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 }
 
 /*
- * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
- * doesn't hold the rcu_node's ->lock, and will acquire and release the lock
- * itself
+ * Like sync_rcu_exp_done(), but this function assumes the caller doesn't
+ * hold the rcu_node's ->lock, and will acquire and release the lock itself
  */
-static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
+static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
 {
 	unsigned long flags;
 	bool ret;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	ret = sync_rcu_preempt_exp_done(rnp);
+	ret = sync_rcu_exp_done(rnp);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	return ret;
@@ -191,7 +190,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 	unsigned long mask;
 
 	for (;;) {
-		if (!sync_rcu_preempt_exp_done(rnp)) {
+		if (!sync_rcu_exp_done(rnp)) {
 			if (!rnp->expmask)
 				rcu_initiate_boost(rnp, flags);
 			else
@@ -471,9 +470,9 @@ static void synchronize_sched_expedited_wait(void)
 	for (;;) {
 		ret = swait_event_timeout_exclusive(
 				rcu_state.expedited_wq,
-				sync_rcu_preempt_exp_done_unlocked(rnp_root),
+				sync_rcu_exp_done_unlocked(rnp_root),
 				jiffies_stall);
-		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
+		if (ret > 0 || sync_rcu_exp_done_unlocked(rnp_root))
 			return;
 		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
 		if (rcu_cpu_stall_suppress)
@@ -507,7 +506,7 @@ static void synchronize_sched_expedited_wait(void)
 			rcu_for_each_node_breadth_first(rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
-				if (sync_rcu_preempt_exp_done_unlocked(rnp))
+				if (sync_rcu_exp_done_unlocked(rnp))
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa08d55..6dbea4b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -485,7 +485,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
 			     (!empty_norm || rnp->qsmask));
-		empty_exp = sync_rcu_preempt_exp_done(rnp);
+		empty_exp = sync_rcu_exp_done(rnp);
 		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
 		list_del_init(&t->rcu_node_entry);
@@ -509,7 +509,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * Note that rcu_report_unblock_qs_rnp() releases rnp->lock,
 		 * so we must take a snapshot of the expedited state.
 		 */
-		empty_exp_now = sync_rcu_preempt_exp_done(rnp);
+		empty_exp_now = sync_rcu_exp_done(rnp);
 		if (!empty_norm && !rcu_preempt_blocked_readers_cgp(rnp)) {
 			trace_rcu_quiescent_state_report(TPS("preempt_rcu"),
 							 rnp->gp_seq,
-- 
2.9.5

