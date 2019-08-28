Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67904C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A02173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGkn7CrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfH1JC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:02:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1JC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3fJ5/ijz6zHbXywFtx0jDFf0uM2Dl/iW2D2TASoPX/E=; b=VGkn7CrQI6NpBr79xtxsgD4Aa
        6u6T+RqJmNTYZoqUDCxUqHD462XMVXq4Jhjy4UyFtftl7o6novQ3huRAInOnJwuL9XEq5V9myFggD
        K3M2NED2OGf8oYzKcJpykaI4+d2Rb7MCapbYgjhi8EE+9RAqyW4fSFWSzkKz7rwN6mqNag4LzGFMN
        4ObHChUio9hDvmOX/kKrhAWdw+EBlg51NF2m1lwtNTTREsCW0QRsIHSZctXlJIXgQX1xkp7TcrXl1
        XNtRV0eGX+lR1jof/DpqDAzpTtrvu9cnRNEXqmbqnahYtKW9B8URFFzstcSTk7TCKTZGcTwVHfiOF
        CWXCs7WoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2tqN-0007xQ-0m; Wed, 28 Aug 2019 09:02:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5CF033074C6;
        Wed, 28 Aug 2019 11:01:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D41C20230B09; Wed, 28 Aug 2019 11:02:17 +0200 (CEST)
Date:   Wed, 28 Aug 2019 11:02:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
Message-ID: <20190828090217.GN2386@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
 <20190828084416.GC2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828084416.GC2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:44:16AM +0200, Peter Zijlstra wrote:

> Let me clean up this mess for you.

Here, how's that. Now we don't check is_metric_idx() _3_ times on the
enable/disable path and all the topdown crud is properly placed in the
fixed counter functions.

Please think; don't tinker.

---

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1033,22 +1033,34 @@ static inline void x86_assign_hw_event(s
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
+	case INTEL_PMC_IDX_FIXED_METRIC_BASE ... INTEL_PMC_IDX_FIXED_METRIC_BASE+3:
+		/* All METRIC events are mapped onto the fixed SLOTS event */
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
+	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
-	} else {
+		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
+				  (idx - INTEL_PMC_IDX_FIXED);
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
 
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2128,27 +2128,61 @@ static inline void intel_pmu_ack_status(
 	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
 }
 
-static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
+static inline bool event_is_checkpointed(struct perf_event *event)
+{
+	return unlikely(event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
+}
+
+static inline void intel_set_masks(struct perf_event *event, int idx)
+{
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
 {
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
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
+		 * When there are other Top-Down events still active; don't
+		 * disable the SLOTS counter.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+
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
@@ -2156,18 +2190,19 @@ static void intel_pmu_disable_event(stru
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
+	 * Metric stuff doesn't do PEBS (I hope?); and so the early exit from
+	 * intel_pmu_disable_fixed() is OK.
 	 */
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_disable(event);
@@ -2192,8 +2227,22 @@ static void intel_pmu_read_event(struct
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
+		 * When there are other Top-Down events already active; don't
+		 * enable the SLOTS counter.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
+
+	intel_set_masks(event, hwc->idx);
 
 	/*
 	 * Enable IRQ generation (0x8), if not PEBS,
@@ -2213,6 +2262,7 @@ static void intel_pmu_enable_fixed(struc
 	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
 		bits |= 0x4;
 
+	idx -= INTEL_PMC_IDX_FIXED;
 	bits <<= (idx * 4);
 	mask = 0xfULL << (idx * 4);
 
@@ -2230,7 +2280,6 @@ static void intel_pmu_enable_fixed(struc
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
 		if (!__this_cpu_read(cpu_hw_events.enabled))
@@ -2240,23 +2289,16 @@ static void intel_pmu_enable_event(struc
 		return;
 	}
 
-	if (event->attr.exclude_host)
-		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
-	if (event->attr.exclude_guest)
-		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
-
-	if (unlikely(event_is_checkpointed(event)))
-		cpuc->intel_cp_status |= (1ull << hwc->idx);
 
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
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -349,6 +349,20 @@ struct cpu_hw_events {
 	EVENT_CONSTRAINT(c, (1ULL << (32+n)), FIXED_EVENT_FLAGS)
 
 /*
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
+/*
  * Constraint on the Event code + UMask
  */
 #define INTEL_UEVENT_CONSTRAINT(c, n)	\
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -795,6 +795,7 @@
 #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
 #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
 #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
 #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -175,11 +175,39 @@ struct x86_pmu_capability {
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
 
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
