Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0CC218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCUPjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:39:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38588 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:39:24 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6zmq-00082A-Dh; Thu, 21 Mar 2019 16:39:20 +0100
Date:   Thu, 21 Mar 2019 16:39:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [WARNING] tick_handle_oneshot_broadcast() on !online CPU
In-Reply-To: <7fe83094-6821-dd94-f91e-6beb658bc7e6@arm.com>
Message-ID: <alpine.DEB.2.21.1903211540180.1784@nanos.tec.linutronix.de>
References: <7fe83094-6821-dd94-f91e-6beb658bc7e6@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Valentin Schneider wrote:
> I stared at the code and did a bit of tracing, the sequence seems to be:
> 
> ---
> echo 0 > /sys/devices/system/cpu/cpu2/online
> 
> takedown_cpu()
>   take_cpu_down()
>      __cpu_disable() (clears CPU in cpu_online_mask & cpu_active_mask)

active_mask has been cleared long ago.
 
>   [...] <warn happens here>
> 
>   tick_cleanup_dead_cpu()
>     tick_shutdown_broadcast_oneshot() (removes cpu from the tick_broadcast_* masks)
> ---
> 
> In that case we always have
> 
>   tick_broadcast_force_mask=[CPU2]
>   cpu_online_mask=[CPU4]
> 
> So tick_handle_oneshot_broadcast::tmpmask becomes [CPU2] and we hit the warn.
>
> 
> I was thinking of guarding the setting of tmpmask with cpu_online(cpu), but
> AFAICT nothing saves us from __cpu_disable() happening *after* those checks
> (and even potentially after the WARN_ON_ONCE). Do we want some extra lock
> in here, or is that a benign issue?

Hmm. This only seems to be an issue with forced broadcast. The dynamic
broadcast stuff does not have that problem as the CPU is obviously not idle
while going down.

Patch below (completely untested) should fix it.

Thanks,

	tglx

8<---------------

--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -68,6 +68,12 @@ extern void tick_broadcast_control(enum
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
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -36,10 +36,12 @@ static __cacheline_aligned_in_smp DEFINE
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
@@ -444,8 +446,6 @@ void tick_shutdown_broadcast(unsigned in
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
 	bc = tick_broadcast_device.evtdev;
-	cpumask_clear_cpu(cpu, tick_broadcast_mask);
-	cpumask_clear_cpu(cpu, tick_broadcast_on);
 
 	if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC) {
 		if (bc && cpumask_empty(tick_broadcast_mask))
@@ -454,6 +454,16 @@ void tick_shutdown_broadcast(unsigned in
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
+
+void tick_broadcast_offline(unsigned int cpu)
+{
+	raw_spin_lock(&tick_broadcast_lock);
+	cpumask_clear_cpu(cpu, tick_broadcast_mask);
+	cpumask_clear_cpu(cpu, tick_broadcast_on);
+	tick_broadcast_oneshot_offline(cpu);
+	raw_spin_unlock(&tick_broadcast_lock);
+}
+
 #endif
 
 void tick_suspend_broadcast(void)
@@ -950,14 +960,10 @@ void hotplug_cpu__broadcast_tick_pull(in
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
@@ -965,8 +971,6 @@ void tick_shutdown_broadcast_oneshot(uns
 	cpumask_clear_cpu(cpu, tick_broadcast_oneshot_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_pending_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_force_mask);
-
-	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 #endif
 
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -64,7 +64,6 @@ extern ssize_t sysfs_get_uname(const cha
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
 extern void tick_install_broadcast_device(struct clock_event_device *dev);
 extern int tick_is_broadcast_device(struct clock_event_device *dev);
-extern void tick_shutdown_broadcast(unsigned int cpu);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
 extern bool tick_resume_check_broadcast(void);
@@ -78,7 +77,6 @@ static inline void tick_install_broadcas
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
 static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
-static inline void tick_shutdown_broadcast(unsigned int cpu) { }
 static inline void tick_suspend_broadcast(void) { }
 static inline void tick_resume_broadcast(void) { }
 static inline bool tick_resume_check_broadcast(void) { return false; }
@@ -128,19 +126,23 @@ static inline int tick_check_oneshot_cha
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
