Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0815C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7814520866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgACTm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:42:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:49004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbgACTmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:42:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 11:42:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,391,1571727600"; 
   d="scan'208";a="421525532"
Received: from otc-lr-04.jf.intel.com ([10.54.39.18])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2020 11:42:51 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 5/7] perf/x86: Remove swap_task_ctx()
Date:   Fri,  3 Jan 2020 11:39:22 -0800
Message-Id: <1578080364-5928-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pmu specific data is saved in task_struct now. It doesn't need to
swap between context.

Remove swap_task_ctx() support.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/x86/events/core.c       |  8 --------
 arch/x86/events/intel/core.c |  7 -------
 arch/x86/events/intel/lbr.c  | 23 -----------------------
 arch/x86/events/perf_event.h | 11 -----------
 4 files changed, 49 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3874a2d..7046a59 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2244,13 +2244,6 @@ static void x86_pmu_sched_task(struct perf_event_context *ctx,
 		x86_pmu.sched_task(ctx, task, sched_in);
 }
 
-static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
-				  struct perf_event_context *next)
-{
-	if (x86_pmu.swap_task_ctx)
-		x86_pmu.swap_task_ctx(prev, next);
-}
-
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2305,7 +2298,6 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
-	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 439306b..bd18c83 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3820,12 +3820,6 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, task, sched_in);
 }
 
-static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
-				    struct perf_event_context *next)
-{
-	intel_pmu_lbr_swap_task_ctx(prev, next);
-}
-
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -3961,7 +3955,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
-	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 855628a..20c1d7e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -423,29 +423,6 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
-				 struct perf_event_context *next)
-{
-	struct x86_perf_task_context *prev_ctx_data, *next_ctx_data;
-
-	swap(prev->task_ctx_data, next->task_ctx_data);
-
-	/*
-	 * Architecture specific synchronization makes sense in
-	 * case both prev->task_ctx_data and next->task_ctx_data
-	 * pointers are allocated.
-	 */
-
-	prev_ctx_data = next->task_ctx_data;
-	next_ctx_data = prev->task_ctx_data;
-
-	if (!prev_ctx_data || !next_ctx_data)
-		return;
-
-	swap(prev_ctx_data->lbr_callstack_users,
-	     next_ctx_data->lbr_callstack_users);
-}
-
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 			      struct task_struct *task, bool sched_in)
 {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b8b7280..ed287ba 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -684,14 +684,6 @@ struct x86_pmu {
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
 	/*
-	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
-	 * switch helper to bridge calls from perf/core to perf/x86.
-	 * See struct pmu::swap_task_ctx() usage for examples;
-	 */
-	void		(*swap_task_ctx)(struct perf_event_context *prev,
-					 struct perf_event_context *next);
-
-	/*
 	 * AMD bits
 	 */
 	unsigned int	amd_nb_constraints : 1;
@@ -1025,9 +1017,6 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
 
 void intel_ds_init(void);
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
-				 struct perf_event_context *next);
-
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 			      struct task_struct *task, bool sched_in);
 
-- 
2.7.4

