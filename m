Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9202468B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFUa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:30:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:10719 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgAFUa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:30:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 12:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245699483"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 12:30:24 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 07/14] perf/x86/intel: Support per thread RDPMC TopDown metrics
Date:   Mon,  6 Jan 2020 12:29:12 -0800
Message-Id: <20200106202919.2943-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With Ice Lake CPUs, the TopDown metrics are directly available as fixed
counters and do not require generic counters, which make it possible to
measure TopDown per thread/process instead of only per core.

The metrics and slots values have to be saved/restored during context
switching.
The saved values are also used as previous values to calculate the
delta.

The PERF_METRICS MSR value will be returned if RDPMC metrics events.

Re-use last_period and period_left, which are unused sampling fields,
for saved_metric and saved_slots.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V4:
- Re-use last_period and period_left for saved_metric and saved_slots.

 arch/x86/events/core.c       |   5 +-
 arch/x86/events/intel/core.c | 103 +++++++++++++++++++++++++++++------
 include/linux/perf_event.h   |  29 ++++++----
 3 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bfa5e8286eed..333541c05815 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2204,7 +2204,10 @@ static int x86_pmu_event_idx(struct perf_event *event)
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
-	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
+	/* Return PERF_METRICS MSR value for metrics event */
+	if (is_metric_idx(idx))
+		idx = 1 << 29;
+	else if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
 		idx -= INTEL_PMC_IDX_FIXED;
 		idx |= 1 << 30;
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d7aecfe03372..0d1a327c18fc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2244,7 +2244,13 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 	if (left == x86_pmu.max_period) {
 		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
 		wrmsrl(MSR_PERF_METRICS, 0);
-		local64_set(&hwc->period_left, 0);
+		hwc->saved_slots = 0;
+		hwc->saved_metric = 0;
+	}
+
+	if ((hwc->saved_slots) && is_slots_event(event)) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
+		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
 	}
 
 	perf_event_update_userpage(event);
@@ -2265,7 +2271,7 @@ static u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 	return  mul_u64_u32_div(slots, val, 0xff);
 }
 
-static void __icl_update_topdown_event(struct perf_event *event,
+static u64 icl_get_topdown_value(struct perf_event *event,
 				       u64 slots, u64 metrics)
 {
 	int idx = event->hw.idx;
@@ -2276,7 +2282,50 @@ static void __icl_update_topdown_event(struct perf_event *event,
 	else
 		delta = slots;
 
-	local64_add(delta, &event->count);
+	return delta;
+}
+
+static void __icl_update_topdown_event(struct perf_event *event,
+				       u64 slots, u64 metrics,
+				       u64 last_slots, u64 last_metrics)
+{
+	u64 delta, last = 0;
+
+	delta = icl_get_topdown_value(event, slots, metrics);
+	if (last_slots)
+		last = icl_get_topdown_value(event, last_slots, last_metrics);
+
+	/*
+	 * The 8bit integer fraction of metric may be not accurate,
+	 * especially when the changes is very small.
+	 * For example, if only a few bad_spec happens, the fraction
+	 * may be reduced from 1 to 0. If so, the bad_spec event value
+	 * will be 0 which is definitely less than the last value.
+	 * Avoid update event->count for this case.
+	 */
+	if (delta > last) {
+		delta -= last;
+		local64_add(delta, &event->count);
+	}
+}
+
+static void update_saved_topdown_regs(struct perf_event *event,
+				      u64 slots, u64 metrics)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *other;
+	int idx;
+
+	event->hw.saved_slots = slots;
+	event->hw.saved_metric = metrics;
+
+	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+		if (!is_topdown_idx(idx))
+			continue;
+		other = cpuc->events[idx];
+		other->hw.saved_slots = slots;
+		other->hw.saved_metric = metrics;
+	}
 }
 
 /*
@@ -2290,6 +2339,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
 	u64 slots, metrics;
+	bool reset = true;
 	int idx;
 
 	/* read Fixed counter 3 */
@@ -2304,25 +2354,45 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
-		__icl_update_topdown_event(other, slots, metrics);
+		__icl_update_topdown_event(other, slots, metrics,
+					   event ? event->hw.saved_slots : 0,
+					   event ? event->hw.saved_metric : 0);
 	}
 
 	/*
 	 * Check and update this event, which may have been cleared
 	 * in active_mask e.g. x86_pmu_stop()
 	 */
-	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
-		__icl_update_topdown_event(event, slots, metrics);
+	if (event && !test_bit(event->hw.idx, cpuc->active_mask)) {
+		__icl_update_topdown_event(event, slots, metrics,
+					   event->hw.saved_slots,
+					   event->hw.saved_metric);
 
-	/*
-	 * Software is recommended to periodically clear both registers
-	 * in order to maintain accurate measurements, which is required for
-	 * certain scenarios that involve sampling metrics at high rates.
-	 * Software should always write fixed counter 3 before write to
-	 * PERF_METRICS.
-	 */
-	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
-	wrmsrl(MSR_PERF_METRICS, 0);
+		/*
+		 * In x86_pmu_stop(), the event is cleared in active_mask first,
+		 * then drain the delta, which indicates context switch for
+		 * counting.
+		 * Save metric and slots for context switch.
+		 * Don't need to reset the PERF_METRICS and Fixed counter 3.
+		 * Because the values will be restored in next schedule in.
+		 */
+		update_saved_topdown_regs(event, slots, metrics);
+		reset = false;
+	}
+
+	if (reset) {
+		/*
+		 * Software is recommended to periodically clear both registers
+		 * in order to maintain accurate measurements, which is required
+		 * for certain scenarios that involve sampling metrics at high
+		 * rates. Software should always write fixed counter 3 before
+		 * write to PERF_METRICS.
+		 */
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+		if (event)
+			update_saved_topdown_regs(event, 0, 0);
+	}
 
 	return slots;
 }
@@ -3515,9 +3585,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			event->attr.config1 = event->hw.config &
 					      X86_ALL_EVENT_FLAGS;
 			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
-
-			if (is_metric_event(event))
-				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 011dcbdbccc2..3f58414e4a91 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -200,17 +200,26 @@ struct hw_perf_event {
 	 */
 	u64				sample_period;
 
-	/*
-	 * The period we started this sample with.
-	 */
-	u64				last_period;
+	union {
+		struct { /* Sampling */
+			/*
+			 * The period we started this sample with.
+			 */
+			u64				last_period;
 
-	/*
-	 * However much is left of the current period; note that this is
-	 * a full 64bit value and allows for generation of periods longer
-	 * than hardware might allow.
-	 */
-	local64_t			period_left;
+			/*
+			 * However much is left of the current period;
+			 * note that this is a full 64bit value and
+			 * allows for generation of periods longer
+			 * than hardware might allow.
+			 */
+			local64_t			period_left;
+		};
+		struct { /* Topdown events counting for context switch */
+			u64				saved_metric;
+			u64				saved_slots;
+		};
+	};
 
 	/*
 	 * State for throttling the event, see __perf_event_overflow() and
-- 
2.17.1

