Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1C3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6601020657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfHEHQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:16:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:2431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbfHEHQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:16:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 00:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="176230569"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2019 00:16:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v4 2/7] perf/x86/intel: Support PEBS output to PT
Date:   Mon,  5 Aug 2019 10:16:13 +0300
Message-Id: <20190805071618.29468-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805071618.29468-1-alexander.shishkin@linux.intel.com>
References: <20190805071618.29468-1-alexander.shishkin@linux.intel.com>
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
to PT or to the DS area, therefore, in case of conflict, the conflicting
event will fail to schedule, allowing the rotation logic to alternate
between the PEBS->PT and PEBS->DS events.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/core.c           | 34 +++++++++++++++++++++
 arch/x86/events/intel/core.c     | 18 +++++++++++
 arch/x86/events/intel/ds.c       | 51 +++++++++++++++++++++++++++++++-
 arch/x86/events/intel/pt.c       |  5 ++++
 arch/x86/events/perf_event.h     | 17 +++++++++++
 arch/x86/include/asm/intel_pt.h  |  2 ++
 arch/x86/include/asm/msr-index.h |  4 +++
 7 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index cfe256ca76df..b95320cf7dbf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1005,6 +1005,27 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 
 	/* current number of events already accepted */
 	n = cpuc->n_events;
+	if (!cpuc->n_events)
+		cpuc->pebs_output = 0;
+
+	if (!cpuc->is_fake && leader->attr.precise_ip) {
+		/*
+		 * For PEBS->PT, if !aux_event, the group leader (PT) went
+		 * away, the group was broken down and this singleton event
+		 * can't schedule any more.
+		 */
+		if (is_pebs_pt(leader) && !leader->aux_event)
+			return -EINVAL;
+
+		/*
+		 * pebs_output: 0: no PEBS so far, 1: PT, 2: DS
+		 */
+		if (cpuc->pebs_output &&
+		    cpuc->pebs_output != is_pebs_pt(leader) + 1)
+			return -EINVAL;
+
+		cpuc->pebs_output = is_pebs_pt(leader) + 1;
+	}
 
 	if (is_x86_event(leader)) {
 		if (n >= max_count)
@@ -2241,6 +2262,17 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
 	return 0;
 }
 
+static int x86_pmu_aux_source_match(struct perf_event *event)
+{
+	if (!(pmu.capabilities & PERF_PMU_CAP_AUX_SOURCE))
+		return 0;
+
+	if (x86_pmu.aux_source_match)
+		return x86_pmu.aux_source_match(event);
+
+	return 0;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2266,6 +2298,8 @@ static struct pmu pmu = {
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
 	.check_period		= x86_pmu_check_period,
+
+	.aux_source_match	= x86_pmu_aux_source_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b5f367..a2d34be2d612 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -18,6 +18,7 @@
 #include <asm/cpufeature.h>
 #include <asm/hardirq.h>
 #include <asm/intel-family.h>
+#include <asm/intel_pt.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
 
@@ -3298,6 +3299,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
+	if (event->attr.aux_source) {
+		if (!event->attr.precise_ip)
+			return -EINVAL;
+
+		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
+	}
+
 	if (event->attr.type != PERF_TYPE_RAW)
 		return 0;
 
@@ -3811,6 +3819,14 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
 }
 
+static int intel_pmu_aux_source_match(struct perf_event *event)
+{
+	if (!x86_pmu.intel_cap.pebs_output_pt_available)
+		return 0;
+
+	return is_intel_pt_event(event);
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3935,6 +3951,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.sched_task		= intel_pmu_sched_task,
 
 	.check_period		= intel_pmu_check_period,
+
+	.aux_source_match	= intel_pmu_aux_source_match,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f1269e804e9b..65a3cea04f60 100644
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
@@ -1059,10 +1065,40 @@ void intel_pmu_pebs_add(struct perf_event *event)
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
+	if (!is_pebs_pt(event))
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
+	if (!is_pebs_pt(event))
+		return;
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
@@ -1100,6 +1136,8 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	} else {
 		ds->pebs_event_reset[hwc->idx] = 0;
 	}
+
+	intel_pmu_pebs_via_pt_enable(event);
 }
 
 void intel_pmu_pebs_del(struct perf_event *event)
