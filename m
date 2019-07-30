Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9961EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7608A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfG3WlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:41:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbfG3WlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:41:12 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsanf-0002Ow-R7; Wed, 31 Jul 2019 00:40:57 +0200
Message-Id: <20190730223828.965541887@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Jul 2019 00:33:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: [patch 6/7] posix-timers: Move rcu_head out of it union
References: <20190730223348.409366334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer deletion on PREEMPT_RT is prone to priority inversion and live
locks. The hrtimer code has a synchronization mechanism for this. Posix CPU
timers will grow one.

But that mechanism cannot be invoked while holding the k_itimer lock
because that can deadlock against the running timer callback. So the lock
must be dropped which allows the timer to be freed.

The timer free can be prevented by taking RCU readlock before dropping the
lock, but because the rcu_head is part of the 'it' union a concurrent free
will overwrite the hrtimer on which the task is trying to synchronize.

Move the rcu_head out of the union to prevent this.

[ tglx: Fixed up kernel-doc. Rewrote changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    5 +++--
 kernel/time/posix-timers.c   |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -85,7 +85,8 @@ static inline int clockid_to_fd(const cl
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
- *			internals. Also used for rcu freeing the timer.
+ *			internals.
+ * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
 	struct list_head	list;
@@ -114,8 +115,8 @@ struct k_itimer {
 		struct {
 			struct alarm	alarmtimer;
 		} alarm;
-		struct rcu_head		rcu;
 	} it;
+	struct rcu_head		rcu;
 };
 
 void run_posix_cpu_timers(struct task_struct *task);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -442,7 +442,7 @@ static struct k_itimer * alloc_posix_tim
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -459,7 +459,7 @@ static void release_posix_timer(struct k
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)


