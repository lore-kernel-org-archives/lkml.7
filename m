Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ED9222C5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066752;
	bh=hjspEx7XW0txuViSdE7c/ij+PLwKvCzqr+anBxafuRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbpxU/0l4rljQjT07BQ53yp35jP7N+aj99E6b02odE9jV10X18JOn5i5fWSwFF6qi
	 3Z5loH588rdqwfjmpGCanW8ZaJ7vlEudMC0wC+7/KVXS1fz0i8uJvrRa2Tf/5WXe19
	 /3I2uGI+e1gNvtFeI578eczm0jidN+xs4yx+2Jfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfJCBjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfJCBjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4C2222CD;
        Thu,  3 Oct 2019 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066748;
        bh=hjspEx7XW0txuViSdE7c/ij+PLwKvCzqr+anBxafuRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4E2AiR+oG4qEtghFzgPeeYM40B2lDX7vlL7yvAUoh6V9PC8VCoXb4Gak8783BrI7
         MaPHvpMe8WkS1bCBirdEORE37L8Fcduwm9itw1bKI4m8z9qf7QO7BEktMz7+uCZOHz
         eBqfsxLmy+Sy7bH4FR+0Ju+C0DwlZcZAw8GNW7XM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/12] rcu: Force tick on for nohz_full CPUs not reaching quiescent states
Date:   Wed,  2 Oct 2019 18:38:59 -0700
Message-Id: <20191003013903.13079-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

CPUs running for long time periods in the kernel in nohz_full mode
might leave the scheduling-clock interrupt disabled for then full
duration of their in-kernel execution.  This can (among other things)
delay grace periods.  This commit therefore forces the tick back on
for any nohz_full CPU that is failing to pass through a quiescent state
upon return from interrupt, which the resched_cpu() will induce.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
[ paulmck: Clear ->rcu_forced_tick as reported by Joel Fernandes testing. ]
[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 38 +++++++++++++++++++++++++++++++-------
 kernel/rcu/tree.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 74bf5c65..621cc06 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -650,6 +650,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
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
@@ -885,6 +891,18 @@ void rcu_irq_enter_irqson(void)
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
@@ -1979,6 +1997,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		if (!offloaded)
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
+		rcu_disable_tick_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
@@ -2268,6 +2287,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 	int cpu;
 	unsigned long flags;
 	unsigned long mask;
+	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
@@ -2292,8 +2312,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
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
@@ -2321,7 +2344,7 @@ void rcu_force_quiescent_state(void)
 	rnp = __this_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
 		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
-		      !raw_spin_trylock(&rnp->fqslock);
+		       !raw_spin_trylock(&rnp->fqslock);
 		if (rnp_old != NULL)
 			raw_spin_unlock(&rnp_old->fqslock);
 		if (ret)
@@ -2854,7 +2877,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 {
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
 		rcu_barrier_trace(TPS("LastCB"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 		complete(&rcu_state.barrier_completion);
 	} else {
 		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
@@ -2878,7 +2901,7 @@ static void rcu_barrier_func(void *unused)
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 	}
 	rcu_nocb_unlock(rdp);
 }
@@ -2905,7 +2928,7 @@ void rcu_barrier(void)
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
 		rcu_barrier_trace(TPS("EarlyExit"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rcu_state.barrier_mutex);
 		return;
@@ -2937,11 +2960,11 @@ void rcu_barrier(void)
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
@@ -3167,6 +3190,7 @@ void rcu_cpu_starting(unsigned int cpu)
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
-- 
2.9.5

