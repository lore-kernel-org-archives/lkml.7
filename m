Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C41C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA332085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGDQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:00:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:53366 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDQAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:00:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="185016939"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2019 09:00:33 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 2/7] perf/x86/intel: Support PEBS output to PT
Date:   Thu,  4 Jul 2019 19:00:19 +0300
Message-Id: <20190704160024.56600-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
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
 arch/x86/events/core.c           | 45 +++++++++++++++++++++++
 arch/x86/events/intel/core.c     | 20 +++++++++++
 arch/x86/events/intel/ds.c       | 61 +++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h     | 11 ++++++
 arch/x86/include/asm/msr-index.h |  4 +++
 5 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f0e4804515d8..a11924e20df3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -869,6 +869,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	unsigned long used_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
+	int n_pebs_ds, n_pebs_pt;
 	struct hw_perf_event *hwc;
 
 	bitmap_zero(used_mask, X86_PMC_IDX_MAX);
@@ -884,6 +885,37 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
+	/*
+	 * Check for PEBS->DS and PEBS->PT events.
+	 * 1) They can't be scheduled simultaneously;
+	 * 2) PEBS->PT events depend on a corresponding PT event
+	 */
+	for (i = 0, n_pebs_ds = 0, n_pebs_pt = 0; i < n; i++) {
+		e = cpuc->event_list[i];
+
+		if (e->attr.precise_ip) {
+			if (e->hw.flags & PERF_X86_EVENT_PEBS_VIA_PT) {
+				/*
+				 * New PEBS->PT event, check ->aux_event; if
+				 * it's NULL, the group has been broken down
+				 * and this event can't schedule any more.
+				 */
+				if (!cpuc->is_fake && i >= n0 && !e->aux_event)
+					return -EINVAL;
+				n_pebs_pt++;
+			} else {
+				n_pebs_ds++;
+			}
+		}
+	}
+
+	/*
+	 * Fail to add conflicting PEBS events. If this happens, rotation
+	 * takes care that all events get to run.
+	 */
+	if (n_pebs_ds && n_pebs_pt)
+		return -EINVAL;
+
 	if (x86_pmu.start_scheduling)
 		x86_pmu.start_scheduling(cpuc);
 
@@ -2241,6 +2273,17 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
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
@@ -2266,6 +2309,8 @@ static struct pmu pmu = {
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
 	.check_period		= x86_pmu_check_period,
+
+	.aux_source_match	= x86_pmu_aux_source_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bda450ff51ee..6955d4f7e7aa 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3301,6 +3301,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
 
@@ -3814,6 +3821,17 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
 }
 
+static int intel_pmu_aux_source_match(struct perf_event *event)
+{
+	if (!x86_pmu.intel_cap.pebs_output_pt_available)
+		return 0;
+
+	if (event->pmu->name && !strcmp(event->pmu->name, "intel_pt"))
+		return 1;
+
+	return 0;
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3938,6 +3956,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.sched_task		= intel_pmu_sched_task,
 
 	.check_period		= intel_pmu_check_period,
+
+	.aux_source_match	= intel_pmu_aux_source_match,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7acc526b4ad2..9c59462f38a3 100644
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
 
@@ -2032,6 +2085,12 @@ void __init intel_ds_init(void)
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
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9bcec3f99e4a..57882c6c67d2 100644
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
@@ -711,6 +720,8 @@ struct x86_pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period) (struct perf_event *event, u64 period);
+
+	int (*aux_source_match) (struct perf_event *event);
 };
 
 struct x86_perf_task_context {
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

