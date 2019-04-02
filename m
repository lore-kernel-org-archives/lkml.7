Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D493C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8D22075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfDBTrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:47:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:54561 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfDBTru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:47:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 12:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="130892985"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2019 12:47:49 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
Date:   Tue,  2 Apr 2019 12:45:05 -0700
Message-Id: <20190402194509.2832-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402194509.2832-1-kan.liang@linux.intel.com>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add Icelake core PMU perf code, including constraint tables and the main
enable code.

Icelake expanded the generic counters to always 8 even with HT on, but a
range of events cannot be scheduled on the extra 4 counters.
Add new constraint ranges to describe this to the scheduler.
The number of constraints that need to be checked is larger now than
with earlier CPUs.
At some point we may need a new data structure to look them up more
efficiently than with linear search. So far it still seems to be
acceptable however.

Icelake added a new fixed counter SLOTS. Full support for it is added
later in the patch series.

The cache events table is identical to Skylake.

Compare to PEBS instruction event on generic counter, fixed counter 0
has less skid. Force instruction:ppp always in fixed counter 0.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V4:
- remove has_xmm_regs

 arch/x86/events/intel/core.c      | 111 ++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c        |  26 ++++++-
 arch/x86/events/perf_event.h      |   2 +
 arch/x86/include/asm/intel_ds.h   |   2 +-
 arch/x86/include/asm/perf_event.h |   2 +-
 5 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7828090dcd09..47984eb93f3b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -239,6 +239,35 @@ static struct extra_reg intel_skl_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct event_constraint intel_icl_event_constraints[] = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
+	INTEL_UEVENT_CONSTRAINT(0x1c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
+	INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
+	INTEL_EVENT_CONSTRAINT(0x32, 0xf),	/* SW_PREFETCH_ACCESS.* */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x48, 0x54, 0xf),
+	INTEL_EVENT_CONSTRAINT_RANGE(0x60, 0x8b, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x04a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_TOTAL */
+	INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_MEM_ANY */
+	INTEL_EVENT_CONSTRAINT(0xa3, 0xf),      /* CYCLE_ACTIVITY.* */
+	INTEL_EVENT_CONSTRAINT_RANGE(0xa8, 0xb0, 0xf),
+	INTEL_EVENT_CONSTRAINT_RANGE(0xb7, 0xbd, 0xf),
+	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xe6, 0xf),
+	INTEL_EVENT_CONSTRAINT_RANGE(0xf0, 0xf4, 0xf),
+	EVENT_CONSTRAINT_END
+};
+
+static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffff9fffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
+	EVENT_EXTRA_END
+};
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
@@ -3366,6 +3395,9 @@ static struct event_constraint counter0_constraint =
 static struct event_constraint counter2_constraint =
 			EVENT_CONSTRAINT(0, 0x4, 0);
 
+static struct event_constraint fixed_counter0_constraint =
+			FIXED_EVENT_CONSTRAINT(0x00c0, 0);
+
 static struct event_constraint *
 hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -3384,6 +3416,21 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return c;
 }
 
+static struct event_constraint *
+icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	/*
+	 * Fixed counter 0 has less skid.
+	 * Force instruction:ppp in Fixed counter 0
+	 */
+	if ((event->attr.precise_ip == 3) &&
+	    ((event->hw.config & X86_RAW_EVENT_MASK) == 0x00c0))
+		return &fixed_counter0_constraint;
+
+	return hsw_get_event_constraints(cpuc, idx, event);
+}
+
 static struct event_constraint *
 glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -4110,6 +4157,42 @@ static struct attribute *hsw_tsx_events_attrs[] = {
 	NULL
 };
 
