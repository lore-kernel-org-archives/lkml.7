Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1733DFC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45A520869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfKFXIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45525 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbfKFXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:12 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPJ-0004jE-CP; Thu, 07 Nov 2019 00:08:09 +0100
Message-Id: <20191106224556.332094221@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:39 +0100
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
Subject: [patch 05/12] futex: Split futex_mm_release() for exit/exec
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow separate handling of the futex exit state in the futex exit code
for exit and exec, split futex_mm_release() into two functions and invoke
them from the corresponding exit/exec_mm_release() callsites.

Preparatory only, no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/futex.h |    6 ++++--
 kernel/fork.c         |    5 ++---
 kernel/futex.c        |    7 ++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -91,14 +91,16 @@ static inline void futex_exit_done(struc
 	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
-void futex_mm_release(struct task_struct *tsk);
+void futex_exit_release(struct task_struct *tsk);
+void futex_exec_release(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
-static inline void futex_mm_release(struct task_struct *tsk) { }
 static inline void futex_exit_done(struct task_struct *tsk) { }
+static inline void futex_exit_release(struct task_struct *tsk) { }
+static inline void futex_exec_release(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1285,9 +1285,6 @@ static int wait_for_vfork_done(struct ta
  */
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
-	/* Get rid of any futexes when releasing the mm */
-	futex_mm_release(tsk);
-
 	uprobe_free_utask(tsk);
 
 	/* Get rid of any cached register state */
@@ -1322,11 +1319,13 @@ static void mm_release(struct task_struc
 
 void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
+	futex_exit_release(tsk);
 	mm_release(tsk, mm);
 }
 
 void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
+	futex_exec_release(tsk);
 	mm_release(tsk, mm);
 }
 
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3661,7 +3661,7 @@ static void exit_robust_list(struct task
 	}
 }
 
-void futex_mm_release(struct task_struct *tsk)
+void futex_exec_release(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
 		exit_robust_list(tsk);
@@ -3679,6 +3679,11 @@ void futex_mm_release(struct task_struct
 		exit_pi_state_list(tsk);
 }
 
+void futex_exit_release(struct task_struct *tsk)
+{
+	futex_exec_release(tsk);
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {


