Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425B217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfK1PRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:17:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:39027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfK1PR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 07:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="199551682"
Received: from otc-lr-04.jf.intel.com ([10.54.39.104])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 07:17:28 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Date:   Thu, 28 Nov 2019 07:14:26 -0800
Message-Id: <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For per-process event, only allocate the space for current task.
The space will be allocated by the first user.

For system-wide event, allocation for all the existing tasks and
upcoming tasks are required. Add variable nr_task_data_events to track
the number of system-wide event.
In perf_event_alloc(), the space for all the existing tasks will be
allocated.
The space for new tasks will be allocated in perf_event_fork().

The allocation may be failed. For per-process event, it error out.
For system-wide event, it doesn't error out, a debug message will be
dumped to system log instead. LBR callstack may be cutoff for the task
which doesn't have the space allocated.

Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b4976e0..e519720 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -387,6 +387,10 @@ static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 
+/* Track the number of system-wide event which requires pmu specific data */
+static atomic_t nr_task_data_events;
+static DEFINE_RAW_SPINLOCK(task_data_events_lock);
+
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
@@ -4552,6 +4556,104 @@ init_task_ctx_data_rcu(struct task_struct *task, size_t ctx_size, gfp_t flags)
 	return ret;
 }
 
+static int
+init_task_ctx_data(struct task_struct *task, size_t ctx_size)
+{
+	struct perf_ctx_data *ctx_data;
+	unsigned long flags;
+	int ret = 0;
+
+	raw_spin_lock_irqsave(&task->perf_ctx_data_lock, flags);
+
+	ret = __init_task_ctx_data_rcu(task, ctx_size, GFP_KERNEL);
+	if (ret)
+		goto unlock;
+
+	ctx_data = task->perf_ctx_data;
+	/* System-wide event is active as well */
+	if ((ctx_data->refcount == 1) && atomic_read(&nr_task_data_events))
+		ctx_data->refcount++;
+
+unlock:
+	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, flags);
+	return ret;
+}
+
+static int
+init_system_wide_ctx_data(size_t ctx_size)
+{
+	struct task_struct *g, *p;
+	int failed_alloc = 0;
+	unsigned long flags;
+
+	/*
+	 * Allocate perf_ctx_data for all existing threads by the first event.
+	 *
+	 * The perf_ctx_data for new thread will be allocated in
+	 * perf_event_fork(). The perf_event_fork() is called after the thread
+	 * is added into the tasklist. It guarantees that any new threads will
+	 * not be missed.
+	 */
+	raw_spin_lock_irqsave(&task_data_events_lock, flags);
+	if (atomic_inc_return(&nr_task_data_events) > 1)
+		goto unlock;
+
+	read_lock(&tasklist_lock);
+
+	for_each_process_thread(g, p) {
+		/*
+		 * The PMU specific data may already be allocated by
+		 * per-process event. Need to update refcounter.
+		 * init_task_ctx_data_rcu() is called here.
+		 * Do a quick allocation in first round with GFP_ATOMIC.
+		 */
+		if (init_task_ctx_data_rcu(p, ctx_size, GFP_ATOMIC))
+			failed_alloc++;
+	}
+
+	/*
+	 * Failed to allocate the ctx data for some tasks.
+	 * Repeat the allocation.
+	 */
+	if (!failed_alloc)
+		goto tasklist_unlock;
+
+	failed_alloc = 0;
+	for_each_process_thread(g, p) {
+		/*
+		 * Doesn't need to update refcounter for the task which
+		 * is monitored by per-process event, or new created
+		 * PMU specific data. They are done in first round allocation.
+		 * alloc_task_ctx_data_rcu() is called here.
+		 */
+		if (alloc_task_ctx_data_rcu(p, ctx_size, GFP_KERNEL) &&
+		    ((++failed_alloc) == 1)) {
+			printk(KERN_DEBUG
+			       "Failed to allocate space for LBR callstack for some tasks. "
+			       "Their LBR callstack may be cutoff.\n");
+		}
+	}
+
+tasklist_unlock:
+	read_unlock(&tasklist_lock);
+unlock:
+	raw_spin_unlock_irqrestore(&task_data_events_lock, flags);
+
+	return 0;
+}
+
+static int
+init_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+	size_t ctx_size = event->pmu->task_ctx_size;
+
+	if (task)
+		return init_task_ctx_data(task, ctx_size);
+	else
+		return init_system_wide_ctx_data(ctx_size);
+}
+
 static void
 free_perf_ctx_data(struct rcu_head *rcu_head)
 {
@@ -4594,6 +4696,40 @@ fini_task_ctx_data_rcu(struct task_struct *task, bool force)
 	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, flags);
 }
 
