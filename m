Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606DAC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3FB20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbfFJH3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388128AbfFJH3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:32 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:31 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] perf intel-pt: Add gp registers to synthesized PEBS sample
Date:   Mon, 10 Jun 2019 10:27:59 +0300
Message-Id: <20190610072803.10456-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add general purpose register information from PEBS data in the Intel PT
trace to the synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4517c02fa478..3a6d5af6a71b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -43,6 +43,8 @@
 #include "intel-pt.h"
 #include "config.h"
 
+#include "../arch/x86/include/uapi/asm/perf_regs.h"
+
 #include "intel-pt-decoder/intel-pt-log.h"
 #include "intel-pt-decoder/intel-pt-decoder.h"
 #include "intel-pt-decoder/intel-pt-insn-decoder.h"
@@ -1443,6 +1445,60 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
+/*
+ * PEBS gp_regs array indexes plus 1 so that 0 means not present. Refer
+ * intel_pt_add_gp_regs().
+ */
+static const int pebs_gp_regs[] = {
+	[PERF_REG_X86_FLAGS]	= 1,
+	[PERF_REG_X86_IP]	= 2,
+	[PERF_REG_X86_AX]	= 3,
+	[PERF_REG_X86_CX]	= 4,
+	[PERF_REG_X86_DX]	= 5,
+	[PERF_REG_X86_BX]	= 6,
+	[PERF_REG_X86_SP]	= 7,
+	[PERF_REG_X86_BP]	= 8,
+	[PERF_REG_X86_SI]	= 9,
+	[PERF_REG_X86_DI]	= 10,
+	[PERF_REG_X86_R8]	= 11,
+	[PERF_REG_X86_R9]	= 12,
+	[PERF_REG_X86_R10]	= 13,
+	[PERF_REG_X86_R11]	= 14,
+	[PERF_REG_X86_R12]	= 15,
+	[PERF_REG_X86_R13]	= 16,
+	[PERF_REG_X86_R14]	= 17,
+	[PERF_REG_X86_R15]	= 18,
+};
+
+static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
+				 const struct intel_pt_blk_items *items,
+				 u64 regs_mask)
+{
+	const u64 *gp_regs = items->val[INTEL_PT_GP_REGS_POS];
+	u32 mask = items->mask[INTEL_PT_GP_REGS_POS];
+	u32 bit;
+	int i;
+
+	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+		/* Get the PEBS gp_regs array index */
+		int n = pebs_gp_regs[i] - 1;
+
+		if (n < 0)
+			continue;
+		/*
+		 * Add only registers that were requested (i.e. 'regs_mask') and
+		 * that were provided (i.e. 'mask'), and update the resulting
+		 * mask (i.e. 'intr_regs->mask') accordingly.
+		 */
+		if (mask & 1 << n && regs_mask & bit) {
+			intr_regs->mask |= bit;
+			*pos++ = gp_regs[n];
+		}
+	}
+
+	return pos;
+}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1493,6 +1549,19 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
 	}
 
+	if (sample_type & PERF_SAMPLE_REGS_INTR &&
+	    items->mask[INTEL_PT_GP_REGS_POS]) {
+		u64 regs[sizeof(sample.intr_regs.mask)];
+		u64 regs_mask = evsel->attr.sample_regs_intr;
+
+		sample.intr_regs.abi = items->is_32_bit ?
+				       PERF_SAMPLE_REGS_ABI_32 :
+				       PERF_SAMPLE_REGS_ABI_64;
+		sample.intr_regs.regs = regs;
+
+		intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.17.1

