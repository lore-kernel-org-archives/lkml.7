Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EDCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10846206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AEbGk7v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbfHAP7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:59:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfHAP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:59:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71FxgOX006392
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 08:59:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71FxgOX006392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675182;
        bh=b+KSdwVDhv6OVp0UQeQ+UjCgbhrh0vArb1kMx9kzbic=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AEbGk7v5vM3RVsWSStdmz+REQmvF0Y53AXIxbV1sYG0o2wGg/9xDYT33dN6U14/x0
         ICaAmCmMTku4zoHp/RQ3a588IIVBKKhAvBeYbPKAIdVavZLklWP3uQHAwCvjjOGwGG
         4f1iRGK8vx8lZ1sxAoxg9xAOGk/Sfrdz01BFXlNHXteSdI6mxFScVOZSuRz5Z3xMTR
         /Pdv6vA+xhdpl1NMsBg/BmjQ9xkSRZXoye568U+GrTcljoLtIvf+xCN+mFMgxIkKf9
         wv8usUQq+98AI0enA243fbq1oDdFNTkZsFDhPsevqS4dXd8KUTOmwlIeDC59odvJ9c
         8GzTR4AZbgoqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71Fxfk6006388;
        Thu, 1 Aug 2019 08:59:41 -0700
Date:   Thu, 1 Aug 2019 08:59:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-1c2df8ac9292ea1fe6c958c198bf6bc5c768acf5@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, bigeasy@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, bigeasy@linutronix.de,
          anna-maria@linutronix.de, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190726185753.832418500@linutronix.de>
References: <20190726185753.832418500@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timers: Prepare support for PREEMPT_RT
Git-Commit-ID: 1c2df8ac9292ea1fe6c958c198bf6bc5c768acf5
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

Commit-ID:  1c2df8ac9292ea1fe6c958c198bf6bc5c768acf5
Gitweb:     https://git.kernel.org/tip/1c2df8ac9292ea1fe6c958c198bf6bc5c768acf5
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:31:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:43:20 +0200

timers: Prepare support for PREEMPT_RT

When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
the soft interrupt thread is preempted in the middle of a timer callback,
then calling del_timer_sync() can lead to two issues:

  - If the caller is on a remote CPU then it has to spin wait for the timer
    handler to complete. This can result in unbound priority inversion.

  - If the caller originates from the task which preempted the timer
    handler on the same CPU, then spin waiting for the timer handler to
    complete is never going to end.

To avoid these issues, add a new lock to the timer base which is held
around the execution of the timer callbacks. If del_timer_sync() detects
that the timer callback is currently running, it blocks on the expiry
lock. When the callback is finished, the expiry lock is dropped by the
softirq thread which wakes up the waiter and the system makes progress.

This addresses both the priority inversion and the life lock issues.

This mechanism is not used for timers which are marked IRQSAFE as for those
preemption is disabled accross the callback and therefore this situation
cannot happen. The callbacks for such timers need to be individually
audited for RT compliance.

The same issue can happen in virtual machines when the vCPU which runs a
timer callback is scheduled out. If a second vCPU of the same guest calls
del_timer_sync() it will spin wait for the other vCPU to be scheduled back
in. The expiry lock mechanism would avoid that. It'd be trivial to enable
this when paravirt spinlocks are enabled in a guest, but it's not clear
whether this is an actual problem in the wild, so for now it's an RT only
mechanism.

As the softirq thread can be preempted with PREEMPT_RT=y, the SMP variant
of del_timer_sync() needs to be used on UP as well.

[ tglx: Refactored it for mainline ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.832418500@linutronix.de


---
 include/linux/timer.h |   2 +-
 kernel/time/timer.c   | 103 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 282e4f2a532a..1e6650ed066d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,7 +183,7 @@ extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
   extern int del_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t)		del_timer(t)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 343c7ba33b1c..673c6a0f0c45 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -196,6 +196,10 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		expiry_lock;
+	atomic_t		timer_waiters;
+#endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1227,7 +1231,78 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_PREEMPT_RT
+static __init void timer_base_init_expiry_lock(struct timer_base *base)
+{
+	spin_lock_init(&base->expiry_lock);
+}
+
+static inline void timer_base_lock_expiry(struct timer_base *base)
+{
+	spin_lock(&base->expiry_lock);
+}
+
+static inline void timer_base_unlock_expiry(struct timer_base *base)
+{
+	spin_unlock(&base->expiry_lock);
+}
+
+/*
+ * The counterpart to del_timer_wait_running().
+ *
+ * If there is a waiter for base->expiry_lock, then it was waiting for the
+ * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * the waiter to acquire the lock and make progress.
+ */
+static void timer_sync_wait_running(struct timer_base *base)
+{
+	if (atomic_read(&base->timer_waiters)) {
+		spin_unlock(&base->expiry_lock);
+		spin_lock(&base->expiry_lock);
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
+static void del_timer_wait_running(struct timer_list *timer)
+{
+	u32 tf;
+
+	tf = READ_ONCE(timer->flags);
+	if (!(tf & TIMER_MIGRATING)) {
+		struct timer_base *base = get_timer_base(tf);
+
+		/*
+		 * Mark the base as contended and grab the expiry lock,
+		 * which is held by the softirq across the timer
+		 * callback. Drop the lock immediately so the softirq can
+		 * expire the next timer. In theory the timer could already
+		 * be running again, but that's more than unlikely and just
+		 * causes another wait loop.
+		 */
+		atomic_inc(&base->timer_waiters);
+		spin_lock_bh(&base->expiry_lock);
+		atomic_dec(&base->timer_waiters);
+		spin_unlock_bh(&base->expiry_lock);
+	}
+}
+#else
+static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
+static inline void timer_base_lock_expiry(struct timer_base *base) { }
+static inline void timer_base_unlock_expiry(struct timer_base *base) { }
+static inline void timer_sync_wait_running(struct timer_base *base) { }
+static inline void del_timer_wait_running(struct timer_list *timer) { }
+#endif
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1266,6 +1341,8 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1283,12 +1360,17 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		cpu_relax();
-	}
+
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1360,10 +1442,13 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
+			timer_sync_wait_running(base);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1658,6 +1743,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1684,8 +1770,8 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
-	base->running_timer = NULL;
 	raw_spin_unlock_irq(&base->lock);
+	timer_base_unlock_expiry(base);
 }
 
 /*
@@ -1930,6 +2016,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		timer_base_init_expiry_lock(base);
 	}
 }
 
