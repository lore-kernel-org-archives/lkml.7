Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B852C352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D65E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfI0ILI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfI0ILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKv-0005ef-H6; Fri, 27 Sep 2019 10:10:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 348561C0744;
        Fri, 27 Sep 2019 10:10:44 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:44 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] tasks, sched/core: RCUify the assignment of rq->curr
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190903200603.GW2349@hirez.programming.kicks-ass.net>
References: <20190903200603.GW2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <156957184417.9866.5061690782234958008.tip-bot2@tip-bot2>
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

Commit-ID:     5311a98fef7d0dc2e8040ae0e18f5568d6d1dd5a
Gitweb:        https://git.kernel.org/tip/5311a98fef7d0dc2e8040ae0e18f5568d6d1dd5a
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Sat, 14 Sep 2019 07:35:02 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:29 +02:00

tasks, sched/core: RCUify the assignment of rq->curr

The current task on the runqueue is currently read with rcu_dereference().

To obtain ordinary RCU semantics for an rcu_dereference() of rq->curr it needs
to be paired with rcu_assign_pointer() of rq->curr.  Which provides the
memory barrier necessary to order assignments to the task_struct
and the assignment to rq->curr.

Unfortunately the assignment of rq->curr in __schedule is a hot path,
and it has already been show that additional barriers in that code
will reduce the performance of the scheduler.  So I will attempt to
describe below why you can effectively have ordinary RCU semantics
without any additional barriers.

The assignment of rq->curr in init_idle is a slow path called once
per cpu and that can use rcu_assign_pointer() without any concerns.

As I write this there are effectively two users of rcu_dereference() on
rq->curr.  There is the membarrier code in kernel/sched/membarrier.c
that only looks at "->mm" after the rcu_dereference().  Then there is
task_numa_compare() in kernel/sched/fair.c.  My best reading of the
code shows that task_numa_compare only access: "->flags",
"->cpus_ptr", "->numa_group", "->numa_faults[]",
"->total_numa_faults", and "->se.cfs_rq".

The code in __schedule() essentially does:
	rq_lock(...);
	smp_mb__after_spinlock();

	next = pick_next_task(...);
	rq->curr = next;

	context_switch(prev, next);

At the start of the function the rq_lock/smp_mb__after_spinlock
pair provides a full memory barrier.  Further there is a full memory barrier
in context_switch().

This means that any task that has already run and modified itself (the
common case) has already seen two memory barriers before __schedule()
runs and begins executing.  A task that modifies itself then sees a
third full memory barrier pair with the rq_lock();

For a brand new task that is enqueued with wake_up_new_task() there
are the memory barriers present from the taking and release the
pi_lock and the rq_lock as the processes is enqueued as well as the
full memory barrier at the start of __schedule() assuming __schedule()
happens on the same cpu.

This means that by the time we reach the assignment of rq->curr
except for values on the task struct modified in pick_next_task
the code has the same guarantees as if it used rcu_assign_pointer().

Reading through all of the implementations of pick_next_task it
appears pick_next_task is limited to modifying the task_struct fields
"->se", "->rt", "->dl".  These fields are the sched_entity structures
of the varies schedulers.

Further "->se.cfs_rq" is only changed in cgroup attach/move operations
initialized by userspace.

Unless I have missed something this means that in practice that the
users of "rcu_dereference(rq->curr)" get normal RCU semantics of
rcu_dereference() for the fields the care about, despite the
assignment of rq->curr in __schedule() ot using rcu_assign_pointer.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20190903200603.GW2349@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e5fefb..84c7116 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4033,7 +4033,11 @@ static void __sched notrace __schedule(bool preempt)
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
-		rq->curr = next;
+		/*
+		 * RCU users of rcu_dereference(rq->curr) may not see
+		 * changes to task_struct made by pick_next_task().
+		 */
+		RCU_INIT_POINTER(rq->curr, next);
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -6060,7 +6064,8 @@ void init_idle(struct task_struct *idle, int cpu)
 	__set_task_cpu(idle, cpu);
 	rcu_read_unlock();
 
-	rq->curr = rq->idle = idle;
+	rq->idle = idle;
+	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
