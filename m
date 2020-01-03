Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E32C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC88220866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgACTmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:42:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:49004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgACTmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:42:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 11:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,391,1571727600"; 
   d="scan'208";a="421525511"
Received: from otc-lr-04.jf.intel.com ([10.54.39.18])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2020 11:42:48 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 2/7] perf: Init/fini PMU specific data
Date:   Fri,  3 Jan 2020 11:39:19 -0800
Message-Id: <1578080364-5928-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU specific data for the monitored tasks only be allocated during
LBR call stack monitoring.

When a LBR call stack event is accounted, the perf_ctx_data for related
tasks will be allocated/initialized by init_perf_ctx_data().
When a LBR call stack event is unaccounted, the perf_ctx_data for
related tasks will be detached/freed by fini_task_ctx_data().

Perf supports both per-process event and system-wide event.
- For per-process event, perf only allocates the perf_ctx_data for
  current task.
  If the allocation fails, perf error out for per-process event.
- For system-wide event, perf has to allocate the perf_ctx_data for
  both existing tasks and upcoming tasks.
  The allocation for the existing tasks is done in perf_event_alloc().
  The allocation for new tasks will be done in perf_event_fork().
  If any allocation fails, perf doesn't error out for system-wide event.
  A debug message will be dumped to system log instead. LBR callstack
  may be cutoff for the task which doesn't have the space allocated.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Merge patch 2 and 3 of V1. Remove several helpers
  e.g. alloc/init/fini_task_ctx_data_rcu().
- Move the allocations out of spin lock
- Remove tasklist_lock. Use RCU iteration of the tasklist
- Retrieve total number of threads from global nr_threads

 kernel/events/core.c | 325 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0e0f85a..64d3ee4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -47,6 +47,7 @@
 #include <linux/parser.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/stat.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 
@@ -387,6 +388,10 @@ static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 
+/* Track the number of system-wide event which requires pmu specific data */
+static atomic_t nr_task_data_sys_wide_events;
+static DEFINE_RAW_SPINLOCK(task_data_sys_wide_events_lock);
+
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
@@ -4440,6 +4445,256 @@ static void unaccount_freq_event(void)
 		atomic_dec(&nr_freq_events);
 }
 
