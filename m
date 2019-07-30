Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1302C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D192087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbfG3WlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:41:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbfG3WlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:41:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsank-0002Pe-Jk; Wed, 31 Jul 2019 00:41:01 +0200
Message-Id: <20190730223829.058247862@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Jul 2019 00:33:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: [patch 7/7] posix-timers: Prepare for PREEMPT_RT
References: <20190730223348.409366334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posix timer delete retry loops are affected by the same priority inversion
and live lock issues as the other timers.

Provide a RT specific synchronization function which keeps a reference to
the timer by holding rcu read lock to prevent the timer from being freed,
dropping the timer lock and invoking the timer specific wait function.

This does not yet cover posix CPU timers because they need more special
treatment on PREEMPT_RT.

Originally-by: Anna-Maria Gleixenr <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -805,6 +805,27 @@ static int common_hrtimer_try_to_cancel(
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static struct k_itimer *timer_wait_running(struct k_itimer *timer,
+					   unsigned long *flags)
+{
+	const struct k_clock *kc = READ_ONCE(timer->kclock);
+	timer_t timer_id = READ_ONCE(timer->it_id);
+
+	/* Prevent kfree(timer) after dropping the lock */
+	rcu_read_lock();
+	unlock_timer(timer, *flags);
+
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_cancel_wait_running(&timer->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_cancel_wait_running(&timer->it.alarm.alarmtimer.timer);
+	rcu_read_unlock();
+
+	/* Relock the timer. It might be not longer hashed. */
+	return lock_timer(timer_id, flags);
+}
+#else
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
@@ -815,6 +836,7 @@ static struct k_itimer *timer_wait_runni
 	/* Relock the timer. It might be not longer hashed. */
 	return lock_timer(timer_id, flags);
 }
+#endif
 
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,


