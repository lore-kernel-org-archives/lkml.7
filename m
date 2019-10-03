Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA903C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EAE222C5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066747;
	bh=6h+QCo3AQ22ybrCN8XD/cXFxftua9jah0t1An8gD+S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KY5tm0z5bF6WyEzt37+LJEMENgVfWDl5mYp8UCrZk0N1z7u3IK7Lz/MmYljdIackq
	 1Zb9eMsGLZ2hcTPac9KaKtC3mBmSEHm9Z05Sdyq+/cMFzU3HZRopW7Cy0gguIG14G4
	 AxBRSfk6YntJ7nR6trJTCJZZdZ3iOGilZnjHvIsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfJCBjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfJCBjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3B6222BE;
        Thu,  3 Oct 2019 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066745;
        bh=6h+QCo3AQ22ybrCN8XD/cXFxftua9jah0t1An8gD+S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lytA4J+fP0xeR6gAZdqgxwKQ4vEeCoetPljLYIbuHmMirCpEjYX5PlwhTHmFnqABI
         WguZ7pCX7I7XgDY9CtDSJWwXJuyMS2rDQfeQE2Gf4cItdAkPxGq/wP+tla4/5kUnVf
         OvS2yAmi2ifH4NQvcfH3viSVCOtaDIfY4qCuPTBg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/12] nohz: Add TICK_DEP_BIT_RCU
Date:   Wed,  2 Oct 2019 18:38:52 -0700
Message-Id: <20191003013903.13079-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

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
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
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
-- 
2.9.5

