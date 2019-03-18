Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43292C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064382175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCRVo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:44:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:57599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfCRVoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="308301814"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:44:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 12/22] perf/x86/intel: Basic support for metrics counters
Date:   Mon, 18 Mar 2019 14:41:34 -0700
Message-Id: <20190318214144.4639-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318214144.4639-1-kan.liang@linux.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Metrics counters (hardware counters containing multiple metrics)
are modelled as separate registers for each sub-event, with an
extra reg being used for coordinating access to the underlying
register in the scheduler.

This patch adds the basic infrastructure to separate the scheduler
register indexes from the actual hardware register indexes. In
most cases the MSR address is already used correctly, but for
code using indexes we need a separate reg_idx field in the event
to indicate the correct underlying register.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c            | 18 ++++++++++++++++--
 arch/x86/events/intel/core.c      | 29 ++++++++++++++++++++---------
 arch/x86/events/perf_event.h      | 15 +++++++++++++++
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h | 30 ++++++++++++++++++++++++++++++
 include/linux/perf_event.h        |  1 +
 6 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2b2328a528df..9320cb7906cd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -996,16 +996,30 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	struct hw_perf_event *hwc = &event->hw;
 
 	hwc->idx = cpuc->assign[i];
+	hwc->reg_idx = hwc->idx;
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
+	if (is_metric_idx(hwc->idx))
+		hwc->reg_idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
 	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
 		hwc->config_base = 0;
 		hwc->event_base	= 0;
 	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
+			(hwc->reg_idx - INTEL_PMC_IDX_FIXED);
+		hwc->event_base_rdpmc = (hwc->reg_idx - INTEL_PMC_IDX_FIXED)
+			| 1<<30;
 	} else {
 		hwc->config_base = x86_pmu_config_addr(hwc->idx);
 		hwc->event_base  = x86_pmu_event_addr(hwc->idx);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 87dafac87520..f1cb0155c79a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2057,7 +2057,7 @@ static inline void intel_pmu_ack_status(u64 ack)
 
 static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
 {
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	int idx = hwc->reg_idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask;
 
 	mask = 0xfULL << (idx * 4);
@@ -2083,9 +2083,19 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
+	__clear_bit(hwc->idx, cpuc->enabled_events);
+
+	/*
+	 * When any other slots sharing event is still enabled,
+	 * cancel the disabling.
+	 */
+	if (is_any_slots_idx(hwc->idx) &&
+	    (*(u64 *)&cpuc->enabled_events & INTEL_PMC_MSK_ANY_SLOTS))
+		return;
+
+	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->reg_idx);
+	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->reg_idx);
+	cpuc->intel_cp_status &= ~(1ull << hwc->reg_idx);
 
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_disable(event);
@@ -2117,7 +2127,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	int idx = hwc->reg_idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask, bits = 0;
 
 	/*
@@ -2161,18 +2171,19 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	}
 
 	if (event->attr.exclude_host)
-		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
+		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->reg_idx);
 	if (event->attr.exclude_guest)
-		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
+		cpuc->intel_ctrl_host_mask |= (1ull << hwc->reg_idx);
 
 	if (unlikely(event_is_checkpointed(event)))
-		cpuc->intel_cp_status |= (1ull << hwc->idx);
+		cpuc->intel_cp_status |= (1ull << hwc->reg_idx);
 
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_enable(event);
 
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
-		intel_pmu_enable_fixed(event);
+		if (!__test_and_set_bit(hwc->idx, cpuc->enabled_events))
+			intel_pmu_enable_fixed(event);
 		return;
 	}
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index efa893ce95e2..e4215ea5c65e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -187,6 +187,7 @@ struct cpu_hw_events {
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	unsigned long		running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
+	unsigned long		enabled_events[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 
 	int			n_events; /* the # of events in the below arrays */
 	int			n_added;  /* the # last events in the below arrays;
@@ -347,6 +348,20 @@ struct cpu_hw_events {
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
index b14b8bea8681..5f369e954ba8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -771,6 +771,7 @@
 #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
 #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
 #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
 #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 64cb4dffe4cd..fc85efa4cb69 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -166,6 +166,10 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
 #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
@@ -175,6 +179,32 @@ struct x86_pmu_capability {
  */
 #define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
 
+/*
+ * We model PERF_METRICS as more magic fixed-mode PMCs, one for each metric
+ * and another for the whole slots counter
+ *
+ * Internally they all map to Fixed Ctr 3 (SLOTS), and allocate PERF_METRICS
+ * as an extra_reg. PERF_METRICS has no own configuration, but we fill in
+ * the configuration of FxCtr3 to enforce that all the shared users of SLOTS
+ * have the same configuration.
+ */
+#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 17)
+#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
+#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
+#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
+#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
+#define INTEL_PMC_MSK_ANY_SLOTS			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
+						 INTEL_PMC_MSK_FIXED_SLOTS)
+static inline bool is_metric_idx(int idx)
+{
+	return idx >= INTEL_PMC_IDX_FIXED_METRIC_BASE && idx <= INTEL_PMC_IDX_TD_BE_BOUND;
+}
+
+static inline bool is_any_slots_idx(int idx)
+{
+	return is_metric_idx(idx) || idx == INTEL_PMC_IDX_FIXED_SLOTS;
+}
+
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
 #define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 088358be55ff..4c62da79ff41 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -127,6 +127,7 @@ struct hw_perf_event {
 			unsigned long	event_base;
 			int		event_base_rdpmc;
 			int		idx;
+			int		reg_idx;
 			int		last_cpu;
 			int		flags;
 
-- 
2.17.1

