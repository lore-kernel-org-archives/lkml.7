Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61398FC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D61820869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfKFXI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfKFXIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:25 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPU-0004kX-Q0; Thu, 07 Nov 2019 00:08:21 +0100
Message-Id: <20191106224556.753355618@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:43 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [patch 09/12] futex: Provide state handling for exec() as well
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exec() attempts to handle potentially held futexes gracefully by running
the futex exit handling code like exit() does.

The current implementation has no protection against concurrent incoming
waiters. The reason is that the futex state cannot be set to
FUTEX_STATE_DEAD after the cleanup because the task struct is still active
and just about to execute the new binary.

While its arguably buggy when a task holds a futex over exec(), for
consistency sake the state handling can at least cover the actual futex
exit cleanup section. This provides state consistency protection accross
the cleanup. As the futex state of the task becomes FUTEX_STATE_OK after the
cleanup has been finished, this cannot prevent subsequent attempts to
attach to the task in case that the cleanup was not successfull in mopping
up all leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3661,7 +3661,7 @@ static void exit_robust_list(struct task
 	}
 }
 
-void futex_exec_release(struct task_struct *tsk)
+static void futex_cleanup(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
 		exit_robust_list(tsk);
@@ -3701,7 +3701,7 @@ void futex_exit_recursive(struct task_st
 	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
-void futex_exit_release(struct task_struct *tsk)
+static void futex_cleanup_begin(struct task_struct *tsk)
 {
 	/*
 	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
@@ -3717,10 +3717,40 @@ void futex_exit_release(struct task_stru
 	raw_spin_lock_irq(&tsk->pi_lock);
 	tsk->futex_state = FUTEX_STATE_EXITING;
 	raw_spin_unlock_irq(&tsk->pi_lock);
+}
 
-	futex_exec_release(tsk);
+static void futex_cleanup_end(struct task_struct *tsk, int state)
+{
+	/*
+	 * Lockless store. The only side effect is that an observer might
+	 * take another loop until it becomes visible.
+	 */
+	tsk->futex_state = state;
+}
 
-	tsk->futex_state = FUTEX_STATE_DEAD;
+void futex_exec_release(struct task_struct *tsk)
+{
+	/*
+	 * The state handling is done for consistency, but in the case of
+	 * exec() there is no way to prevent futher damage as the PID stays
+	 * the same. But for the unlikely and arguably buggy case that a
+	 * futex is held on exec(), this provides at least as much state
+	 * consistency protection which is possible.
+	 */
+	futex_cleanup_begin(tsk);
+	futex_cleanup(tsk);
+	/*
+	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
+	 * exec a new binary.
+	 */
+	futex_cleanup_end(tsk, FUTEX_STATE_OK);
+}
+
+void futex_exit_release(struct task_struct *tsk)
+{
+	futex_cleanup_begin(tsk);
+	futex_cleanup(tsk);
+	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,


