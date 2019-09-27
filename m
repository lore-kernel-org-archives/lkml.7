Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3616F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfI0ILE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfI0ILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlL1-0005iS-8I; Fri, 27 Sep 2019 10:10:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BAD951C07BA;
        Fri, 27 Sep 2019 10:10:44 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:44 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] tasks: Add a count of task RCU users
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
In-Reply-To: <87woebdplt.fsf_-_@x220.int.ebiederm.org>
References: <87woebdplt.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <156957184468.9866.15729112622047548545.tip-bot2@tip-bot2>
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

Commit-ID:     3fbd7ee285b2bbc6eebd15a3c8786d9776a402a8
Gitweb:        https://git.kernel.org/tip/3fbd7ee285b2bbc6eebd15a3c8786d9776a402a8
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Sat, 14 Sep 2019 07:33:34 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:29 +02:00

tasks: Add a count of task RCU users

Add a count of the number of RCU users (currently 1) of the task
struct so that we can later add the scheduler case and get rid of the
very subtle task_rcu_dereference(), and just use rcu_dereference().

As suggested by Oleg have the count overlap rcu_head so that no
additional space in task_struct is required.

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
Link: https://lkml.kernel.org/r/87woebdplt.fsf_-_@x220.int.ebiederm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h      | 5 ++++-
 include/linux/sched/task.h | 1 +
 kernel/exit.c              | 7 ++++++-
 kernel/fork.c              | 7 +++----
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e2e9196..8e43e54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1147,7 +1147,10 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 
-	struct rcu_head			rcu;
+	union {
+		refcount_t		rcu_users;
+		struct rcu_head		rcu;
+	};
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 3d90ed8..153a683 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -120,6 +120,7 @@ static inline void put_task_struct(struct task_struct *t)
 }
 
 struct task_struct *task_rcu_dereference(struct task_struct **ptask);
+void put_task_struct_rcu_user(struct task_struct *task);
 
 #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
 extern int arch_task_struct_size __read_mostly;
diff --git a/kernel/exit.c b/kernel/exit.c
index 22ab6a4..3bcaec2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	put_task_struct(tsk);
 }
 
+void put_task_struct_rcu_user(struct task_struct *task)
+{
+	if (refcount_dec_and_test(&task->rcu_users))
+		call_rcu(&task->rcu, delayed_put_task_struct);
+}
 
 void release_task(struct task_struct *p)
 {
@@ -222,7 +227,7 @@ repeat:
 
 	write_unlock_irq(&tasklist_lock);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_task_struct_rcu_user(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
diff --git a/kernel/fork.c b/kernel/fork.c
index 1d1cd06..7eefe33 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -902,10 +902,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
 
-	/*
-	 * One for us, one for whoever does the "release_task()" (usually
-	 * parent)
-	 */
+	/* One for the user space visible state that goes away when reaped. */
+	refcount_set(&tsk->rcu_users, 1);
+	/* One for the rcu users, and one for the scheduler */
 	refcount_set(&tsk->usage, 2);
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
