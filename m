Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B53CCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E8B208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfJaLzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfJaLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92z-00039a-5I; Thu, 31 Oct 2019 12:55:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 119101C0671;
        Thu, 31 Oct 2019 12:55:12 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:11 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Force on tick when invoking lots of callbacks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291178.29376.6993443685603243726.tip-bot2@tip-bot2>
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

Commit-ID:     6a949b7af82db7eb1e52caaed122eab1cf63acee
Gitweb:        https://git.kernel.org/tip/6a949b7af82db7eb1e52caaed122eab1cf63acee
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 28 Jul 2019 11:50:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:46:04 -07:00

rcu: Force on tick when invoking lots of callbacks

Callback invocation can run for a significant time period, and within
CONFIG_NO_HZ_FULL=y kernels, this period will be devoid of scheduler-clock
interrupts.  In-kernel execution without such interrupts can cause all
manner of malfunction, with RCU CPU stall warnings being but one result.

This commit therefore forces scheduling-clock interrupts on whenever more
than a few RCU callbacks are invoked.  Because offloaded callback invocation
can be preempted, this forcing is withdrawn on each context switch.  This
in turn requires that the loop invoking RCU callbacks reiterate the forcing
periodically.

[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
[ paulmck: Remove NO_HZ_FULL check per Frederic Weisbecker feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8110514..238f93b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2151,6 +2151,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		debug_rcu_head_unqueue(rhp);
@@ -2217,6 +2218,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
 	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
+	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 }
 
 /*
