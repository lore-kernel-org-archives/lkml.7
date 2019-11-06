Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D84FC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E2120869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfKFXIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbfKFXIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:10 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPG-0004j4-QX; Thu, 07 Nov 2019 00:08:07 +0100
Message-Id: <20191106224556.240518241@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:38 +0100
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
Subject: [patch 04/12] exit/exec: Seperate mm_release()
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_release() contains the futex exit handling. mm_release() is called from
do_exit()->exit_mm() and from exec()->exec_mm().

In the exit_mm() case PF_EXITING and the futex state is updated. In the
exec_mm() case these states are not touched.

As the futex exit code needs further protections against exit races, this
needs to be split into two functions.

Preparatory only, no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/exec.c                |    2 +-
 include/linux/sched/mm.h |    6 ++++--
 kernel/exit.c            |    2 +-
 kernel/fork.c            |   12 +++++++++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1015,7 +1015,7 @@ static int exec_mmap(struct mm_struct *m
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
-	mm_release(tsk, old_mm);
+	exec_mm_release(tsk, old_mm);
 
 	if (old_mm) {
 		sync_mm_rss(old_mm);
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -117,8 +117,10 @@ extern struct mm_struct *get_task_mm(str
  * succeeds.
  */
 extern struct mm_struct *mm_access(struct task_struct *task, unsigned int mode);
-/* Remove the current tasks stale references to the old mm_struct */
-extern void mm_release(struct task_struct *, struct mm_struct *);
+/* Remove the current tasks stale references to the old mm_struct on exit() */
+extern void exit_mm_release(struct task_struct *, struct mm_struct *);
+/* Remove the current tasks stale references to the old mm_struct on exec() */
+extern void exec_mm_release(struct task_struct *, struct mm_struct *);
 
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -437,7 +437,7 @@ static void exit_mm(void)
 	struct mm_struct *mm = current->mm;
 	struct core_state *core_state;
 
-	mm_release(current, mm);
+	exit_mm_release(current, mm);
 	if (!mm)
 		return;
 	sync_mm_rss(mm);
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1283,7 +1283,7 @@ static int wait_for_vfork_done(struct ta
  * restoring the old one. . .
  * Eric Biederman 10 January 1998
  */
-void mm_release(struct task_struct *tsk, struct mm_struct *mm)
+static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	/* Get rid of any futexes when releasing the mm */
 	futex_mm_release(tsk);
@@ -1320,6 +1320,16 @@ void mm_release(struct task_struct *tsk,
 		complete_vfork_done(tsk);
 }
 
+void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm_release(tsk, mm);
+}
+
+void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm_release(tsk, mm);
+}
+
 /**
  * dup_mm() - duplicates an existing mm structure
  * @tsk: the task_struct with which the new mm will be associated.


