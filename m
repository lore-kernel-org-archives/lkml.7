Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0D521994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfGZTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388594AbfGZTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:19:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5k4-0001C7-4T; Fri, 26 Jul 2019 21:19:00 +0200
Message-Id: <20190726185753.737767218@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 11/12] hrtimer: Prepare support for PREEMPT_RT
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
the soft interrupt thread is preempted in the middle of a timer callback,
then calling hrtimer_cancel() can lead to two issues:

  - If the caller is on a remote CPU then it has to spin wait for the timer
    handler to complete. This can result in unbound priority inversion.

  - If the caller originates from the task which preempted the timer
    handler on the same CPU, then spin waiting for the timer handler to
    complete is never going to end.

To avoid these issues, add a new lock to the timer base which is held
around the execution of the timer callbacks. If hrtimer_cancel() detects
that the timer callback is currently running, it blocks on the expiry
lock. When the callback is finished, the expiry lock is dropped by the
softirq thread which wakes up the waiter and the system makes progress.

This addresses both the priority inversion and the life lock issues.

The same issue can happen in virtual machines when the vCPU which runs a
timer callback is scheduled out. If a second vCPU of the same guest calls
hrtimer_cancel() it will spin wait for the other vCPU to be scheduled back
in. The expiry lock mechanism would avoid that. It'd be trivial to enable
this when paravirt spinlocks are enabled in a guest, but it's not clear
whether this is an actual problem in the wild, so for now it's an RT only
mechanism.

[ tglx: Refactored it for mainline ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 include/linux/hrtimer.h |    8 ++++
 kernel/time/hrtimer.c   |   96 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 98 insertions(+), 6 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -189,6 +189,10 @@ enum  hrtimer_base_type {
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
+ * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
+ *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
  *			hrtimer enqueue; it is the total first expiry time (hard
  *			and soft hrtimer are taken into account)
@@ -216,6 +220,10 @@ struct hrtimer_cpu_base {
 	unsigned short			nr_hangs;
 	unsigned int			max_hang_time;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t			softirq_expiry_lock;
+	atomic_t			timer_waiters;
+#endif
 	ktime_t				expires_next;
 	struct hrtimer			*next_timer;
 	ktime_t				softirq_expires_next;
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1158,6 +1158,81 @@ int hrtimer_try_to_cancel(struct hrtimer
 }
 EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
 
+#ifdef CONFIG_PREEMPT_RT
+static void hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base)
+{
+	spin_lock_init(&base->softirq_expiry_lock);
+}
+
+static void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base)
+{
+	spin_lock(&base->softirq_expiry_lock);
+}
+
+static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
+{
+	spin_unlock(&base->softirq_expiry_lock);
+}
+
+/*
+ * The counterpart to hrtimer_cancel_wait_running().
+ *
+ * If there is a waiter for cpu_base->expiry_lock, then it was waiting for
+ * the timer callback to finish. Drop expiry_lock and reaquire it. That
+ * allows the waiter to acquire the lock and make progress.
+ */
+static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
+				      unsigned long flags)
+{
+	if (atomic_read(&cpu_base->timer_waiters)) {
+		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+		spin_unlock(&cpu_base->softirq_expiry_lock);
+		spin_lock(&cpu_base->softirq_expiry_lock);
+		raw_spin_lock_irq(&cpu_base->lock);
+	}
+}
+
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
+ *
+ * This prevents priority inversion, if the softirq thread on a remote CPU
+ * got preempted, and it prevents a life lock when the task which tries to
+ * delete a timer preempted the softirq thread running the timer callback
+ * function.
+ */
+static void hrtimer_cancel_wait_running(const struct hrtimer *timer)
+{
+	struct hrtimer_clock_base *base = timer->base;
+
+	if (!timer->is_soft || !base || !base->cpu_base)
+		return;
+
+	/*
+	 * Mark the base as contended and grab the expiry lock, which is
+	 * held by the softirq across the timer callback. Drop the lock
+	 * immediately so the softirq can expire the next timer. In theory
+	 * the timer could already be running again, but that's more than
+	 * unlikely and just causes another wait loop.
+	 */
+	atomic_inc(&base->cpu_base->timer_waiters);
+	spin_lock_bh(&base->cpu_base->softirq_expiry_lock);
+	atomic_dec(&base->cpu_base->timer_waiters);
+	spin_unlock_bh(&base->cpu_base->softirq_expiry_lock);
+}
+#else
+static inline void
+hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base) { }
+static inline void
+hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base) { }
+static inline void
+hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base) { }
+static inline void hrtimer_sync_wait_running(struct hrtimer_cpu_base *base,
+					     unsigned long flags) { }
+static inline void hrtimer_cancel_wait_running(struct hrtimer *timer) { }
+#endif
+
 /**
  * hrtimer_cancel - cancel a timer and wait for the handler to finish.
  * @timer:	the timer to be cancelled
@@ -1168,13 +1243,17 @@ EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel)
  */
 int hrtimer_cancel(struct hrtimer *timer)
 {
-	for (;;) {
-		int ret = hrtimer_try_to_cancel(timer);
+	int ret;
 
-		if (ret >= 0)
-			return ret;
-		cpu_relax();
-	}
+	do {
+		ret = hrtimer_try_to_cancel(timer);
+
+		if (ret < 0) {
+			hrtimer_cancel_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
@@ -1469,6 +1548,8 @@ static void __hrtimer_run_queues(struct
 				break;
 
 			__run_hrtimer(cpu_base, base, timer, &basenow, flags);
+			if (active_mask == HRTIMER_ACTIVE_SOFT)
+				hrtimer_sync_wait_running(cpu_base, flags);
 		}
 	}
 }
@@ -1479,6 +1560,7 @@ static __latent_entropy void hrtimer_run
 	unsigned long flags;
 	ktime_t now;
 
+	hrtimer_cpu_base_lock_expiry(cpu_base);
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
@@ -1488,6 +1570,7 @@ static __latent_entropy void hrtimer_run
 	hrtimer_update_softirq_timer(cpu_base, true);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	hrtimer_cpu_base_unlock_expiry(cpu_base);
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1866,6 +1949,7 @@ int hrtimers_prepare_cpu(unsigned int cp
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 


