Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FDFC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EC5217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfKFXIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfKFXIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:07 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPA-0004in-Q7; Thu, 07 Nov 2019 00:08:02 +0100
Message-Id: <20191106224555.943191378@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:35 +0100
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
Subject: [patch 01/12] futex: Prevent robust futex exit race
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Tao <yang.tao172@zte.com.cn>

Robust futexes utilize the robust_list mechanism to allow the kernel to
release futexes which are held when a task exits. The exit can be voluntary
or caused by a signal or fault. This prevents that waiters block forever.

The futex operations in user space store a pointer to the futex they are
either locking or unlocking in the op_pending member of the per task robust
list.

After a lock operation has succeeded the futex is queued in the robust list
linked list and the op_pending pointer is cleared.

After an unlock operation has succeeded the futex is removed from the
robust list linked list and the op_pending pointer is cleared.

The robust list exit code checks for the pending operation and any futex
which is queued in the linked list. It carefully checks whether the futex
value is the TID of the exiting task. If so, it sets the OWNER_DIED bit and
tries to wake up a potential waiter.

This is race free for the lock operation but unlock has two race scenarios
where waiters might not be woken up. These issues can be observed with
regular robust pthread mutexes. PI aware pthread mutexes are not affected.

(1) Unlocking task is killed after unlocking the futex value in user space
    before being able to wake a waiter.

        pthread_mutex_unlock()
                |
                V
        atomic_exchange_rel (&mutex->__data.__lock, 0)
                        <------------------------killed
            lll_futex_wake ()                   |
                                                |
                                                |(__lock = 0)
                                                |(enter kernel)
                                                |
                                                V
                                            do_exit()
                                            exit_mm()
                                          mm_release()
                                        exit_robust_list()
                                        handle_futex_death()
                                                |
                                                |(__lock = 0)
                                                |(uval = 0)
                                                |
                                                V
        if ((uval & FUTEX_TID_MASK) != task_pid_vnr(curr))
                return 0;

    The sanity check which ensures that the user space futex is owned by
    the exiting task prevents the wakeup of waiters which in consequence
    block infinitely.

(2) Waiting task is killed after a wakeup and before it can acquire the
    futex in user space.

        OWNER                         WAITER
				futex_wait()      		
   pthread_mutex_unlock()               |
                |                       |
                |(__lock = 0)           |
                |                       |
                V                       |
         futex_wake() ------------>  wakeup()
                                        |
                                        |(return to userspace)
                                        |(__lock = 0)
                                        |
                                        V
                        oldval = mutex->__data.__lock
                                          <-----------------killed
    atomic_compare_and_exchange_val_acq (&mutex->__data.__lock,  |
                        id | assume_other_futex_waiters, 0)      |
                                                                 |
                                                                 |
                                                   (enter kernel)|
                                                                 |
                                                                 V
                                                         do_exit()
                                                        |
                                                        |
                                                        V
                                        handle_futex_death()
                                        |
                                        |(__lock = 0)
                                        |(uval = 0)
                                        |
                                        V
        if ((uval & FUTEX_TID_MASK) != task_pid_vnr(curr))
                return 0;

    The sanity check which ensures that the user space futex is owned
    by the exiting task prevents the wakeup of waiters, which seems to
    be correct as the exiting task does not own the futex value, but
    the consequence is that other waiters wont be woken up and block
    infinitely.

In both scenarios the following conditions are true:

   - task->robust_list->list_op_pending != NULL
   - user space futex value == 0
   - Regular futex (not PI)

If these conditions are met then it is reasonably safe to wake up a
potential waiter in order to prevent the above problems.

As this might be a false positive it can cause spurious wakeups, but the
waiter side has to handle other types of unrelated wakeups, e.g. signals
gracefully anyway. So such a spurious wakeup will not affect the
correctness of these operations.

This workaround must not touch the user space futex value and cannot set
the OWNER_DIED bit because the lock value is 0, i.e. uncontended. Setting
OWNER_DIED in this case would result in inconsistent state and subsequently
in malfunction of the owner died handling in user space.

