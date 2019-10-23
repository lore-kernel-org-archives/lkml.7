Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A883DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A922084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbfJWHOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:14:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:35986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfJWHOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:14:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="349310694"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2019 00:14:01 -0700
Received: from [10.249.230.188] (abudanko-mobl.ccr.corp.intel.com [10.249.230.188])
        by linux.intel.com (Postfix) with ESMTP id 46A1458029F;
        Wed, 23 Oct 2019 00:13:58 -0700 (PDT)
Subject: [PATCH v5 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8d5a880-38e5-29f4-9e6a-848f70a67988@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9c6445a9-bdba-ef03-3859-f1f91198f27a@linux.intel.com>
Date:   Wed, 23 Oct 2019 10:13:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f8d5a880-38e5-29f4-9e6a-848f70a67988@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Install Intel specific PMU task context synchronization adapter and
extend optimized context switch path with PMU specific task context
synchronization to fix LBR callstack virtualization on context switches.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/intel/core.c |  7 +++++++
 kernel/events/core.c         | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bbf6588d47ee..dc64b16e6b71 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3820,6 +3820,12 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
+				    struct perf_event_context *next)
+{
+	intel_pmu_lbr_swap_task_ctx(prev, next);
+}
+
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -3955,6 +3961,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f9a5d4356562..ed31aa849161 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3204,10 +3204,21 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
+			struct pmu *pmu = ctx->pmu;
+
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
+			/*
+			 * PMU specific parts of task perf context can require
+			 * additional synchronization. As an example of such
+			 * synchronization see implementation details of Intel
+			 * LBR call stack data profiling;
+			 */
+			if (pmu->swap_task_ctx)
+				pmu->swap_task_ctx(ctx, next_ctx);
+			else
+				swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
-- 
2.20.1

