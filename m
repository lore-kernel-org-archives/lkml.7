Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A411CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C321906
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfJaL5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfJaLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92p-00032H-IJ; Thu, 31 Oct 2019 12:55:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0781F1C05CD;
        Thu, 31 Oct 2019 12:55:05 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:04 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Force nohz_full tick on upon irq enter instead of exit
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290468.29376.3346250787604219868.tip-bot2@tip-bot2>
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

Commit-ID:     b200a0489517d9e5a52e983183e890f573454ebd
Gitweb:        https://git.kernel.org/tip/b200a0489517d9e5a52e983183e890f573454ebd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 15 Aug 2019 13:24:49 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Oct 2019 07:02:21 -07:00

rcu: Force nohz_full tick on upon irq enter instead of exit

There is interrupt-exit code that forces on the tick for nohz_full CPUs
failing to respond to the current grace period in a timely fashion.
However, this code must compare ->dynticks_nmi_nesting to the value 2
in the interrupt-exit fastpath.  This commit therefore moves this code
to the interrupt-entry fastpath, where a lighter-weight comparison to
zero may be used.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fda338..8dc8784 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -651,12 +651,6 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
-		if (tick_nohz_full_cpu(rdp->cpu) &&
-		    rdp->dynticks_nmi_nesting == 2 &&
-		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-			rdp->rcu_forced_tick = true;
-			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
-		}
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
@@ -831,6 +825,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 			rcu_cleanup_after_idle();
 
 		incby = 1;
+	} else if (tick_nohz_full_cpu(rdp->cpu) &&
+		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
+		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		rdp->rcu_forced_tick = true;
+		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
