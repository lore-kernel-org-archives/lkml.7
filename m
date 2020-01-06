Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC3C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D58424682
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgAFUa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:30:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:10708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgAFUaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:30:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 12:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245699447"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 12:30:21 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 04/14] perf/x86/intel: Basic support for metrics counters
Date:   Mon,  6 Jan 2020 12:29:09 -0800
Message-Id: <20200106202919.2943-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
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

Naming:
The events which uses Metrics counters are called TopDown metric
events or metric events in the code.
The fixed counter 3 is called TopDown slots event or slots event.
Topdown events stand for metric events + slots event in the code.

Thank Peter Zijlstra very much to clean up the patch. All the topdown
support has been properly placed in the fixed counter functions. So the
is_topdown_idx() only need to be check once. Also, clean up the
x86_assign_hw_event() by converting multiple if-else statements to a
switch statement.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 arch/x86/events/core.c            | 23 ++++++--
 arch/x86/events/intel/core.c      | 98 ++++++++++++++++++++++---------
 arch/x86/events/perf_event.h      | 14 +++++
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h | 28 +++++++++
 5 files changed, 129 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6e3f0c18908e..12410f4beea5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1054,22 +1054,33 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 				struct cpu_hw_events *cpuc, int i)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	int idx;
 
-	hwc->idx = cpuc->assign[i];
+	idx = hwc->idx = cpuc->assign[i];
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
-	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
+	switch (hwc->idx) {
+	case INTEL_PMC_IDX_FIXED_BTS:
 		hwc->config_base = 0;
 		hwc->event_base	= 0;
-	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
+		break;
+
+	case INTEL_PMC_IDX_FIXED_METRIC_BASE ... INTEL_PMC_IDX_FIXED_METRIC_BASE + 3:
+		/* All METRIC events are mapped onto the fixed SLOTS event */
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+		/* fall through */
+	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
-	} else {
+		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (idx - INTEL_PMC_IDX_FIXED);
+		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		break;
+
+	default:
 		hwc->config_base = x86_pmu_config_addr(hwc->idx);
 		hwc->event_base  = x86_pmu_event_addr(hwc->idx);
 		hwc->event_base_rdpmc = x86_pmu_rdpmc_index(hwc->idx);
+		break;
 	}
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b61e81316c2b..9b40d6c0eb5a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2129,27 +2129,60 @@ static inline void intel_pmu_ack_status(u64 ack)
 	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
 }
 
-static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
+static inline bool event_is_checkpointed(struct perf_event *event)
+{
+	return unlikely(event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
+}
+
+static inline void intel_set_masks(struct perf_event *event, int idx)
 {
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (event->attr.exclude_host)
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
+	if (event->attr.exclude_guest)
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+	if (event_is_checkpointed(event))
+		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
+}
+
+static inline void intel_clear_masks(struct perf_event *event, int idx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
+}
+
+static void intel_pmu_disable_fixed(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
 	u64 ctrl_val, mask;
+	int idx = hwc->idx;
 
-	mask = 0xfULL << (idx * 4);
+	if (is_topdown_idx(idx)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		/*
+		 * When there are other Top-Down events still active,
+		 * don't disable the SLOTS counter.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
 
+	intel_clear_masks(event, idx);
+
+	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
 	rdmsrl(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	wrmsrl(hwc->config_base, ctrl_val);
 }
 
-static inline bool event_is_checkpointed(struct perf_event *event)
-{
-	return (event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
-}
-
 static void intel_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
 		intel_pmu_disable_bts();
@@ -2157,18 +2190,19 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
-
-	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
-		intel_pmu_disable_fixed(hwc);
-	else
+	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+		intel_pmu_disable_fixed(event);
+	} else {
+		intel_clear_masks(event, hwc->idx);
 		x86_pmu_disable_event(event);
+	}
 
 	/*
 	 * Needs to be called after x86_pmu_disable_event,
 	 * so we don't trigger the event without PEBS bit set.
+	 *
+	 * Metric stuff doesn't do PEBS. So the early exit from
+	 * intel_pmu_disable_fixed() is OK.
 	 */
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_disable(event);
@@ -2193,8 +2227,22 @@ static void intel_pmu_read_event(struct perf_event *event)
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask, bits = 0;
+	int idx = hwc->idx;
+
+	if (is_topdown_idx(idx)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		/*
+		 * When there are other Top-Down events already active,
+		 * don't enable the SLOTS counter.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
+
+	intel_set_masks(event, idx);
 
 	/*
 	 * Enable IRQ generation (0x8), if not PEBS,
@@ -2214,6 +2262,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
 		bits |= 0x4;
 
+	idx -= INTEL_PMC_IDX_FIXED;
 	bits <<= (idx * 4);
 	mask = 0xfULL << (idx * 4);
 
@@ -2231,7 +2280,6 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
 		if (!__this_cpu_read(cpu_hw_events.enabled))
@@ -2241,23 +2289,15 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		return;
 	}
 
-	if (event->attr.exclude_host)
-		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
-	if (event->attr.exclude_guest)
-		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
-
-	if (unlikely(event_is_checkpointed(event)))
-		cpuc->intel_cp_status |= (1ull << hwc->idx);
-
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_enable(event);
 
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
 		intel_pmu_enable_fixed(event);
-		return;
+	} else {
+		intel_set_masks(event, hwc->idx);
+		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 	}
-
-	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 }
 
 static void intel_pmu_add_event(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 930611db8f9a..6ebca54f86df 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -356,6 +356,20 @@ struct cpu_hw_events {
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
+#define METRIC_EVENT_CONSTRAINT(c, n)						\
+	EVENT_CONSTRAINT(c, (1ULL << (INTEL_PMC_IDX_FIXED_METRIC_BASE+n)),	\
+	FIXED_EVENT_FLAGS)
+
 /*
  * Constraint on the Event code + UMask
  */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 20ce682a2540..bc6a5c2c8f86 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -799,6 +799,7 @@
 #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
 #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
 #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
 #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7df1d5b78aa8..3f1290424c52 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -191,6 +191,34 @@ struct x86_pmu_capability {
  */
 #define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 15)
 
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
+#define INTEL_PMC_OTHER_TOPDOWN_BITS(bit)	(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)
+
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
 #define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
-- 
2.17.1

