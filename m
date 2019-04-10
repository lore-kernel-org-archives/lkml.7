Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B7C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F120874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDJBLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:11:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:13855 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfDJBLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:11:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="134419252"
Received: from otc-lr-04.jf.intel.com ([10.54.39.19])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2019 18:10:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, acme@kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Add Tremont core PMU support
Date:   Tue,  9 Apr 2019 18:10:00 -0700
Message-Id: <1554858600-148296-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
References: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add perf core PMU support for Intel Tremont CPU.

The init code is based on Goldmont plus.

The generic purpose counter 0 and fixed counter 0 have less skid.
Force :ppp events on generic purpose counter 0.
Force instruction:ppp always on fixed counter 0.

Updates LLC cache event table and OFFCORE_RESPONSE mask.

The adaptive PEBS, which is already enabled on ICL, is also supported
on Tremont. No extra codes required.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f34d92b..f478831 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1856,6 +1856,45 @@ static __initconst const u64 glp_hw_cache_extra_regs
 	},
 };
 
+#define TNT_LOCAL_DRAM			BIT_ULL(26)
+#define TNT_DEMAND_READ			GLM_DEMAND_DATA_RD
+#define TNT_DEMAND_WRITE		GLM_DEMAND_RFO
+#define TNT_LLC_ACCESS			GLM_ANY_RESPONSE
+#define TNT_SNP_ANY			(SNB_SNP_NOT_NEEDED|SNB_SNP_MISS| \
+					 SNB_NO_FWD|SNB_SNP_FWD|SNB_HITM)
+#define TNT_LLC_MISS			(TNT_SNP_ANY|SNB_NON_DRAM|TNT_LOCAL_DRAM)
+
+static __initconst const u64 tnt_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= TNT_DEMAND_READ|
+						  TNT_LLC_ACCESS,
+			[C(RESULT_MISS)]	= TNT_DEMAND_READ|
+						  TNT_LLC_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= TNT_DEMAND_WRITE|
+						  TNT_LLC_ACCESS,
+			[C(RESULT_MISS)]	= TNT_DEMAND_WRITE|
+						  TNT_LLC_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+};
+
+static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
+	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0xffffff9fffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0xffffff9fffull, RSP_1),
+	EVENT_EXTRA_END
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -3451,6 +3490,29 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return c;
 }
 
+static struct event_constraint *
+tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct event_constraint *c;
+
+	/*
+	 * :ppp means to do reduced skid PEBS,
+	 * which is available at PMC0 and fixed counter 0.
+	 */
+	if (event->attr.precise_ip == 3) {
+		/* Force instruction:ppp in Fixed counter 0 */
+		if (event->hw.config == X86_CONFIG(.event=0xc0))
+			return &fixed_counter0_constraint;
+
+		return &counter0_constraint;
+	}
+
+	c = intel_get_event_constraints(cpuc, idx, event);
+
+	return c;
+}
+
 static bool allow_tsx_force_abort = true;
 
 static struct event_constraint *
@@ -4530,6 +4592,32 @@ __init int intel_pmu_init(void)
 		name = "goldmont_plus";
 		break;
 
+	case INTEL_FAM6_ATOM_TREMONT_X:
+		x86_pmu.late_ack = true;
+		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+
+		intel_pmu_lbr_init_skl();
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		x86_pmu.extra_regs = intel_tnt_extra_regs;
+		/*
+		 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
+		 * for precise cycles.
+		 */
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		extra_attr = slm_format_attr;
+		pr_cont("Tremont events, ");
+		name = "Tremont";
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
-- 
2.7.4

