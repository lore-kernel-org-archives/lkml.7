Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE605C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB412070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfHSPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:45:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfHSPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqk-0006tz-9b; Mon, 19 Aug 2019 17:45:38 +0200
Message-Id: <20190819143802.038794711@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 07/44] posix-cpu-timers: Simplify sighand locking in
 run_posix_cpu_timers()
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

run_posix_cpu_timers() is called from the timer interrupt. The posix timer
expiry always affects the current task which got interrupted.

sighand locking is only racy when done on a foreign task, which must use
lock_task_sighand(). But in case of run_posix_cpu_timers() that's
pointless.

sighand of a task can only be dropped or changed by the task itself. Drop
happens in do_exit(), changing sighand happens in execve().

So the timer interrupt can see one of the following states of the current
task which it interrupted:

   - executing:	sighand is set
   - exiting:	sighand is either set or NULL
   - execing:	sighand is either the original one or the new one

The 'check -> lock -> check again' logic in lock_task_sighand() is not
required here at all. The state cannot change as the interrupted task
context obviously is not executing instructions.

So the only interesting case here is to check whether current->sighand is
NULL or not.

Add the check for sighand == NULL right at the beginning and replace
lock_task_sighand() with a regular spin_lock() invocation along with proper
comments why this is safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1141,20 +1141,34 @@ void run_posix_cpu_timers(void)
 {
 	struct task_struct *tsk = current;
 	struct k_itimer *timer, *next;
-	unsigned long flags;
 	LIST_HEAD(firing);
 
 	lockdep_assert_irqs_disabled();
 
 	/*
-	 * The fast path checks that there are no expired thread or thread
-	 * group timers.  If that's so, just return.
+	 * Verify that sighand exits. If not, the task is exiting and has
+	 * dropped sighand already. Without sighand, timer expiry is
+	 * pointless.
 	 */
-	if (!fastpath_timer_check(tsk))
+	if (!tsk->sighand)
 		return;
 
-	if (!lock_task_sighand(tsk, &flags))
+	/*
+	 * Now do a fast check for expired task and group timers. If
+	 * no expired timers found, return.
+	 */
+	if(!fastpath_timer_check(tsk))
 		return;
+
+	/*
+	 * The timer interrupt hit current. It's verified that sighand
+	 * exists, so it cannot go away before the timer interrupt returns
+	 * as only current can remove or change its own sighand in exit()
+	 * or exec() with sighand lock held and interrupts disabled. Ergo
+	 * the interrupt can only observe a valid sighand or NULL.
+	 */
+	spin_lock(&tsk->sighand->siglock);
+
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
@@ -1172,7 +1186,7 @@ void run_posix_cpu_timers(void)
 	 * that gets the timer lock before we do will give it up and
 	 * spin until we've taken care of that timer below.
 	 */
-	unlock_task_sighand(tsk, &flags);
+	spin_unlock(&tsk->sighand->siglock);
 
 	/*
 	 * Now that all the timers on our list have the firing flag,


