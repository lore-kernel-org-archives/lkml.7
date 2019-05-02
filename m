Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B929C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD372075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEBKuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:50:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:24027 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEBKui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:50:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 03:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="166965992"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2019 03:50:32 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Support PEBS output to PT
Date:   Thu,  2 May 2019 13:50:22 +0300
Message-Id: <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PEBS declares ability to output its data to Intel PT stream, use the
aux_source attribute bit to enable PEBS data output to PT. This requires
a PT event to be present and scheduled in the same context. Unlike the
DS area, the kernel does not extract PEBS records from the PT stream to
generate corresponding records in the perf stream, because that would
require real time in-kernel PT decoding, which is not feasible. The PMI,
however, can still be used.

The output setting is per-CPU, so all PEBS events must be either writing
to PT or to the DS area, so in order to not mess up the event scheduling,
we fall back to the latter in case both types of events are scheduled in.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/core.c     | 13 +++++++
 arch/x86/events/intel/ds.c       | 59 +++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h     |  9 +++++
 arch/x86/include/asm/msr-index.h |  3 ++
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4b4dac089635..949a589fd9b1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3291,6 +3291,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
+	if (event->attr.aux_source) {
+		if (!event->attr.precise_ip)
+			return -EINVAL;
+
+		if (!x86_pmu.intel_cap.pebs_output_pt_available)
+			return -EOPNOTSUPP;
+
+		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
+
+		/* Signal to the core that we handled it */
+		event->attr.aux_source = 0;
+	}
+
 	if (event->attr.type != PERF_TYPE_RAW)
 		return 0;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7a9f5dac5abe..c38defc7c386 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -902,6 +902,9 @@ struct event_constraint *intel_pebs_constraints(struct perf_event *event)
  */
 static inline bool pebs_needs_sched_cb(struct cpu_hw_events *cpuc)
 {
+	if (cpuc->n_pebs == cpuc->n_pebs_via_pt)
+		return false;
+
 	return cpuc->n_pebs && (cpuc->n_pebs == cpuc->n_large_pebs);
 }
 
@@ -919,6 +922,9 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 	u64 threshold;
 	int reserved;
 
+	if (cpuc->n_pebs_via_pt)
+		return;
+
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
 		reserved = x86_pmu.max_pebs_events + x86_pmu.num_counters_fixed;
 	else
@@ -1059,10 +1065,50 @@ void intel_pmu_pebs_add(struct perf_event *event)
 	cpuc->n_pebs++;
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs++;
+	if (hwc->flags & PERF_X86_EVENT_PEBS_VIA_PT)
+		cpuc->n_pebs_via_pt++;
 
 	pebs_update_state(needed_cb, cpuc, event, true);
 }
 
+static void intel_pmu_pebs_via_pt_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!(event->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT))
+		return;
+
+	if (!(cpuc->pebs_enabled & ~PEBS_VIA_PT_MASK))
+		cpuc->pebs_enabled &= ~PEBS_VIA_PT_MASK;
+}
+
+static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	struct debug_store *ds = cpuc->ds;
+
+	if (!(event->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT))
+		return;
+
+	/*
+	 * In case there's a mix of PEBS->PT and PEBS->DS, fall back
+	 * to DS.
+	 */
+	if (cpuc->n_pebs != cpuc->n_pebs_via_pt) {
+		/* PEBS-to-DS events present, fall back to DS */
+		intel_pmu_pebs_via_pt_disable(event);
+		return;
+	}
+
+	if (!(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
+		cpuc->pebs_enabled |= PEBS_PMI_AFTER_EACH_RECORD;
+
+	cpuc->pebs_enabled |= PEBS_OUTPUT_PT;
+
+	wrmsrl(MSR_RELOAD_PMC0 + hwc->idx, ds->pebs_event_reset[hwc->idx]);
+}
+
 void intel_pmu_pebs_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1100,6 +1146,8 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	} else {
 		ds->pebs_event_reset[hwc->idx] = 0;
 	}
+
+	intel_pmu_pebs_via_pt_enable(event);
 }
 
 void intel_pmu_pebs_del(struct perf_event *event)
@@ -1111,6 +1159,8 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	cpuc->n_pebs--;
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs--;
+	if (hwc->flags & PERF_X86_EVENT_PEBS_VIA_PT)
+		cpuc->n_pebs_via_pt--;
 
 	pebs_update_state(needed_cb, cpuc, event, false);
 }
@@ -1120,7 +1170,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (cpuc->n_pebs == cpuc->n_large_pebs)
+	if (cpuc->n_pebs == cpuc->n_large_pebs &&
+	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
 		intel_pmu_drain_pebs_buffer();
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
@@ -1131,6 +1182,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
 		cpuc->pebs_enabled &= ~(1ULL << 63);
 
+	intel_pmu_pebs_via_pt_disable(event);
+
 	if (cpuc->enabled)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 
@@ -2032,6 +2085,10 @@ void __init intel_ds_init(void)
 					  PERF_SAMPLE_REGS_INTR);
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+
+			if (x86_pmu.intel_cap.pebs_output_pt_available)
+				pr_cont("PEBS-via-PT, ");
+
 			break;
 
 		default:
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 07fc84bb85c1..39d8c1b70866 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -76,6 +76,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_EXCL_ACCT	0x0100 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
+#define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -85,6 +86,11 @@ struct amd_nb {
 };
 
 #define PEBS_COUNTER_MASK	((1ULL << MAX_PEBS_EVENTS) - 1)
+#define PEBS_PMI_AFTER_EACH_RECORD BIT_ULL(60)
+#define PEBS_OUTPUT_OFFSET	61
+#define PEBS_OUTPUT_MASK	(3ull << PEBS_OUTPUT_OFFSET)
+#define PEBS_OUTPUT_PT		(1ull << PEBS_OUTPUT_OFFSET)
+#define PEBS_VIA_PT_MASK	(PEBS_OUTPUT_PT | PEBS_PMI_AFTER_EACH_RECORD)
 
 /*
  * Flags PEBS can handle without an PMI.
@@ -229,6 +235,7 @@ struct cpu_hw_events {
 	u64			pebs_enabled;
 	int			n_pebs;
 	int			n_large_pebs;
+	int			n_pebs_via_pt;
 
 	/* Current super set of events hardware configuration */
 	u64			pebs_data_cfg;
@@ -528,6 +535,8 @@ union perf_capabilities {
 		 */
 		u64	full_width_write:1;
 		u64     pebs_baseline:1;
+		u64	pebs_metrics_available:1;
+		u64	pebs_output_pt_available:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1378518cf63f..c7ef38693654 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -782,6 +782,9 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 
+#define MSR_RELOAD_PMC0			0x000014c1
+#define MSR_RELOAD_FIXED_CTR0		0x00001309
+
 /* Geode defined MSRs */
 #define MSR_GEODE_BUSCONT_CONF0		0x00001900
 
-- 
2.20.1

