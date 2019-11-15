Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445CBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298E82073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKOST0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:19:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44306 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:19:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVgBk-00059S-1d; Fri, 15 Nov 2019 19:19:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B43111C18CF;
        Fri, 15 Nov 2019 19:19:19 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:19:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Provide state handling for exec() as well
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.753355618@linutronix.de>
References: <20191106224556.753355618@linutronix.de>
MIME-Version: 1.0
Message-ID: <157384195969.12247.9678359807421410494.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1cc7f1d098bbada1f999b143893b31e0bc0cafc4
Gitweb:        https://git.kernel.org/tip/1cc7f1d098bbada1f999b143893b31e0bc0cafc4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 19:10:53 +01:00

futex: Provide state handling for exec() as well

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
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.753355618@linutronix.de

---
 kernel/futex.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index f618562..0c9850a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3661,7 +3661,7 @@ static void exit_robust_list(struct task_struct *curr)
 	}
 }
 
-void futex_exec_release(struct task_struct *tsk)
+static void futex_cleanup(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
 		exit_robust_list(tsk);
@@ -3701,7 +3701,7 @@ void futex_exit_recursive(struct task_struct *tsk)
 	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
-void futex_exit_release(struct task_struct *tsk)
+static void futex_cleanup_begin(struct task_struct *tsk)
 {
 	/*
 	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
@@ -3717,10 +3717,40 @@ void futex_exit_release(struct task_struct *tsk)
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
