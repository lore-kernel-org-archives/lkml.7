Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B4CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E51B2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfJaL4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:56:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfJaLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92x-00039W-29; Thu, 31 Oct 2019 12:55:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B054A1C0070;
        Thu, 31 Oct 2019 12:55:11 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:11 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Force on tick for readers and callback flooders
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291137.29376.6492575120270689137.tip-bot2@tip-bot2>
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

Commit-ID:     d38e6dc6ed0dfef8d323354031a1ee1a7cfdedc1
Gitweb:        https://git.kernel.org/tip/d38e6dc6ed0dfef8d323354031a1ee1a7cfdedc1
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 28 Jul 2019 12:00:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:46:04 -07:00

rcutorture: Force on tick for readers and callback flooders

Readers and callback flooders in the rcutorture stress-test suite run for
extended time periods by design.  They do take pains to relinquish the
CPU from time to time, but in some cases this relies on the scheduler
being active, which in turn relies on the scheduler-clock interrupt
firing from time to time.

This commit therefore forces scheduling-clock interrupts within
these loops.  While in the area, this commit also prevents
rcu_torture_reader()'s occasional timed sleeps from delaying shutdown.

[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca..ab61f5c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -44,6 +44,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
+#include <linux/tick.h>
 
 #include "rcu.h"
 
@@ -1363,15 +1364,15 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
 				mod_timer(&t, jiffies + 1);
 		}
-		if (!rcu_torture_one_read(&rand))
+		if (!rcu_torture_one_read(&rand) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
-		if (time_after(jiffies, lastsleep)) {
+		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			schedule_timeout_interruptible(1);
 			lastsleep = jiffies + 10;
 		}
@@ -1383,6 +1384,7 @@ rcu_torture_reader(void *arg)
 		del_timer_sync(&t);
 		destroy_timer_on_stack(&t);
 	}
+	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 	torture_kthread_stopping("rcu_torture_reader");
 	return 0;
 }
@@ -1729,10 +1731,10 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
-	} else {
-		// No userspace emulation: CB invocation throttles call_rcu()
-		cond_resched();
+		return;
 	}
+	// No userspace emulation: CB invocation throttles call_rcu()
+	cond_resched();
 }
 
 /*
@@ -1865,6 +1867,7 @@ static void rcu_torture_fwd_prog_cr(void)
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
 	rcu_launder_gp_seq_start = gps;
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1911,6 +1914,7 @@ static void rcu_torture_fwd_prog_cr(void)
 		rcu_torture_fwd_cb_hist();
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
+	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
