Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7AB20840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfGXR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:27:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:32492 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfGXR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:27:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 10:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="368859102"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 10:18:23 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/8] perf/x86/intel: Basic support for metrics counters
Date:   Wed, 24 Jul 2019 10:17:47 -0700
Message-Id: <20190724171753.8087-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724171753.8087-1-kan.liang@linux.intel.com>
References: <20190724171753.8087-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Metrics counters (hardware counters containing multiple metrics)
are modeled as separate registers for each TopDown metric events,
with an extra reg being used for coordinating access to the
underlying register in the scheduler.

Adds the basic infrastructure to separate the scheduler register indexes
from the actual hardware register indexes. In most cases the MSR address
is already used correctly, but for code using indexes we need calculate
the correct underlying register.

The TopDown metric events share the fixed counter 3. It only needs
enable/disable once for them.

Move BTS index to 47. Because bit 48 in the PERF_GLOBAL_STATUS is used
to indicate the overflow status of PERF_METRICS counters now.

Naming:
The events which uses Metrics counters are called TopDown metric
events or metric events in the code.
The fixed counter 3 is called TopDown slots event or slots event.
Topdown events stand for metric events + slots event in the code.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c            | 16 ++++++++--
 arch/x86/events/intel/core.c      | 28 ++++++++++++------
 arch/x86/events/perf_event.h      | 14 +++++++++
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h | 49 +++++++++++++++++++++++++++++--
 5 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81b005e4c7d9..54534ff00940 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1033,18 +1033,30 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 				struct cpu_hw_events *cpuc, int i)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	int reg_idx;
 
 	hwc->idx = cpuc->assign[i];
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
+	/*
+	 * Metrics counters use different indexes in the scheduler
+	 * versus the hardware.
+	 *
+	 * Map metrics to fixed counter 3 (which is the base count),
+	 * but the update event callback reads the extra metric register
+	 * and converts to the right metric.
+	 */
+	reg_idx = get_reg_idx(hwc->idx);
+
 	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
 		hwc->config_base = 0;
 		hwc->event_base	= 0;
 	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
+				  (reg_idx - INTEL_PMC_IDX_FIXED);
+		hwc->event_base_rdpmc = (reg_idx - INTEL_PMC_IDX_FIXED) | 1<<30;
 	} else {
 		hwc->config_base = x86_pmu_config_addr(hwc->idx);
 		hwc->event_base  = x86_pmu_event_addr(hwc->idx);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1b2c37ed49db..f4d6335a18e2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2131,7 +2131,7 @@ static inline void intel_pmu_ack_status(u64 ack)
 
 static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
 {
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	int idx = get_reg_idx(hwc->idx) - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask;
 
 	mask = 0xfULL << (idx * 4);
@@ -2150,6 +2150,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int reg_idx = get_reg_idx(hwc->idx);
 
 	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
 		intel_pmu_disable_bts();
@@ -2157,9 +2158,16 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
+	/*
+	 * When any other topdown events are still enabled,
+	 * cancel the disabling.
+	 */
+	if (has_other_topdown_event(cpuc->active_mask, hwc->idx))
+		return;
+
+	cpuc->intel_ctrl_guest_mask &= ~(1ull << reg_idx);
+	cpuc->intel_ctrl_host_mask &= ~(1ull << reg_idx);
+	cpuc->intel_cp_status &= ~(1ull << reg_idx);
 
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
 		intel_pmu_disable_fixed(hwc);
@@ -2193,7 +2201,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	int idx = get_reg_idx(hwc->idx) - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask, bits = 0;
 
 	/*
@@ -2232,6 +2240,7 @@ static void intel_pmu_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int reg_idx = get_reg_idx(hwc->idx);
 
 	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
 		if (!__this_cpu_read(cpu_hw_events.enabled))
@@ -2242,18 +2251,19 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	}
 
 	if (event->attr.exclude_host)
-		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
+		cpuc->intel_ctrl_guest_mask |= (1ull << reg_idx);
 	if (event->attr.exclude_guest)
-		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
+		cpuc->intel_ctrl_host_mask |= (1ull << reg_idx);
 
 	if (unlikely(event_is_checkpointed(event)))
-		cpuc->intel_cp_status |= (1ull << hwc->idx);
+		cpuc->intel_cp_status |= (1ull << reg_idx);
 
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_enable(event);
 
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
-		intel_pmu_enable_fixed(event);
+		if (!has_other_topdown_event(cpuc->active_mask, hwc->idx))
+			intel_pmu_enable_fixed(event);
 		return;
 	}
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8751008fc170..37f17f55ef2d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -348,6 +348,20 @@ struct cpu_hw_events {
 #define FIXED_EVENT_CONSTRAINT(c, n)	\
 	EVENT_CONSTRAINT(c, (1ULL << (32+n)), FIXED_EVENT_FLAGS)
 
+/*
+ * Special metric counters do not actually exist, but get remapped
+ * to a combination of FxCtr3 + MSR_PERF_METRICS
+ *
+ * This allocates them to a dummy offset for the scheduler.
+ * This does not allow sharing of multiple users of the same
+ * metric without multiplexing, even though the hardware supports that
+ * in principle.
+ */
+
+#define METRIC_EVENT_CONSTRAINT(c, n)					\
+	EVENT_CONSTRAINT(c, (1ULL << (INTEL_PMC_IDX_FIXED_METRIC_BASE+n)), \
+			 FIXED_EVENT_FLAGS)
+
 /*
  * Constraint on the Event code + UMask
  */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6b4fc2788078..78f3a5ebc1e2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -793,6 +793,7 @@
 #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
 #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
 #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
 #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 457d35a75ad3..88a506312a10 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -175,11 +175,56 @@ struct x86_pmu_capability {
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
- * We choose a value in the middle of the fixed event range, since lower
+ * We choose value 47 for the fixed index of BTS, since lower
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 15)
+
+/*
+ * We model PERF_METRICS as more magic fixed-mode PMCs, one for each metric
+ *
+ * Internally they all map to Fixed Ctr 3 (SLOTS), and allocate PERF_METRICS
+ * as an extra_reg. PERF_METRICS has no own configuration, but we fill in
+ * the configuration of FxCtr3 to enforce that all the shared users of SLOTS
+ * have the same configuration.
+ */
+#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
+#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
+#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
+#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
+#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
+						 INTEL_PMC_MSK_FIXED_SLOTS)
+
+
+static inline bool is_metric_idx(int idx)
+{
+	return (unsigned)(idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) < 4;
+}
+
+static inline bool is_topdown_idx(int idx)
+{
+	return is_metric_idx(idx) || idx == INTEL_PMC_IDX_FIXED_SLOTS;
+}
+
+static inline int get_reg_idx(int idx)
+{
+	return is_metric_idx(idx) ? INTEL_PMC_IDX_FIXED_SLOTS : idx;
+}
+
+#define INTEL_PMC_CLEAR_TOPDOWN_BIT(bit)	(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)
+/*
+ * Check if any topdown events are still enabled.
+ *
+ * For non topdown events, always return false.
+ */
+static inline bool has_other_topdown_event(unsigned long *active_mask,
+						 int idx)
+{
+	return is_topdown_idx(idx) &&
+	       (*(u64 *)active_mask & INTEL_PMC_CLEAR_TOPDOWN_BIT(idx));
+}
 
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
-- 
2.17.1

