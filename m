Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B5C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8720692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgAHPGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:06:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:20641 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgAHPGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:06:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="422942686"
Received: from otc-lr-04.jf.intel.com ([10.54.39.113])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 07:06:49 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V3 2/7] perf: attach/detach PMU specific data
Date:   Wed,  8 Jan 2020 07:03:04 -0800
Message-Id: <1578495789-95006-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
References: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU specific data for the monitored tasks only be allocated during
LBR call stack monitoring.

When a LBR call stack event is accounted, the perf_ctx_data for related
tasks will be allocated/attached by attach_perf_ctx_data().
When a LBR call stack event is unaccounted, the perf_ctx_data for
related tasks will be detached/freed by detach_perf_ctx_data().

LBR call stack events could be per-task events or system-wide events.
- For per-task event, perf only allocates the perf_ctx_data for current
  task. If the allocation fails, perf will error out.
- For system-wide event, perf has to allocate the perf_ctx_data for
  both existing tasks and upcoming tasks.
  The allocation for the existing tasks is done in perf_event_alloc().
  The allocation for new tasks will be done in perf_event_fork().
  If any allocation fails, perf doesn't error out for system-wide event.
  A debug message will be dumped to system log instead. LBR callstack
  may be cutoff for the task which doesn't have the space allocated.
- The perf_ctx_data only be freed by the last LBR call stack event.
  The number of per-task events is tracked by refcount of each task.
  Since the system-wide events impact all tasks, it's not practical to
  go through the whole task list to update the refcount for each
  system-wide event. The number of system-wide events is tracked by a
  global variable nr_task_data_sys_wide_events.
  Introduce a macro TASK_DATA_SYS_WIDE for refcount to indicate the
  PMU specific data is used by system-wide events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Remove global spin lock task_data_sys_wide_events_lock
  Since the global spin lock has been removed, we cannot guarantee
  that the allocation/assignments for existing threads and free are
  serialized.
  To fix it, in V3, we go through the task list when accounting for
  each system-wide event, and assign the perf_ctx_data pointer if needed.
  (In V2, we only do the assignment for the first system-wide event).
  In V3, we also add a breaker in free process for system-wide event.
  If there is new system-wide event accounted, stop the free process
  immediately.
- Add a macro TASK_DATA_SYS_WIDE to indicate the PMU specific data
  is used by system-wide events.

 kernel/events/core.c | 371 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 371 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 43567d1..27f5f94 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -47,6 +47,7 @@
 #include <linux/parser.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/stat.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 
