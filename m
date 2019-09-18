Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E14C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3903D20665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfIROmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:42:09 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:25564 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfIROmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:42:07 -0400
IronPort-SDR: xkb6jbkBmdMUU5T/nEjlA80YccQgPlRtiXzOsOt3B5jv5C/S7Oc7nqfDoVbtUYlEQYBABMbXnc
 FfaGxZsKYFXv/+H80OuGGGIv7ngVtQKrwD27+vmTCkA1LZyo78ENHCH4zPwE5oD7HrEIWIn3Cv
 bBWyyeLd+MIpVdH/bjzVPLxmJLFYUC7nf1yO2mSBBZr/ECnvZYNmzHUIIaKTh+McEAk+EIEni1
 EENpuYLCJ41DdN2n29k7CY2xjI+5jibniB/iIbfGG+UpAa6VEeKR6tmUwuUGRxbCjL2gkgpRMn
 0WI=
X-IronPort-AV: E=Sophos;i="5.64,520,1559548800"; 
   d="scan'208";a="43273331"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 18 Sep 2019 06:42:04 -0800
IronPort-SDR: 4DxW12cmTMlFOfD1OpeucPn8zHFhy22DCQzrhsMyUNHaK5ppr1Fr70Incsv7kjZ/PKYmLmv+dy
 WU4Gba7C1yl05FirFLDjkc3TjoDBv3pCQHSQEhK9OlUR+Fdh5Mr0LpAwk5zYanZrGKUpfbiiJB
 3glpEOOSm2wjCG57BKceG0gy7oj95bJksTPafLR9az/l7ipanxUdK0Jww9jHYfIfNVLDYkUEeH
 +tRdY60WI7EvcxNsja6lL9B77VilQpAoeC1WKEwB6q2IjGba9CmININBhoNvKYELI5YBqlLft1
 82g=
From:   Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>
CC:     <balasubramani_vivekanandan@mentor.com>, <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 1/1] tick: broadcast-hrtimer: Fix a race in bc_set_next
Date:   Wed, 18 Sep 2019 16:41:38 +0200
Message-ID: <20190918144138.24839-2-balasubramani_vivekanandan@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918144138.24839-1-balasubramani_vivekanandan@mentor.com>
References: <20190918144138.24839-1-balasubramani_vivekanandan@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cpu requests broadcasting, before starting the tick broadcast
hrtimer, bc_set_next() checks if the timer callback (bc_handler) is
active using hrtimer_try_to_cancel(). But hrtimer_try_to_cancel() does
not provide the required synchronization when the callback is active on
other core.
The callback could have already executed
tick_handle_oneshot_broadcast() and could have also returned. But still
there is a small time window where the hrtimer_try_to_cancel() returns
-1. In that case bc_set_next() returns without doing anything, but the
next_event of the tick broadcast clock device is already set to a
timeout value.

In the race condition diagram below, CPU #1 is running the timer
callback and CPU #2 is entering idle state and so calls bc_set_next().

In the worst case, the next_event will contain an expiry time, but the
hrtimer will not be started which happens when the racing callback
returns HRTIMER_NORESTART. The hrtimer might never recover if all
further requests from the CPUs to subscribe to tick broadcast have
timeout greater than the next_event of tick broadcast clock device. This
leads to cascading of failures and finally noticed as rcu stall
warnings.

Here is a depiction of the race condition

CPU #1 (Running timer callback)                   CPU #2 (Enter idle
                                                  and subscribe to
                                                  tick broadcast)
---------------------                             ---------------------

__run_hrtimer()                                   tick_broadcast_enter()

  bc_handler()                                      __tick_broadcast_oneshot_control()

    tick_handle_oneshot_broadcast()

      raw_spin_lock(&tick_broadcast_lock);

      dev->next_event = KTIME_MAX;                  //wait for tick_broadcast_lock
      //next_event for tick broadcast clock
      set to KTIME_MAX since no other cores
      subscribed to tick broadcasting

      raw_spin_unlock(&tick_broadcast_lock);

    if (dev->next_event == KTIME_MAX)
      return HRTIMER_NORESTART
    // callback function exits without
       restarting the hrtimer                      //tick_broadcast_lock acquired
                                                   raw_spin_lock(&tick_broadcast_lock);

                                                   tick_broadcast_set_event()

                                                     clockevents_program_event()

                                                       dev->next_event = expires;

                                                       bc_set_next()

                                                         hrtimer_try_to_cancel()
                                                         //returns -1 since the timer
                                                         callback is active. Exits without
                                                         restarting the timer
  cpu_base->running = NULL;

