Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E9ACA9ED3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4468214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKBMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:47:27 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48713 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbfKBMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Th-jslZ_1572698841;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-jslZ_1572698841)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:21 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 5/7] rcu: wrap usages of rcu_read_lock_nesting
Date:   Sat,  2 Nov 2019 12:45:57 +0000
Message-Id: <20191102124559.1135-6-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191102124559.1135-1-laijs@linux.alibaba.com>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
Reply-To: <20191101162109.GN20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for using percpu rcu_preempt_depth on x86

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_exp.h    |  4 ++--
 kernel/rcu/tree_plugin.h | 43 ++++++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index afa9f573b00f..dcb2124203cf 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -608,7 +608,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!t->rcu_read_lock_nesting) {
+	if (!rcu_preempt_depth()) {
 		rdp->exp_deferred_qs = true;
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
@@ -632,7 +632,7 @@ static void rcu_exp_handler(void *unused)
 	 * can have caused this quiescent state to already have been
 	 * reported, so we really do need to check ->expmask.
 	 */
-	if (t->rcu_read_lock_nesting > 0) {
+	if (rcu_preempt_depth() > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			rdp->exp_deferred_qs = true;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 98644966c808..eb5906c55c8d 100644
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
@@ -346,6 +346,21 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 /* Bias and limit values for ->rcu_read_lock_nesting. */
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
+static inline void rcu_preempt_depth_inc(void)
+{
+	current->rcu_read_lock_nesting++;
+}
+
+static inline bool rcu_preempt_depth_dec_and_test(void)
+{
+	return --current->rcu_read_lock_nesting == 0;
+}
+
+static inline void rcu_preempt_depth_set(int val)
+{
+	current->rcu_read_lock_nesting = val;
+}
+
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -353,9 +368,9 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
  */
 void __rcu_read_lock(void)
 {
-	current->rcu_read_lock_nesting++;
+	rcu_preempt_depth_inc();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
-		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
+		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -371,15 +386,13 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (--t->rcu_read_lock_nesting == 0) {
+	if (rcu_preempt_depth_dec_and_test()) {
 		barrier();  /* critical section before exit code. */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		int rrln = t->rcu_read_lock_nesting;
-
-		WARN_ON_ONCE(rrln < 0);
+		WARN_ON_ONCE(rcu_preempt_depth() < 0);
 	}
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
@@ -531,7 +544,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       !t->rcu_read_lock_nesting;
+	       !rcu_preempt_depth();
 }
 
 /*
@@ -662,7 +675,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
-	if (t->rcu_read_lock_nesting > 0 ||
+	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
@@ -672,13 +685,13 @@ static void rcu_flavor_sched_clock_irq(int user)
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
@@ -699,11 +712,11 @@ void exit_rcu(void)
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
2.20.1

