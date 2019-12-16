Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBB622464
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUCRBsQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLPXWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:22:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31497 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726834AbfLPXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576538552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=74sLsfLQMH2aJnW/B+MH+KEzYf3ET05ZlrmfGySHhA8=;
        b=fUCRBsQ3zt9rVWNxxYAg1bqX23xZ+yAnGPIxPihsIX1kqyxiQCoj+04lwVcR+5o/6w77e+
        P6KSViQoJ3gUt/jATab2a4FYYK5VebOJ0aTYS/X+p3tmsK3ovQt7SL6JyVwOmiWzd0pDSI
        xZ71JmRCVxOsISDG0yoVy8pj0BFJxhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-xo0nGpqXMquVAh61WyHo3Q-1; Mon, 16 Dec 2019 18:22:27 -0500
X-MC-Unique: xo0nGpqXMquVAh61WyHo3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F3B10054E3;
        Mon, 16 Dec 2019 23:22:26 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19B257C827;
        Mon, 16 Dec 2019 23:22:26 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [PATCH 1/4] tick/sched: Forward timer even in nohz mode
Date:   Mon, 16 Dec 2019 18:22:22 -0500
Message-Id: <1576538545-13274-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when exiting nohz, the expiry will be forwarded as if we
had just run the timer.  If we re-enter nohz before this new expiry,
and exit after, this forwarding will happen again.  If this load pattern
recurs the tick can be indefinitely postponed.

To avoid this, use last_tick as-is rather than calling hrtimer_forward().
However, in some cases the tick *will* have just run (despite being
"stopped"), and leading to double timer execution.

To avoid that, forward the timer after every tick (regardless of nohz
status) and keep last_tick up-to-date.  During nohz, last_tick will
reflect what the expiry would have been if not in nohz mode.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/time/tick-sched.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8b192e67aabc..8936b604dd6c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -642,9 +642,6 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	hrtimer_cancel(&ts->sched_timer);
 	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
-	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
-
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
 		hrtimer_start_expires(&ts->sched_timer,
 				      HRTIMER_MODE_ABS_PINNED_HARD);
@@ -1207,12 +1204,13 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
+	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 
 	/* No need to reprogram if we are running tickless  */
 	if (unlikely(ts->tick_stopped))
 		return;
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
@@ -1311,12 +1309,13 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 	else
 		ts->next_tick = 0;
 
+	hrtimer_forward(timer, now, tick_period);
+	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
+
 	/* No need to reprogram if we are in idle or full dynticks mode */
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
 
-	hrtimer_forward(timer, now, tick_period);
-
 	return HRTIMER_RESTART;
 }
 
-- 
1.8.3.1

