Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C1F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJaL4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:56:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfJaLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92x-0003AD-Or; Thu, 31 Oct 2019 12:55:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB59C1C06D8;
        Thu, 31 Oct 2019 12:55:12 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:12 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] nohz: Add TICK_DEP_BIT_RCU
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291252.29376.12062616091234228344.tip-bot2@tip-bot2>
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

Commit-ID:     01b4c39901e087ceebae2733857248de81476bd8
Gitweb:        https://git.kernel.org/tip/01b4c39901e087ceebae2733857248de81476bd8
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 24 Jul 2019 15:22:59 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:45:16 -07:00

nohz: Add TICK_DEP_BIT_RCU

If a nohz_full CPU is looping in the kernel, the scheduling-clock tick
might nevertheless remain disabled.  In !PREEMPT kernels, this can
prevent RCU's attempts to enlist the aid of that CPU's executions of
cond_resched(), which can in turn result in an arbitrarily delayed grace
period and thus an OOM.  RCU therefore needs a way to enable a holdout
nohz_full CPU's scheduler-clock interrupt.

This commit therefore provides a new TICK_DEP_BIT_RCU value which RCU can
pass to tick_dep_set_cpu() and friends to force on the scheduler-clock
interrupt for a specified CPU or task.  In some cases, rcutorture needs
to turn on the scheduler-clock tick, so this commit also exports the
relevant symbols to GPL-licensed modules.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/tick.h         | 7 ++++++-
 include/trace/events/timer.h | 3 ++-
 kernel/time/tick-sched.c     | 7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b..39eb445 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -108,7 +108,8 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_POSIX_TIMER	= 0,
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
-	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
+	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
+	TICK_DEP_BIT_RCU		= 4
 };
 
 #define TICK_DEP_MASK_NONE		0
@@ -116,6 +117,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
+#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
@@ -268,6 +270,9 @@ static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
+static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
 static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index b7a9048..295517f 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -367,7 +367,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(POSIX_TIMER)		\
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
-		tick_dep_name_end(CLOCK_UNSTABLE)
+		tick_dep_name(CLOCK_UNSTABLE)		\
+		tick_dep_name_end(RCU)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9558517..d1b0a84 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -198,6 +198,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU);
+		return true;
+	}
+
 	return false;
 }
 
@@ -324,6 +329,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 		preempt_enable();
 	}
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_set_cpu);
 
 void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 {
@@ -331,6 +337,7 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 
 	atomic_andnot(BIT(bit), &ts->tick_dep_mask);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
  * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