@@ -1111,6 +1149,8 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	cpuc->n_pebs--;
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs--;
+	if (hwc->flags & PERF_X86_EVENT_PEBS_VIA_PT)
+		cpuc->n_pebs_via_pt--;
 
 	pebs_update_state(needed_cb, cpuc, event, false);
 }
@@ -1120,7 +1160,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (cpuc->n_pebs == cpuc->n_large_pebs)
+	if (cpuc->n_pebs == cpuc->n_large_pebs &&
+	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
 		intel_pmu_drain_pebs_buffer();
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
@@ -1131,6 +1172,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
 		cpuc->pebs_enabled &= ~(1ULL << 63);
 
+	intel_pmu_pebs_via_pt_disable(event);
+
 	if (cpuc->enabled)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 
@@ -2031,6 +2074,12 @@ void __init intel_ds_init(void)
 					  PERF_SAMPLE_REGS_INTR);
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+
+			if (x86_pmu.intel_cap.pebs_output_pt_available) {
+				pr_cont("PEBS-via-PT, ");
+				x86_get_pmu()->capabilities |= PERF_PMU_CAP_AUX_SOURCE;
+			}
+
 			break;
 
 		default:
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d3dc2274ddd4..d58124d93e5f 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1481,6 +1481,11 @@ void cpu_emergency_stop_pt(void)
 		pt_event_stop(pt->handle.event, PERF_EF_UPDATE);
 }
 
+int is_intel_pt_event(struct perf_event *event)
+{
+	return event->pmu == &pt_pmu.pmu;
+}
+
 static __init int pt_init(void)
 {
 	int ret, cpu, prior_warn = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8751008fc170..f7cdf7952765 100644
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
@@ -211,6 +217,8 @@ struct cpu_hw_events {
 	u64			pebs_enabled;
 	int			n_pebs;
 	int			n_large_pebs;
+	int			n_pebs_via_pt;
+	int			pebs_output;
 
 	/* Current super set of events hardware configuration */
 	u64			pebs_data_cfg;
@@ -510,6 +518,8 @@ union perf_capabilities {
 		 */
 		u64	full_width_write:1;
 		u64     pebs_baseline:1;
+		u64	pebs_metrics_available:1;
+		u64	pebs_output_pt_available:1;
 	};
 	u64	capabilities;
 };
@@ -692,6 +702,8 @@ struct x86_pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period) (struct perf_event *event, u64 period);
+
+	int (*aux_source_match) (struct perf_event *event);
 };
 
 struct x86_perf_task_context {
@@ -901,6 +913,11 @@ static inline int amd_pmu_init(void)
 
 #endif /* CONFIG_CPU_SUP_AMD */
 
+static inline int is_pebs_pt(struct perf_event *event)
+{
+	return !!(event->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT);
+}
+
 #ifdef CONFIG_CPU_SUP_INTEL
 
 static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 634f99b1dc22..423b788f495e 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -28,10 +28,12 @@ enum pt_capabilities {
 void cpu_emergency_stop_pt(void);
 extern u32 intel_pt_validate_hw_cap(enum pt_capabilities cap);
 extern u32 intel_pt_validate_cap(u32 *caps, enum pt_capabilities cap);
+extern int is_intel_pt_event(struct perf_event *event);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
 static inline u32 intel_pt_validate_hw_cap(enum pt_capabilities cap) { return 0; }
 static inline u32 intel_pt_validate_cap(u32 *caps, enum pt_capabilities capability) { return 0; }
+static inline int is_intel_pt_event(struct perf_event *event) { return 0; }
 #endif
 
 #endif /* _ASM_X86_INTEL_PT_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6b4fc2788078..03c42f08f063 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -375,6 +375,10 @@
 /* Alternative perfctr range with full access. */
 #define MSR_IA32_PMC0			0x000004c1
 
+/* Auto-reload via MSR instead of DS area */
+#define MSR_RELOAD_PMC0			0x000014c1
+#define MSR_RELOAD_FIXED_CTR0		0x00001309
+
 /* AMD64 MSRs. Not complete. See the architecture manual for a more
    complete list. */
 
-- 
2.20.1

