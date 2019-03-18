Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8655F217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfCRVoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:44:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:57586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbfCRVoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="308301776"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:44:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 03/22] perf/x86/intel: Support adaptive PEBSv4
Date:   Mon, 18 Mar 2019 14:41:25 -0700
Message-Id: <20190318214144.4639-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318214144.4639-1-kan.liang@linux.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Adaptive PEBS is a new way to report PEBS sampling information. Instead
of a fixed size record for all PEBS events it allows to configure the
PEBS record to only include the information needed. Events can then opt
in to use such an extended record, or stay with a basic record which
only contains the IP.

The major new feature is to support LBRs in PEBS record.
This allows (much faster) large PEBS, while still supporting callstacks
through callstack LBR. So essentially a lot of profiling can now be done
without frequent interrupts, dropping the overhead significantly.

The main requirement still is to use a period, and not use frequency
mode, because frequency mode requires reevaluating the frequency on each
overflow.

The floating point state (XMM) is also supported, which allows efficient
profiling of FP function arguments.

Adapt the drain function to handle variable length records.

Use a new callback to parse the new record format, and also handle the
STATUS field now being at a different offset.

Add code to set up the configuration register. Since there is only a
single register, all events either get the full super set of all events,
or only the basic record.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      |   2 +
 arch/x86/events/intel/ds.c        | 293 ++++++++++++++++++++++++++++--
 arch/x86/events/intel/lbr.c       |  22 +++
 arch/x86/events/perf_event.h      |  14 ++
 arch/x86/include/asm/msr-index.h  |   1 +
 arch/x86/include/asm/perf_event.h |  42 +++++
 6 files changed, 359 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 17096d3cd616..a964b9832b0c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3446,6 +3446,8 @@ static int intel_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 
+	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
+
 	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
 		cpuc->shared_regs = allocate_shared_regs(cpu);
 		if (!cpuc->shared_regs)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4a2206876baa..974284c5ed6c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -906,17 +906,82 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 
 	if (cpuc->n_pebs == cpuc->n_large_pebs) {
 		threshold = ds->pebs_absolute_maximum -
-			reserved * x86_pmu.pebs_record_size;
+			reserved * cpuc->pebs_record_size;
 	} else {
-		threshold = ds->pebs_buffer_base + x86_pmu.pebs_record_size;
+		threshold = ds->pebs_buffer_base + cpuc->pebs_record_size;
 	}
 
 	ds->pebs_interrupt_threshold = threshold;
 }
 
+static void adaptive_pebs_record_size_update(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 d = cpuc->pebs_data_cfg;
+	int sz = sizeof(struct pebs_basic);
+
+	if (d & PEBS_DATACFG_MEMINFO)
+		sz += sizeof(struct pebs_meminfo);
+	if (d & PEBS_DATACFG_GPRS)
+		sz += sizeof(struct pebs_gprs);
+	if (d & PEBS_DATACFG_XMMS)
+		sz += sizeof(struct pebs_xmm);
+	if (d & PEBS_DATACFG_LBRS)
+		sz += x86_pmu.lbr_nr * sizeof(struct pebs_lbr_entry);
+
+	cpuc->pebs_record_size = sz;
+}
+
+static u64 pebs_update_adaptive_cfg(struct perf_event *event)
+{
+	u64 sample_type = event->attr.sample_type;
+	u64 pebs_data_cfg = 0;
+
+
+	if ((sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) ||
+		event->attr.precise_ip < 2) {
+
+		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |
+				   PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT |
+				   PERF_SAMPLE_TRANSACTION))
+			pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
+
+		/*
+		 * Cases we need the registers:
+		 * + user requested registers
+		 * + precise_ip < 2 for the non event IP
+		 * + For RTM TSX weight we need GPRs too for the abort
+		 * code. But we don't want to force GPRs for all other
+		 * weights.  So add it only for the RTM abort event.
+		 */
+		if (((sample_type & PERF_SAMPLE_REGS_INTR) &&
+			(event->attr.sample_regs_intr & 0xffffffff)) ||
+		    (event->attr.precise_ip < 2) ||
+		    ((sample_type & PERF_SAMPLE_WEIGHT) &&
+		     ((event->attr.config & 0xffff) == x86_pmu.force_gpr_event)))
+			pebs_data_cfg |= PEBS_DATACFG_GPRS;
+
+		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+			(event->attr.sample_regs_intr >> 32))
+			pebs_data_cfg |= PEBS_DATACFG_XMMS;
+
+		if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+			/*
+			 * For now always log all LBRs. Could configure this
+			 * later.
+			 */
+			pebs_data_cfg |= PEBS_DATACFG_LBRS |
+				((x86_pmu.lbr_nr-1) << PEBS_DATACFG_LBR_SHIFT);
+		}
+	}
+	return pebs_data_cfg;
+}
+
 static void
-pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
+pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
+		  struct perf_event *event, bool add)
 {
+	struct pmu *pmu = event->ctx->pmu;
 	/*
 	 * Make sure we get updated with the first PEBS
 	 * event. It will trigger also during removal, but
@@ -933,6 +998,19 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
 		update = true;
 	}
 
+	if (x86_pmu.intel_cap.pebs_baseline && add) {
+		u64 pebs_data_cfg;
+
+		pebs_data_cfg = pebs_update_adaptive_cfg(event);
+
+		/* Update pebs_record_size if new event requires more data. */
+		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
+			cpuc->pebs_data_cfg |= pebs_data_cfg;
+			adaptive_pebs_record_size_update();
+			update = true;
+		}
+	}
+
 	if (update)
 		pebs_update_threshold(cpuc);
 }
@@ -947,7 +1025,7 @@ void intel_pmu_pebs_add(struct perf_event *event)
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs++;
 
-	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
+	pebs_update_state(needed_cb, cpuc, event, true);
 }
 
 void intel_pmu_pebs_enable(struct perf_event *event)
@@ -965,6 +1043,14 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
 		cpuc->pebs_enabled |= 1ULL << 63;
 
+	if (x86_pmu.intel_cap.pebs_baseline) {
+		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
+		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
+			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
+			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
+		}
+	}
+
 	/*
 	 * Use auto-reload if possible to save a MSR write in the PMI.
 	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
@@ -991,7 +1077,12 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs--;
 
-	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
+	/* Clear both pebs_data_cfg and pebs_record_size for first PEBS. */
+	if (x86_pmu.intel_cap.pebs_baseline && !cpuc->n_pebs) {
+		cpuc->pebs_data_cfg = 0;
+		cpuc->pebs_record_size = sizeof(struct pebs_basic);
+	}
+	pebs_update_state(needed_cb, cpuc, event, false);
 }
 
 void intel_pmu_pebs_disable(struct perf_event *event)
@@ -1004,6 +1095,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
 
+	/* Delay reprograming DATA_CFG to next enable */
+
 	if (event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT)
 		cpuc->pebs_enabled &= ~(1ULL << (hwc->idx + 32));
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
@@ -1013,6 +1106,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 
 	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
+	hwc->config &= ~ICL_EVENTSEL_ADAPTIVE;
 }
 
 void intel_pmu_pebs_enable_all(void)
@@ -1144,6 +1238,24 @@ static u64 intel_hsw_transaction(u64 tsx_tuning, u64 ax)
 	return txn;
 }
 
