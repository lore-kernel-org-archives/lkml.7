Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59632C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316CF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKOSTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:19:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44346 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfKOSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:19:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVgBk-00059n-BX; Fri, 15 Nov 2019 19:19:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0EF201C08AC;
        Fri, 15 Nov 2019 19:19:20 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:19:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Mark the begin of futex exit explicitly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.539409004@linutronix.de>
References: <20191106224556.539409004@linutronix.de>
MIME-Version: 1.0
Message-ID: <157384196002.12247.3177597964023827853.tip-bot2@tip-bot2>
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

Commit-ID:     804933764d1f5afdfc094ea914f4173b720477d6
Gitweb:        https://git.kernel.org/tip/804933764d1f5afdfc094ea914f4173b720477d6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 19:10:52 +01:00

futex: Mark the begin of futex exit explicitly

Instead of relying on PF_EXITING use an explicit state for the futex exit
and set it in the futex exit function. This moves the smp barrier and the
lock/unlock serialization into the futex code.

As with the DEAD state this is restricted to the exit path as exec
continues to use the same task struct.

This allows to simplify that logic in a next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.539409004@linutronix.de

---
 include/linux/futex.h | 31 +++----------------------------
 kernel/exit.c         | 13 +------------
 kernel/futex.c        | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9762951..9daf8d9 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -50,6 +50,7 @@ union futex_key {
 #ifdef CONFIG_FUTEX
 enum {
 	FUTEX_STATE_OK,
+	FUTEX_STATE_EXITING,
 	FUTEX_STATE_DEAD,
 };
 
@@ -64,33 +65,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 	tsk->futex_state = FUTEX_STATE_OK;
 }
 
-/**
- * futex_exit_done - Sets the tasks futex state to FUTEX_STATE_DEAD
- * @tsk:	task to set the state on
- *
- * Set the futex exit state of the task lockless. The futex waiter code
- * observes that state when a task is exiting and loops until the task has
- * actually finished the futex cleanup. The worst case for this is that the
- * waiter runs through the wait loop until the state becomes visible.
- *
- * This has two callers:
- *
- * - futex_mm_release() after the futex exit cleanup has been done
- *
- * - do_exit() from the recursive fault handling path.
- *
- * In case of a recursive fault this is best effort. Either the futex exit
- * code has run already or not. If the OWNER_DIED bit has been set on the
- * futex then the waiter can take it over. If not, the problem is pushed
- * back to user space. If the futex exit code did not run yet, then an
- * already queued waiter might block forever, but there is nothing which
- * can be done about that.
- */
-static inline void futex_exit_done(struct task_struct *tsk)
-{
-	tsk->futex_state = FUTEX_STATE_DEAD;
-}
-
+void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
 
@@ -98,7 +73,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
-static inline void futex_exit_done(struct task_struct *tsk) { }
+static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
diff --git a/kernel/exit.c b/kernel/exit.c
index f3b8fa1..d351fd0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -746,23 +746,12 @@ void __noreturn do_exit(long code)
 	 */
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
-		futex_exit_done(tsk);
+		futex_exit_recursive(tsk);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
 
 	exit_signals(tsk);  /* sets PF_EXITING */
-	/*
-	 * Ensure that all new tsk->pi_lock acquisitions must observe
-	 * PF_EXITING. Serializes against futex.c:attach_to_pi_owner().
-	 */
-	smp_mb();
-	/*
-	 * Ensure that we must observe the pi_state in exit_mm() ->
-	 * mm_release() -> exit_pi_state_list().
-	 */
-	raw_spin_lock_irq(&tsk->pi_lock);
-	raw_spin_unlock_irq(&tsk->pi_lock);
 
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
diff --git a/kernel/futex.c b/kernel/futex.c
index 426dd71..3488fb0 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3679,10 +3679,45 @@ void futex_exec_release(struct task_struct *tsk)
 		exit_pi_state_list(tsk);
 }
 
+/**
+ * futex_exit_recursive - Set the tasks futex state to FUTEX_STATE_DEAD
+ * @tsk:	task to set the state on
+ *
+ * Set the futex exit state of the task lockless. The futex waiter code
+ * observes that state when a task is exiting and loops until the task has
+ * actually finished the futex cleanup. The worst case for this is that the
+ * waiter runs through the wait loop until the state becomes visible.
+ *
+ * This is called from the recursive fault handling path in do_exit().
+ *
+ * This is best effort. Either the futex exit code has run already or
+ * not. If the OWNER_DIED bit has been set on the futex then the waiter can
+ * take it over. If not, the problem is pushed back to user space. If the
+ * futex exit code did not run yet, then an already queued waiter might
+ * block forever, but there is nothing which can be done about that.
+ */
+void futex_exit_recursive(struct task_struct *tsk)
+{
+	tsk->futex_state = FUTEX_STATE_DEAD;
+}
+
 void futex_exit_release(struct task_struct *tsk)
 {
+	tsk->futex_state = FUTEX_STATE_EXITING;
+	/*
+	 * Ensure that all new tsk->pi_lock acquisitions must observe
+	 * FUTEX_STATE_EXITING. Serializes against attach_to_pi_owner().
+	 */
+	smp_mb();
+	/*
+	 * Ensure that we must observe the pi_state in exit_pi_state_list().
+	 */
+	raw_spin_lock_irq(&tsk->pi_lock);
+	raw_spin_unlock_irq(&tsk->pi_lock);
+
 	futex_exec_release(tsk);
-	futex_exit_done(tsk);
+
+	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
