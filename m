Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4921FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB721D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405312AbfIYMDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 08:03:34 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:39220 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfIYMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:03:34 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 08:03:33 EDT
IronPort-SDR: RmUgbz6NDbZWY0bgFNnyrYChj7r+s5CIWE2GUd7gfWBUvORqP5JuiUNF+Cm6z5us8TWZyGvR6/
 yFLOj9K4R+QYecoZOOJlgjxzlJbB0X0YmRDMwis4k37nvZQEGHRy50fqAncUZbRWL1C/MW+oAA
 8/Z/041ARwttxnxGdx8g90anYzlugo112UWyspJWQEyf9uSveYH7RESKkthTYqqFXswlJrwe3b
 t1R8XPzzsGTTmbJsrdQjOH/1GkzSZYdnxhhVfXqKQGwD+UntJjC4cYd66986WDrTp5bkH3npSr
 RXY=
X-IronPort-AV: E=Sophos;i="5.64,547,1559548800"; 
   d="scan'208";a="41676305"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 25 Sep 2019 03:56:27 -0800
IronPort-SDR: kb+tahSPeBsTuXc7+mgw3lD3m7jXdDGgFg1h9fEg6Lfj8FXqkB0PUdGjGgg633k71/9oSD9T17
 4Xa0trEHhqKSUPpl0FcF++uiNKqwgUULBlimBgRbbipRj8DFbDVMjf98b2XrjTSx7dPjh4EJXf
 asUfawAtFXi11cPbqtSrzogIA22qXo5a0VPj2af+9/r4OGdO3c1kl3nd/lqloX4+iicVRBVM88
 ef49sT+MqpdYXl0aIA5pjibdMQJ0YgA48CmjXnFfVmZ0+t3JQSPxSnPd2mE3mYne4pYbYvBCQq
 PRM=
From:   Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>
CC:     <balasubramani_vivekanandan@mentor.com>, <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/1] tick: broadcast-hrtimer: Fix a race in bc_set_next
Date:   Wed, 25 Sep 2019 13:55:41 +0200
Message-ID: <20190925115541.1170-2-balasubramani_vivekanandan@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925115541.1170-1-balasubramani_vivekanandan@mentor.com>
References: <alpine.DEB.2.21.1909232041080.1934@nanos.tec.linutronix.de>
 <20190925115541.1170-1-balasubramani_vivekanandan@mentor.com>
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
warnings as shown in [1]

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

Since it is now allowed to start the hrtimer from the callback, there is
no need for the try to cancel logic. All that is now removed.

[1]: rcu stall warnings noticed before this patch