+EVENT_ATTR_STR(tx-capacity-read,  tx_capacity_read,  "event=0x54,umask=0x80");
+EVENT_ATTR_STR(tx-capacity-write, tx_capacity_write, "event=0x54,umask=0x2");
+EVENT_ATTR_STR(el-capacity-read,  el_capacity_read,  "event=0x54,umask=0x80");
+EVENT_ATTR_STR(el-capacity-write, el_capacity_write, "event=0x54,umask=0x2");
+
+static struct attribute *icl_events_attrs[] = {
+	EVENT_PTR(mem_ld_hsw),
+	EVENT_PTR(mem_st_hsw),
+	NULL,
+};
+
+static struct attribute *icl_tsx_events_attrs[] = {
+	EVENT_PTR(tx_start),
+	EVENT_PTR(tx_abort),
+	EVENT_PTR(tx_commit),
+	EVENT_PTR(tx_capacity_read),
+	EVENT_PTR(tx_capacity_write),
+	EVENT_PTR(tx_conflict),
+	EVENT_PTR(el_start),
+	EVENT_PTR(el_abort),
+	EVENT_PTR(el_commit),
+	EVENT_PTR(el_capacity_read),
+	EVENT_PTR(el_capacity_write),
+	EVENT_PTR(el_conflict),
+	EVENT_PTR(cycles_t),
+	EVENT_PTR(cycles_ct),
+	NULL,
+};
+
+static __init struct attribute **get_icl_events_attrs(void)
+{
+	return boot_cpu_has(X86_FEATURE_RTM) ?
+		merge_attr(icl_events_attrs, icl_tsx_events_attrs) :
+		icl_events_attrs;
+}
+
 static ssize_t freeze_on_smi_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -4697,6 +4780,34 @@ __init int intel_pmu_init(void)
 		name = "skylake";
 		break;
 
+	case INTEL_FAM6_ICELAKE_MOBILE:
+		x86_pmu.late_ack = true;
+		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+		intel_pmu_lbr_init_skl();
+
+		x86_pmu.event_constraints = intel_icl_event_constraints;
+		x86_pmu.pebs_constraints = intel_icl_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_icl_extra_regs;
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+
+		x86_pmu.hw_config = hsw_hw_config;
+		x86_pmu.get_event_constraints = icl_get_event_constraints;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			hsw_format_attr : nhm_format_attr;
+		extra_attr = merge_attr(extra_attr, skl_format_attr);
+		x86_pmu.cpu_events = get_icl_events_attrs();
+		x86_pmu.force_gpr_event = 0x2ca;
+		x86_pmu.lbr_pt_coexist = true;
+		intel_pmu_pebs_data_source_skl(false);
+		pr_cont("Icelake events, ");
+		name = "icelake";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 155fca3af062..9c1ba58e166d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -849,6 +849,26 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_icl_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x400000000ULL),	/* SLOTS */
+
+	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),		/* MEM_TRANS_RETIRED.LOAD_LATENCY */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),  /* MEM_INST_RETIRED.LOAD */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x2d0, 0xf),  /* MEM_INST_RETIRED.STORE */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf), /* MEM_LOAD_*_RETIRED.* */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf), 	     /* MEM_INST_RETIRED.* */
+
+	/*
+	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
+	 * need the full constraints from the main table.
+	 */
+
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
 	struct event_constraint *c;
@@ -1056,7 +1076,8 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 
 	cpuc->pebs_enabled |= 1ULL << hwc->idx;
 
-	if (event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT)
+	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
+	    (x86_pmu.version < 5))
 		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
 		cpuc->pebs_enabled |= 1ULL << 63;
@@ -1108,7 +1129,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
 
-	if (event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT)
+	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
+	    (x86_pmu.version < 5))
 		cpuc->pebs_enabled &= ~(1ULL << (hwc->idx + 32));
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
 		cpuc->pebs_enabled &= ~(1ULL << 63);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 583d72884ddb..bf5d81a94901 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -998,6 +998,8 @@ extern struct event_constraint intel_bdw_pebs_event_constraints[];
 
 extern struct event_constraint intel_skl_pebs_event_constraints[];
 
+extern struct event_constraint intel_icl_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
 void intel_pmu_pebs_add(struct perf_event *event);
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index ae26df1c2789..8380c3ddd4b2 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -8,7 +8,7 @@
 
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS		8
-#define MAX_FIXED_PEBS_EVENTS	3
+#define MAX_FIXED_PEBS_EVENTS	4
 
 /*
  * A debug store configuration.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fd0ec2699213..dcb8bac6fddb 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -7,7 +7,7 @@
  */
 
 #define INTEL_PMC_MAX_GENERIC				       32
-#define INTEL_PMC_MAX_FIXED					3
+#define INTEL_PMC_MAX_FIXED					4
 #define INTEL_PMC_IDX_FIXED				       32
 
 #define X86_PMC_IDX_MAX					       64
-- 
2.17.1

