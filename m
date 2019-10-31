Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A22CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387802087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJaLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfJaLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92u-00037u-Ja; Thu, 31 Oct 2019 12:55:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 758151C04D7;
        Thu, 31 Oct 2019 12:55:10 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:10 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Emulate dyntick aspect of userspace
 nohz_full sojourn
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291017.29376.11893239366143477054.tip-bot2@tip-bot2>
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

Commit-ID:     79ba7ff5a9925f5c170f51ed7a96d1475eb6c27f
Gitweb:        https://git.kernel.org/tip/79ba7ff5a9925f5c170f51ed7a96d1475eb6c27f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 04 Aug 2019 13:17:35 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:46:05 -07:00

rcutorture: Emulate dyntick aspect of userspace nohz_full sojourn

During an actual call_rcu() flood, there would be frequent trips to
userspace (in-kernel call_rcu() floods must be otherwise housebroken).
Userspace execution on nohz_full CPUs implies an RCU dyntick idle/not-idle
transition pair, so this commit adds emulation of that pair.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  1 +
 kernel/rcu/rcutorture.c | 11 +++++++++++
 kernel/rcu/tree.c       |  1 +
 3 files changed, 13 insertions(+)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9bf1dfe..37b6f0c 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -84,6 +84,7 @@ static inline void rcu_scheduler_starting(void) { }
 #endif /* #else #ifndef CONFIG_SRCU */
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_is_watching(void) { return true; }
+static inline void rcu_momentary_dyntick_idle(void) { }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ab61f5c..49ad887 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1761,6 +1761,11 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 		kfree(rfcp);
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
+		if (tick_nohz_full_enabled()) {
+			local_irq_save(flags);
+			rcu_momentary_dyntick_idle();
+			local_irq_restore(flags);
+		}
 	}
 	return freed;
 }
@@ -1835,6 +1840,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 static void rcu_torture_fwd_prog_cr(void)
 {
 	unsigned long cver;
+	unsigned long flags;
 	unsigned long gps;
 	int i;
 	long n_launders;
@@ -1894,6 +1900,11 @@ static void rcu_torture_fwd_prog_cr(void)
 		}
 		cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
+		if (tick_nohz_full_enabled()) {
+			local_irq_save(flags);
+			rcu_momentary_dyntick_idle();
+			local_irq_restore(flags);
+		}
 	}
 	stoppedat = jiffies;
 	n_launders_cb_snap = READ_ONCE(n_launders_cb);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7c67ea5..66354ef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -375,6 +375,7 @@ void rcu_momentary_dyntick_idle(void)
 	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
 	rcu_preempt_deferred_qs(current);
 }
+EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
 
 /**
  * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
