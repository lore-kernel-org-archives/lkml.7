Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6648221900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfCVQjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:39:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:60741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbfCVQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:39:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144356636"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 09:39:41 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 15/23] perf/x86/intel: Support hardware TopDown metrics
Date:   Fri, 22 Mar 2019 09:37:10 -0700
Message-Id: <20190322163718.2191-16-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322163718.2191-1-kan.liang@linux.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intro
=====

Icelake has support for measuring the four top level TopDown metrics
directly in hardware. This is implemented by an additional "metrics"
register, and a new Fixed Counter 3 that measures pipeline "slots".

Events
======

We export four metric events as separate perf events, which map to
internal "metrics" counter register. Those events do not exist in
hardware, but can be allocated by the scheduler.

For the event mapping we use a special 0xff event code, which is
reserved for software.

When setting up such events they point to the slots counter, and a
special callback, metric_update_event(), reads the additional metrics
msr to generate the metrics. Then the metric is reported by multiplying
the metric (percentage) with slots.

This multiplication allows to easily keep a running count, for example
when the slots counter overflows, and makes all the standard tools, such
as a perf stat, work. They can do deltas of the values without needing
to know about percentages. This also simplifies accumulating the counts
of child events, which otherwise would need to know how to average
percent values.

Groups
======

To avoid reading the METRICS register multiple times, the metrics and
slots value are cached. This only works when multiple sub-events are in
the same group.

Resetting1
==========

The 8bit metrics ratio values lose precision when the measurement period
gets longer.

To avoid this we always reset the metric value when reading, as we
already accumulate the count in the perf count value.

For a long period read, low precision is acceptable.
For a short period read, the register will be reset often enough that it
is not a problem.

This implies that to read more than one submetrics always a group needs
to be used, so that the caching above still gives the correct value.

We also need to support this in the NMI, so that it's possible to
collect all top down metrics as part of leader sampling. To avoid races
with the normal transactions use a special nmi_metric cache that is only
used during the NMI.

Resetting2
==========

The PERF_METRICS may report wrong value if its delta was less than 1/255
of SLOTS (Fixed counter 3).

To avoid this, the PERF_METRICS and SLOTS registers have to be reset
simultaneously. The slots value has to be cached as well.

In counting, the -max_period is the initial value of the SLOTS. The huge
initial value will definitely trigger the issue mentioned above.
Force initial value as 0 for topdown and slots event counting.

RDPMC
=========
The TopDown events can be collected per thread/process. To use TopDown
through RDPMC in applications on Icelake, the metrics and slots values
have to be saved/restored during context switching.

Add specific set_period() to specially handle the slots and metrics
event. Because,
 - The initial value must be 0.
 - Only need to restore the value in context switch. For other cases,
   the counters have been cleared after read.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2.

 arch/x86/events/core.c           |  40 +++++--
 arch/x86/events/intel/core.c     | 192 +++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h     |  14 +++
 arch/x86/include/asm/msr-index.h |   2 +
 include/linux/perf_event.h       |   5 +
 5 files changed, 242 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d24f8d009529..7d4d56f76436 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -91,16 +91,20 @@ u64 x86_perf_event_update(struct perf_event *event)
 					new_raw_count) != prev_raw_count)
 		goto again;
 
-	/*
-	 * Now we have the new raw value and have updated the prev
-	 * timestamp already. We can now calculate the elapsed delta
-	 * (event-)time and add that to the generic event.
-	 *
-	 * Careful, not all hw sign-extends above the physical width
-	 * of the count.
-	 */
-	delta = (new_raw_count << shift) - (prev_raw_count << shift);
-	delta >>= shift;
+	if (unlikely(hwc->flags & PERF_X86_EVENT_UPDATE))
+		delta = x86_pmu.metric_update_event(event, new_raw_count);
+	else {
+		/*
+		 * Now we have the new raw value and have updated the prev
+		 * timestamp already. We can now calculate the elapsed delta
+		 * (event-)time and add that to the generic event.
+		 *
+		 * Careful, not all hw sign-extends above the physical width
+		 * of the count.
+		 */
+		delta = (new_raw_count << shift) - (prev_raw_count << shift);
+		delta >>= shift;
+	}
 
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
@@ -974,6 +978,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 
 	max_count = x86_pmu.num_counters + x86_pmu.num_counters_fixed;
 
+	/* There are 4 TopDown metrics */
+	if (x86_pmu.has_metric)
+		max_count += 4;
+
 	/* current number of events already accepted */
 	n = cpuc->n_events;
 
