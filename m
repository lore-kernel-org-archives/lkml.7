Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD59C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5785120836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575952004;
	bh=TtuewavVP5vwIKVRdCXx1Q/YP4pSunXsFONv7HQROpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UyK5oImQ97uY3DyUfweWQ6prIYwgcvPtYuOnP0VDoUQwvhbixcOU8YiLGRjtbeqIU
	 RNAzWrR/5lX8Q49eU6ivr0l+OEpGmBnajQ/ZE2n2ThyZzqbPmPjir98XFuSjzkwCPd
	 cQFLMrlKU6FHRFhZfooZl1uJQM7zosmw3qxsfSjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLJE0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfLJE0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:39 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D858D24680;
        Tue, 10 Dec 2019 04:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951998;
        bh=TtuewavVP5vwIKVRdCXx1Q/YP4pSunXsFONv7HQROpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yo19HZo2Jo2vLh7c0gyjYXM9RaGYu2wZDCNEWOfcNOOhrpNuSUrpzd8lmF7scSebz
         5GQfHAz8qeMWhsBBGG2DYfZa/+Bvo5eka+1vSWhSB6dWRhGd2IPoA5AACfhmFbPQs7
         xDizkD4gzYfcuCcfAj1/rprn5SM5g2SIGq7RXErE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/11] rcu: Provide wrappers for uses of ->rcu_read_lock_nesting
Date:   Mon,  9 Dec 2019 20:26:28 -0800
Message-Id: <20191210042629.3808-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

This commit provides wrapper functions for uses of ->rcu_read_lock_nesting
to improve readability and to ease future changes to support inlining
of __rcu_read_lock() and __rcu_read_unlock().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    |  4 ++--
 kernel/rcu/tree_plugin.h | 53 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 98d078c..d8da6b1 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -610,7 +610,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!t->rcu_read_lock_nesting) {
+	if (!rcu_preempt_depth()) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
@@ -634,7 +634,7 @@ static void rcu_exp_handler(void *unused)
 	 * can have caused this quiescent state to already have been
 	 * reported, so we really do need to check ->expmask.
 	 */
-	if (t->rcu_read_lock_nesting > 0) {
+	if (rcu_preempt_depth() > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			rdp->exp_deferred_qs = true;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 698a7f1..ebdbdec 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -290,8 +290,8 @@ void rcu_note_context_switch(bool preempt)
 
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
-	if (t->rcu_read_lock_nesting > 0 &&
+	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
+	if (rcu_preempt_depth() > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
 		/* Possibly blocking in an RCU read-side critical section. */
@@ -348,6 +348,21 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 #define RCU_NEST_NMAX (-INT_MAX / 2)
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
+static void rcu_preempt_read_enter(void)
+{
+	current->rcu_read_lock_nesting++;
+}
+
+static void rcu_preempt_read_exit(void)
+{
+	current->rcu_read_lock_nesting--;
+}
+
+static void rcu_preempt_depth_set(int val)
+{
+	current->rcu_read_lock_nesting = val;
+}
+
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -355,9 +370,9 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
  */
 void __rcu_read_lock(void)
 {
-	current->rcu_read_lock_nesting++;
+	rcu_preempt_read_enter();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
-		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
+		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -373,19 +388,19 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (t->rcu_read_lock_nesting != 1) {
-		--t->rcu_read_lock_nesting;
+	if (rcu_preempt_depth() != 1) {
+		rcu_preempt_read_exit();
 	} else {
 		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
+		rcu_preempt_depth_set(-RCU_NEST_BIAS);
 		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 		barrier();  /* ->rcu_read_unlock_special load before assign */
-		t->rcu_read_lock_nesting = 0;
+		rcu_preempt_depth_set(0);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		int rrln = t->rcu_read_lock_nesting;
+		int rrln = rcu_preempt_depth();
 
 		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
 	}
@@ -539,7 +554,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       t->rcu_read_lock_nesting <= 0;
+	       rcu_preempt_depth() <= 0;
 }
 
 /*
@@ -552,16 +567,16 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
+	bool couldrecurse = rcu_preempt_depth() >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
 	if (couldrecurse)
-		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
+		rcu_preempt_depth_set(rcu_preempt_depth() - RCU_NEST_BIAS);
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 	if (couldrecurse)
-		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
+		rcu_preempt_depth_set(rcu_preempt_depth() + RCU_NEST_BIAS);
 }
 
 /*
@@ -672,7 +687,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
-	if (t->rcu_read_lock_nesting > 0 ||
+	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
@@ -682,13 +697,13 @@ static void rcu_flavor_sched_clock_irq(int user)
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
-	} else if (!t->rcu_read_lock_nesting) {
+	} else if (!rcu_preempt_depth()) {
 		rcu_qs(); /* Report immediate QS. */
 		return;
 	}
 
 	/* If GP is oldish, ask for help from rcu_read_unlock_special(). */
-	if (t->rcu_read_lock_nesting > 0 &&
+	if (rcu_preempt_depth() > 0 &&
 	    __this_cpu_read(rcu_data.core_needs_qs) &&
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
@@ -709,11 +724,11 @@ void exit_rcu(void)
 	struct task_struct *t = current;
 
 	if (unlikely(!list_empty(&current->rcu_node_entry))) {
-		t->rcu_read_lock_nesting = 1;
+		rcu_preempt_depth_set(1);
 		barrier();
 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
-	} else if (unlikely(t->rcu_read_lock_nesting)) {
-		t->rcu_read_lock_nesting = 1;
+	} else if (unlikely(rcu_preempt_depth())) {
+		rcu_preempt_depth_set(1);
 	} else {
 		return;
 	}
-- 
2.9.5

