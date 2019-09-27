Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42798C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BBD2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfI0ILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfI0ILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKx-0005hG-N0; Fri, 27 Sep 2019 10:10:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 874A51C07A5;
        Fri, 27 Sep 2019 10:10:44 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:44 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] tasks, sched/core: Ensure tasks are available for
 a grace period after leaving the runqueue
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <87r24jdpl5.fsf_-_@x220.int.ebiederm.org>
References: <87r24jdpl5.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <156957184451.9866.478882199102320208.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0ff7b2cfbae36ebcd216c6a5ad7f8534eebeaee2
Gitweb:        https://git.kernel.org/tip/0ff7b2cfbae36ebcd216c6a5ad7f8534eebeaee2
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Sat, 14 Sep 2019 07:33:58 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:29 +02:00

tasks, sched/core: Ensure tasks are available for a grace period after leaving the runqueue

In the ordinary case today the RCU grace period for a task_struct is
triggered when another process wait's for it's zombine and causes the
kernel to call release_task().  As the waiting task has to receive a
signal and then act upon it before this happens, typically this will
occur after the original task as been removed from the runqueue.

Unfortunaty in some cases such as self reaping tasks it can be shown
that release_task() will be called starting the grace period for
task_struct long before the task leaves the runqueue.

Therefore use put_task_struct_rcu_user() in finish_task_switch() to
guarantee that the there is a RCU lifetime after the task
leaves the runqueue.

Besides the change in the start of the RCU grace period for the
task_struct this change may cause perf_event_delayed_put and
trace_sched_process_free.  The function perf_event_delayed_put boils
down to just a WARN_ON for cases that I assume never show happen.  So
I don't see any problem with delaying it.

The function trace_sched_process_free is a trace point and thus
visible to user space.  Occassionally userspace has the strangest
dependencies so this has a miniscule chance of causing a regression.
This change only changes the timing of when the tracepoint is called.
The change in timing arguably gives userspace a more accurate picture
of what is going on.  So I don't expect there to be a regression.

In the case where a task self reaps we are pretty much guaranteed that
the RCU grace period is delayed.  So we should get quite a bit of
coverage in of this worst case for the change in a normal threaded
workload.  So I expect any issues to turn up quickly or not at all.

I have lightly tested this change and everything appears to work
fine.

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Inspired-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87r24jdpl5.fsf_-_@x220.int.ebiederm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/fork.c       | 11 +++++++----
 kernel/sched/core.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7eefe33..d6e5525 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -902,10 +902,13 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
 
-	/* One for the user space visible state that goes away when reaped. */
-	refcount_set(&tsk->rcu_users, 1);
-	/* One for the rcu users, and one for the scheduler */
-	refcount_set(&tsk->usage, 2);
+	/*
+	 * One for the user space visible state that goes away when reaped.
+	 * One for the scheduler.
+	 */
+	refcount_set(&tsk->rcu_users, 2);
+	/* One for the rcu users */
+	refcount_set(&tsk->usage, 1);
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06961b9..5e5fefb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3254,7 +3254,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-		put_task_struct(prev);
+		put_task_struct_rcu_user(prev);
 	}
 
 	tick_nohz_task_switch();