+static inline void *next_pebs_record(void *p)
+{
+	unsigned int size;
+
+	if (x86_pmu.intel_cap.pebs_format < 4)
+		size = x86_pmu.pebs_record_size;
+	else
+		size = ((struct pebs_basic *)p)->format_size >> 48;
+	return p + size;
+}
+
+static inline u64 get_pebs_status(struct pebs_record_nhm *n)
+{
+	if (x86_pmu.intel_cap.pebs_format < 4)
+		return n->status;
+	return ((struct pebs_basic *)n)->applicable_counters;
+}
+
 #define PERF_X86_EVENT_PEBS_HSW_PREC \
 		(PERF_X86_EVENT_PEBS_ST_HSW | \
 		 PERF_X86_EVENT_PEBS_LD_HSW | \
@@ -1164,7 +1276,7 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
-static void setup_pebs_sample_data(struct perf_event *event,
+static void setup_pebs_fixed_sample_data(struct perf_event *event,
 				   struct pt_regs *iregs, void *__pebs,
 				   struct perf_sample_data *data,
 				   struct pt_regs *regs)
@@ -1306,6 +1418,129 @@ static void setup_pebs_sample_data(struct perf_event *event,
 		data->br_stack = &cpuc->lbr_stack;
 }
 
+static void adaptive_pebs_save_regs(struct pt_regs *regs,
+				    struct pebs_gprs *gprs)
+{
+	regs->ax = gprs->ax;
+	regs->bx = gprs->bx;
+	regs->cx = gprs->cx;
+	regs->dx = gprs->dx;
+	regs->si = gprs->si;
+	regs->di = gprs->di;
+	regs->bp = gprs->bp;
+	regs->sp = gprs->sp;
+#ifndef CONFIG_X86_32
+	regs->r8 = gprs->r8;
+	regs->r9 = gprs->r9;
+	regs->r10 = gprs->r10;
+	regs->r11 = gprs->r11;
+	regs->r12 = gprs->r12;
+	regs->r13 = gprs->r13;
+	regs->r14 = gprs->r14;
+	regs->r15 = gprs->r15;
+#endif
+}
+
+/*
+ * With adaptive PEBS the layout depends on what fields are configured.
+ */
+
+static void setup_pebs_adaptive_sample_data(struct perf_event *event,
+					    struct pt_regs *iregs, void *__pebs,
+					    struct perf_sample_data *data,
+					    struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct pebs_basic *basic = __pebs;
+	void *next_record = basic + 1;
+	u64 sample_type;
+	u64 format_size;
+	struct pebs_gprs *gprs = NULL;
+
+	if (basic == NULL)
+		return;
+
+	sample_type = event->attr.sample_type;
+	format_size = basic->format_size;
+	perf_sample_data_init(data, 0, event->hw.last_period);
+	data->period = event->hw.last_period;
+
+	if (event->attr.use_clockid == 0)
+		data->time = native_sched_clock_from_tsc(basic->tsc);
+
+	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happened between the record and
+	 * PMI.
+	 */
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		data->callchain = perf_callchain(event, iregs);
+
+	*regs = *iregs;
+	/* The ip in basic is EventingIP */
+	set_linear_ip(regs, basic->ip);
+	regs->flags = PERF_EFLAGS_EXACT;
+
+	if (format_size & PEBS_DATACFG_GPRS) {
+		gprs = next_record;
+		next_record = gprs + 1;
+
+		if (event->attr.precise_ip < 2) {
+			set_linear_ip(regs, gprs->ip);
+			regs->flags &= ~PERF_EFLAGS_EXACT;
+		}
+
+		if (sample_type & PERF_SAMPLE_REGS_INTR)
+			adaptive_pebs_save_regs(regs, gprs);
+	}
+
+	if (format_size & PEBS_DATACFG_MEMINFO) {
+		struct pebs_meminfo *meminfo = next_record;
+
+		next_record = meminfo + 1;
+
+		if (sample_type & PERF_SAMPLE_WEIGHT)
+			data->weight = meminfo->latency ?:
+				intel_hsw_weight(meminfo->tsx_tuning);
+
+		if (sample_type & PERF_SAMPLE_DATA_SRC)
+			data->data_src.val = get_data_src(event, meminfo->aux);
+
+		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+			data->addr = meminfo->address;
+
+		if (sample_type & PERF_SAMPLE_TRANSACTION)
+			data->txn = intel_hsw_transaction(meminfo->tsx_tuning,
+							  gprs ? gprs->ax : 0);
+	}
+
+	if (format_size & PEBS_DATACFG_LBRS) {
+		struct pebs_lbr *lbr = next_record;
+		int num_lbr = ((format_size >> PEBS_DATACFG_LBR_SHIFT)
+					& 0xff) + 1;
+		next_record = next_record + num_lbr*sizeof(struct pebs_lbr_entry);
+
+		if (has_branch_stack(event)) {
+			intel_pmu_store_pebs_lbrs(lbr);
+			data->br_stack = &cpuc->lbr_stack;
+		}
+	}
+
+	if (format_size & PEBS_DATACFG_XMMS) {
+		struct pebs_xmm *xmm = next_record;
+
+		next_record = xmm + 1;
+		data->extra_regs = xmm->xmm;
+	}
+
+	WARN_ONCE(next_record != __pebs + (format_size >> 48),
+			"PEBS record size %llu, expected %llu, config %llx\n",
+			format_size >> 48,
+			(u64)(next_record - __pebs),
+			basic->format_size);
+}
+
 static inline void *
 get_next_pebs_record_by_bit(void *base, void *top, int bit)
 {
@@ -1323,19 +1558,20 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	if (base == NULL)
 		return NULL;
 
-	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
+	for (at = base; at < top; at = next_pebs_record(at)) {
 		struct pebs_record_nhm *p = at;
+		unsigned long status = get_pebs_status(p);
 
-		if (test_bit(bit, (unsigned long *)&p->status)) {
+		if (test_bit(bit, (unsigned long *)&status)) {
 			/* PEBS v3 has accurate status bits */
 			if (x86_pmu.intel_cap.pebs_format >= 3)
 				return at;
 
-			if (p->status == (1 << bit))
+			if (status == (1 << bit))
 				return at;
 
 			/* clear non-PEBS bit and re-check */
-			pebs_status = p->status & cpuc->pebs_enabled;
+			pebs_status = status & cpuc->pebs_enabled;
 			pebs_status &= PEBS_COUNTER_MASK;
 			if (pebs_status == (1 << bit))
 				return at;
@@ -1434,14 +1670,14 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 		return;
 
 	while (count > 1) {
-		setup_pebs_sample_data(event, iregs, at, &data, &regs);
+		x86_pmu.setup_pebs_sample_data(event, iregs, at, &data, &regs);
 		perf_event_output(event, &data, &regs);
-		at += x86_pmu.pebs_record_size;
+		at = next_pebs_record(at);
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		count--;
 	}
 
-	setup_pebs_sample_data(event, iregs, at, &data, &regs);
+	x86_pmu.setup_pebs_sample_data(event, iregs, at, &data, &regs);
 
 	/*
 	 * All but the last records are processed.
@@ -1534,11 +1770,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		return;
 	}
 
-	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
+	for (at = base; at < top; at = next_pebs_record(at)) {
 		struct pebs_record_nhm *p = at;
 		u64 pebs_status;
 
-		pebs_status = p->status & cpuc->pebs_enabled;
+		pebs_status = get_pebs_status(p) & cpuc->pebs_enabled;
 		pebs_status &= mask;
 
 		/* PEBS v3 has more accurate status bits */
@@ -1637,8 +1873,10 @@ void __init intel_ds_init(void)
 		x86_pmu.pebs_no_isolation = 1;
 	if (x86_pmu.pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
+		char *pebs_qual = "";
 		int format = x86_pmu.intel_cap.pebs_format;
 
+		x86_pmu.setup_pebs_sample_data = setup_pebs_fixed_sample_data;
 		switch (format) {
 		case 0:
 			pr_cont("PEBS fmt0%c, ", pebs_type);
@@ -1674,10 +1912,35 @@ void __init intel_ds_init(void)
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
+		case 4:
+			x86_pmu.drain_pebs = intel_pmu_drain_pebs_nhm;
+			x86_pmu.setup_pebs_sample_data = setup_pebs_adaptive_sample_data;
+			x86_pmu.pebs_record_size = sizeof(struct pebs_basic);
+			if (x86_pmu.intel_cap.pebs_baseline) {
+				x86_pmu.large_pebs_flags |=
+					PERF_SAMPLE_BRANCH_STACK |
+					PERF_SAMPLE_TIME;
+				x86_pmu.flags |= PMU_FL_PEBS_ALL;
+				pebs_qual = "-baseline";
+			} else {
+				/* Only basic record supported */
+				x86_pmu.large_pebs_flags &=
+					~(PERF_SAMPLE_ADDR |
+					  PERF_SAMPLE_TIME |
+					  PERF_SAMPLE_DATA_SRC |
+					  PERF_SAMPLE_TRANSACTION |
+					  PERF_SAMPLE_REGS_USER |
+					  PERF_SAMPLE_REGS_INTR);
+			}
+			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+			break;
+
 		default:
 			pr_cont("no PEBS fmt%d%c, ", format, pebs_type);
 			x86_pmu.pebs = 0;
 		}
+		if (format != 4)
+			x86_pmu.intel_cap.pebs_baseline = 0;
 	}
 }
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c88ed39582a1..58889f952959 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1079,6 +1079,28 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	}
 }
 
+void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		u64 info = lbr->lbr[i].info;
+		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
+
+		e->from		= lbr->lbr[i].from;
+		e->to		= lbr->lbr[i].to;
+		e->mispred	= !!(info & LBR_INFO_MISPRED);
+		e->predicted	= !(info & LBR_INFO_MISPRED);
+		e->in_tx	= !!(info & LBR_INFO_IN_TX);
+		e->abort	= !!(info & LBR_INFO_ABORT);
+		e->cycles	= info & LBR_INFO_CYCLES;
+		e->reserved	= 0;
+	}
+	intel_pmu_lbr_filter(cpuc);
+}
+
 /*
  * Map interface branch filters onto LBR filters
  */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7e75f474b076..db3b622265fa 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -207,6 +207,11 @@ struct cpu_hw_events {
 	int			n_pebs;
 	int			n_large_pebs;
 
+	/* Current super set of events hardware configuration */
+	u64			pebs_data_cfg;
+	u64			active_pebs_data_cfg;
+	int			pebs_record_size;
+
 	/*
 	 * Intel LBR bits
 	 */
@@ -468,6 +473,7 @@ union perf_capabilities {
 		 * values > 32bit.
 		 */
 		u64	full_width_write:1;
+		u64     pebs_baseline:1;
 	};
 	u64	capabilities;
 };
@@ -612,10 +618,16 @@ struct x86_pmu {
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	void		(*drain_pebs)(struct pt_regs *regs);
+	void		(*setup_pebs_sample_data)(struct perf_event *event,
+						  struct pt_regs *iregs,
+						  void *__pebs,
+						  struct perf_sample_data *data,
+						  struct pt_regs *regs);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	int 		max_pebs_events;
 	unsigned long	large_pebs_flags;
+	u64		force_gpr_event;
 
 	/*
 	 * Intel LBR
@@ -952,6 +964,8 @@ void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
+void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
+
 void intel_ds_init(void);
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8e40c2446fd1..b14b8bea8681 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -116,6 +116,7 @@
 #define LBR_INFO_CYCLES			0xffff
 
 #define MSR_IA32_PEBS_ENABLE		0x000003f1
+#define MSR_PEBS_DATA_CFG		0x000003f2
 #define MSR_IA32_DS_AREA		0x00000600
 #define MSR_IA32_PERF_CAPABILITIES	0x00000345
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8bdf74902293..da0a80ef6505 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -32,6 +32,7 @@
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
+#define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
 
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
@@ -87,6 +88,12 @@
 #define ARCH_PERFMON_BRANCH_MISSES_RETIRED		6
 #define ARCH_PERFMON_EVENTS_COUNT			7
 
+#define PEBS_DATACFG_MEMINFO	BIT_ULL(0)
+#define PEBS_DATACFG_GPRS	BIT_ULL(1)
+#define PEBS_DATACFG_XMMS	BIT_ULL(2)
+#define PEBS_DATACFG_LBRS	BIT_ULL(3)
+#define PEBS_DATACFG_LBR_SHIFT	24
+
 /*
  * Intel "Architectural Performance Monitoring" CPUID
  * detection/enumeration details:
@@ -176,6 +183,41 @@ struct x86_pmu_capability {
 #define GLOBAL_STATUS_LBRS_FROZEN			BIT_ULL(58)
 #define GLOBAL_STATUS_TRACE_TOPAPMI			BIT_ULL(55)
 
+/*
+ * Adaptive PEBS v4
+ */
+
+struct pebs_basic {
+	u64 format_size;
+	u64 ip;
+	u64 applicable_counters;
+	u64 tsc;
+};
+
+struct pebs_meminfo {
+	u64 address;
+	u64 aux;
+	u64 latency;
+	u64 tsx_tuning;
+};
+
+struct pebs_gprs {
+	u64 flags, ip, ax, cx, dx, bx, sp, bp, si, di;
+	u64 r8, r9, r10, r11, r12, r13, r14, r15;
+};
+
+struct pebs_xmm {
+	u64 xmm[16*2];	/* two entries for each register */
+};
+
+struct pebs_lbr_entry {
+	u64 from, to, info;
+};
+
+struct pebs_lbr {
+	struct pebs_lbr_entry lbr[0]; /* Variable length */
+};
+
 /*
  * IBS cpuid feature detection
  */
-- 
2.17.1

