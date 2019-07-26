Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B95C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1383F22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfGZTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbfGZTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:19:01 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5k3-0001Bp-JM; Fri, 26 Jul 2019 21:18:59 +0200
Message-Id: <20190726185753.645792403@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 10/12] hrtimer: Determine hard/soft expiry mode for hrtimer
 sleepers on RT
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On PREEMPT_RT enabled kernels hrtimers which are not explicitely marked for
hard interrupt expiry mode are moved into soft interrupt context either for
latency reasons or because the hrtimer callback takes regular spinlocks or
invokes other functions which are not suitable for hard interrupt context
on PREEMPT_RT.

The hrtimer_sleeper callback is RT compatible in hard interrupt context,
but there is a latency concern: Untrusted userspace can spawn many threads
which arm timers for the same expiry time on the same CPU. On expiry that
causes a latency spike due to the wakeup of a gazillion threads.

OTOH, priviledged real-time user space applications rely on the low latency
of hard interrupt wakeups. These syscall related wakeups are all based on
hrtimer sleepers.

If the current task is in a real-time scheduling class, mark the mode for
hard interrupt expiry.

[ tglx: Split out of a larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1662,6 +1662,30 @@ static enum hrtimer_restart hrtimer_wake
 static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 				   clockid_t clock_id, enum hrtimer_mode mode)
 {
+	/*
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * marked for hard interrupt expiry mode are moved into soft
+	 * interrupt context either for latency reasons or because the
+	 * hrtimer callback takes regular spinlocks or invokes other
+	 * functions which are not suitable for hard interrupt context on
+	 * PREEMPT_RT.
+	 *
+	 * The hrtimer_sleeper callback is RT compatible in hard interrupt
+	 * context, but there is a latency concern: Untrusted userspace can
+	 * spawn many threads which arm timers for the same expiry time on
+	 * the same CPU. That causes a latency spike due to the wakeup of
+	 * a gazillion threads.
+	 *
+	 * OTOH, priviledged real-time user space applications rely on the
+	 * low latency of hard interrupt wakeups. If the current task is in
+	 * a real-time scheduling class, mark the mode for hard interrupt
+	 * expiry.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
+			mode |= HRTIMER_MODE_HARD;
+	}
+
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = current;


