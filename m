Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D7CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECED21906
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfJaL5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfJaLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92l-00033M-Mj; Thu, 31 Oct 2019 12:55:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CE9A1C0671;
        Thu, 31 Oct 2019 12:55:05 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:05 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Force tick on for nohz_full CPUs not reaching
 quiescent states
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290512.29376.2397341748578098915.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     66e4c33b51bc515ca803c0948cf1525b53ffd631
Gitweb:        https://git.kernel.org/tip/66e4c33b51bc515ca803c0948cf1525b53ffd631
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 12 Aug 2019 16:14:00 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Oct 2019 07:02:21 -07:00

rcu: Force tick on for nohz_full CPUs not reaching quiescent states

CPUs running for long time periods in the kernel in nohz_full mode
might leave the scheduling-clock interrupt disabled for then full
duration of their in-kernel execution.  This can (among other things)
delay grace periods.  This commit therefore forces the tick back on
for any nohz_full CPU that is failing to pass through a quiescent state
upon return from interrupt, which the resched_cpu() will induce.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
[ paulmck: Clear ->rcu_forced_tick as reported by Joel Fernandes testing. ]
[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 38 +++++++++++++++++++++++++++++++-------
 kernel/rcu/tree.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 66354ef..9fda338 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
+		if (tick_nohz_full_cpu(rdp->cpu) &&
+		    rdp->dynticks_nmi_nesting == 2 &&
+		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+			rdp->rcu_forced_tick = true;
+			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
+		}
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
@@ -886,6 +892,18 @@ void rcu_irq_enter_irqson(void)
 	local_irq_restore(flags);
 }
 
+/*
+ * If the scheduler-clock interrupt was enabled on a nohz_full CPU
+ * in order to get to a quiescent state, disable it.
+ */
+void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
+{
+	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
+		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+		rdp->rcu_forced_tick = false;
+	}
+}
+
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
@@ -1980,6 +1998,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		if (!offloaded)
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
+		rcu_disable_tick_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
@@ -2265,6 +2284,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 	int cpu;
 	unsigned long flags;
 	unsigned long mask;
+	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
@@ -2289,8 +2309,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
 			if ((rnp->qsmask & bit) != 0) {
-				if (f(per_cpu_ptr(&rcu_data, cpu)))
+				rdp = per_cpu_ptr(&rcu_data, cpu);
+				if (f(rdp)) {
 					mask |= bit;
+					rcu_disable_tick_upon_qs(rdp);
+				}
 			}
 		}
 		if (mask != 0) {
@@ -2318,7 +2341,7 @@ void rcu_force_quiescent_state(void)
 	rnp = __this_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
 		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
-		      !raw_spin_trylock(&rnp->fqslock);
+		       !raw_spin_trylock(&rnp->fqslock);
 		if (rnp_old != NULL)
 			raw_spin_unlock(&rnp_old->fqslock);
 		if (ret)
@@ -2851,7 +2874,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 {
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
 		rcu_barrier_trace(TPS("LastCB"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 		complete(&rcu_state.barrier_completion);
 	} else {
 		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
@@ -2875,7 +2898,7 @@ static void rcu_barrier_func(void *unused)
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 	}
 	rcu_nocb_unlock(rdp);
 }
@@ -2902,7 +2925,7 @@ void rcu_barrier(void)
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
 		rcu_barrier_trace(TPS("EarlyExit"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rcu_state.barrier_mutex);
 		return;
@@ -2934,11 +2957,11 @@ void rcu_barrier(void)
 			continue;
 		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
-					   rcu_state.barrier_sequence);
+					  rcu_state.barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
 		} else {
 			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
-					   rcu_state.barrier_sequence);
+					  rcu_state.barrier_sequence);
 		}
 	}
 	put_online_cpus();
@@ -3160,6 +3183,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+		rcu_disable_tick_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c612f30..055c317 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -181,6 +181,7 @@ struct rcu_data {
 	atomic_t dynticks;		/* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
+	bool rcu_forced_tick;		/* Forced tick to provide QS. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
 	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
 	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
