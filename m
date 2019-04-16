Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A9EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FBE20857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfDPLlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:41:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:41:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBfcbX3429340
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:41:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBfcFS3429337;
        Tue, 16 Apr 2019 04:41:38 -0700
Date:   Tue, 16 Apr 2019 04:41:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-6daeb8737f8a93c6d3a3ae57e23dd3dbe8b239da@git.kernel.org>
Cc:     mingo@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        kan.liang@linux.intel.com, torvalds@linux-foundation.org,
        jolsa@redhat.com, acme@redhat.com, vincent.weaver@maine.edu
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          eranian@google.com, mingo@kernel.org, kan.liang@linux.intel.com,
          hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          acme@redhat.com, vincent.weaver@maine.edu, jolsa@redhat.com
In-Reply-To: <1554922629-126287-3-git-send-email-kan.liang@linux.intel.com>
References: <1554922629-126287-3-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Add Tremont core PMU support
Git-Commit-ID: 6daeb8737f8a93c6d3a3ae57e23dd3dbe8b239da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6daeb8737f8a93c6d3a3ae57e23dd3dbe8b239da
Gitweb:     https://git.kernel.org/tip/6daeb8737f8a93c6d3a3ae57e23dd3dbe8b239da
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Wed, 10 Apr 2019 11:57:09 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:26:19 +0200

perf/x86/intel: Add Tremont core PMU support

Add perf core PMU support for Intel Tremont CPU.

The init code is based on Goldmont plus.

The generic purpose counter 0 and fixed counter 0 have less skid.
Force :ppp events on generic purpose counter 0.
Force instruction:ppp on generic purpose counter 0 and fixed counter 0.

Updates LLC cache event table and OFFCORE_RESPONSE mask.

Adaptive PEBS, which is already enabled on ICL, is also supported
on Tremont. No extra code required.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/1554922629-126287-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 156c6ae53d3c..4b4dac089635 100644
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
@@ -3406,6 +3445,9 @@ static struct event_constraint counter2_constraint =
 static struct event_constraint fixed0_constraint =
 			FIXED_EVENT_CONSTRAINT(0x00c0, 0);
 
+static struct event_constraint fixed0_counter0_constraint =
+			INTEL_ALL_EVENT_CONSTRAINT(0, 0x100000001ULL);
+
 static struct event_constraint *
 hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -3454,6 +3496,29 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
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
+	 * which is available on PMC0 and fixed counter 0.
+	 */
+	if (event->attr.precise_ip == 3) {
+		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
+		if (constraint_match(&fixed0_constraint, event->hw.config))
+			return &fixed0_counter0_constraint;
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
@@ -4585,6 +4650,32 @@ __init int intel_pmu_init(void)
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
