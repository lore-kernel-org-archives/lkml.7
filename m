Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BE1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55B220717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbfINMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 08:32:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40166 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbfINMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:32:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97Ds-0003aM-6T; Sat, 14 Sep 2019 06:32:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97Dp-0002oP-HB; Sat, 14 Sep 2019 06:32:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
        <20190903074117.GX2369@hirez.programming.kicks-ass.net>
        <20190903074718.GT2386@hirez.programming.kicks-ass.net>
        <87k1apqqgk.fsf@x220.int.ebiederm.org>
Date:   Sat, 14 Sep 2019 07:31:55 -0500
In-Reply-To: <87k1apqqgk.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 03 Sep 2019 11:44:59 -0500")
Message-ID: <87blvnf490.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i97Dp-0002oP-HB;;;mid=<87blvnf490.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WKKW4zKjsqe/envcofroPMWToQ/iobMQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 2/4] task: Ensure tasks are available for a grace period after leaving the runqueue
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the ordinary case today the rcu grace period for a task_struct is
triggered when another process wait's for it's zombine and causes the
kernel to call release_task().  As the waiting task has to receive a
signal and then act upon it before this happens, typically this will
occur after the original task as been removed from the runqueue.

Unfortunaty in some cases such as self reaping tasks it can be shown
that release_task() will be called starting the grace period for
task_struct long before the task leaves the runqueue.

Therefore use put_task_struct_rcu_user in finish_task_switch to
guarantee that the there is a rcu lifetime after the task
leaves the runqueue.

Besides the change in the start of the rcu grace period for the
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
the rcu grace period is delayed.  So we should get quite a bit of
coverage in of this worst case for the change in a normal threaded
workload.  So I expect any issues to turn up quickly or not at all.

I have lightly tested this change and everything appears to work
fine.

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Inspired-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c       | 11 +++++++----
 kernel/sched/core.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f04741d5c70..7a74ade4e7d6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -900,10 +900,13 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
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
index 2b037f195473..69015b7c28da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3135,7 +3135,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-		put_task_struct(prev);
+		put_task_struct_rcu_user(prev);
 	}
 
 	tick_nohz_task_switch();
-- 
2.21.0.dirty