[   26.477514] INFO: rcu_preempt detected stalls on CPUs/tasks:
[   26.483197]  4-...: (0 ticks this GP) idle=718/0/0 softirq=1436/1436 fqs=0
[   26.490171]  (detected by 0, t=1755 jiffies, g=778, c=777, q=10243)
[   26.496456] Task dump for CPU 4:
[   26.499688] swapper/4       R  running task        0     0      1 0x00000020
[   26.506756] Call trace:
[   26.509221] [<ffff000008086214>] __switch_to+0x94/0xd8
[   26.514378] [<ffff000008ed9000>] bp_hardening_data+0x0/0x10
[   26.519964] rcu_preempt kthread starved for 1762 jiffies! g778 c777 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=4
[   26.530245] rcu_preempt     I    0     8      2 0x00000020
[   26.535742] Call trace:
[   26.538192] [<ffff000008086214>] __switch_to+0x94/0xd8
[   26.543344] [<ffff000008a6365c>] __schedule+0x274/0x940
[   26.548578] [<ffff000008a63d68>] schedule+0x40/0xa8
[   26.553467] [<ffff000008a6847c>] schedule_timeout+0x94/0x430
[   26.559141] [<ffff00000813cb04>] rcu_gp_kthread+0x76c/0x1068
[   26.564813] [<ffff0000080e1610>] kthread+0x138/0x140
[   26.569787] [<ffff000008084f74>] ret_from_fork+0x10/0x1c
[   30.481515] INFO: rcu_sched detected stalls on CPUs/tasks:
[   30.487030]  4-...: (0 ticks this GP) idle=718/0/0 softirq=1436/1436 fqs=0
[   30.494004]  (detected by 1, t=1755 jiffies, g=-24, c=-25, q=45)
[   30.500028] Task dump for CPU 4:
[   30.503261] swapper/4       R  running task        0     0      1 0x00000020
[   30.510330] Call trace:
[   30.512796] [<ffff000008086214>] __switch_to+0x94/0xd8
[   30.517953] [<ffff000008ed9000>] bp_hardening_data+0x0/0x10
[   30.523541] rcu_sched kthread starved for 1762 jiffies! g18446744073709551592 c18446744073709551591 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=4
[   30.536608] rcu_sched       I    0     9      2 0x00000020
[   30.542105] Call trace:
[   30.544554] [<ffff000008086214>] __switch_to+0x94/0xd8
[   30.549707] [<ffff000008a6365c>] __schedule+0x274/0x940
[   30.554942] [<ffff000008a63d68>] schedule+0x40/0xa8
[   30.559830] [<ffff000008a6847c>] schedule_timeout+0x94/0x430
[   30.565504] [<ffff00000813cb04>] rcu_gp_kthread+0x76c/0x1068
[   30.571176] [<ffff0000080e1610>] kthread+0x138/0x140
[   30.576149] [<ffff000008084f74>] ret_from_fork+0x10/0x1c

Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-broadcast-hrtimer.c | 52 ++++++++++++----------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index c1f5bb590b5e..6828fe3baacd 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -42,39 +42,37 @@ static int bc_shutdown(struct clock_event_device *evt)
  */
 static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 {
-	int bc_moved;
 	/*
-	 * We try to cancel the timer first. If the callback is on
-	 * flight on some other cpu then we let it handle it. If we
-	 * were able to cancel the timer nothing can rearm it as we
-	 * own broadcast_lock.
+	 * This is called either from enter/exit idle code or from the
+	 * broadcast handler. In all cases tick_broadcast_lock is held.
 	 *
-	 * However we can also be called from the event handler of
-	 * ce_broadcast_hrtimer itself when it expires. We cannot
-	 * restart the timer because we are in the callback, but we
-	 * can set the expiry time and let the callback return
-	 * HRTIMER_RESTART.
+	 * hrtimer_cancel() cannot be called here neither from the
+	 * broadcast handler nor from the enter/exit idle code. The idle
+	 * code can run into the problem described in bc_shutdown() and the
+	 * broadcast handler cannot wait for itself to complete for obvious
+	 * reasons.
 	 *
-	 * Since we are in the idle loop at this point and because
-	 * hrtimer_{start/cancel} functions call into tracing,
-	 * calls to these functions must be bound within RCU_NONIDLE.
+	 * Each caller tries to arm the hrtimer on its own CPU, but if the
+	 * handler is currently running hrtimer_start() does not move
+	 * it. It keeps it on the CPU on which it is assigned at the
+	 * moment.
 	 */
 	RCU_NONIDLE(
 		{
-			bc_moved = hrtimer_try_to_cancel(&bctimer) >= 0;
-			if (bc_moved) {
-				hrtimer_start(&bctimer, expires,
-					      HRTIMER_MODE_ABS_PINNED_HARD);
-			}
+			hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
+			/*
+			 * The core tick broadcast mode expects bc->bound_on to be set
+			 * correctly to prevent a CPU which has the broadcast hrtimer
+			 * armed from going deep idle.
+			 *
+			 * As tick_broadcast_lock is held, nothing can change the
+			 * cpu base which was just established in hrtimer_start()
+			 * above. So the below access is safe even without holding
+			 * the hrtimer base lock.
+			 */
+			bc->bound_on = bctimer.base->cpu_base->cpu;
 		}
 	);
-
-	if (bc_moved) {
-		/* Bind the "device" to the cpu */
-		bc->bound_on = smp_processor_id();
-	} else if (bc->bound_on == smp_processor_id()) {
-		hrtimer_set_expires(&bctimer, expires);
-	}
 	return 0;
 }
 
@@ -100,10 +98,6 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 {
 	ce_broadcast_hrtimer.event_handler(&ce_broadcast_hrtimer);
 
-	if (clockevent_state_oneshot(&ce_broadcast_hrtimer))
-		if (ce_broadcast_hrtimer.next_event != KTIME_MAX)
-			return HRTIMER_RESTART;
-
 	return HRTIMER_NORESTART;
 }
 
-- 
2.17.1

