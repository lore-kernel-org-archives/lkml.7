Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E392184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfJVGAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:00:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:54929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfJVGAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:00:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 23:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="187778623"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2019 23:00:06 -0700
Received: from [10.249.230.171] (abudanko-mobl.ccr.corp.intel.com [10.249.230.171])
        by linux.intel.com (Postfix) with ESMTP id 3197558029D;
        Mon, 21 Oct 2019 23:00:02 -0700 (PDT)
Subject: [PATCH v4 3/4] perf/x86/intel: implement LBR callstacks context
 synchronization
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
References: <f4662ac9-e72e-d141-bead-da07e29f81e8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2bd6306a-9086-60b8-b5c9-4e16f39950d4@linux.intel.com>
Date:   Tue, 22 Oct 2019 09:00:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f4662ac9-e72e-d141-bead-da07e29f81e8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement intel_pmu_lbr_sync_task_ctx() method updating counters
of the events that requested LBR callstack data on a sample.

The counter can be zero for the case when task context belongs to
a thread that has just come from a block on a futex and the context
contains saved (lbr_stack_state == LBR_VALID) LBR register values.

For the values to be restored at LBR registers on the next thread's
switch-in event it swaps the counter value with the one that is
expected to be non zero at the previous equivalent task perf event
context.

Swap operation type ensures the previous task perf event context
stays consistent with the amount of events that requested LBR
callstack data on a sample.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 6 ++++++
 arch/x86/events/perf_event.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ea54634eabf3..3cf58bcb88af 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -417,6 +417,12 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
+void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context *prev,
+				 struct x86_perf_task_context *next)
+{
+	swap(prev->lbr_callstack_users, next->lbr_callstack_users);
+}
+
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index be78f2765f74..0474ec6f4771 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1024,6 +1024,9 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
 
 void intel_ds_init(void);
 
+void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context *prev,
+				 struct x86_perf_task_context *next);
+
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
-- 
2.20.1

