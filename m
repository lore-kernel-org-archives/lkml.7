Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7D1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9842722314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgACTnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:43:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:49004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgACTm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:42:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 11:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,391,1571727600"; 
   d="scan'208";a="421525542"
Received: from otc-lr-04.jf.intel.com ([10.54.39.18])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2020 11:42:53 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 7/7] perf: Clean up event context from sched_task()
Date:   Fri,  3 Jan 2020 11:39:24 -0800
Message-Id: <1578080364-5928-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

No one uses event context in sched_task() anymore.

Remove the event context parameters from sched_task().
ctx_lock is useless as well.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/powerpc/perf/core-book3s.c | 8 ++------
 arch/x86/events/core.c          | 5 ++---
 arch/x86/events/intel/core.c    | 7 +++----
 arch/x86/events/intel/ds.c      | 2 +-
 arch/x86/events/intel/lbr.c     | 3 +--
 arch/x86/events/perf_event.h    | 8 +++-----
 include/linux/perf_event.h      | 3 +--
 kernel/events/core.c            | 4 +---
 8 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 99cb809..3c3631d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -126,10 +126,7 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_context *ctx,
-				 struct task_struct *task, bool sched_in)
-{
-}
+static void power_pmu_sched_task(struct task_struct *task, bool sched_in) {}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -406,8 +403,7 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_context *ctx,
-				 struct task_struct *task, bool sched_in)
+static void power_pmu_sched_task(struct task_struct *task, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7046a59..43d0918 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2237,11 +2237,10 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_context *ctx,
-			       struct task_struct *task, bool sched_in)
+static void x86_pmu_sched_task(struct task_struct *task, bool sched_in)
 {
 	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, task, sched_in);
+		x86_pmu.sched_task(task, sched_in);
 }
 
 void perf_check_microcode(void)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bd18c83..f43ec24 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3813,11 +3813,10 @@ static void intel_pmu_cpu_dead(int cpu)
 	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
 }
 
-static void intel_pmu_sched_task(struct perf_event_context *ctx,
-				 struct task_struct *task, bool sched_in)
+static void intel_pmu_sched_task(struct task_struct *task, bool sched_in)
 {
-	intel_pmu_pebs_sched_task(ctx, sched_in);
-	intel_pmu_lbr_sched_task(ctx, task, sched_in);
+	intel_pmu_pebs_sched_task(sched_in);
+	intel_pmu_lbr_sched_task(task, sched_in);
 }
 
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ce83950..d22af4b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -908,7 +908,7 @@ static inline bool pebs_needs_sched_cb(struct cpu_hw_events *cpuc)
 	return cpuc->n_pebs && (cpuc->n_pebs == cpuc->n_large_pebs);
 }
 
-void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_pebs_sched_task(bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 20c1d7e..97fadfa 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -423,8 +423,7 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
-			      struct task_struct *task, bool sched_in)
+void intel_pmu_lbr_sched_task(struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ed287ba..84822cb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -638,8 +638,7 @@ struct x86_pmu {
 	void		(*cpu_dead)(int cpu);
 
 	void		(*check_microcode)(void);
-	void		(*sched_task)(struct perf_event_context *ctx,
-				      struct task_struct *task, bool sched_in);
+	void		(*sched_task)(struct task_struct *task, bool sched_in);
 
 	/*
 	 * Intel Arch Perfmon v2+
@@ -1009,7 +1008,7 @@ void intel_pmu_pebs_enable_all(void);
 
 void intel_pmu_pebs_disable_all(void);
 
-void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_pebs_sched_task(bool sched_in);
 
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
@@ -1017,8 +1016,7 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
 
 void intel_ds_init(void);
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
-			      struct task_struct *task, bool sched_in);
+void intel_pmu_lbr_sched_task(struct task_struct *task, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 364b0d0..91d2d28 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -405,8 +405,7 @@ struct pmu {
 	/*
 	 * context-switches callback
 	 */
-	void (*sched_task)		(struct perf_event_context *ctx,
-					 struct task_struct *task, bool sched_in);
+	void (*sched_task)		(struct task_struct *task, bool sched_in);
 	/*
 	 * PMU specific data size
 	 */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 36cef64..eea4d5c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3318,13 +3318,11 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 		if (WARN_ON_ONCE(!pmu->sched_task))
 			continue;
 
-		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 		perf_pmu_disable(pmu);
 
-		pmu->sched_task(cpuctx->task_ctx, sched_in ? next : prev, sched_in);
+		pmu->sched_task(sched_in ? next : prev, sched_in);
 
 		perf_pmu_enable(pmu);
-		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 	}
 }
 
-- 
2.7.4