@@ -1157,6 +1165,9 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (idx == INTEL_PMC_IDX_FIXED_BTS)
 		return 0;
 
+	if (x86_pmu.set_period && x86_pmu.set_period(event))
+		goto update_userpage;
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
@@ -1205,6 +1216,7 @@ int x86_perf_event_set_period(struct perf_event *event)
 			(u64)(-left) & x86_pmu.cntval_mask);
 	}
 
+update_userpage:
 	perf_event_update_userpage(event);
 
 	return ret;
@@ -1957,6 +1969,8 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 
 	txn_flags = cpuc->txn_flags;
 	cpuc->txn_flags = 0;
+	cpuc->txn_metric = 0;
+	cpuc->txn_slots = 0;
 	if (txn_flags & ~PERF_PMU_TXN_ADD)
 		return;
 
@@ -1984,6 +1998,8 @@ static int x86_pmu_commit_txn(struct pmu *pmu)
 
 	WARN_ON_ONCE(!cpuc->txn_flags);	/* no txn in flight */
 
+	cpuc->txn_metric = 0;
+	cpuc->txn_slots = 0;
 	if (cpuc->txn_flags & ~PERF_PMU_TXN_ADD) {
 		cpuc->txn_flags = 0;
 		return 0;
@@ -2198,7 +2214,9 @@ static int x86_pmu_event_idx(struct perf_event *event)
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
-	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
+	if (is_metric_idx(idx))
+		idx = 1 << 29;
+	else if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
 		idx -= INTEL_PMC_IDX_FIXED;
 		idx |= 1 << 30;
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2da822414627..6a8a221dc188 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -245,6 +245,11 @@ static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(0x01ff, 0),	/* Retiring metric */
+	METRIC_EVENT_CONSTRAINT(0x02ff, 1),	/* Bad speculation metric */
+	METRIC_EVENT_CONSTRAINT(0x03ff, 2),	/* FE bound metric */
+	METRIC_EVENT_CONSTRAINT(0x04ff, 3),	/* BE bound metric */
+
 	INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
 	INTEL_EVENT_CONSTRAINT(0x32, 0xf),	/* SW_PREFETCH_ACCESS.* */
@@ -265,6 +270,14 @@ static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
 	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
 	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
+	/*
+	 * PERF_METRICS does exist, but it is not configured. But we
+	 * share the original Fixed Ctr 3 from different metrics
+	 * events. So use the extra reg to enforce the same
+	 * configuration on the original register, but do not actually
+	 * write to it.
+	 */
+	INTEL_EVENT_EXTRA_REG(0xff, 0, -1L, PERF_METRICS),
 	EVENT_EXTRA_END
 };
 
@@ -2432,6 +2445,8 @@ static int intel_pmu_handle_irq_v4(struct pt_regs *regs)
 	int pmu_enabled = cpuc->enabled;
 	int loops = 0;
 
+	cpuc->nmi_metric = 0;
+	cpuc->nmi_slots = 0;
 	/* PMU has been disabled because of counter freezing */
 	cpuc->enabled = 0;
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
@@ -2505,6 +2520,8 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	int pmu_enabled;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
+	cpuc->nmi_metric = 0;
+	cpuc->nmi_slots = 0;
 
 	/*
 	 * Save the PMU state.
@@ -3236,6 +3253,13 @@ static int core_pmu_hw_config(struct perf_event *event)
 	return intel_pmu_bts_config(event);
 }
 
+#define EVENT_CODE(e)	(e->attr.config & INTEL_ARCH_EVENT_MASK)
+#define is_slots_event(e)	(EVENT_CODE(e) == 0x0400)
+#define is_perf_metrics_event(e)				\
+		(((EVENT_CODE(e) & 0xff) == 0xff) &&		\
+		 (EVENT_CODE(e) >= 0x01ff) &&			\
+		 (EVENT_CODE(e) <= 0x04ff))
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3281,6 +3305,31 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type != PERF_TYPE_RAW)
 		return 0;
 
+	/* Fixed Counter 3 with its metric sub events */
+	if (x86_pmu.has_metric &&
+	    (is_slots_event(event) || is_perf_metrics_event(event))) {
+		if (event->attr.config1 != 0)
+			return -EINVAL;
+		if (event->attr.config & ARCH_PERFMON_EVENTSEL_ANY)
+			return -EINVAL;
+		/*
+		 * Put configuration (minus event) into config1 so that
+		 * the scheduler enforces through an extra_reg that
+		 * all instances of the metrics events have the same
+		 * configuration.
+		 */
+		event->attr.config1 = event->hw.config & X86_ALL_EVENT_FLAGS;
+		if (is_perf_metrics_event(event)) {
+			if (!x86_pmu.intel_cap.perf_metrics)
+				return -EINVAL;
+			if (is_sampling_event(event))
+				return -EINVAL;
+		}
+		if (!is_sampling_event(event))
+			event->hw.flags |= PERF_X86_EVENT_UPDATE;
+		return 0;
+	}
+
 	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
 		return 0;
 
