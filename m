Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2B218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCWR2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:28:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfCWR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:28:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2NHSMVn1106457
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Mar 2019 10:28:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2NHSLdU1106453;
        Sat, 23 Mar 2019 10:28:21 -0700
Date:   Sat, 23 Mar 2019 10:28:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1b72d43237980eab9b6ae6bb8181e51c840377e6@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        valentin.schneider@arm.com, fweisbec@gmail.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          valentin.schneider@arm.com, tglx@linutronix.de,
          fweisbec@gmail.com, mingo@kernel.org
In-Reply-To: <alpine.DEB.2.21.1903211540180.1784@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903211540180.1784@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick: Remove outgoing CPU from broadcast masks
Git-Commit-ID: 1b72d43237980eab9b6ae6bb8181e51c840377e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1b72d43237980eab9b6ae6bb8181e51c840377e6
Gitweb:     https://git.kernel.org/tip/1b72d43237980eab9b6ae6bb8181e51c840377e6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 21 Mar 2019 16:39:20 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Mar 2019 18:26:43 +0100

tick: Remove outgoing CPU from broadcast masks

Valentin reported that unplugging a CPU occasionally results in a warning
in the tick broadcast code which is triggered when an offline CPU is in the
broadcast mask.

This happens because the outgoing CPU is not removing itself from the
broadcast masks, especially not from the broadcast_force_mask. The removal
happens on the control CPU after the outgoing CPU is dead. It's a long
standing issue, but the warning is harmless.

Rework the hotplug mechanism so that the outgoing CPU removes itself from
the broadcast masks after disabling interrupts and removing itself from the
online mask.

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1903211540180.1784@nanos.tec.linutronix.de
---
 include/linux/tick.h         |  6 ++++++
 kernel/cpu.c                 |  2 ++
 kernel/time/clockevents.c    | 18 ++++++++++++++++--
 kernel/time/tick-broadcast.c | 40 +++++++++++++++++++---------------------
 kernel/time/tick-internal.h  | 10 ++++++----
 5 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..76acb48acdb7 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -68,6 +68,12 @@ extern void tick_broadcast_control(enum tick_broadcast_mode mode);
 static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
 #endif /* BROADCAST */
 
+#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
+extern void tick_offline_cpu(unsigned int cpu);
+#else
+static inline void tick_offline_cpu(unsigned int cpu) { }
+#endif
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern int tick_broadcast_oneshot_control(enum tick_broadcast_state state);
 #else
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 025f419d16f6..f69ba38573c2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -844,6 +844,8 @@ static int take_cpu_down(void *_param)
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
+	/* Remove CPU from timer broadcasting */
+	tick_offline_cpu(cpu);
 	/* Park the stopper thread */
 	stop_machine_park(cpu);
 	return 0;
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5e77662dd2d9..f5490222e134 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -611,6 +611,22 @@ void clockevents_resume(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+
+# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+/**
+ * tick_offline_cpu - Take CPU out of the broadcast mechanism
+ * @cpu:	The outgoing CPU
+ *
+ * Called on the outgoing CPU after it took itself offline.
+ */
+void tick_offline_cpu(unsigned int cpu)
+{
+	raw_spin_lock(&clockevents_lock);
+	tick_broadcast_offline(cpu);
+	raw_spin_unlock(&clockevents_lock);
+}
+# endif
+
 /**
  * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
  */
@@ -621,8 +637,6 @@ void tick_cleanup_dead_cpu(int cpu)
 
 	raw_spin_lock_irqsave(&clockevents_lock, flags);
 
-	tick_shutdown_broadcast_oneshot(cpu);
-	tick_shutdown_broadcast(cpu);
 	tick_shutdown(cpu);
 	/*
 	 * Unregister the clock event devices which were
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index ee834d4fb814..0283523de045 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -36,10 +36,12 @@ static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
 static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
+static void tick_broadcast_oneshot_offline(unsigned int cpu);
 #else
 static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
 static inline void tick_broadcast_clear_oneshot(int cpu) { }
 static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
+static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
 #endif
 
 /*
@@ -433,27 +435,29 @@ void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/*
- * Remove a CPU from broadcasting
- */
-void tick_shutdown_broadcast(unsigned int cpu)
+static void tick_shutdown_broadcast(void)
 {
-	struct clock_event_device *bc;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
-
-	bc = tick_broadcast_device.evtdev;
-	cpumask_clear_cpu(cpu, tick_broadcast_mask);
-	cpumask_clear_cpu(cpu, tick_broadcast_on);
+	struct clock_event_device *bc = tick_broadcast_device.evtdev;
 
 	if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC) {
 		if (bc && cpumask_empty(tick_broadcast_mask))
 			clockevents_shutdown(bc);
 	}
+}
 
