Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E0CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA08421734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfJaL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:56:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55433 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfJaLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92v-00039I-SP; Thu, 31 Oct 2019 12:55:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 47A1B1C06D6;
        Thu, 31 Oct 2019 12:55:11 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:11 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] stop_machine: Provide RCU quiescent state in multi_cpu_stop()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291102.29376.11840837332483723665.tip-bot2@tip-bot2>
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

Commit-ID:     366237e7b0833faa2d8da7a8d7d7da8c3ca802e5
Gitweb:        https://git.kernel.org/tip/366237e7b0833faa2d8da7a8d7d7da8c3ca802e5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 10 Jul 2019 08:01:01 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:46:05 -07:00

stop_machine: Provide RCU quiescent state in multi_cpu_stop()

When multi_cpu_stop() loops waiting for other tasks, it can trigger an RCU
CPU stall warning.  This can be misleading because what is instead needed
is information on whatever task is blocking multi_cpu_stop().  This commit
therefore inserts an RCU quiescent state into the multi_cpu_stop()
function's waitloop.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutree.h | 1 +
 kernel/rcu/tree.c       | 2 +-
 kernel/stop_machine.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 18b1ed9..c5147de 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,6 +37,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
+void rcu_momentary_dyntick_idle(void);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 238f93b..a5c296d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -364,7 +364,7 @@ bool rcu_eqs_special_set(int cpu)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-static void __maybe_unused rcu_momentary_dyntick_idle(void)
+void rcu_momentary_dyntick_idle(void)
 {
 	int special;
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index c7031a2..34c4f11 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -233,6 +233,7 @@ static int multi_cpu_stop(void *data)
 			 */
 			touch_nmi_watchdog();
 		}
+		rcu_momentary_dyntick_idle();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
