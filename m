Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D99FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E972084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfJUUEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:57214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUUEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467366"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:20 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 02/13] perf/x86/intel: Output LBR TOS information
Date:   Mon, 21 Oct 2019 13:03:03 -0700
Message-Id: <20191021200314.1613-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new branch sample type was introduced to require the LBR Top-of-Stack
(TOS) information.

For non-adaptive PEBS and non-PEBS, the TOS information can be directly
retrieved from TOS MSR read in intel_pmu_lbr_read().

For adaptive PEBS, the LBR information stored in PEBS record doesn't
include the TOS information. For single PEBS, TOS can be directly read
from MSR, because the PMI is triggered immediately after PEBS is
written. TOS MSR is still unchanged.
For large PEBS, TOS MSR has stale value. Set -1ULL to indicate that the
TOS information is not available.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 arch/x86/events/intel/ds.c   | 5 ++++-
 arch/x86/events/intel/lbr.c  | 9 +++++++++
 arch/x86/events/perf_event.h | 1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 27ee47a7be66..d9e5611b0282 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2411,8 +2411,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.lbr_tos = cpuc->lbr_tos;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ce83950036c5..29355175fdea 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1474,8 +1474,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		event->attr.use_clockid == 0)
 		data->time = native_sched_clock_from_tsc(pebs->tsc);
 
-	if (has_branch_stack(event))
+	if (has_branch_stack(event)) {
 		data->br_stack = &cpuc->lbr_stack;
+		data->lbr_tos = cpuc->lbr_tos;
+	}
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1602,6 +1604,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
 			data->br_stack = &cpuc->lbr_stack;
+			data->lbr_tos = cpuc->lbr_tos;
 		}
 	}
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ea54634eabf3..39412b819290 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -562,6 +562,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
+	cpuc->lbr_tos = tos;
 }
 
 /*
@@ -657,6 +658,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
+	cpuc->lbr_tos = tos;
 }
 
 void intel_pmu_lbr_read(void)
@@ -1097,6 +1099,13 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 	int i;
 
 	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
+
+	/* Cannot get TOS for large PEBS */
+	if (cpuc->n_pebs == cpuc->n_large_pebs)
+		cpuc->lbr_tos = -1ULL;
+	else
+		cpuc->lbr_tos = intel_pmu_lbr_tos();
+
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		u64 info = lbr->lbr[i].info;
 		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf4ebc1..deaf3935f627 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -234,6 +234,7 @@ struct cpu_hw_events {
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
 	u64				br_sel;
+	u64				lbr_tos;
 	struct x86_perf_task_context	*last_task_ctx;
 	int				last_log_id;
 
-- 
2.17.1

