Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A8CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5C321906
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfJaL5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfJaLzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92p-000321-Dz; Thu, 31 Oct 2019 12:55:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94F781C04E3;
        Thu, 31 Oct 2019 12:55:04 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:04 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Reset CPU hints when reporting a quiescent state
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290433.29376.12281262134449590392.tip-bot2@tip-bot2>
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

Commit-ID:     516e5ae0c94016294d3ef175454215b235d03945
Gitweb:        https://git.kernel.org/tip/516e5ae0c94016294d3ef175454215b235d03945
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 05 Sep 2019 10:26:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Oct 2019 07:02:21 -07:00

rcu: Reset CPU hints when reporting a quiescent state

In some cases, tracing shows that need_heavy_qs is still set even though
urgent_qs was cleared upon reporting of a quiescent state.  One such
case is when the softirq reports that a CPU has passed quiescent state.

Commit 671a63517cf9 ("rcu: Avoid unnecessary softirq when system is
idle") fixed a bug where core_needs_qs was not being cleared.  In order
to avoid running into similar situations with the urgent-grace-period
flags, this commit causes rcu_disable_urgency_upon_qs(), previously
rcu_disable_tick_upon_qs(), to clear the urgency hints, ->rcu_urgent_qs
and ->rcu_need_heavy_qs.  Note that it is possible for CPUs to go
offline with these urgency hints still set.  This is handled because
rcu_disable_urgency_upon_qs() is also invoked during the online process.

Because these hints can be cleared both by the corresponding CPU and by
the grace-period kthread, this commit also adds a number of READ_ONCE()
and WRITE_ONCE() calls.

Tested overnight with rcutorture running for 60 minutes on all
configurations of RCU.

Signed-off-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
[ paulmck: Clear urgency flags in rcu_disable_urgency_upon_qs(). ]
[ paulmck: Remove ->core_needs_qs from the set cleared at quiescent state. ]
[ paulmck: Make rcu_disable_urgency_upon_qs static per kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8dc8784..82caca3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -827,7 +827,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
 		rdp->rcu_forced_tick = true;
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
@@ -892,11 +892,14 @@ void rcu_irq_enter_irqson(void)
 }
 
 /*
- * If the scheduler-clock interrupt was enabled on a nohz_full CPU
- * in order to get to a quiescent state, disable it.
+ * If any sort of urgency was applied to the current CPU (for example,
+ * the scheduler-clock interrupt was enabled on a nohz_full CPU) in order
+ * to get to a quiescent state, disable it.
  */
-void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
+static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 {
+	WRITE_ONCE(rdp->rcu_urgent_qs, false);
+	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
 		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		rdp->rcu_forced_tick = false;
@@ -1997,7 +2000,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		if (!offloaded)
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
-		rcu_disable_tick_upon_qs(rdp);
+		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
@@ -2311,7 +2314,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (f(rdp)) {
 					mask |= bit;
-					rcu_disable_tick_upon_qs(rdp);
+					rcu_disable_urgency_upon_qs(rdp);
 				}
 			}
 		}
@@ -3182,7 +3185,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
-		rcu_disable_tick_upon_qs(rdp);
+		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