@@ -4141,6 +4190,141 @@ static __init void intel_ht_bug(void)
 	x86_pmu.stop_scheduling = intel_stop_scheduling;
 }
 
+/*
+ * Update metric event with the PERF_METRICS register and return the delta
+ *
+ * Metric events are defined as SLOTS * metric. The original
+ * metric can be reconstructed by taking SUM(all-metrics)/metric
+ * (or SLOTS/metric)
+ *
+ * There are some limits for reading and resetting the PERF_METRICS register.
+ * - The PERF_METRICS and SLOTS registers have to be reset simultaneously.
+ * - To get the high precision, the measurement period has to be short.
+ *   The PERF_METRICS and SLOTS will be reset for each reading.
+ *   The only exception is context switch. The PERF_METRICS and SLOTS have to
+ *   be saved/restored during context switch for RDPMC users.
+ *
+ * The PERF_METRICS doesn't have the absolute value. To calculate the delta
+ * of metric events,
+ *   delta = new_SLOTS * new_METRICS - last_SLOTS * last_METRICS;
+ * Only need to save the last SLOTS and METRICS for context switch. For other
+ * cases, the registers have been reset. The last_* values are 0.
+ *
+ * To avoid reading the METRICS register multiple times, the metrics and slots
+ * value are cached. This only works when multiple sub-events are in the same
+ * group.
+ */
+static u64 icl_metric_update_event(struct perf_event *event, u64 val)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 newval, metric, slots_val = 0, new, last;
+	bool nmi = in_nmi();
+	int txn_flags = nmi ? 0 : cpuc->txn_flags;
+
+	/*
+	 * Use cached value for transaction.
+	 */
+	newval = 0;
+	if (txn_flags) {
+		newval = cpuc->txn_metric;
+		slots_val = cpuc->txn_slots;
+	} else if (nmi) {
+		newval = cpuc->nmi_metric;
+		slots_val = cpuc->nmi_slots;
+	}
+
+	if (!newval) {
+		slots_val = val;
+
+		rdpmcl((1<<29), newval);
+		if (txn_flags) {
+			cpuc->txn_metric = newval;
+			cpuc->txn_slots = slots_val;
+		} else if (nmi) {
+			cpuc->nmi_metric = newval;
+			cpuc->nmi_slots = slots_val;
+		}
+
+		if (!(txn_flags & PERF_PMU_TXN_REMOVE)) {
+			/* Reset the metric value when reading
+			 * The SLOTS register must be reset when PERF_METRICS reset,
+			 * otherwise PERF_METRICS may has wrong output.
+			 */
+			wrmsrl(MSR_PERF_METRICS, 0);
+			wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+			hwc->saved_metric = 0;
+			hwc->saved_slots = 0;
+		} else {
+			/* saved metric and slots for context switch */
+			hwc->saved_metric = newval;
+			hwc->saved_slots = val;
+
+		}
+		/* cache the last metric and slots */
+		cpuc->last_metric = hwc->last_metric;
+		cpuc->last_slots = hwc->last_slots;
+		hwc->last_metric = 0;
+		hwc->last_slots = 0;
+	}
+
+	/* The METRICS and SLOTS have been reset when reading */
+	if (!(txn_flags & PERF_PMU_TXN_REMOVE))
+		local64_set(&hwc->prev_count, 0);
+
+	if (is_slots_event(event))
+		return (slots_val - cpuc->last_slots);
+
+	/*
+	 * The metric is reported as an 8bit integer percentage
+	 * suming up to 0xff. As the counter is less than 64bits
+	 * we can use the not used bits to get the needed precision.
+	 * Use 16bit fixed point arithmetic for
+	 * slots-in-metric = (MetricPct / 0xff) * val
+	 * This works fine for upto 48bit counters, but will
+	 * lose precision above that.
+	 */
+
+	metric = (cpuc->last_metric >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
+	last = (((metric * 0xffff) >> 8) * cpuc->last_slots) >> 16;
+
+	metric = (newval >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
+	new = (((metric * 0xffff) >> 8) * slots_val) >> 16;
+
+	return (new - last);
+}
+
+/*
+ * Update counters for metrics and slots events
+ */
+static int icl_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+
+	if (!(hwc->flags & PERF_X86_EVENT_UPDATE))
+		return 0;
+
+	/* The initial value must be 0 */
+	if ((left == x86_pmu.max_period) && !hwc->saved_slots) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+	}
+
+	/* restore metric and slots for context switch */
+	if (hwc->saved_slots) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3,  hwc->saved_slots);
+		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
+		hwc->last_slots = hwc->saved_slots;
+		hwc->last_metric = hwc->saved_metric;
+		hwc->saved_slots = 0;
+		hwc->saved_metric = 0;
+
+	}
+
+	return 1;
+}
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_hsw,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_hsw,	"event=0xd0,umask=0x82")
 