The rest of the user space state is still consistent as no other task can
observe the list_op_pending entry in the exiting tasks robust list.

The eventually woken up waiter will observe the uncontended lock value and
take it over.

[ tglx: Massaged changelog and comment. Made the return explicit and not
  	depend on the subsequent check and added constants to hand into
  	handle_futex_death() instead of plain numbers. Fixed a few coding
	style issues. ]

Signed-off-by: Yang Tao <yang.tao172@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1573010582-35297-1-git-send-email-wang.yi59@zte.com.cn
---
 kernel/futex.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3452,11 +3452,16 @@ SYSCALL_DEFINE3(get_robust_list, int, pi
 	return ret;
 }
 
+/* Constants for the pending_op argument of handle_futex_death */
+#define HANDLE_DEATH_PENDING	true
+#define HANDLE_DEATH_LIST	false
+
 /*
  * Process a futex-list entry, check whether it's owned by the
  * dying task, and do notification if so:
  */
-static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
+static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
+			      bool pi, bool pending_op)
 {
 	u32 uval, uninitialized_var(nval), mval;
 	int err;
@@ -3469,6 +3474,42 @@ static int handle_futex_death(u32 __user
 	if (get_user(uval, uaddr))
 		return -1;
 
+	/*
+	 * Special case for regular (non PI) futexes. The unlock path in
+	 * user space has two race scenarios:
+	 *
+	 * 1. The unlock path releases the user space futex value and
+	 *    before it can execute the futex() syscall to wake up
+	 *    waiters it is killed.
+	 *
+	 * 2. A woken up waiter is killed before it can acquire the
+	 *    futex in user space.
+	 *
+	 * In both cases the TID validation below prevents a wakeup of
+	 * potential waiters which can cause these waiters to block
+	 * forever.
+	 *
+	 * In both cases the following conditions are met:
+	 *
+	 *	1) task->robust_list->list_op_pending != NULL
+	 *	   @pending_op == true
+	 *	2) User space futex value == 0
+	 *	3) Regular futex: @pi == false
+	 *
+	 * If these conditions are met, it is safe to attempt waking up a
+	 * potential waiter without touching the user space futex value and
+	 * trying to set the OWNER_DIED bit. The user space futex value is
+	 * uncontended and the rest of the user space mutex state is
+	 * consistent, so a woken waiter will just take over the
+	 * uncontended futex. Setting the OWNER_DIED bit would create
+	 * inconsistent state and malfunction of the user space owner died
+	 * handling.
+	 */
+	if (pending_op && !pi && !uval) {
+		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+		return 0;
+	}
+
 	if ((uval & FUTEX_TID_MASK) != task_pid_vnr(curr))
 		return 0;
 
@@ -3588,10 +3629,11 @@ void exit_robust_list(struct task_struct
 		 * A pending lock might already be on the list, so
 		 * don't process it twice:
 		 */
-		if (entry != pending)
+		if (entry != pending) {
 			if (handle_futex_death((void __user *)entry + futex_offset,
-						curr, pi))
+						curr, pi, HANDLE_DEATH_LIST))
 				return;
+		}
 		if (rc)
 			return;
 		entry = next_entry;
@@ -3605,9 +3647,10 @@ void exit_robust_list(struct task_struct
 		cond_resched();
 	}
 
-	if (pending)
+	if (pending) {
 		handle_futex_death((void __user *)pending + futex_offset,
-				   curr, pip);
+				   curr, pip, HANDLE_DEATH_PENDING);
+	}
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
@@ -3784,7 +3827,8 @@ void compat_exit_robust_list(struct task
 		if (entry != pending) {
 			void __user *uaddr = futex_uaddr(entry, futex_offset);
 
-			if (handle_futex_death(uaddr, curr, pi))
+			if (handle_futex_death(uaddr, curr, pi,
+					       HANDLE_DEATH_LIST))
 				return;
 		}
 		if (rc)
@@ -3803,7 +3847,7 @@ void compat_exit_robust_list(struct task
 	if (pending) {
 		void __user *uaddr = futex_uaddr(pending, futex_offset);
 
-		handle_futex_death(uaddr, curr, pip);
+		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
 


