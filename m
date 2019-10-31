Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0E4CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1832C217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfJaL51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55351 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfJaLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92k-00031M-Ue; Thu, 31 Oct 2019 12:55:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EA0B1C0070;
        Thu, 31 Oct 2019 12:55:04 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:03 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Confine ->core_needs_qs accesses to the
 corresponding CPU
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290397.29376.9034850067084045394.tip-bot2@tip-bot2>
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

Commit-ID:     ed93dfc6bc0084485ccad1ff6bd2ea81ab2c03cd
Gitweb:        https://git.kernel.org/tip/ed93dfc6bc0084485ccad1ff6bd2ea81ab2c03cd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 13 Sep 2019 14:09:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Oct 2019 07:02:21 -07:00

rcu: Confine ->core_needs_qs accesses to the corresponding CPU

Commit 671a63517cf9 ("rcu: Avoid unnecessary softirq when system
is idle") fixed a bug that could result in an indefinite number of
unnecessary invocations of the RCU_SOFTIRQ handler at the trailing edge
of a scheduler-clock interrupt.  However, the fix introduced off-CPU
stores to ->core_needs_qs.  These writes did not conflict with the
on-CPU stores because the CPU's leaf rcu_node structure's ->lock was
held across all such stores.  However, the loads from ->core_needs_qs
were not promoted to READ_ONCE() and, worse yet, the code loading from
->core_needs_qs was written assuming that it was only ever updated by
the corresponding CPU.  So operation has been robust, but only by luck.
This situation is therefore an accident waiting to happen.

This commit therefore takes a different approach.  Instead of clearing
->core_needs_qs from the grace-period kthread's force-quiescent-state
processing, it modifies the rcu_pending() function to suppress the
rcu_sched_clock_irq() function's call to invoke_rcu_core() if there is no
grace period in progress.  This avoids the infinite needless RCU_SOFTIRQ
handlers while still keeping all accesses to ->core_needs_qs local to
the corresponding CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 82caca3..0c8046b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1989,7 +1989,6 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
-	rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
@@ -2819,6 +2818,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
  */
 static int rcu_pending(void)
 {
+	bool gp_in_progress;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -2834,7 +2834,8 @@ static int rcu_pending(void)
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
-	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
+	gp_in_progress = rcu_gp_in_progress();
+	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
@@ -2842,8 +2843,7 @@ static int rcu_pending(void)
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) &&
+	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
 	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
