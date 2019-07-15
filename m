Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4701206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHBUrB4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfGOMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfGOMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=16XLyidZ/bBeouKWj76ylHFwo0Gqag6/YjKXwOALh+U=; b=BHBUrB4xIWS2nQFn8J8d9nc+B
        jQIOAN/Ziu/PmMTyzYZ7HcwK25Qq+dbxKYEd4OqguFlUB345RBeC+BMgz5xXc34XkbagNoTcQu6lQ
        z/LNIFKvXu1FhZmvNybKgW6u3NdD/b4wpCDaEtNTFF2wSi7y+Q3FRn5AhWxkdLX/qV/Y5nRVif+ws
        p8Mavnn6Vet9D7E+1YUee6oDv/LYUJAo29hppiVKVVg0pbfLo9ttdjZy3kKXQeJDGpaUBFbbPn0BT
        IYVRdboqU+SIHAqKbnOQ5E3nzo5mvSioAWcAKduYtd7vl7NQcYezrczed+0GpUaTEQ4SgrO8r0mw3
        b5/wqXy2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hn0OJ-00078v-Jf; Mon, 15 Jul 2019 12:47:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F78F20144520; Mon, 15 Jul 2019 14:47:37 +0200 (CEST)
Date:   Mon, 15 Jul 2019 14:47:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Borislav Petkov <bp@suse.de>,
        syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] perf/hw_breakpoint: Fix breakpoint overcommit issue
Message-ID: <20190715124737.GN3463@hirez.programming.kicks-ass.net>
References: <20190709134821.8027-1-frederic@kernel.org>
 <20190710140421.GP3402@hirez.programming.kicks-ass.net>
 <20190710153406.GA18838@lenoir>
 <20190711105305.GY3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20190711105305.GY3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2019 at 12:53:05PM +0200, Peter Zijlstra wrote:
> > I wish we could use event->ctx->task instead but on pmu::init() there
> > is no ctx yet (we could pass the task in parameter though) 
> 
> Right, that should be fairly easy.
> 
> > and on event->destroy() it's TASK_TOMBSTONE and retrieving the task at
> > that time would be non trivial.
> 
> Well, right, we can maybe make TOMBSTONE be the LSB instead of the whole
> word, then we can recover the task pointer... *yuck* though.

Something like the attached, completely untested patches.

I didn't do the hw_breakpoint bit, because I got lost in that, but this
basically provides what you asked for I think.


--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-task-1.patch"

Subject: perf: Clarify perf_event_exit_task_context()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 15 13:39:03 CEST 2019

