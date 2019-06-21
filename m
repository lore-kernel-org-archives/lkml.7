Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D1B208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138803;
	bh=bHCkysYrdrnGl1Kry6UIh/KBnlqzCp/lLuZteguG56M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRSVqVvGNBz2kcJqiS9qlbCM/97g4dBAxVvMpd5LT+0z00kwHBuighCS/tLbnaPlN
	 n0yvLXTX8hbBlzX4ld732JpMDmqzHi0tMKDZQR2sCJ4LMYULxp1Aw4fWH+G+y70aCR
	 QuARr0lRIkyJNsZoFlKJNl8lGUO9n+vv5vwerWXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFURkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFURkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:00 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3917208CA;
        Fri, 21 Jun 2019 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138799;
        bh=bHCkysYrdrnGl1Kry6UIh/KBnlqzCp/lLuZteguG56M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXIU/ZXn4/oALXi5ZEA2rhQvd5XbuiK3E2AvsYhQ7gTvcdtiT2k2PYgGkmpk/yEz6
         S6MNoqUrL0OAkY5l/7u+CG6/TH0hoKb2aLtuvyoe08okPK/1aMeAeEn/v5NfqonVQF
         UkCdxZuXbd6IoxyXdBFp9OScS/mTrhgxVyX+9fT0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/25] perf intel-pt: Add gp registers to synthesized PEBS sample
Date:   Fri, 21 Jun 2019 14:38:15 -0300
Message-Id: <20190621173831.13780-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add general purpose register information from PEBS data in the Intel PT
trace to the synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 979519b00a74..00c2c96bb805 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -35,6 +35,8 @@
 #include "config.h"
 #include "time-utils.h"
 
+#include "../arch/x86/include/uapi/asm/perf_regs.h"
+
 #include "intel-pt-decoder/intel-pt-log.h"
 #include "intel-pt-decoder/intel-pt-decoder.h"
 #include "intel-pt-decoder/intel-pt-insn-decoder.h"
@@ -1547,6 +1549,60 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
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
@@ -1597,6 +1653,19 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
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
2.20.1

