Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA4B20717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbfINMf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 08:35:29 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40329 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbfINMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:35:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97Gx-0003qF-Ld; Sat, 14 Sep 2019 06:35:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97Gr-00037n-B7; Sat, 14 Sep 2019 06:35:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
        <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
        <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
Date:   Sat, 14 Sep 2019 07:35:02 -0500
In-Reply-To: <87muf7f4bf.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 14 Sep 2019 07:30:28 -0500")
Message-ID: <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i97Gr-00037n-B7;;;mid=<87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fWCOXOBQIwNdP5hvvIwXngemgjOMnoBo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The current task on the runqueue is currently read with rcu_dereference().

To obtain ordinary rcu semantics for an rcu_dereference of rq->curr it needs
to be paird with rcu_assign_pointer of rq->curr.  Which provides the
memory barrier necessary to order assignments to the task_struct
and the assignment to rq->curr.

Unfortunately the assignment of rq->curr in __schedule is a hot path,
and it has already been show that additional barriers in that code
will reduce the performance of the scheduler.  So I will attempt to
describe below why you can effectively have ordinary rcu semantics
without any additional barriers.

The assignment of rq->curr in init_idle is a slow path called once
per cpu and that can use rcu_assign_pointer() without any concerns.

As I write this there are effectively two users of rcu_dereference on
rq->curr.  There is the membarrier code in kernel/sched/membarrier.c
that only looks at "->mm" after the rcu_dereference.  Then there is
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
the code has the same guarantees as if it used rcu_assign_pointer.

Reading through all of the implementations of pick_next_task it
appears pick_next_task is limited to modifying the task_struct fields
"->se", "->rt", "->dl".  These fields are the sched_entity structures
of the varies schedulers.

Further "->se.cfs_rq" is only changed in cgroup attach/move operations
initialized by userspace.

Unless I have missed something this means that in practice that the
users of "rcu_dereerence(rq->curr)" get normal rcu semantics of
rcu_dereference() for the fields the care about, despite the
assignment of rq->curr in __schedule() ot using rcu_assign_pointer.

Link: https://lore.kernel.org/r/20190903200603.GW2349@hirez.programming.kicks-ass.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 69015b7c28da..668262806942 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3857,7 +3857,11 @@ static void __sched notrace __schedule(bool preempt)
 
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
@@ -5863,7 +5867,8 @@ void init_idle(struct task_struct *idle, int cpu)
 	__set_task_cpu(idle, cpu);
 	rcu_read_unlock();
 
-	rq->curr = rq->idle = idle;
+	rq->idle = idle;
+	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
-- 
2.21.0.dirty

