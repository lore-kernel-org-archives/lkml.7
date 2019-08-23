Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6CBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD7A23404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbfHWCMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:12:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33731 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389411AbfHWCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3q-0000yW-DL; Fri, 23 Aug 2019 04:12:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 143421C07E4;
        Fri, 23 Aug 2019 04:12:18 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:18 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Use a callback for cancel
 synchronization on PREEMPT_RT
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixenr <anna-maria@linutronix.de>
In-Reply-To: <20190819143801.656864506@linutronix.de>
References: <20190819143801.656864506@linutronix.de>
MIME-Version: 1.0
Message-ID: <156652633800.11667.5499751485130399187.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ec8f954a40da8cd3d159713b608e901f0cd909a9
Gitweb:        https://git.kernel.org/tip/ec8f954a40da8cd3d159713b608e901f0cd909a9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2019 07:35:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2019 22:05:46 +02:00

posix-timers: Use a callback for cancel synchronization on PREEMPT_RT

Posix timer delete retry loops are affected by the same priority inversion
and live lock issues as the other timers.
    
Provide a RT specific synchronization function which keeps a reference to
the timer by holding rcu read lock to prevent the timer from being freed,
dropping the timer lock and invoking the timer specific wait function via a
new callback.
    
This does not yet cover posix CPU timers because they need more special
treatment on PREEMPT_RT.

[ This is folded into the original attempt which did not use a callback. ]

Originally-by: Anna-Maria Gleixenr <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190819143801.656864506@linutronix.de
---
 kernel/time/alarmtimer.c   | 14 ++++++++++++++
 kernel/time/posix-timers.c | 18 +++++++++++++++++-
 kernel/time/posix-timers.h |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 3694744..ec32876 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -606,6 +606,19 @@ static int alarm_timer_try_to_cancel(struct k_itimer *timr)
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
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 3e663f9..9e37783 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -805,13 +805,25 @@ static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+static void common_timer_wait_running(struct k_itimer *timer)
+{
+	hrtimer_cancel_wait_running(&timer->it.real.timer);
+}
+
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
+	const struct k_clock *kc = READ_ONCE(timer->kclock);
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
+	/* Prevent kfree(timer) after dropping the lock */
+	rcu_read_lock();
 	unlock_timer(timer, *flags);
-	cpu_relax();
+
+	if (!WARN_ON_ONCE(!kc->timer_wait_running))
+		kc->timer_wait_running(timer);
+
+	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
 	return lock_timer(timer_id, flags);
 }
@@ -1255,6 +1267,7 @@ static const struct k_clock clock_realtime = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1270,6 +1283,7 @@ static const struct k_clock clock_monotonic = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1300,6 +1314,7 @@ static const struct k_clock clock_tai = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1315,6 +1330,7 @@ static const struct k_clock clock_boottime = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index de5daa6..897c29e 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -24,6 +24,7 @@ struct k_clock {
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
 	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
 			     bool absolute, bool sigev_none);
+	void	(*timer_wait_running)(struct k_itimer *timr);
 };
 
 extern const struct k_clock clock_posix_cpu;
