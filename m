Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E8CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF36F214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKBMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:47:31 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:63316 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbfKBMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Th-lLCs_1572698840;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-lLCs_1572698840)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:20 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 4/7] rcu: don't use negative ->rcu_read_lock_nesting
Date:   Sat,  2 Nov 2019 12:45:56 +0000
Message-Id: <20191102124559.1135-5-laijs@linux.alibaba.com>
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

Negative ->rcu_read_lock_nesting was introduced to prevent
scheduler deadlock. But now with the help of deferred qs
mechanism, we can defer qs rather than persevere in reporting qs
and deadlock. So negative ->rcu_read_lock_nesting is useless now
and rcu_read_unlock() can be simplified.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_exp.h    | 29 ++---------------------------
 kernel/rcu/tree_plugin.h | 14 +++-----------
 2 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index e4b77d314f6d..afa9f573b00f 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -609,11 +609,11 @@ static void rcu_exp_handler(void *unused)
 	 * report the quiescent state, otherwise defer.
 	 */
 	if (!t->rcu_read_lock_nesting) {
+		rdp->exp_deferred_qs = true;
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
-			rcu_report_exp_rdp(rdp);
+			rcu_preempt_deferred_qs(t);
 		} else {
-			rdp->exp_deferred_qs = true;
 			set_tsk_need_resched(t);
 			set_preempt_need_resched();
 		}
@@ -641,31 +641,6 @@ static void rcu_exp_handler(void *unused)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-
-	/*
-	 * The final and least likely case is where the interrupted
-	 * code was just about to or just finished exiting the RCU-preempt
-	 * read-side critical section, and no, we can't tell which.
-	 * So either way, set ->deferred_qs to flag later code that
-	 * a quiescent state is required.
-	 *
-	 * If the CPU is fully enabled (or if some buggy RCU-preempt
-	 * read-side critical section is being used from idle), just
-	 * invoke rcu_preempt_deferred_qs() to immediately report the
-	 * quiescent state.  We cannot use rcu_read_unlock_special()
-	 * because we are in an interrupt handler, which will cause that
-	 * function to take an early exit without doing anything.
-	 *
-	 * Otherwise, force a context switch after the CPU enables everything.
-	 */
-	rdp->exp_deferred_qs = true;
-	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
-		rcu_preempt_deferred_qs(t);
-	} else {
-		set_tsk_need_resched(t);
-		set_preempt_need_resched();
-	}
 }
 
 /* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f2fd7d687bdb..98644966c808 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -344,8 +344,6 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 }
 
 /* Bias and limit values for ->rcu_read_lock_nesting. */
-#define RCU_NEST_BIAS INT_MAX
-#define RCU_NEST_NMAX (-INT_MAX / 2)
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
 /*
@@ -373,21 +371,15 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (t->rcu_read_lock_nesting != 1) {
-		--t->rcu_read_lock_nesting;
-	} else {
+	if (--t->rcu_read_lock_nesting == 0) {
 		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
-		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
-		barrier();  /* ->rcu_read_unlock_special load before assign */
-		t->rcu_read_lock_nesting = 0;
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		int rrln = t->rcu_read_lock_nesting;
 
-		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
+		WARN_ON_ONCE(rrln < 0);
 	}
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
@@ -539,7 +531,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       t->rcu_read_lock_nesting <= 0;
+	       !t->rcu_read_lock_nesting;
 }
 
 /*
-- 
2.20.1

