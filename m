Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C174320838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CsuMOb5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbfHATEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:04:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHATEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:04:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J44f3069348
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:04:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J44f3069348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686244;
        bh=zigYgK7CxPRe+mOKjEFeeL5FKDm9u+Bp0I2s6HXN7dY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CsuMOb5olQIB/lmWQsYY7tAiYZFPnzaxOp3SW962G0sO2iDugSCwYX3oy1U/8Dw3E
         SdqiOT7l5fZUTkOdRA74Um4R9nXA05ONaLsSbTyfqfsuONOAr8eZEg7HdwfPuh7P18
         LuBMfeBLeolI9N2DxV+lBC78n8dfLooK4Djs7Hclbsj1uxk0rm9I0hS1dUz8oGvadv
         WaOFYtEjBj6BBKKK7ZRkpM+g76+T1C4oVibskMizmhq7tmsBgQTaxI5qOn13YcKW//
         uBFSDYtjChdgpmOP+Wr3FsrEmCTcwOh6TyXqzqGYZ+oCcE8KZV4DubIJsvBXy1S6sd
         ufm7LTdalc0tw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J43Ou069309;
        Thu, 1 Aug 2019 12:04:03 -0700
Date:   Thu, 1 Aug 2019 12:04:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-f61eff83cec9cfab31fd30a2ca8856be379cdcd5@git.kernel.org>
Cc:     bigeasy@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: bigeasy@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190726185753.737767218@linutronix.de>
References: <20190726185753.737767218@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Prepare support for PREEMPT_RT
Git-Commit-ID: f61eff83cec9cfab31fd30a2ca8856be379cdcd5
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

Commit-ID:  f61eff83cec9cfab31fd30a2ca8856be379cdcd5
Gitweb:     https://git.kernel.org/tip/f61eff83cec9cfab31fd30a2ca8856be379cdcd5
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:22 +0200

hrtimer: Prepare support for PREEMPT_RT

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.737767218@linutronix.de



---
 include/linux/hrtimer.h | 16 +++++++++
 kernel/time/hrtimer.c   | 95 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 7d0d0a36a8f4..5df4bcff96d5 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -192,6 +192,10 @@ enum  hrtimer_base_type {
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
@@ -218,6 +222,10 @@ struct hrtimer_cpu_base {
 	unsigned short			nr_retries;
 	unsigned short			nr_hangs;
 	unsigned int			max_hang_time;
+#endif
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t			softirq_expiry_lock;
+	atomic_t			timer_waiters;
 #endif
 	ktime_t				expires_next;
 	struct hrtimer			*next_timer;
@@ -350,6 +358,14 @@ extern void hrtimers_resume(void);
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 
+#ifdef CONFIG_PREEMPT_RT
+void hrtimer_cancel_wait_running(const struct hrtimer *timer);
+#else
+static inline void hrtimer_cancel_wait_running(struct hrtimer *timer)
+{
+	cpu_relax();
+}
+#endif
 
 /* Exported timer functions: */
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c101f88ae8aa..499122752649 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1162,6 +1162,82 @@ int hrtimer_try_to_cancel(struct hrtimer *timer)
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
+void hrtimer_cancel_wait_running(const struct hrtimer *timer)
+{
+	struct hrtimer_clock_base *base = timer->base;
+
+	if (!timer->is_soft || !base || !base->cpu_base) {
+		cpu_relax();
+		return;
+	}
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
+#endif
+
 /**
  * hrtimer_cancel - cancel a timer and wait for the handler to finish.
  * @timer:	the timer to be cancelled
@@ -1172,13 +1248,15 @@ EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
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
+		if (ret < 0)
+			hrtimer_cancel_wait_running(timer);
+	} while (ret < 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
@@ -1475,6 +1553,8 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 				break;
 
 			__run_hrtimer(cpu_base, base, timer, &basenow, flags);
+			if (active_mask == HRTIMER_ACTIVE_SOFT)
+				hrtimer_sync_wait_running(cpu_base, flags);
 		}
 	}
 }
@@ -1485,6 +1565,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	unsigned long flags;
 	ktime_t now;
 
+	hrtimer_cpu_base_lock_expiry(cpu_base);
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
@@ -1494,6 +1575,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	hrtimer_update_softirq_timer(cpu_base, true);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	hrtimer_cpu_base_unlock_expiry(cpu_base);
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1897,6 +1979,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 
