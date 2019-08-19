Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398B22CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfHSPpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:45:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfHSPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqi-0006tH-OM; Mon, 19 Aug 2019 17:45:36 +0200
Message-Id: <20190819143801.656864506@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:44 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 03/44] posix-timer: Use a callback for cancel synchronization
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup timer_wait_running() by using a kclock callback. Get's rid of the
ifdeffery and the odd conditionals. Should have thought about this right
away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c   |   14 ++++++++++++++
 kernel/time/posix-timers.c |   32 ++++++++++++--------------------
 kernel/time/posix-timers.h |    1 +
 3 files changed, 27 insertions(+), 20 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -606,6 +606,19 @@ static int alarm_timer_try_to_cancel(str
 }
 
 /**
+ * alarm_timer_wait_running - Posix timer callback to wait for a timer
+ * @timr:	Pointer to the posixtimer data struct
+ *
+ * Called from the core code when timer cancel detected that the callback
+ * is running. @timr is unlocked and rcu read lock is held to prevent it
+ * from being freed.
+ */
+static void alarm_timer_wait_running(struct k_itimer *timr)
+{
+	hrtimer_cancel_wait_running(&timr->it.alarm.alarmtimer.timer);
+}
+
+/**
  * alarm_timer_arm - Posix timer callback to arm a timer
  * @timr:	Pointer to the posixtimer data struct
  * @expires:	The new expiry time
@@ -834,6 +847,7 @@ const struct k_clock alarm_clock = {
 	.timer_forward		= alarm_timer_forward,
 	.timer_remaining	= alarm_timer_remaining,
 	.timer_try_to_cancel	= alarm_timer_try_to_cancel,
+	.timer_wait_running	= alarm_timer_wait_running,
 	.nsleep			= alarm_timer_nsleep,
 };
 #endif /* CONFIG_POSIX_TIMERS */
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -805,7 +805,11 @@ static int common_hrtimer_try_to_cancel(
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
-#ifdef CONFIG_PREEMPT_RT
+static void common_timer_wait_running(struct k_itimer *timer)
+{
+	hrtimer_cancel_wait_running(&timer->it.real.timer);
+}
+
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
@@ -816,29 +820,13 @@ static struct k_itimer *timer_wait_runni
 	rcu_read_lock();
 	unlock_timer(timer, *flags);
 
-	if (kc->timer_arm == common_hrtimer_arm)
-		hrtimer_cancel_wait_running(&timer->it.real.timer);
-	else if (kc == &alarm_clock)
-		hrtimer_cancel_wait_running(&timer->it.alarm.alarmtimer.timer);
-	else
-		WARN_ON_ONCE(1);
-	rcu_read_unlock();
-
-	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id, flags);
-}
-#else
-static struct k_itimer *timer_wait_running(struct k_itimer *timer,
-					   unsigned long *flags)
-{
-	timer_t timer_id = READ_ONCE(timer->it_id);
+	if (!WARN_ON_ONCE(kc->timer_wait_running))
+		kc->timer_wait_running(timer);
 
-	unlock_timer(timer, *flags);
-	cpu_relax();
+	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
 	return lock_timer(timer_id, flags);
 }
-#endif
 
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
@@ -1279,6 +1267,7 @@ static const struct k_clock clock_realti
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1294,6 +1283,7 @@ static const struct k_clock clock_monoto
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1324,6 +1314,7 @@ static const struct k_clock clock_tai =
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1339,6 +1330,7 @@ static const struct k_clock clock_bootti
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -24,6 +24,7 @@ struct k_clock {
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
 	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
 			     bool absolute, bool sigev_none);
+	void	(*timer_wait_running)(struct k_itimer *timr);
 };
 
 extern const struct k_clock clock_posix_cpu;