In the fix, if hrtimer_try_to_cancel returns callback is active, an
additional check is added in bc_set_next() to know the state of the
timer callback.  If the timer callback has already released the
tick_broadcast_lock, then the bc_set_next() can safely call
hrtimer_cancel() to cancel the timer and restart it.

When there are no more cpus subscribed to broadcast, the timer callback
might not set the expiry time for hrtimer. Therefore the callback timer
function is modified to set the state of broadcast clock to
CLOCK_EVT_STATE_ONESHOT_STOPPED which in turn will set the expiry time
of hrtimer to KTIME_MAX.

Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
---
 kernel/time/tick-broadcast-hrtimer.c | 58 ++++++++++++++++++++++------
 kernel/time/tick-broadcast.c         |  2 +
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index c1f5bb590b5e..09644403a320 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -42,18 +42,13 @@ static int bc_shutdown(struct clock_event_device *evt)
  */
 static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 {
+	ktime_t now;
+	ktime_t bc_expiry;
 	int bc_moved;
+
 	/*
-	 * We try to cancel the timer first. If the callback is on
-	 * flight on some other cpu then we let it handle it. If we
-	 * were able to cancel the timer nothing can rearm it as we
-	 * own broadcast_lock.
-	 *
-	 * However we can also be called from the event handler of
-	 * ce_broadcast_hrtimer itself when it expires. We cannot
-	 * restart the timer because we are in the callback, but we
-	 * can set the expiry time and let the callback return
-	 * HRTIMER_RESTART.
+	 * We try to cancel the timer first. If we were able to cancel
+	 * the timer nothing can rearm it as we own broadcast_lock.
 	 *
 	 * Since we are in the idle loop at this point and because
 	 * hrtimer_{start/cancel} functions call into tracing,
@@ -72,9 +67,47 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 	if (bc_moved) {
 		/* Bind the "device" to the cpu */
 		bc->bound_on = smp_processor_id();
-	} else if (bc->bound_on == smp_processor_id()) {
-		hrtimer_set_expires(&bctimer, expires);
+	} else {
+		if (bc->bound_on == smp_processor_id()) {
+			/* We are called from the callback timer itself, we
+			 * just set expiry time and let the callback return
+			 * HRTIMER_RESTART
+			 */
+			hrtimer_set_expires(&bctimer, expires);
+		} else {
+			now = ktime_get();
+			bc_expiry = hrtimer_get_expires(&bctimer);
+
+			/* If the expiry time of the tick broadcast hrtimer is
+			 * in future means that hrtimer callback is running on
+			 * another core which has set the expiry time for the
+			 * broadcast timer. We are holding the broadcast_lock
+			 * means the timer callback has already released it.
+			 * We can now safely cancel the timer and restart it.
+			 */
+			if (bc_expiry > now) {
+				RCU_NONIDLE(
+					{
+						hrtimer_cancel(&bctimer);
+						hrtimer_start(&bctimer, expires,
+							      HRTIMER_MODE_ABS_PINNED_HARD);
+					}
+				);
+				bc->bound_on = smp_processor_id();
+			}
+			/* Else the hrtimer callback is waiting on the other
+			 * core for the broadcast_lock. There is no need for
+			 * us to do anything
+			 */
+		}
 	}
+
+	return 0;
+}
+
+static int bc_set_oneshot_stopped(struct clock_event_device *bc)
+{
+	hrtimer_set_expires(&bctimer, KTIME_MAX);
 	return 0;
 }
 
@@ -85,6 +118,7 @@ static struct clock_event_device ce_broadcast_hrtimer = {
 	.features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_KTIME |
 				  CLOCK_EVT_FEAT_HRTIMER,
+	.set_state_oneshot_stopped = bc_set_oneshot_stopped,
 	.rating			= 0,
 	.bound_on		= -1,
 	.min_delta_ns		= 1,
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index e51778c312f1..28f04527ff54 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -672,6 +672,8 @@ static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
 	 */
 	if (next_event != KTIME_MAX)
 		tick_broadcast_set_event(dev, next_cpu, next_event);
+	else
+		clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT_STOPPED);
 
 	raw_spin_unlock(&tick_broadcast_lock);
 
-- 
2.17.1