@@ -4839,6 +5023,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.has_xmm_regs = true;
 		intel_pmu_pebs_data_source_skl(false);
+		x86_pmu.has_metric = x86_pmu.intel_cap.perf_metrics;
+		x86_pmu.metric_update_event = icl_metric_update_event;
+		x86_pmu.set_period = icl_set_period;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -4953,6 +5140,11 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
+	if (x86_pmu.has_metric) {
+		x86_pmu.intel_ctrl |= 1ULL << 48;
+		pr_cont("TopDown, ");
+	}
+
 	kfree(to_free);
 	return 0;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bd6ab970c73f..6500463bda85 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -40,6 +40,7 @@ enum extra_reg_type {
 	EXTRA_REG_LBR   = 2,	/* lbr_select */
 	EXTRA_REG_LDLAT = 3,	/* ld_lat_threshold */
 	EXTRA_REG_FE    = 4,    /* fe_* */
+	EXTRA_REG_PERF_METRICS = 5, /* perf metrics */
 
 	EXTRA_REG_MAX		/* number of entries needed */
 };
@@ -71,6 +72,7 @@ struct event_constraint {
 #define PERF_X86_EVENT_EXCL_ACCT	0x0200 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
+#define PERF_X86_EVENT_UPDATE		0x1000 /* call update_event after read */
 
 static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 {
@@ -237,6 +239,13 @@ struct cpu_hw_events {
 	u64				intel_ctrl_host_mask;
 	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
 
+	unsigned long			txn_metric;
+	unsigned long			txn_slots;
+	unsigned long			nmi_metric;
+	unsigned long			nmi_slots;
+	unsigned long			last_metric;
+	unsigned long			last_slots;
+
 	/*
 	 * Intel checkpoint mask
 	 */
@@ -525,6 +534,7 @@ union perf_capabilities {
 		 */
 		u64	full_width_write:1;
 		u64     pebs_baseline:1;
+		u64	perf_metrics:1;
 	};
 	u64	capabilities;
 };
@@ -588,6 +598,7 @@ struct x86_pmu {
 	int		(*addr_offset)(int index, bool eventsel);
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
+	u64		(*metric_update_event)(struct perf_event *event, u64 val);
 	int		max_events;
 	int		num_counters;
 	int		num_counters_fixed;
@@ -618,6 +629,7 @@ struct x86_pmu {
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
 	u64		(*limit_period)(struct perf_event *event, u64 l);
+	int		(*set_period)(struct perf_event *event);
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
@@ -701,6 +713,8 @@ struct x86_pmu {
 	struct extra_reg *extra_regs;
 	unsigned int flags;
 
+	bool has_metric;
+
 	/*
 	 * Intel host/guest support (KVM)
 	 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4310477d6808..bcdd6fadf225 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -102,6 +102,8 @@
 #define MSR_TURBO_RATIO_LIMIT1		0x000001ae
 #define MSR_TURBO_RATIO_LIMIT2		0x000001af
 
+#define MSR_PERF_METRICS		0x00000329
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
 #define MSR_LBR_NHM_FROM		0x00000680
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c0cbd714f10e..2a1405e907ec 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -133,6 +133,11 @@ struct hw_perf_event {
 
 			struct hw_perf_event_extra extra_reg;
 			struct hw_perf_event_extra branch_reg;
+
+			u64		saved_metric;
+			u64		saved_slots;
+			u64		last_slots;
+			u64		last_metric;
 		};
 		struct { /* software */
 			struct hrtimer	hrtimer;
-- 
2.17.1