-	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
+/*
+ * Remove a CPU from broadcasting
+ */
+void tick_broadcast_offline(unsigned int cpu)
+{
+	raw_spin_lock(&tick_broadcast_lock);
+	cpumask_clear_cpu(cpu, tick_broadcast_mask);
+	cpumask_clear_cpu(cpu, tick_broadcast_on);
+	tick_broadcast_oneshot_offline(cpu);
+	tick_shutdown_broadcast();
+	raw_spin_unlock(&tick_broadcast_lock);
 }
+
 #endif
 
 void tick_suspend_broadcast(void)
@@ -950,14 +954,10 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 }
 
 /*
- * Remove a dead CPU from broadcasting
+ * Remove a dying CPU from broadcasting
  */
-void tick_shutdown_broadcast_oneshot(unsigned int cpu)
+static void tick_broadcast_oneshot_offline(unsigned int cpu)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
-
 	/*
 	 * Clear the broadcast masks for the dead cpu, but do not stop
 	 * the broadcast device!
@@ -965,8 +965,6 @@ void tick_shutdown_broadcast_oneshot(unsigned int cpu)
 	cpumask_clear_cpu(cpu, tick_broadcast_oneshot_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_pending_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_force_mask);
-
-	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 #endif
 
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index e277284c2831..7b2496136729 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -64,7 +64,6 @@ extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
 extern void tick_install_broadcast_device(struct clock_event_device *dev);
 extern int tick_is_broadcast_device(struct clock_event_device *dev);
-extern void tick_shutdown_broadcast(unsigned int cpu);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
 extern bool tick_resume_check_broadcast(void);
@@ -78,7 +77,6 @@ static inline void tick_install_broadcast_device(struct clock_event_device *dev)
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
 static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
-static inline void tick_shutdown_broadcast(unsigned int cpu) { }
 static inline void tick_suspend_broadcast(void) { }
 static inline void tick_resume_broadcast(void) { }
 static inline bool tick_resume_check_broadcast(void) { return false; }
@@ -128,19 +126,23 @@ static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
 /* Functions related to oneshot broadcasting */
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
 extern void tick_broadcast_switch_to_oneshot(void);
-extern void tick_shutdown_broadcast_oneshot(unsigned int cpu);
 extern int tick_broadcast_oneshot_active(void);
 extern void tick_check_oneshot_broadcast_this_cpu(void);
 bool tick_broadcast_oneshot_available(void);
 extern struct cpumask *tick_get_broadcast_oneshot_mask(void);
 #else /* !(BROADCAST && ONESHOT): */
 static inline void tick_broadcast_switch_to_oneshot(void) { }
-static inline void tick_shutdown_broadcast_oneshot(unsigned int cpu) { }
 static inline int tick_broadcast_oneshot_active(void) { return 0; }
 static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
 #endif /* !(BROADCAST && ONESHOT) */
 
+#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
+extern void tick_broadcast_offline(unsigned int cpu);
+#else
+static inline void tick_broadcast_offline(unsigned int cpu) { }
+#endif
+
 /* NO_HZ_FULL internal */
 #ifdef CONFIG_NO_HZ_FULL
 extern void tick_nohz_init(void);
