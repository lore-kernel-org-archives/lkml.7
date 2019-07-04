Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC86FC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE7F21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ryBGsPAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGDWN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 18:13:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDWN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 18:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LU76jX5mUvwoVyF8OaHgcpTir8O9zOpGjGZaM7tm0C8=; b=ryBGsPAM2ALjqGgABSitfCFVM
        jlCWdOAm1vZ33ngZcZMDdubbGCJhsktxNU4Bp5VRWjIzIrx+z/5NzHMw6PB+JuQWYLtlGxNRlMilY
        BJr1/3EuQ+4mxmxUR9xJMwm6ntmWeACR6iZ2b+XaHMiAITbnA0b/WYqG9zOBXEz3fwz1qF9GguQC3
        y1Dd9Z08BkoGD9we+GyplGmCGXtiUxqvspjLWkfeAOqcybZbq8/9luskhd7APqGoReiOx0iF/axUM
        1Jm/n1tNv9UiaXiY85qzCnMFgQLKxKLMmv8KYLkeGFhIkS9VaqFo3gL+U9RLDObWerOKj/igycK4P
        fsJkfhyAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hj9yn-0006MG-N1; Thu, 04 Jul 2019 22:13:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] Convert get_task_struct to return the task
Date:   Thu,  4 Jul 2019 15:13:23 -0700
Message-Id: <20190704221323.24290-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Returning the pointer that was passed in allows us to write
slightly more idiomatic code.  Convert a few users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/sched/task.h        | 6 +++++-
 kernel/events/core.c              | 9 +++------
 kernel/irq/manage.c               | 3 +--
 kernel/locking/rtmutex.c          | 6 ++----
 kernel/locking/rwsem-xadd.c       | 3 +--
 kernel/trace/trace_sched_wakeup.c | 3 +--
 6 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f1227f2c38a4..47032fe3f16c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -89,7 +89,11 @@ extern void sched_exec(void);
 #define sched_exec()   {}
 #endif
 
-#define get_task_struct(tsk) do { refcount_inc(&(tsk)->usage); } while(0)
+static inline struct task_struct *get_task_struct(struct task_struct *t)
+{
+	refcount_inc(&t->usage);
+	return t;
+}
 
 extern void __put_task_struct(struct task_struct *t);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f85929ce13be..f8c3ec50a74b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4082,10 +4082,8 @@ alloc_perf_context(struct pmu *pmu, struct task_struct *task)
 		return NULL;
 
 	__perf_event_init_context(ctx);
-	if (task) {
-		ctx->task = task;
-		get_task_struct(task);
-	}
+	if (task)
+		ctx->task = get_task_struct(task);
 	ctx->pmu = pmu;
 
 	return ctx;
@@ -10324,8 +10322,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 * and we cannot use the ctx information because we need the
 		 * pmu before we get a ctx.
 		 */
-		get_task_struct(task);
-		event->hw.target = task;
+		event->hw.target = get_task_struct(task);
 	}
 
 	event->clock = &local_clock;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 78f3ddeb7fe4..a6cc41fd562b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1229,8 +1229,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	 * the thread dies to avoid that the interrupt code
 	 * references an already freed task_struct.
 	 */
-	get_task_struct(t);
-	new->thread = t;
+	new->thread = get_task_struct(t);
 	/*
 	 * Tell the thread to set its affinity. This is
 	 * important for shared interrupt handlers as we do
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 38fbf9fa7f1b..7ad8dd384d35 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -628,8 +628,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		}
 
 		/* [10] Grab the next task, i.e. owner of @lock */
-		task = rt_mutex_owner(lock);
-		get_task_struct(task);
+		task = get_task_struct(rt_mutex_owner(lock));
 		raw_spin_lock(&task->pi_lock);
 
 		/*
@@ -709,8 +708,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	}
 
 	/* [10] Grab the next task, i.e. the owner of @lock */
-	task = rt_mutex_owner(lock);
-	get_task_struct(task);
+	task = get_task_struct(rt_mutex_owner(lock));
 	raw_spin_lock(&task->pi_lock);
 
 	/* [11] requeue the pi waiters if necessary */
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 0b1f77957240..b81ba6e93f9c 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -223,8 +223,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
 		struct task_struct *tsk;
 
-		tsk = waiter->task;
-		get_task_struct(tsk);
+		tsk = get_task_struct(waiter->task);
 
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 743b2b520d34..5e43b9664eca 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -579,8 +579,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	else
 		tracing_dl = 0;
 
-	wakeup_task = p;
-	get_task_struct(wakeup_task);
+	wakeup_task = get_task_struct(p);
 
 	local_save_flags(flags);
 
-- 
2.20.1

