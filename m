Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F6C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC5E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gzJZeDRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfG3WPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:15:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfG3WPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:15:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMEx9M3398584
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:15:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMEx9M3398584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524900;
        bh=mD70gKmkh6jDBFlhLyayjqQ0pkFhWaeZ62L8iKyfSgg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gzJZeDRm7MomnNjdsxmwUuW3BmnNcZlUBVAgmNOZRizenO33mIipsRdFa0BsdYkPO
         amJLdgr3vGZ2/mCbJytgQIcPwa6TtH6VtJV8WrGDMaaHT6SsHwUyBDoq/xPVxG/HCD
         Tfl5ipucGDvERrHHY6LYOu+4tFeJbeO5x0Tz+7vgFzFjkTftHmFjXbja9/+stz4kd+
         5WKgK5pKTXFw+H0hV/kI+eG09pq/UJCbxjbzMBvx6RBxVl6V9h50XQl4NcN871vmGy
         89jcIU8Q84v9Bvc6gUs6ZdUqF+jG5BOR1eL2gCRdV4bKvLyNDmy3/JNZCEE0aJUmxM
         VIFXctmyRtN+g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMEx6D3398580;
        Tue, 30 Jul 2019 15:14:59 -0700
Date:   Tue, 30 Jul 2019 15:14:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-fe2db1c61da8176954e84d2e1f42863a945b1a21@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com, bigeasy@linutronix.de,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de
In-Reply-To: <20190726185753.459144407@linutronix.de>
References: <20190726185753.459144407@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick: Mark tick related hrtimers to expiry in
 hard interrupt context
Git-Commit-ID: fe2db1c61da8176954e84d2e1f42863a945b1a21
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

Commit-ID:  fe2db1c61da8176954e84d2e1f42863a945b1a21
Gitweb:     https://git.kernel.org/tip/fe2db1c61da8176954e84d2e1f42863a945b1a21
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:56 +0200

tick: Mark tick related hrtimers to expiry in hard interrupt context

The tick related hrtimers, which drive the scheduler tick and hrtimer based
broadcasting are required to expire in hard interrupt context for obvious
reasons.

Mark them so PREEMPT_RT kernels wont move them to soft interrupt expiry.

Make the horribly formatted RCU_NONIDLE bracket maze readable while at it.

No functional change, 

[ tglx: Split out from larger combo patch. Add changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.459144407@linutronix.de

---
 kernel/time/tick-broadcast-hrtimer.c | 13 +++++++++----
 kernel/time/tick-sched.c             | 15 +++++++++------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 5be6154e2fd2..c1f5bb590b5e 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -59,11 +59,16 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 	 * hrtimer_{start/cancel} functions call into tracing,
 	 * calls to these functions must be bound within RCU_NONIDLE.
 	 */
-	RCU_NONIDLE({
+	RCU_NONIDLE(
+		{
 			bc_moved = hrtimer_try_to_cancel(&bctimer) >= 0;
-			if (bc_moved)
+			if (bc_moved) {
 				hrtimer_start(&bctimer, expires,
-					      HRTIMER_MODE_ABS_PINNED);});
+					      HRTIMER_MODE_ABS_PINNED_HARD);
+			}
+		}
+	);
+
 	if (bc_moved) {
 		/* Bind the "device" to the cpu */
 		bc->bound_on = smp_processor_id();
@@ -104,7 +109,7 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 
 void tick_setup_hrtimer_broadcast(void)
 {
-	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	bctimer.function = bc_handler;
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be9707f68024..01ff32a02af2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -634,10 +634,12 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	/* Forward the time to expire in the future */
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
 
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
-		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
-	else
+	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+		hrtimer_start_expires(&ts->sched_timer,
+				      HRTIMER_MODE_ABS_PINNED_HARD);
+	} else {
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	}
 
 	/*
 	 * Reset to make sure next tick stop doesn't get fooled by past
@@ -802,7 +804,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
-		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start(&ts->sched_timer, tick,
+			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
 		hrtimer_set_expires(&ts->sched_timer, tick);
 		tick_program_event(tick, 1);
@@ -1327,7 +1330,7 @@ void tick_setup_sched_timer(void)
 	/*
 	 * Emulate tick processing via per-CPU hrtimers:
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	ts->sched_timer.function = tick_sched_timer;
 
 	/* Get the next period (per-CPU) */
@@ -1342,7 +1345,7 @@ void tick_setup_sched_timer(void)
 	}
 
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }
 #endif /* HIGH_RES_TIMERS */