@@ -387,6 +388,39 @@ static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 
+/* Track the number of system-wide event which requires pmu specific data */
+static atomic_t nr_task_data_sys_wide_events;
+
+/*
+ * There are two types of users for pmu specific data, system-wide event and
+ * per-task event.
+ *
+ * The number of system-wide events is already tracked by global variable
+ * nr_task_data_sys_wide_events. Set TASK_DATA_SYS_WIDE in refcount to
+ * indicate the PMU specific data is used by system-wide events.
+ *
+ * The number of per-task event users is tracked by refcount. Since the
+ * TASK_DATA_SYS_WIDE is already occupied by system-wide events, limit
+ * the max number of per-task event users less than half of TASK_DATA_SYS_WIDE.
+ */
+#define TASK_DATA_SYS_WIDE		0x1000000
+#define MAX_NR_TASK_DATA_EVENTS		(TASK_DATA_SYS_WIDE >> 1)
+
+static inline bool has_task_data_sys_wide(struct perf_ctx_data *perf_ctx_data)
+{
+	return !!(refcount_read(&perf_ctx_data->refcount) & TASK_DATA_SYS_WIDE);
+}
+
+static inline bool exceed_task_data_events_limit(struct perf_ctx_data *perf_ctx_data)
+{
+	unsigned int count = refcount_read(&perf_ctx_data->refcount);
+
+	if (has_task_data_sys_wide(perf_ctx_data))
+		return (count - TASK_DATA_SYS_WIDE) > MAX_NR_TASK_DATA_EVENTS;
+	else
+		return count > MAX_NR_TASK_DATA_EVENTS;
+}
+
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
@@ -4440,6 +4474,279 @@ static void unaccount_freq_event(void)
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
+attach_task_ctx_data(struct task_struct *task, size_t ctx_size)
+{
+	struct perf_ctx_data *ctx_data, *tsk_data;
+
+	/*
+	 * To make the code RT friendly, make the the allocation out of
+	 * the spinlock.
+	 */
+	if (alloc_perf_ctx_data(ctx_size, GFP_KERNEL, &ctx_data))
+		return -ENOMEM;
+
+	raw_spin_lock(&task->perf_ctx_data_lock);
+
+	tsk_data = task->perf_ctx_data;
+	if (tsk_data) {
+		free_perf_ctx_data(ctx_data);
+		if (WARN_ON_ONCE(exceed_task_data_events_limit(tsk_data))) {
+			raw_spin_unlock(&task->perf_ctx_data_lock);
+			return -EINVAL;
+		}
+		refcount_inc(&tsk_data->refcount);
+	} else {
+		refcount_set(&ctx_data->refcount, 1);
+		/* System-wide event is active as well */
+		if (atomic_read(&nr_task_data_sys_wide_events))
+			refcount_add(TASK_DATA_SYS_WIDE, &ctx_data->refcount);
+
+		rcu_assign_pointer(task->perf_ctx_data, ctx_data);
+	}
+
+	raw_spin_unlock(&task->perf_ctx_data_lock);
+	return 0;
+}
+
+static int
+attach_system_wide_ctx_data(size_t ctx_size)
+{
+	int i, num_thread, pos, nr_failed_alloc;
+	unsigned long flags = GFP_ATOMIC;
+	struct perf_ctx_data *tsk_data;
+	struct perf_ctx_data **data;
+	struct task_struct *g, *p;
+	bool re_alloc = true;
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
+	atomic_inc(&nr_task_data_sys_wide_events);
+
+repeat:
+	/*
+	 * Allocate perf_ctx_data for all existing threads.
+	 * The perf_ctx_data for new threads will be allocated in
+	 * perf_event_fork().
+	 * Do a quick allocation in first round with GFP_ATOMIC.
+	 */
+	for (i = 0; i < num_thread; i++) {
+		if (alloc_perf_ctx_data(ctx_size, flags, &data[i]))
+			break;
+	}
+	num_thread = i;
+	nr_failed_alloc = 0;
+	pos = 0;
+
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
+		raw_spin_lock(&p->perf_ctx_data_lock);
+		tsk_data = p->perf_ctx_data;
+		if (tsk_data) {
+			/*
+			 * The perf_ctx_data for this thread may has been
+			 * allocated by per-task event.
+			 * Only update refcount for the case.
+			 */
+			if (!has_task_data_sys_wide(tsk_data))
+				refcount_add(TASK_DATA_SYS_WIDE, &tsk_data->refcount);
+			raw_spin_unlock(&p->perf_ctx_data_lock);
+			continue;
+		}
+
+		if (pos < num_thread) {
+			refcount_set(&data[pos]->refcount, TASK_DATA_SYS_WIDE);
+			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
+		} else {
+			/*
+			 * The quick allocation in first round may be failed.
+			 * Track the number in nr_failed_alloc.
+			 */
+			nr_failed_alloc++;
+		}
+		raw_spin_unlock(&p->perf_ctx_data_lock);
+	}
+	rcu_read_unlock();
+
+	if (re_alloc && !nr_failed_alloc) {
+		num_thread = nr_failed_alloc;
+		flags = GFP_KERNEL;
+		re_alloc = false;
+		goto repeat;
+	}
+
+	if (nr_failed_alloc) {
+		printk_once(KERN_DEBUG
+			    "Failed to allocate space for LBR callstack. "
+			    "The LBR callstack for some tasks may be cutoff.\n");
+	}
+
+	for (; pos < num_thread; pos++)
+		free_perf_ctx_data(data[pos]);
+
+	kfree(data);
+	return 0;
+}
+
+static int
+attach_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+	size_t ctx_size = event->pmu->task_ctx_size;
+
+	if (task)
+		return attach_task_ctx_data(task, ctx_size);
+	else
+		return attach_system_wide_ctx_data(ctx_size);
+}
+
+/**
+ * Detach perf_ctx_data RCU pointer for a task monitored by per-task event
+ * @task:        Target Task
+ * @force:       Unconditionally free perf_ctx_data
+ *
+ * If force is set, free perf_ctx_data unconditionally.
+ * Otherwise, free perf_ctx_data when there are no users.
+ * Lock is required to sync the writers of perf_ctx_data RCU pointer
+ */
+static void
+detach_task_ctx_data(struct task_struct *task, bool force)
+{
+	struct perf_ctx_data *ctx_data;
+
+	raw_spin_lock(&task->perf_ctx_data_lock);
+
+	ctx_data = task->perf_ctx_data;
+	if (!ctx_data)
+		goto unlock;
+
+	if (!force) {
+		WARN_ON_ONCE(refcount_read(&ctx_data->refcount) == TASK_DATA_SYS_WIDE);
+
+		if (!refcount_dec_and_test(&ctx_data->refcount))
+			goto unlock;
+	}
+
+	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
+	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data_rcu);
+
+unlock:
+	raw_spin_unlock(&task->perf_ctx_data_lock);
+}
+
+/**
+ * Detach perf_ctx_data RCU pointer for a task monitored by system-wide event
+ * @task:        Target Task
+ *
+ * Free perf_ctx_data when there are no users.
+ */
+static void
+detach_task_ctx_data_sys_wide(struct task_struct *task)
+{
+	struct perf_ctx_data *ctx_data;
+
+	lockdep_assert_held(&task->perf_ctx_data_lock);
+
+	ctx_data = task->perf_ctx_data;
+	if (!ctx_data)
+		return;
+
+	WARN_ON_ONCE(!has_task_data_sys_wide(ctx_data));
+
+	if (!refcount_sub_and_test(TASK_DATA_SYS_WIDE, &ctx_data->refcount))
+		return;
+
+	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
+	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data_rcu);
+}
+
+static void detach_system_wide_ctx_data(void)
+{
+	struct task_struct *g, *p;
+
+	if (!atomic_dec_and_test(&nr_task_data_sys_wide_events))
+		return;
+
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
+		raw_spin_lock(&p->perf_ctx_data_lock);
+
+		/*
+		 * A new system-wide event may be attached while freeing
+		 * everything for the old event.
+		 * If so, stop the free process immediately.
+		 * For the freed threads, attach_system_wide_ctx_data()
+		 * will re-allocate the space.
+		 */
+		if (unlikely(atomic_read(&nr_task_data_sys_wide_events))) {
+			raw_spin_unlock(&p->perf_ctx_data_lock);
+			goto unlock;
+		}
+
+		detach_task_ctx_data_sys_wide(p);
+		raw_spin_unlock(&p->perf_ctx_data_lock);
+	}
+unlock:
+	rcu_read_unlock();
+}
+
+static void detach_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+
+	if (task)
+		detach_task_ctx_data(task, false);
+	else
+		detach_system_wide_ctx_data();
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -4471,6 +4778,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		detach_perf_ctx_data(event);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7297,10 +7606,63 @@ static void perf_event_task(struct task_struct *task,
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
+	raw_spin_lock(&child->perf_ctx_data_lock);
+
+	if (child->perf_ctx_data) {
+		free_perf_ctx_data(ctx_data);
+	} else {
+		refcount_set(&ctx_data->refcount, TASK_DATA_SYS_WIDE);
+		rcu_assign_pointer(child->perf_ctx_data, ctx_data);
+	}
+
+	/*
+	 * System-wide event may be unaccount when attaching the perf_ctx_data.
+	 * For example,
+	 *                CPU A                              CPU B
+	 *        perf_event_alloc_task_data():
+	 *          read(nr_task_data_sys_wide_events)
+	 *                                         detach_system_wide_ctx_data()
+	 *          alloc_perf_ctx_data()
+	 *          rcu_assign_pointer(perf_ctx_data);
+	 *
+	 * The perf_ctx_data may never be freed until the task is terminated.
+	 */
+	if (unlikely(!atomic_read(&nr_task_data_sys_wide_events)))
+		detach_task_ctx_data_sys_wide(child);
+
+	raw_spin_unlock(&child->perf_ctx_data_lock);
+}
+
 void perf_event_fork(struct task_struct *task)
 {
 	perf_event_task(task, NULL, 1);
 	perf_event_namespaces(task);
+	perf_event_alloc_task_data(task, current);
 }
 
 /*
@@ -10826,11 +11188,18 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		goto err_callchain_buffer;
 
+	if ((event->attach_state & PERF_ATTACH_TASK_DATA) &&
+	    attach_perf_ctx_data(event))
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
@@ -11892,6 +12261,8 @@ void perf_event_exit_task(struct task_struct *child)
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
 	perf_event_task(child, NULL, 0);
+
+	detach_task_ctx_data(child, true);
 }
 
 static void perf_free_event(struct perf_event *event,
-- 
2.7.4

