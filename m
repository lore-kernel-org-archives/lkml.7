Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0208CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39DB2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfJaKIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:08:55 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:21040 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbfJaKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgmBgSZ_1572516515;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgmBgSZ_1572516515)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:35 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 09/11] rcu: wrap usages of rcu_read_lock_nesting
Date:   Thu, 31 Oct 2019 10:08:04 +0000
Message-Id: <20191031100806.1326-10-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
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
index 9dcbd2734620..dc1af2073e25 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -620,7 +620,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!t->rcu_read_lock_nesting) {
+	if (!rcu_preempt_depth()) {
 		rdp->exp_deferred_qs = true;
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
@@ -641,7 +641,7 @@ static void rcu_exp_handler(void *unused)
 	 * grace period is still waiting on this CPU, set ->deferred_qs
 	 * so that the eventual quiescent state will be reported.
 	 */
-	if (t->rcu_read_lock_nesting > 0) {
+	if (rcu_preempt_depth() > 0) {
 		rdp->exp_deferred_qs = true;
 		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
 		return;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c62631c79463..81cacf637865 100644
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
@@ -529,7 +542,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       !t->rcu_read_lock_nesting;
+	       !rcu_preempt_depth();
 }
 
 /*
@@ -667,7 +680,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
-	if (t->rcu_read_lock_nesting > 0 ||
+	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
@@ -677,13 +690,13 @@ static void rcu_flavor_sched_clock_irq(int user)
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
@@ -704,11 +717,11 @@ void exit_rcu(void)
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