+static int
+alloc_perf_ctx_data(size_t ctx_size, gfp_t flags,
+		    struct perf_ctx_data **task_ctx_data)
+{
+	struct perf_ctx_data *ctx_data;
+
+	ctx_data = kzalloc(sizeof(struct perf_ctx_data), flags);
+	if (!ctx_data)
+		return -ENOMEM;
+
+	ctx_data->data = kzalloc(ctx_size, flags);
+	if (!ctx_data->data) {
+		kfree(ctx_data);
+		return -ENOMEM;
+	}
+
+	ctx_data->data_size = ctx_size;
+	*task_ctx_data = ctx_data;
+
+	return 0;
+}
+
+static void
+free_perf_ctx_data(struct perf_ctx_data *ctx_data)
+{
+	kfree(ctx_data->data);
+	kfree(ctx_data);
+}
+
+static void
+free_perf_ctx_data_rcu(struct rcu_head *rcu_head)
+{
+	struct perf_ctx_data *ctx_data;
+
+	ctx_data = container_of(rcu_head, struct perf_ctx_data, rcu_head);
+	free_perf_ctx_data(ctx_data);
+}
+
+static int
+init_task_ctx_data(struct task_struct *task, size_t ctx_size)
+{
+	struct perf_ctx_data *ctx_data;
+
+	if (alloc_perf_ctx_data(ctx_size, GFP_KERNEL, &ctx_data))
+		return -ENOMEM;
+
+	mutex_lock(&task->perf_event_mutex);
+
+	if (task->perf_ctx_data) {
+		refcount_inc(&task->perf_ctx_data->refcount);
+		free_perf_ctx_data(ctx_data);
+	} else {
+		refcount_set(&ctx_data->refcount, 1);
+		/* System-wide event is active as well */
+		if (atomic_read(&nr_task_data_sys_wide_events))
+			refcount_inc(&ctx_data->refcount);
+		rcu_assign_pointer(task->perf_ctx_data, ctx_data);
+	}
+
+	mutex_unlock(&task->perf_event_mutex);
+	return 0;
+}
+
+static int
+init_system_wide_ctx_data(size_t ctx_size)
+{
+	struct perf_ctx_data **data;
+	struct task_struct *g, *p;
+	unsigned long flags;
+	int i, num_thread, pos = 0, nr_new_tasks = 0;
+
+	/* Retrieve total number of threads */
+	num_thread = nr_threads;
+
+	data = kcalloc(num_thread, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		printk_once(KERN_DEBUG
+			    "Failed to allocate space for LBR callstack. "
+			    "The LBR callstack for all tasks may be cutoff.\n");
+		return -ENOMEM;
+	}
+
+	/* Do a quick allocation in first round with GFP_ATOMIC. */
+	for (i = 0; i < num_thread; i++) {
+		if (alloc_perf_ctx_data(ctx_size, GFP_ATOMIC, &data[i]))
+			break;
+	}
+	num_thread = i;
+
+	raw_spin_lock_irqsave(&task_data_sys_wide_events_lock, flags);
+
+	/*
+	 * Allocate perf_ctx_data for all existing threads with the first
+	 * system-wide event.
+	 * The perf_ctx_data for new threads will be allocated in
+	 * perf_event_fork().
+	 */
+	if (atomic_inc_return(&nr_task_data_sys_wide_events) > 1)
+		goto unlock;
+
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
+		mutex_lock(&p->perf_event_mutex);
+		if (p->perf_ctx_data) {
+			/*
+			 * The perf_ctx_data for this thread may has been
+			 * allocated by per-task event.
+			 * Only update refcount for the case.
+			 */
+			refcount_inc(&p->perf_ctx_data->refcount);
+			mutex_unlock(&p->perf_event_mutex);
+			continue;
+		}
+
+		if (pos < num_thread) {
+			refcount_set(&data[pos]->refcount, 1);
+			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
+		} else {
+			/*
+			 * There may be some new threads created,
+			 * when we allocate space.
+			 * Track the number in nr_new_tasks.
+			 */
+			nr_new_tasks++;
+		}
+		mutex_unlock(&p->perf_event_mutex);
+	}
+	rcu_read_unlock();
+
+	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
+
+	if (!nr_new_tasks)
+		goto end;
+
+	/*
+	 * Try again to allocate the space for the left tasks.
+	 */
+	for (i = 0; i < nr_new_tasks; i++) {
+		if (alloc_perf_ctx_data(ctx_size, GFP_KERNEL, &data[i]))
+			break;
+	}
+	num_thread = i;
+	pos = 0;
+
+	raw_spin_lock_irqsave(&task_data_sys_wide_events_lock, flags);
+
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
+
+		mutex_lock(&p->perf_event_mutex);
+		if (p->perf_ctx_data) {
+			mutex_unlock(&p->perf_event_mutex);
+			continue;
+		}
+
+		if (pos < num_thread) {
+			refcount_set(&data[pos]->refcount, 1);
+			rcu_assign_pointer(p->perf_ctx_data, data[pos]);
+		}
+		pos++;
+		mutex_unlock(&p->perf_event_mutex);
+	}
+	rcu_read_unlock();
+
+	if (pos >= num_thread) {
+		printk_once(KERN_DEBUG
+			    "Failed to allocate space for LBR callstack. "
+			    "The LBR callstack for some tasks may be cutoff.\n");
+	}
+unlock:
+	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
+
+end:
+	for (; pos < num_thread; pos++)
+		free_perf_ctx_data(data[pos]);
+
+	kfree(data);
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
+/**
+ * Detach perf_ctx_data RCU pointer for a task
+ * @task:        Target Task
+ * @force:       Unconditionally free perf_ctx_data
+ *
+ * If force is set, free perf_ctx_data unconditionally.
+ * Otherwise, free perf_ctx_data when there are no users.
+ * Lock is required to sync the writers of perf_ctx_data RCU pointer
+ */
+static void
+fini_task_ctx_data(struct task_struct *task, bool force)
+{
+	struct perf_ctx_data *ctx_data;
+
+	mutex_lock(&task->perf_event_mutex);
+
+	ctx_data = task->perf_ctx_data;
+	if (!ctx_data)
+		goto unlock;
+
+	if (!force && !refcount_dec_and_test(&ctx_data->refcount))
+		goto unlock;
+
+	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
+	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data_rcu);
+
+unlock:
+	mutex_unlock(&task->perf_event_mutex);
+}
+
+static void fini_system_wide_ctx_data(void)
+{
+	struct task_struct *g, *p;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task_data_sys_wide_events_lock, flags);
+	if (!atomic_dec_and_test(&nr_task_data_sys_wide_events))
+		goto unlock;
+
+	rcu_read_lock();
+	for_each_process_thread(g, p)
+		fini_task_ctx_data(p, false);
+	rcu_read_unlock();
+
+unlock:
+	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
+}
+
+static void fini_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+
+	if (task)
+		fini_task_ctx_data(task, false);
+	else
+		fini_system_wide_ctx_data();
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -4471,6 +4726,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		fini_perf_ctx_data(event);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7297,10 +7554,69 @@ static void perf_event_task(struct task_struct *task,
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
+	if (!atomic_read(&nr_task_data_sys_wide_events))
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
+	if (alloc_perf_ctx_data(ctx_size, GFP_KERNEL, &ctx_data))
+		return;
+
+	raw_spin_lock_irqsave(&task_data_sys_wide_events_lock, flags);
+
+	/*
+	 * System-wide event may be unaccount when attaching the perf_ctx_data.
+	 * For example,
+	 *                CPU A                              CPU B
+	 *        perf_event_alloc_task_data():
+	 *          read(nr_task_data_events)
+	 *                                         fini_system_wide_ctx_data()
+	 *          alloc_perf_ctx_data()
+	 *          rcu_assign_pointer(perf_ctx_data);
+	 *
+	 * The perf_ctx_data may never be freed until the task is terminated.
+	 */
+	if (unlikely(!atomic_read(&nr_task_data_sys_wide_events))) {
+		free_perf_ctx_data(ctx_data);
+		goto unlock;
+	}
+
+	mutex_lock(&child->perf_event_mutex);
+	if (child->perf_ctx_data) {
+		free_perf_ctx_data(ctx_data);
+	} else {
+		refcount_set(&ctx_data->refcount, 1);
+		rcu_assign_pointer(child->perf_ctx_data, ctx_data);
+	}
+	mutex_unlock(&child->perf_event_mutex);
+
+unlock:
+	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
+}
+
 void perf_event_fork(struct task_struct *task)
 {
 	perf_event_task(task, NULL, 1);
 	perf_event_namespaces(task);
+	perf_event_alloc_task_data(task, current);
 }
 
 /*
@@ -10826,11 +11142,18 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
@@ -11892,6 +12215,8 @@ void perf_event_exit_task(struct task_struct *child)
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
 	perf_event_task(child, NULL, 0);
+
+	fini_task_ctx_data(child, true);
 }
 
 static void perf_free_event(struct perf_event *event,
-- 
2.7.4

