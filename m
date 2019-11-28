Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D3C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330B21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfK1PR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:17:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:39027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfK1PR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:17:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 07:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="199551647"
Received: from otc-lr-04.jf.intel.com ([10.54.39.104])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 07:17:25 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH 1/8] perf: Save PMU specific data in task_struct
Date:   Thu, 28 Nov 2019 07:14:24 -0800
Message-Id: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some PMU specific data has to be saved/restored during context switch,
e.g. LBR call stack data. Currently, the data is saved in event context
structure, but only for per-process event. For system-wide event,
because of missing the LBR call stack data after context switch, LBR
callstacks are always shorter in comparison to per-process mode.

For example,
  Per-process mode:
  $perf record --call-graph lbr -- taskset -c 0 ./tchain_edit

  -   99.90%    99.86%  tchain_edit  tchain_edit       [.] f3
       99.86% _start
          __libc_start_main
          generic_start_main
          main
          f1
        - f2
             f3

  System-wide mode:
  $perf record --call-graph lbr -a -- taskset -c 0 ./tchain_edit

  -   99.88%    99.82%  tchain_edit  tchain_edit        [.] f3
   - 62.02% main
        f1
        f2
        f3
   - 28.83% f1
      - f2
        f3
   - 28.83% f1
      - f2
           f3
   - 8.88% generic_start_main
        main
        f1
        f2
        f3

It isn't practical to simply allocate the data for system-wide event in
CPU context structure for all tasks. We have no idea which CPU a task
will be scheduled to. The duplicated LBR data has to be maintained on
every CPU context structure. That's a huge waste. Otherwise, the LBR
data still lost if the task is scheduled to another CPU.

Save the pmu specific data in task_struct. The size of pmu specific data
is 788 bytes for LBR call stack. Usually, the overall amount of threads
doesn't exceed a few thousands. For 10K threads, keeping LBR data would
consume additional ~8MB. The additional space will only be allocated
during LBR call stack monitoring. It will be released when the
monitoring is finished.

Furthermore, moving task_ctx_data from perf_event_context to task_struct
can reduce complexity and make things clearer. E.g. perf doesn't need to
swap task_ctx_data on optimized context switch path.
This patch set is just the first step. There could be other
optimization/extension on top of this patch set. E.g. for cgroup
profiling, perf just needs to save/store the LBR call stack information
for tasks in specific cgroup. That could reduce the additional space.
Also, the LBR call stack can be available for software events, or allow
even debugging use cases, like LBRs on crash later.

The data can be shared among events. To sync the writers of
perf_ctx_data RCU pointer, add a lock in task_struct as well.

The size of pmu specific data is saved in struct perf_ctx_data. It's
required when child task allocates the space.
The refcount in struct perf_ctx_data is used to track the users of pmu
specific data.

Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h | 28 ++++++++++++++++++++++++++++
 include/linux/sched.h      |  4 ++++
 kernel/events/core.c       |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 34c7c69..a6abefb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -821,6 +821,34 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 };
 
+/**
+ * struct perf_ctx_data - PMU specific data for a task
+ * @rcu_head:  To avoid the race on free PMU specific data
+ * @refcount:  To track users
+ * @data_size: Size of PMU specific data
+ * @data:      PMU specific data
+ *
+ * Currently, the struct is only used in Intel LBR call stack mode to
+ * save/restore the call stack of a task on context switches.
+ * The data only be allocated when Intel LBR call stack mode is enabled.
+ * The data will be freed when the mode is disabled. The rcu_head is
+ * used to prevent the race on free the data.
+ * The content of the data will only be accessed in context switch, which
+ * should be protected by rcu_read_lock().
+ *
+ * Careful: Struct perf_ctx_data is added as a pointor in struct task_struct.
+ * When system-wide Intel LBR call stack mode is enabled, a buffer with
+ * constant size will be allocated for each task.
+ * Also, system memory consumption can further grow when the size of
+ * struct perf_ctx_data enlarges.
+ */
+struct perf_ctx_data {
+	struct rcu_head			rcu_head;
+	u64				refcount;
+	size_t				data_size;
+	void				*data;
+};
+
 /*
  * Number of contexts where an event can trigger:
  *	task, softirq, hardirq, nmi.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 67a1d86..51397e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -46,6 +46,7 @@ struct mempolicy;
 struct nameidata;
 struct nsproxy;
 struct perf_event_context;
+struct perf_ctx_data;
 struct pid_namespace;
 struct pipe_inode_info;
 struct rcu_node;
@@ -1059,6 +1060,9 @@ struct task_struct {
 	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
+	/* Sync the writers of perf_ctx_data RCU pointer */
+	raw_spinlock_t			perf_ctx_data_lock;
+	struct perf_ctx_data __rcu	*perf_ctx_data;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 059ee71..43567d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12321,6 +12321,8 @@ int perf_event_init_task(struct task_struct *child)
 	memset(child->perf_event_ctxp, 0, sizeof(child->perf_event_ctxp));
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
+	child->perf_ctx_data = NULL;
+	raw_spin_lock_init(&child->perf_ctx_data_lock);
 
 	for_each_task_context_nr(ctxn) {
 		ret = perf_event_init_context(child, ctxn);
-- 
2.7.4

