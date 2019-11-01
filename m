Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54299CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C39520578
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfKACBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:01:08 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:14072 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfKACBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:01:07 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 017883BACD3F827086A3;
        Fri,  1 Nov 2019 10:01:05 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id xA120I6t003238;
        Fri, 1 Nov 2019 10:00:18 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019110110005294-235130 ;
          Fri, 1 Nov 2019 10:00:52 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        Yang Tao <yang.tao172@zte.com.cn>
Subject: [PATCH] Robust-futex wakes up the waiters will be missed
Date:   Fri, 1 Nov 2019 10:03:09 +0800
Message-Id: <1572573789-16557-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-11-01 10:00:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-11-01 10:00:23,
        Serialize complete at 2019-11-01 10:00:23
X-MAIL: mse-fl1.zte.com.cn xA120I6t003238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Tao <yang.tao172@zte.com.cn>

We found two scenarios:
(1)When the owner of a mutex lock with robust attribute and no_pi
will release the lock and executes pthread_mutex_unlock(),it is
killed after setting mutex->__data.__lock = 0 and before wake
others. It will go through the robust process, but it will not wake
up watiers because mutex->__data.__lock = 0.

                OWNER

        pthread_mutex_unlock()
                |
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
                return 0;<------wakes up waiters will be missed

(2) When a waiter wakes up and returns to the user space, it is
killed before getting the lock (before modifying
mutex->__data.__lock), and other waiters will not wake up.

        OWNER                         WAITER

   pthread_mutex_unlock()
                |
                |(__lock = 0)
                |
                V
         futex_wake()
                                fuet_wait()   //awaked
                                        |
                                        |
                                        |(enter userspace)
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
                return 0;<------wakes up waiters will be missed
So, in these scenarios, task will not wake up waiters

We found that when the task was killed in two scenarios,
task->robust_list->list_op_pending =&mutex->__data.__list.__next,
so we can do something.

We think that task should wake up once when the following conditions
are met:
        (1) task->robust_list->list_op_pending != NULL;
        (2) mutex->__data.__lock = 0;
        (3) no_pi
In some cases, this may lead to some redundant wakeups, which will
reduce the efficiency of the program, but it will not affectthe
program operation, and it is very rare to meet these three
conditions.

At the same time, we only wake up and do not set the died bit,
because mutex->__data.__lock = 0; mutex->__data.__owner = 0;
At this time, it can be seen that there is no owner,and the wake-up
process directly take the lock.

If the died bit is set, it may cause some misoperation. Such as a
waiter being killed when the owner is releasing the lock, it will
mark the lock with the died bit, which is not good.

We don't need to set "mutex->__data.__count"(in mutex structure),
which will not affect repeated lock holding.

Signed-off-by: Yang Tao <yang.tao172@zte.com.cn>
---
 kernel/futex.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index bd18f60..c2fb590 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3456,7 +3456,9 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
  * Process a futex-list entry, check whether it's owned by the
  * dying task, and do notification if so:
  */
-static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
+static int handle_futex_death(u32 __user *uaddr,
+			      struct task_struct *curr, int pi,
+			      bool pending)
 {
 	u32 uval, uninitialized_var(nval), mval;
 	int err;
@@ -3469,6 +3471,10 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
 	if (get_user(uval, uaddr))
 		return -1;
 
+	/* Robust-futex wakes up the waiters will be missed*/
+	if (pending && !pi && uval == 0)
+		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+
 	if ((uval & FUTEX_TID_MASK) != task_pid_vnr(curr))
 		return 0;
 
@@ -3590,7 +3596,7 @@ void exit_robust_list(struct task_struct *curr)
 		 */
 		if (entry != pending)
 			if (handle_futex_death((void __user *)entry + futex_offset,
-						curr, pi))
+						curr, pi, 0))
 				return;
 		if (rc)
 			return;
@@ -3607,7 +3613,7 @@ void exit_robust_list(struct task_struct *curr)
 
 	if (pending)
 		handle_futex_death((void __user *)pending + futex_offset,
-				   curr, pip);
+				   curr, pip, 1);
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
@@ -3784,7 +3790,7 @@ void compat_exit_robust_list(struct task_struct *curr)
 		if (entry != pending) {
 			void __user *uaddr = futex_uaddr(entry, futex_offset);
 
-			if (handle_futex_death(uaddr, curr, pi))
+			if (handle_futex_death(uaddr, curr, pi, 0))
 				return;
 		}
 		if (rc)
@@ -3803,7 +3809,7 @@ void compat_exit_robust_list(struct task_struct *curr)
 	if (pending) {
 		void __user *uaddr = futex_uaddr(pending, futex_offset);
 
-		handle_futex_death(uaddr, curr, pip);
+		handle_futex_death(uaddr, curr, pip, 1);
 	}
 }
 
-- 
2.15.2