+static void fini_task_ctx_data(struct task_struct *task)
+{
+	fini_task_ctx_data_rcu(task, false);
+}
+
+static void fini_system_wide_ctx_data(void)
+{
+	struct task_struct *g, *p;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task_data_events_lock, flags);
+	if (!atomic_dec_and_test(&nr_task_data_events))
+		goto unlock;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, p)
+		fini_task_ctx_data_rcu(p, false);
+
+	read_unlock(&tasklist_lock);
+
+unlock:
+	raw_spin_unlock_irqrestore(&task_data_events_lock, flags);
+}
+
+static void fini_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+
+	if (task)
+		fini_task_ctx_data(task);
+	else
+		fini_system_wide_ctx_data();
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -4625,6 +4761,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		fini_perf_ctx_data(event);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7451,10 +7589,72 @@ static void perf_event_task(struct task_struct *task,
 		       task_ctx);
 }
 
+/*
+ * Allocate data for a new task when profiling system-wide
+ * events which require PMU specific data
+ */
+static void perf_event_alloc_task_data(struct task_struct *child,
+				       struct task_struct *parent)
+{
+	struct perf_ctx_data *ctx_data;
+	size_t ctx_size = 0;
+	unsigned long flags;
+
+	if (!atomic_read(&nr_task_data_events))
+		return;
+
+	rcu_read_lock();
+	ctx_data = rcu_dereference(parent->perf_ctx_data);
+	if (ctx_data)
+		ctx_size = ctx_data->data_size;
+	rcu_read_unlock();
+
+	if (!ctx_size)
+		return;
+
+	/*
+	 * The refcount of a new task may not be updated correctly for some
+	 * rare case as below.
+	 *                 CPU A                              CPU B
+	 *        perf_event_alloc_task_data():    init_system_wide_ctx_data():
+	 *                                           inc(&nr_task_data_events)
+	 *          read(nr_task_data_events)
+	 *          alloc_task_ctx_data_rcu()
+	 *                                           init_task_ctx_data_rcu()
+	 * The refcount of new task is double count.
+	 * Lock is required to prevent the case by serializing the allocation.
+	 */
+	raw_spin_lock_irqsave(&task_data_events_lock, flags);
+
+	/*
+	 * System-wide event may be unaccount when attaching the perf_ctx_data.
+	 * For example,
+	 *                CPU A                              CPU B
+	 *        perf_event_alloc_task_data():    fini_system_wide_ctx_data():
+	 *          read(nr_task_data_events)
+	 *                                         fini_task_ctx_data_rcu()
+	 *          alloc_task_ctx_data_rcu()
+	 *
+	 * The perf_ctx_data may never be freed until the task is terminated.
+	 */
+	if (unlikely(!atomic_read(&nr_task_data_events)))
+		goto unlock;
+
+	if (alloc_task_ctx_data_rcu(child, ctx_size, GFP_KERNEL)) {
+		printk_once(KERN_DEBUG
+			    "LBR callstack may be cutoff for task %s (%d) ctx_size %zu\n",
+			    child->comm, task_pid_nr(child), ctx_size);
+	}
+
+unlock:
+	raw_spin_unlock_irqrestore(&task_data_events_lock, flags);
+}
+
 void perf_event_fork(struct task_struct *task)
 {
 	perf_event_task(task, NULL, 1);
 	perf_event_namespaces(task);
+	perf_event_alloc_task_data(task, current);
 }
 
 /*
@@ -10980,11 +11180,18 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		goto err_callchain_buffer;
 
+	if ((event->attach_state & PERF_ATTACH_TASK_DATA) &&
+	    init_perf_ctx_data(event))
+		goto err_task_ctx_data;
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
+err_task_ctx_data:
+	if (!event->parent && (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		put_callchain_buffers();
 err_callchain_buffer:
 	if (!event->parent) {
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
@@ -12046,6 +12253,8 @@ void perf_event_exit_task(struct task_struct *child)
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
 	perf_event_task(child, NULL, 0);
+
+	fini_task_ctx_data_rcu(child, true);
 }
 
 static void perf_free_event(struct perf_event *event,
-- 
2.7.4

