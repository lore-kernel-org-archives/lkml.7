Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F0C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBAC207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfFJH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388149AbfFJH3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:36 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] perf intel-pt: Add lbr information to synthesized PEBS sample
Date:   Mon, 10 Jun 2019 10:28:01 +0300
Message-Id: <20190610072803.10456-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lbr information from PEBS data in the Intel PT trace to the synthesized
PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 0175a4ec248f..a73d92189b45 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1524,6 +1524,58 @@ static void intel_pt_add_xmm(struct regs_dump *intr_regs, u64 *pos,
 	}
 }
 
+#define LBR_INFO_MISPRED	(1ULL << 63)
+#define LBR_INFO_IN_TX		(1ULL << 62)
+#define LBR_INFO_ABORT		(1ULL << 61)
+#define LBR_INFO_CYCLES		0xffff
+
+/* Refer kernel's intel_pmu_store_pebs_lbrs() */
+static u64 intel_pt_lbr_flags(u64 info)
+{
+	union {
+		struct branch_flags flags;
+		u64 result;
+	} u = {
+		.flags = {
+			.mispred	= !!(info & LBR_INFO_MISPRED),
+			.predicted	= !(info & LBR_INFO_MISPRED),
+			.in_tx		= !!(info & LBR_INFO_IN_TX),
+			.abort		= !!(info & LBR_INFO_ABORT),
+			.cycles		= info & LBR_INFO_CYCLES,
+		}
+	};
+
+	return u.result;
+}
+
+static void intel_pt_add_lbrs(struct branch_stack *br_stack,
+			      const struct intel_pt_blk_items *items)
+{
+	u64 *to;
+	int i;
+
+	br_stack->nr = 0;
+
+	to = &br_stack->entries[0].from;
+
+	for (i = INTEL_PT_LBR_0_POS; i <= INTEL_PT_LBR_2_POS; i++) {
+		u32 mask = items->mask[i];
+		const u64 *from = items->val[i];
+
+		for (; mask; mask >>= 3, from += 3) {
+			if ((mask & 7) == 7) {
+				*to++ = from[0];
+				*to++ = from[1];
+				*to++ = intel_pt_lbr_flags(from[2]);
+				br_stack->nr += 1;
+			}
+		}
+	}
+}
+
+/* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
+#define LBRS_MAX (INTEL_PT_BLK_ITEM_ID_CNT * 3)
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1590,6 +1642,26 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		intel_pt_add_xmm(&sample.intr_regs, pos, items, regs_mask);
 	}
 
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		struct {
+			struct branch_stack br_stack;
+			struct branch_entry entries[LBRS_MAX];
+		} br;
+
+		if (items->mask[INTEL_PT_LBR_0_POS] ||
+		    items->mask[INTEL_PT_LBR_1_POS] ||
+		    items->mask[INTEL_PT_LBR_2_POS]) {
+			intel_pt_add_lbrs(&br.br_stack, items);
+			sample.branch_stack = &br.br_stack;
+		} else if (pt->synth_opts.last_branch) {
+			intel_pt_copy_last_branch_rb(ptq);
+			sample.branch_stack = ptq->last_branch;
+		} else {
+			br.br_stack.nr = 0;
+			sample.branch_stack = &br.br_stack;
+		}
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.17.1