The variables in perf_event_exit_task_context() are all called 'child'
even though it must be current, this is confusing, apply:

  s/child/task/

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11434,15 +11434,15 @@ perf_event_exit_event(struct perf_event
 	put_event(parent_event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
+static void perf_event_exit_task_context(struct task_struct *task, int ctxn)
 {
-	struct perf_event_context *child_ctx, *clone_ctx = NULL;
-	struct perf_event *child_event, *next;
+	struct perf_event_context *task_ctx, *clone_ctx = NULL;
+	struct perf_event *task_event, *next;
 
-	WARN_ON_ONCE(child != current);
+	WARN_ON_ONCE(task != current);
 
-	child_ctx = perf_pin_task_context(child, ctxn);
-	if (!child_ctx)
+	task_ctx = perf_pin_task_context(task, ctxn);
+	if (!task_ctx)
 		return;
 
 	/*
@@ -11455,27 +11455,27 @@ static void perf_event_exit_task_context
 	 * without ctx::mutex (it cannot because of the move_group double mutex
 	 * lock thing). See the comments in perf_install_in_context().
 	 */
-	mutex_lock(&child_ctx->mutex);
+	mutex_lock(&task_ctx->mutex);
 
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
 	 * in.
 	 */
-	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(__get_cpu_context(child_ctx), child_ctx, EVENT_ALL);
+	raw_spin_lock_irq(&task_ctx->lock);
+	task_ctx_sched_out(__get_cpu_context(task_ctx), task_ctx, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
 	 * and mark the context dead.
 	 */
-	RCU_INIT_POINTER(child->perf_event_ctxp[ctxn], NULL);
-	put_ctx(child_ctx); /* cannot be last */
-	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
+	RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
+	put_ctx(task_ctx); /* cannot be last */
+	WRITE_ONCE(task_ctx->task, TASK_TOMBSTONE);
 	put_task_struct(current); /* cannot be last */
 
-	clone_ctx = unclone_ctx(child_ctx);
-	raw_spin_unlock_irq(&child_ctx->lock);
+	clone_ctx = unclone_ctx(task_ctx);
+	raw_spin_unlock_irq(&task_ctx->lock);
 
 	if (clone_ctx)
 		put_ctx(clone_ctx);
@@ -11485,14 +11485,14 @@ static void perf_event_exit_task_context
 	 * won't get any samples after PERF_RECORD_EXIT. We can however still
 	 * get a few PERF_RECORD_READ events.
 	 */
-	perf_event_task(child, child_ctx, 0);
+	perf_event_task(task, task_ctx, 0);
 
-	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx, child);
+	list_for_each_entry_safe(task_event, next, &task_ctx->event_list, event_entry)
+		perf_event_exit_event(task_event, task_ctx, task);
 
-	mutex_unlock(&child_ctx->mutex);
+	mutex_unlock(&task_ctx->mutex);
 
-	put_ctx(child_ctx);
+	put_ctx(task_ctx);
 }
 
 /*

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-task-2.patch"

Subject: perf: Remove overload of TASK_TOMBSTONE
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 15 13:40:02 CEST 2019

Currently TASK_TOMBSTONE is used for 2 different things.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -165,10 +165,11 @@ static void perf_ctx_unlock(struct perf_
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
+#define TASK_KERNEL ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
 {
-	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
+	return READ_ONCE(event->owner) == TASK_KERNEL;
 }
 
 /*
@@ -11239,7 +11240,7 @@ perf_event_create_kernel_counter(struct
 	}
 
 	/* Mark owner so we could distinguish it from user events. */
-	event->owner = TASK_TOMBSTONE;
+	event->owner = TASK_KERNEL;
 
 	ctx = find_get_context(event->pmu, task, event);
 	if (IS_ERR(ctx)) {

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-task-3.patch"

Subject: perf: Remove TASK_TOMBSTONG
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 15 13:42:35 CEST 2019

Instead of overwriting the entirely of ctx->task, only set the LSB to
mark the ctx dead. This allows recovering the task pointer for fun and
games later on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -164,14 +164,26 @@ static void perf_ctx_unlock(struct perf_
 	raw_spin_unlock(&cpuctx->ctx.lock);
 }
 
-#define TASK_TOMBSTONE ((void *)-1L)
 #define TASK_KERNEL ((void *)-1L)
 
-static bool is_kernel_event(struct perf_event *event)
+static inline bool is_kernel_event(struct perf_event *event)
 {
 	return READ_ONCE(event->owner) == TASK_KERNEL;
 }
 
+static inline bool is_dead_task(struct task_struct *task)
+{
+	return (unsigned long)task & 1;
+}
+
+static inline void mark_dead_task_ctx(struct perf_event_context *ctx)
+{
+	unsigned long task = (unsigned long)READ_ONCE(ctx->task);
+	WARN_ON_ONCE(!task);
+	task |= 1;
+	WRITE_ONCE(ctx->task, (struct task_struct *)task);
+}
+
 /*
  * On task ctx scheduling...
  *
@@ -270,7 +282,7 @@ static void event_function_call(struct p
 		return;
 	}
 
-	if (task == TASK_TOMBSTONE)
+	if (is_dead_task(task))
 		return;
 
 again:
@@ -283,7 +295,7 @@ static void event_function_call(struct p
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
-	if (task == TASK_TOMBSTONE) {
+	if (is_dead_task(task)) {
 		raw_spin_unlock_irq(&ctx->lock);
 		return;
 	}
@@ -309,7 +321,7 @@ static void event_function_local(struct
 	lockdep_assert_irqs_disabled();
 
 	if (task) {
-		if (task == TASK_TOMBSTONE)
+		if (is_dead_task(task))
 			return;
 
 		task_ctx = ctx;
@@ -318,7 +330,7 @@ static void event_function_local(struct
 	perf_ctx_lock(cpuctx, task_ctx);
 
 	task = ctx->task;
-	if (task == TASK_TOMBSTONE)
+	if (is_dead_task(task))
 		goto unlock;
 
 	if (task) {
@@ -1190,7 +1202,7 @@ static void put_ctx(struct perf_event_co
 	if (refcount_dec_and_test(&ctx->refcount)) {
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
-		if (ctx->task && ctx->task != TASK_TOMBSTONE)
+		if (ctx->task && !is_dead_task(ctx->task))
 			put_task_struct(ctx->task);
 		call_rcu(&ctx->rcu_head, free_ctx);
 	}
@@ -1402,7 +1414,7 @@ perf_lock_task_context(struct task_struc
 			goto retry;
 		}
 
-		if (ctx->task == TASK_TOMBSTONE ||
+		if (is_dead_task(ctx->task) ||
 		    !refcount_inc_not_zero(&ctx->refcount)) {
 			raw_spin_unlock(&ctx->lock);
 			ctx = NULL;
@@ -2109,7 +2121,7 @@ static void perf_remove_from_context(str
 
 	/*
 	 * The above event_function_call() can NO-OP when it hits
-	 * TASK_TOMBSTONE. In that case we must already have been detached
+	 * is_dead_task(). In that case we must already have been detached
 	 * from the context (by perf_event_exit_event()) but the grouping
 	 * might still be in-tact.
 	 */
@@ -2590,7 +2602,7 @@ perf_install_in_context(struct perf_even
 	/*
 	 * Should not happen, we validate the ctx is still alive before calling.
 	 */
-	if (WARN_ON_ONCE(task == TASK_TOMBSTONE))
+	if (WARN_ON_ONCE(is_dead_task(task)))
 		return;
 
 	/*
@@ -2630,7 +2642,7 @@ perf_install_in_context(struct perf_even
 
 	raw_spin_lock_irq(&ctx->lock);
 	task = ctx->task;
-	if (WARN_ON_ONCE(task == TASK_TOMBSTONE)) {
+	if (WARN_ON_ONCE(is_dead_task(task))) {
 		/*
 		 * Cannot happen because we already checked above (which also
 		 * cannot happen), and we hold ctx->mutex, which serializes us
@@ -9110,10 +9122,11 @@ static void perf_event_addr_filters_appl
 	unsigned long flags;
 
 	/*
-	 * We may observe TASK_TOMBSTONE, which means that the event tear-down
-	 * will stop on the parent's child_mutex that our caller is also holding
+	 * We may observe is_dead_task(), which means that the event tear-down
+	 * will stop on the parent's child_mutex that our caller is also
+	 * holding
 	 */
-	if (task == TASK_TOMBSTONE)
+	if (is_dead_task(task))
 		return;
 
 	if (ifh->nr_file_filters) {
@@ -11018,7 +11031,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (move_group) {
 		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
 
-		if (gctx->task == TASK_TOMBSTONE) {
+		if (is_dead_task(gctx->task)) {
 			err = -ESRCH;
 			goto err_locked;
 		}
@@ -11057,7 +11070,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		mutex_lock(&ctx->mutex);
 	}
 
-	if (ctx->task == TASK_TOMBSTONE) {
+	if (is_dead_task(ctx->task)) {
 		err = -ESRCH;
 		goto err_locked;
 	}
@@ -11250,7 +11263,7 @@ perf_event_create_kernel_counter(struct
 
 	WARN_ON_ONCE(ctx->parent_ctx);
 	mutex_lock(&ctx->mutex);
-	if (ctx->task == TASK_TOMBSTONE) {
+	if (is_dead_task(ctx->task)) {
 		err = -ESRCH;
 		goto err_unlock;
 	}
@@ -11472,7 +11485,7 @@ static void perf_event_exit_task_context
 	 */
 	RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
 	put_ctx(task_ctx); /* cannot be last */
-	WRITE_ONCE(task_ctx->task, TASK_TOMBSTONE);
+	mark_dead_task_ctx(task_ctx);
 	put_task_struct(current); /* cannot be last */
 
 	clone_ctx = unclone_ctx(task_ctx);
@@ -11581,7 +11594,7 @@ void perf_event_free_task(struct task_st
 		 * exposed yet the context has been (through child_list).
 		 */
 		RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
-		WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
+		mark_dead_task_ctx(ctx);
 		put_task_struct(task); /* cannot be last */
 		raw_spin_unlock_irq(&ctx->lock);
 

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-task-4.patch"

Subject: perf: Delay put_task_struct() for 'dead' contexts
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 15 13:50:05 CEST 2019

Currently we immediately do put_task_struct() when we mark a context
dead, instead delay it until after the final put_ctx() by recovering
the task pointer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -180,10 +180,17 @@ static inline void mark_dead_task_ctx(st
 {
 	unsigned long task = (unsigned long)READ_ONCE(ctx->task);
 	WARN_ON_ONCE(!task);
-	task |= 1;
+	task |= 1;;
 	WRITE_ONCE(ctx->task, (struct task_struct *)task);
 }
 
+static inline struct task_struct *__dead_ctx_task(struct perf_event_context *ctx)
+{
+	unsigned long task = (unsigned long)READ_ONCE(ctx->task);
+	task &= ~1L;
+	return (struct task_struct *)task;
+}
+
 /*
  * On task ctx scheduling...
  *
@@ -1200,10 +1207,11 @@ static void free_ctx(struct rcu_head *he
 static void put_ctx(struct perf_event_context *ctx)
 {
 	if (refcount_dec_and_test(&ctx->refcount)) {
+		struct task_struct *task = __dead_ctx_task(ctx);
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
-		if (ctx->task && !is_dead_task(ctx->task))
-			put_task_struct(ctx->task);
+		if (task)
+			put_task_struct(task);
 		call_rcu(&ctx->rcu_head, free_ctx);
 	}
 }
@@ -11484,9 +11492,8 @@ static void perf_event_exit_task_context
 	 * and mark the context dead.
 	 */
 	RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
-	put_ctx(task_ctx); /* cannot be last */
+	put_ctx(task_ctx); /* matches perf_pin_task_context(), cannot be last */
 	mark_dead_task_ctx(task_ctx);
-	put_task_struct(current); /* cannot be last */
 
 	clone_ctx = unclone_ctx(task_ctx);
 	raw_spin_unlock_irq(&task_ctx->lock);
@@ -11595,7 +11602,6 @@ void perf_event_free_task(struct task_st
 		 */
 		RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
 		mark_dead_task_ctx(ctx);
-		put_task_struct(task); /* cannot be last */
 		raw_spin_unlock_irq(&ctx->lock);
 
 		list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-task-5.patch"

Subject: perf: Pass @task to pmu->event_init() and event->destroy()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 15 14:16:58 CEST 2019

Change the function signature of pmu->event_init() and
event->destroy() to take an additional task pointer.

On pmu->event_init() we can trivially provide it, on event->destroy()
we need to play games to recover it from ctx->task.

This should allow removal of event->hw.target.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/kernel/perf_event.c                   |    4 -
 arch/arc/kernel/perf_event.c                     |    2 
 arch/arm/mach-imx/mmdc.c                         |    2 
 arch/arm/mm/cache-l2x0-pmu.c                     |    2 
 arch/csky/kernel/perf_event.c                    |    2 
 arch/mips/kernel/perf_event_mipsxx.c             |    4 -
 arch/nds32/kernel/perf_event_cpu.c               |    2 
 arch/powerpc/perf/8xx-pmu.c                      |    2 
 arch/powerpc/perf/core-book3s.c                  |    4 -
 arch/powerpc/perf/core-fsl-emb.c                 |    4 -
 arch/powerpc/perf/hv-24x7.c                      |    4 -
 arch/powerpc/perf/hv-gpci.c                      |    2 
 arch/powerpc/perf/imc-pmu.c                      |   12 ++---
 arch/riscv/kernel/perf_event.c                   |    6 +-
 arch/s390/kernel/perf_cpum_cf.c                  |    6 +-
 arch/s390/kernel/perf_cpum_cf_diag.c             |    6 +-
 arch/s390/kernel/perf_cpum_sf.c                  |    6 +-
 arch/sh/kernel/perf_event.c                      |    6 +-
 arch/sparc/kernel/perf_event.c                   |    4 -
 arch/x86/events/amd/iommu.c                      |    2 
 arch/x86/events/amd/power.c                      |    2 
 arch/x86/events/amd/uncore.c                     |    2 
 arch/x86/events/core.c                           |   10 ++--
 arch/x86/events/intel/bts.c                      |    4 -
 arch/x86/events/intel/cstate.c                   |    2 
 arch/x86/events/intel/uncore_snb.c               |    2 
 arch/x86/events/msr.c                            |    2 
 arch/x86/events/perf_event.h                     |    2 
 arch/xtensa/kernel/perf_event.c                  |    2 
 drivers/hwtracing/coresight/coresight-etm-perf.c |    4 -
 drivers/perf/arm-cci.c                           |    6 +-
 drivers/perf/arm-ccn.c                           |    2 
 drivers/perf/arm_dsu_pmu.c                       |    2 
 drivers/perf/arm_pmu.c                           |    4 -
 drivers/perf/arm_smmuv3_pmu.c                    |    2 
 drivers/perf/fsl_imx8_ddr_perf.c                 |    2 
 drivers/perf/hisilicon/hisi_uncore_pmu.c         |    2 
 drivers/perf/hisilicon/hisi_uncore_pmu.h         |    2 
 drivers/perf/qcom_l2_pmu.c                       |    2 
 drivers/perf/qcom_l3_pmu.c                       |    2 
 drivers/perf/thunderx2_pmu.c                     |    2 
 drivers/perf/xgene_pmu.c                         |    2 
 include/linux/perf_event.h                       |    4 -
 include/linux/trace_events.h                     |    4 -
 kernel/events/core.c                             |   48 ++++++++++++-----------
 kernel/trace/trace_event_perf.c                  |    4 -
 46 files changed, 104 insertions(+), 100 deletions(-)

--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -591,7 +591,7 @@ static int supported_cpu(void)
 
 
 
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	/* Nothing to be done! */
 	return;
@@ -687,7 +687,7 @@ static int __hw_perf_event_init(struct p
 /*
  * Main entry point to initialise a HW performance event.
  */
-static int alpha_pmu_event_init(struct perf_event *event)
+static int alpha_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -164,7 +164,7 @@ static int arc_pmu_cache_event(u64 confi
 }
 
 /* initializes hw_perf_event structure if event is supported */
-static int arc_pmu_event_init(struct perf_event *event)
+static int arc_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -272,7 +272,7 @@ static bool mmdc_pmu_group_is_valid(stru
 	return true;
 }
 
-static int mmdc_pmu_event_init(struct perf_event *event)
+static int mmdc_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
 	int cfg = event->attr.config;
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -291,7 +291,7 @@ static bool l2x0_pmu_group_is_valid(stru
 	return num_hw <= PMU_NR_COUNTERS;
 }
 
-static int l2x0_pmu_event_init(struct perf_event *event)
+static int l2x0_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hw = &event->hw;
 
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -839,7 +839,7 @@ static int csky_pmu_cache_event(u64 conf
 	return csky_pmu_cache_map[cache_type][cache_op][cache_result];
 }
 
-static int csky_pmu_event_init(struct perf_event *event)
+static int csky_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -591,7 +591,7 @@ static void mipspmu_free_irq(void)
 static void reset_counters(void *arg);
 static int __hw_perf_event_init(struct perf_event *event);
 
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	if (atomic_dec_and_mutex_lock(&active_events,
 				&pmu_reserve_mutex)) {
@@ -606,7 +606,7 @@ static void hw_perf_event_destroy(struct
 	}
 }
 
-static int mipspmu_event_init(struct perf_event *event)
+static int mipspmu_event_init(struct perf_event *event, struct task_Struct *task)
 {
 	int err = 0;
 
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -854,7 +854,7 @@ static int __hw_perf_event_init(struct p
 	return 0;
 }
 
-static int nds32_pmu_event_init(struct perf_event *event)
+static int nds32_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
 	int err = 0;
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -68,7 +68,7 @@ static int event_type(struct perf_event
 	return -EOPNOTSUPP;
 }
 
-static int mpc8xx_pmu_event_init(struct perf_event *event)
+static int mpc8xx_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int type = event_type(event);
 
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1784,7 +1784,7 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
 /*
  * Release the PMU if this is the last perf_event.
  */
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	if (!atomic_add_unless(&num_events, -1, 1)) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -1836,7 +1836,7 @@ static bool is_event_blacklisted(u64 ev)
 	return false;
 }
 
-static int power_pmu_event_init(struct perf_event *event)
+static int power_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 ev;
 	unsigned long flags;
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -439,7 +439,7 @@ static void fsl_emb_pmu_stop(struct perf
 /*
  * Release the PMU if this is the last perf_event.
  */
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	if (!atomic_add_unless(&num_events, -1, 1)) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -479,7 +479,7 @@ static int hw_perf_cache_event(u64 confi
 	return 0;
 }
 
-static int fsl_emb_pmu_event_init(struct perf_event *event)
+static int fsl_emb_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 ev;
 	struct perf_event *events[MAX_HWEVENTS];
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -603,7 +603,7 @@ static int event_uniq_add(struct rb_root
 	return 0;
 }
 
-static void event_uniq_destroy(struct rb_root *root)
+static void event_uniq_destroy(struct rb_root *root, struct task_struct *task)
 {
 	/*
 	 * the strings we point to are in the giant block of memory filled by
@@ -1277,7 +1277,7 @@ static int single_24x7_request(struct pe
 }
 
 
-static int h_24x7_event_init(struct perf_event *event)
+static int h_24x7_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hv_perf_caps caps;
 	unsigned domain;
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -213,7 +213,7 @@ static int h_gpci_event_add(struct perf_
 	return 0;
 }
 
-static int h_gpci_event_init(struct perf_event *event)
+static int h_gpci_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 count;
 	u8 length;
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -432,7 +432,7 @@ static int nest_pmu_cpumask_init(void)
 				 ppc_nest_imc_cpu_offline);
 }
 
-static void nest_imc_counters_release(struct perf_event *event)
+static void nest_imc_counters_release(struct perf_event *event, struct task_struct *task)
 {
 	int rc, node_id;
 	struct imc_pmu_ref *ref;
@@ -484,7 +484,7 @@ static void nest_imc_counters_release(st
 	mutex_unlock(&ref->lock);
 }
 
-static int nest_imc_event_init(struct perf_event *event)
+static int nest_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int chip_id, rc, node_id;
 	u32 l_config, config = event->attr.config;
@@ -708,7 +708,7 @@ static int core_imc_pmu_cpumask_init(voi
 				 ppc_core_imc_cpu_offline);
 }
 
-static void core_imc_counters_release(struct perf_event *event)
+static void core_imc_counters_release(struct perf_event *event, struct task_struct *task)
 {
 	int rc, core_id;
 	struct imc_pmu_ref *ref;
@@ -759,7 +759,7 @@ static void core_imc_counters_release(st
 	mutex_unlock(&ref->lock);
 }
 
-static int core_imc_event_init(struct perf_event *event)
+static int core_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int core_id, rc;
 	u64 config = event->attr.config;
@@ -885,7 +885,7 @@ static int thread_imc_cpu_init(void)
 			  ppc_thread_imc_cpu_offline);
 }
 
-static int thread_imc_event_init(struct perf_event *event)
+static int thread_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u32 config = event->attr.config;
 	struct task_struct *target;
@@ -1293,7 +1293,7 @@ static void trace_imc_event_del(struct p
 	trace_imc_event_stop(event, flags);
 }
 
-static int trace_imc_event_init(struct perf_event *event)
+static int trace_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct task_struct *target;
 
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -375,13 +375,13 @@ void release_pmc_hardware(void)
 
 static atomic_t riscv_active_events = ATOMIC_INIT(0);
 
-static void riscv_event_destroy(struct perf_event *event)
+static void riscv_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	if (atomic_dec_return(&riscv_active_events) == 0)
 		release_pmc_hardware();
 }
 
-static int riscv_event_init(struct perf_event *event)
+static int riscv_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct perf_event_attr *attr = &event->attr;
 	struct hw_perf_event *hwc = &event->hw;
@@ -413,7 +413,7 @@ static int riscv_event_init(struct perf_
 
 	event->destroy = riscv_event_destroy;
 	if (code < 0) {
-		event->destroy(event);
+		event->destroy(event, task);
 		return code;
 	}
 
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -168,7 +168,7 @@ static atomic_t num_events = ATOMIC_INIT
 static DEFINE_MUTEX(pmc_reserve_mutex);
 
 /* Release the PMU if event is the last perf event */
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	if (!atomic_add_unless(&num_events, -1, 1)) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -292,7 +292,7 @@ static int __hw_perf_event_init(struct p
 	return err;
 }
 
-static int cpumf_pmu_event_init(struct perf_event *event)
+static int cpumf_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 
@@ -307,7 +307,7 @@ static int cpumf_pmu_event_init(struct p
 	}
 
 	if (unlikely(err) && event->destroy)
-		event->destroy(event);
+		event->destroy(event, task);
 
 	return err;
 }
--- a/arch/s390/kernel/perf_cpum_cf_diag.c
+++ b/arch/s390/kernel/perf_cpum_cf_diag.c
@@ -180,7 +180,7 @@ static void cf_diag_disable(struct pmu *
 static atomic_t cf_diag_events = ATOMIC_INIT(0);
 
 /* Release the PMU if event is the last perf event */
-static void cf_diag_perf_event_destroy(struct perf_event *event)
+static void cf_diag_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	debug_sprintf_event(cf_diag_dbg, 5,
 			    "%s event %p cpu %d cf_diag_events %d\n",
@@ -237,7 +237,7 @@ static int __hw_perf_event_init(struct p
 	return err;
 }
 
-static int cf_diag_event_init(struct perf_event *event)
+static int cf_diag_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct perf_event_attr *attr = &event->attr;
 	int err = -ENOENT;
@@ -275,7 +275,7 @@ static int cf_diag_event_init(struct per
 
 	err = __hw_perf_event_init(event);
 	if (unlikely(err))
-		event->destroy(event);
+		event->destroy(event, task);
 out:
 	debug_sprintf_event(cf_diag_dbg, 5, "%s err %d\n", __func__, err);
 	return err;
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -581,7 +581,7 @@ static int reserve_pmc_hardware(void)
 	return 0;
 }
 
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	/* Release PMC if this is the last perf event */
 	if (!atomic_add_unless(&num_events, -1, 1)) {
@@ -823,7 +823,7 @@ static int __hw_perf_event_init(struct p
 	return err;
 }
 
-static int cpumsf_pmu_event_init(struct perf_event *event)
+static int cpumsf_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 
@@ -867,7 +867,7 @@ static int cpumsf_pmu_event_init(struct
 	err = __hw_perf_event_init(event);
 	if (unlikely(err))
 		if (event->destroy)
-			event->destroy(event);
+			event->destroy(event, task);
 	return err;
 }
 
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -78,7 +78,7 @@ EXPORT_SYMBOL_GPL(perf_num_counters);
 /*
  * Release the PMU if this is the last perf_event.
  */
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	if (!atomic_add_unless(&num_events, -1, 1)) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -295,7 +295,7 @@ static void sh_pmu_read(struct perf_even
 	sh_perf_event_update(event, &event->hw, event->hw.idx);
 }
 
-static int sh_pmu_event_init(struct perf_event *event)
+static int sh_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 
@@ -316,7 +316,7 @@ static int sh_pmu_event_init(struct perf
 
 	if (unlikely(err)) {
 		if (event->destroy)
-			event->destroy(event);
+			event->destroy(event, task);
 	}
 
 	return err;
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1224,7 +1224,7 @@ static const struct perf_event_map *spar
 	return pmap;
 }
 
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	perf_event_release_pmc();
 }
@@ -1412,7 +1412,7 @@ static int sparc_pmu_add(struct perf_eve
 	return ret;
 }
 
-static int sparc_pmu_event_init(struct perf_event *event)
+static int sparc_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct perf_event_attr *attr = &event->attr;
 	struct perf_event *evts[MAX_HWEVENTS];
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -204,7 +204,7 @@ static int clear_avail_iommu_bnk_cntr(st
 	return 0;
 }
 
-static int perf_iommu_event_init(struct perf_event *event)
+static int perf_iommu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -124,7 +124,7 @@ static void pmu_event_del(struct perf_ev
 	pmu_event_stop(event, PERF_EF_UPDATE);
 }
 
-static int pmu_event_init(struct perf_event *event)
+static int pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 cfg = event->attr.config & AMD_POWER_EVENT_MASK;
 
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -180,7 +180,7 @@ static void amd_uncore_del(struct perf_e
 	hwc->idx = -1;
 }
 
-static int amd_uncore_event_init(struct perf_event *event)
+static int amd_uncore_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct amd_uncore *uncore;
 	struct hw_perf_event *hwc = &event->hw;
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -277,15 +277,15 @@ static bool check_hw_exists(void)
 	return false;
 }
 
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	x86_release_hardware();
 	atomic_dec(&active_events);
 }
 
-void hw_perf_lbr_event_destroy(struct perf_event *event)
+void hw_perf_lbr_event_destroy(struct perf_event *event, struct task_struct *task)
 {
-	hw_perf_event_destroy(event);
+	hw_perf_event_destroy(event, task);
 
 	/* undo the lbr/bts event accounting */
 	x86_del_exclusive(x86_lbr_exclusive_lbr);
@@ -2041,7 +2041,7 @@ static int validate_group(struct perf_ev
 	return ret;
 }
 
-static int x86_pmu_event_init(struct perf_event *event)
+static int x86_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct pmu *tmp;
 	int err;
@@ -2075,7 +2075,7 @@ static int x86_pmu_event_init(struct per
 	}
 	if (err) {
 		if (event->destroy)
-			event->destroy(event);
+			event->destroy(event, task);
 	}
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -527,13 +527,13 @@ static int bts_event_add(struct perf_eve
 	return 0;
 }
 
-static void bts_event_destroy(struct perf_event *event)
+static void bts_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	x86_release_hardware();
 	x86_del_exclusive(x86_lbr_exclusive_bts);
 }
 
-static int bts_event_init(struct perf_event *event)
+static int bts_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int ret;
 
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -295,7 +295,7 @@ static ssize_t cstate_get_attr_cpumask(s
 		return 0;
 }
 
-static int cstate_pmu_event_init(struct perf_event *event)
+static int cstate_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 cfg = event->attr.config;
 	int cpu;
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -444,7 +444,7 @@ static void snb_uncore_imc_disable_event
  * Keep the custom event_init() function compatible with old event
  * encoding for free running counters.
  */
-static int snb_uncore_imc_event_init(struct perf_event *event)
+static int snb_uncore_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -178,7 +178,7 @@ const struct attribute_group *attr_updat
 	NULL,
 };
 
-static int msr_event_init(struct perf_event *event)
+static int msr_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 cfg = event->attr.config;
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -810,7 +810,7 @@ void x86_release_hardware(void);
 
 int x86_pmu_max_precise(void);
 
-void hw_perf_lbr_event_destroy(struct perf_event *event);
+void hw_perf_lbr_event_destroy(struct perf_event *event, struct task_struct *task);
 
 int x86_setup_perfctr(struct perf_event *event);
 
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -195,7 +195,7 @@ static void xtensa_pmu_disable(struct pm
 	set_er(get_er(XTENSA_PMU_PMG) & ~XTENSA_PMU_PMG_PMEN, XTENSA_PMU_PMG);
 }
 
-static int xtensa_pmu_event_init(struct perf_event *event)
+static int xtensa_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int ret;
 
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -96,13 +96,13 @@ static int etm_addr_filters_alloc(struct
 	return 0;
 }
 
-static void etm_event_destroy(struct perf_event *event)
+static void etm_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	kfree(event->hw.addr_filters);
 	event->hw.addr_filters = NULL;
 }
 
-static int etm_event_init(struct perf_event *event)
+static int etm_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int ret = 0;
 
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1081,7 +1081,7 @@ static void cci_pmu_put_hw(struct cci_pm
 	pmu_free_irq(cci_pmu);
 }
 
-static void hw_perf_event_destroy(struct perf_event *event)
+static void hw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
 	atomic_t *active_events = &cci_pmu->active_events;
@@ -1314,7 +1314,7 @@ static int __hw_perf_event_init(struct p
 	return 0;
 }
 
-static int cci_pmu_event_init(struct perf_event *event)
+static int cci_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
 	atomic_t *active_events = &cci_pmu->active_events;
@@ -1354,7 +1354,7 @@ static int cci_pmu_event_init(struct per
 
 	err = __hw_perf_event_init(event);
 	if (err)
-		hw_perf_event_destroy(event);
+		hw_perf_event_destroy(event, task);
 
 	return err;
 }
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -715,7 +715,7 @@ static void arm_ccn_pmu_event_release(st
 	ccn->dt.pmu_counters[hw->idx].event = NULL;
 }
 
-static int arm_ccn_pmu_event_init(struct perf_event *event)
+static int arm_ccn_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct arm_ccn *ccn;
 	struct hw_perf_event *hw = &event->hw;
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -540,7 +540,7 @@ static bool dsu_pmu_validate_group(struc
 	return dsu_pmu_validate_event(event->pmu, &fake_hw, event);
 }
 
-static int dsu_pmu_event_init(struct perf_event *event)
+static int dsu_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
 
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -419,7 +419,7 @@ __hw_perf_event_init(struct perf_event *
 	return 0;
 }
 
-static int armpmu_event_init(struct perf_event *event)
+static int armpmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 
@@ -771,7 +771,7 @@ static int cpu_pmu_init(struct arm_pmu *
 	return err;
 }
 
-static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
+static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu, struct task_struct *task)
 {
 	cpu_pm_pmu_unregister(cpu_pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -317,7 +317,7 @@ static int smmu_pmu_get_event_idx(struct
  * the core perf events code.
  */
 
-static int smmu_pmu_event_init(struct perf_event *event)
+static int smmu_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -189,7 +189,7 @@ static u32 ddr_perf_read_counter(struct
 	return readl_relaxed(pmu->base + COUNTER_READ + counter * 4);
 }
 
-static int ddr_perf_event_init(struct perf_event *event)
+static int ddr_perf_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -123,7 +123,7 @@ static void hisi_uncore_pmu_clear_event_
 	clear_bit(idx, hisi_pmu->pmu_events.used_mask);
 }
 
-int hisi_uncore_pmu_event_init(struct perf_event *event)
+int hisi_uncore_pmu_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct hisi_pmu *hisi_pmu;
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -85,7 +85,7 @@ void hisi_uncore_pmu_start(struct perf_e
 void hisi_uncore_pmu_stop(struct perf_event *event, int flags);
 void hisi_uncore_pmu_set_event_period(struct perf_event *event);
 void hisi_uncore_pmu_event_update(struct perf_event *event);
-int hisi_uncore_pmu_event_init(struct perf_event *event);
+int hisi_uncore_pmu_event_init(struct perf_event *event, struct task_struct *task);
 void hisi_uncore_pmu_enable(struct pmu *pmu);
 void hisi_uncore_pmu_disable(struct pmu *pmu);
 ssize_t hisi_event_sysfs_show(struct device *dev,
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -477,7 +477,7 @@ static void l2_cache_pmu_disable(struct
 	cluster_pmu_disable();
 }
 
-static int l2_cache_event_init(struct perf_event *event)
+static int l2_cache_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct cluster_pmu *cluster;
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -475,7 +475,7 @@ static bool qcom_l3_cache__validate_even
 	return counters <= L3_NUM_COUNTERS;
 }
 
-static int qcom_l3_cache__event_init(struct perf_event *event)
+static int qcom_l3_cache__event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -407,7 +407,7 @@ static bool tx2_uncore_validate_event_gr
 }
 
 
-static int tx2_uncore_event_init(struct perf_event *event)
+static int tx2_uncore_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct tx2_uncore_pmu *tx2_pmu;
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -887,7 +887,7 @@ static void xgene_perf_pmu_disable(struc
 	xgene_pmu->ops->stop_counters(pmu_dev);
 }
 
-static int xgene_perf_event_init(struct perf_event *event)
+static int xgene_perf_event_init(struct perf_event *event, struct task_struct *task)
 {
 	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
 	struct hw_perf_event *hw = &event->hw;
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -297,7 +297,7 @@ struct pmu {
 	 *
 	 * Other error return values are allowed.
 	 */
-	int (*event_init)		(struct perf_event *event);
+	int (*event_init)		(struct perf_event *event, struct task_struct *task);
 
 	/*
 	 * Notification that the event was mapped or unmapped.  Called
@@ -681,7 +681,7 @@ struct perf_event {
 	struct perf_addr_filter_range	*addr_filter_ranges;
 	unsigned long			addr_filters_gen;
 
-	void (*destroy)(struct perf_event *);
+	void (*destroy)(struct perf_event *, struct task_struct *);
 	struct rcu_head			rcu_head;
 
 	struct pid_namespace		*ns;
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -572,7 +572,7 @@ extern int  perf_trace_add(struct perf_e
 extern void perf_trace_del(struct perf_event *event, int flags);
 #ifdef CONFIG_KPROBE_EVENTS
 extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe);
-extern void perf_kprobe_destroy(struct perf_event *event);
+extern void perf_kprobe_destroy(struct perf_event *event, struct task_struct *task);
 extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
@@ -581,7 +581,7 @@ extern int bpf_get_kprobe_info(const str
 #ifdef CONFIG_UPROBE_EVENTS
 extern int  perf_uprobe_init(struct perf_event *event,
 			     unsigned long ref_ctr_offset, bool is_retprobe);
-extern void perf_uprobe_destroy(struct perf_event *event);
+extern void perf_uprobe_destroy(struct perf_event *event, struct task_struct *task);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
 			       u64 *probe_offset, bool perf_type_tracepoint);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4489,8 +4489,12 @@ static void _free_event(struct perf_even
 	perf_addr_filters_splice(event, NULL);
 	kfree(event->addr_filter_ranges);
 
-	if (event->destroy)
-		event->destroy(event);
+	if (event->destroy) {
+		struct task_struct *task = NULL;
+		if (event->ctx)
+			task = __dead_ctx_task(event->ctx);
+		event->destroy(event, task);
+	}
 
 	/*
 	 * Must be after ->destroy(), due to uprobe_perf_close() using
@@ -8496,7 +8500,7 @@ static int swevent_hlist_get(void)
 
 struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 
-static void sw_perf_event_destroy(struct perf_event *event)
+static void sw_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	u64 event_id = event->attr.config;
 
@@ -8506,7 +8510,7 @@ static void sw_perf_event_destroy(struct
 	swevent_hlist_put();
 }
 
-static int perf_swevent_init(struct perf_event *event)
+static int perf_swevent_init(struct perf_event *event, struct task_struct *task)
 {
 	u64 event_id = event->attr.config;
 
@@ -8664,12 +8668,12 @@ void perf_tp_event(u16 event_type, u64 c
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 
-static void tp_perf_event_destroy(struct perf_event *event)
+static void tp_perf_event_destroy(struct perf_event *event, struct task_struct *task)
 {
 	perf_trace_destroy(event);
 }
 
-static int perf_tp_event_init(struct perf_event *event)
+static int perf_tp_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 
@@ -8742,7 +8746,7 @@ static const struct attribute_group *kpr
 	NULL,
 };
 
-static int perf_kprobe_event_init(struct perf_event *event);
+static int perf_kprobe_event_init(struct perf_event *event, struct task_struct *task);
 static struct pmu perf_kprobe = {
 	.task_ctx_nr	= perf_sw_context,
 	.event_init	= perf_kprobe_event_init,
@@ -8754,7 +8758,7 @@ static struct pmu perf_kprobe = {
 	.attr_groups	= kprobe_attr_groups,
 };
 
-static int perf_kprobe_event_init(struct perf_event *event)
+static int perf_kprobe_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 	bool is_retprobe;
@@ -8801,7 +8805,7 @@ static const struct attribute_group *upr
 	NULL,
 };
 
-static int perf_uprobe_event_init(struct perf_event *event);
+static int perf_uprobe_event_init(struct perf_event *event, struct task_struct *task);
 static struct pmu perf_uprobe = {
 	.task_ctx_nr	= perf_sw_context,
 	.event_init	= perf_uprobe_event_init,
@@ -8813,7 +8817,7 @@ static struct pmu perf_uprobe = {
 	.attr_groups	= uprobe_attr_groups,
 };
 
-static int perf_uprobe_event_init(struct perf_event *event)
+static int perf_uprobe_event_init(struct perf_event *event, struct task_struct *task)
 {
 	int err;
 	unsigned long ref_ctr_offset;
@@ -9528,7 +9532,7 @@ static void perf_swevent_cancel_hrtimer(
 	}
 }
 
-static void perf_swevent_init_hrtimer(struct perf_event *event)
+static void perf_swevent_init_hrtimer(struct perf_event *event, struct task_struct *task)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -9598,7 +9602,7 @@ static void cpu_clock_event_read(struct
 	cpu_clock_event_update(event);
 }
 
-static int cpu_clock_event_init(struct perf_event *event)
+static int cpu_clock_event_init(struct perf_event *event, struct task_struct *task)
 {
 	if (event->attr.type != PERF_TYPE_SOFTWARE)
 		return -ENOENT;
@@ -9679,7 +9683,7 @@ static void task_clock_event_read(struct
 	task_clock_event_update(event, time);
 }
 
-static int task_clock_event_init(struct perf_event *event)
+static int task_clock_event_init(struct perf_event *event, struct task_struct *task)
 {
 	if (event->attr.type != PERF_TYPE_SOFTWARE)
 		return -ENOENT;
@@ -10095,7 +10099,7 @@ static inline bool has_extended_regs(str
 	       (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK);
 }
 
-static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
+static int perf_try_init_event(struct pmu *pmu, struct perf_event *event, struct task_struct *task)
 {
 	struct perf_event_context *ctx = NULL;
 	int ret;
@@ -10120,7 +10124,7 @@ static int perf_try_init_event(struct pm
 	}
 
 	event->pmu = pmu;
-	ret = pmu->event_init(event);
+	ret = pmu->event_init(event, task);
 
 	if (ctx)
 		perf_event_ctx_unlock(event->group_leader, ctx);
@@ -10135,7 +10139,7 @@ static int perf_try_init_event(struct pm
 			ret = -EINVAL;
 
 		if (ret && event->destroy)
-			event->destroy(event);
+			event->destroy(event, task);
 	}
 
 	if (ret)
@@ -10144,7 +10148,7 @@ static int perf_try_init_event(struct pm
 	return ret;
 }
 
-static struct pmu *perf_init_event(struct perf_event *event)
+static struct pmu *perf_init_event(struct perf_event *event, struct task_struct *task)
 {
 	struct pmu *pmu;
 	int idx;
@@ -10155,7 +10159,7 @@ static struct pmu *perf_init_event(struc
 	/* Try parent's PMU first: */
 	if (event->parent && event->parent->pmu) {
 		pmu = event->parent->pmu;
-		ret = perf_try_init_event(pmu, event);
+		ret = perf_try_init_event(pmu, event, task);
 		if (!ret)
 			goto unlock;
 	}
@@ -10164,14 +10168,14 @@ static struct pmu *perf_init_event(struc
 	pmu = idr_find(&pmu_idr, event->attr.type);
 	rcu_read_unlock();
 	if (pmu) {
-		ret = perf_try_init_event(pmu, event);
+		ret = perf_try_init_event(pmu, event, task);
 		if (ret)
 			pmu = ERR_PTR(ret);
 		goto unlock;
 	}
 
 	list_for_each_entry_rcu(pmu, &pmus, entry) {
-		ret = perf_try_init_event(pmu, event);
+		ret = perf_try_init_event(pmu, event, task);
 		if (!ret)
 			goto unlock;
 
@@ -10442,7 +10446,7 @@ perf_event_alloc(struct perf_event_attr
 			goto err_ns;
 	}
 
-	pmu = perf_init_event(event);
+	pmu = perf_init_event(event, task);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
 		goto err_ns;
@@ -10500,7 +10504,7 @@ perf_event_alloc(struct perf_event_attr
 
 err_pmu:
 	if (event->destroy)
-		event->destroy(event);
+		event->destroy(event, task);
 	module_put(pmu->module);
 err_ns:
 	if (is_cgroup_event(event))
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -280,7 +280,7 @@ int perf_kprobe_init(struct perf_event *
 	return ret;
 }
 
-void perf_kprobe_destroy(struct perf_event *p_event)
+void perf_kprobe_destroy(struct perf_event *p_event, struct task_struct *task)
 {
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
@@ -333,7 +333,7 @@ int perf_uprobe_init(struct perf_event *
 	return ret;
 }
 
-void perf_uprobe_destroy(struct perf_event *p_event)
+void perf_uprobe_destroy(struct perf_event *p_event, struct task_struct *task)
 {
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-task-6.patch"

Subject: perf/power: Remove some simple hw.target usage
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 15 14:34:17 CEST 2019


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/perf/imc-pmu.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -888,7 +888,6 @@ static int thread_imc_cpu_init(void)
 static int thread_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
 	u32 config = event->attr.config;
-	struct task_struct *target;
 	struct imc_pmu *pmu;
 
 	if (event->attr.type != event->pmu->type)
@@ -908,8 +907,7 @@ static int thread_imc_event_init(struct
 	if (((config & IMC_EVENT_OFFSET_MASK) > pmu->counter_mem_size))
 		return -EINVAL;
 
-	target = event->hw.target;
-	if (!target)
+	if (!task)
 		return -EINVAL;
 
 	event->pmu->task_ctx_nr = perf_sw_context;
@@ -1295,8 +1293,6 @@ static void trace_imc_event_del(struct p
 
 static int trace_imc_event_init(struct perf_event *event, struct task_struct *task)
 {
-	struct task_struct *target;
-
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
@@ -1308,7 +1304,6 @@ static int trace_imc_event_init(struct p
 		return -ENOENT;
 
 	event->hw.idx = -1;
-	target = event->hw.target;
 
 	event->pmu->task_ctx_nr = perf_hw_context;
 	return 0;

--cWoXeonUoKmBZSoM--
