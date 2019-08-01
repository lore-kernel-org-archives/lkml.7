Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D04C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8A220679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A4XQ+nJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfHATEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:04:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHATEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:04:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J3KXc069183
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:03:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J3KXc069183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686201;
        bh=2Xea3zii+SqlyOQWhiIBqowizLpZYEjR3S7IJ12rgyM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=A4XQ+nJIy9dq5vOlcyMILNV7msUeC2DU5Ftu8aMJSM74YZNCcIQESGKf5K/AIyljJ
         S0KNILwiUu2NgIaWEbR/2y8lsYqh17q3LaYxtKy5y4zxBXIvTo4NpZ9+3ji7HU/KLo
         RgF+IeYE94E7ZQo7iUsg8jc4r1wJUDeJn9A9YbNZlCB6IXUroJCpiuyIMewq91zXxv
         nfgdHVdaRPZ2E/RHzvz2YeNZj4j1hDdyejjKBFPZqT215M83aKcOY0AJiMr21SftXH
         VNRgCS2RRiO9uAyIA+j4qUCxBb7DiNL4PdYZVgOEpIW8x3C9UrKTX3WOISTZWlDJB+
         41Nlf9RNq5uRA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J3KTi069180;
        Thu, 1 Aug 2019 12:03:20 -0700
Date:   Thu, 1 Aug 2019 12:03:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-1842f5a427f5323f5c19ab99b55d09b3ab5172a5@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, peterz@infradead.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          bigeasy@linutronix.de, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, rostedt@goodmis.org
In-Reply-To: <20190726185753.645792403@linutronix.de>
References: <20190726185753.645792403@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Git-Commit-ID: 1842f5a427f5323f5c19ab99b55d09b3ab5172a5
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

Commit-ID:  1842f5a427f5323f5c19ab99b55d09b3ab5172a5
Gitweb:     https://git.kernel.org/tip/1842f5a427f5323f5c19ab99b55d09b3ab5172a5
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:22 +0200

hrtimer: Determine hard/soft expiry mode for hrtimer sleepers on RT

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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.645792403@linutronix.de



---
 kernel/time/hrtimer.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 90dcc4d95e91..c101f88ae8aa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1676,6 +1676,16 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 				   enum hrtimer_mode mode)
 {
+	/*
+	 * Make the enqueue delivery mode check work on RT. If the sleeper
+	 * was initialized for hard interrupt delivery, force the mode bit.
+	 * This is a special case for hrtimer_sleepers because
+	 * hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * fiddling with this decision is avoided at the call sites.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
+		mode |= HRTIMER_MODE_HARD;
+
 	hrtimer_start_expires(&sl->timer, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
@@ -1683,6 +1693,30 @@ EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
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
