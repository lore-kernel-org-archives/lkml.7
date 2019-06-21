Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49120C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200DA2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138814;
	bh=pW736/PrxXzJepQGBwT0m9vRM67pizmcQNVpX+sr17w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y6mhPIYZrKVFqE37iJjdhc8Zm0x1a3zT3BCajc+3UP4CB3ebDu8GlukR/WQ9WWhJk
	 esTS+pXC4Av9oW9I82BTUyk5VpQrF/pJBahylI/sCNQ2BQl+OP5CcoFoxCOss+gbMj
	 gikwrdcMzw3786F6YD9MLRuPZwEVBEEWLQFIK5jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfFURkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFURkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:11 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57282083B;
        Fri, 21 Jun 2019 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138810;
        bh=pW736/PrxXzJepQGBwT0m9vRM67pizmcQNVpX+sr17w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZ+ruJujulUvCoEdEfG56JJSI1R/N/LtzCAqnoo33EL6nJNBCSe1a57AEZ+Y2gNRu
         2Li4p3nm5Q0za4+XxDQ3WAm8QhUWUuSoFTjW/tDsutTFhGkFZcm8OENhYSsZg948G0
         mBvgk8vFKd2senEjZNB02d6ID+V6NNPmT0noA46Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/25] perf intel-pt: Add LBR information to synthesized PEBS sample
Date:   Fri, 21 Jun 2019 14:38:17 -0300
Message-Id: <20190621173831.13780-12-acme@kernel.org>
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

Add LBR information from PEBS data in the Intel PT trace to the
synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f83dd10bb7d0..db00c13dc36f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1628,6 +1628,58 @@ static void intel_pt_add_xmm(struct regs_dump *intr_regs, u64 *pos,
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
@@ -1694,6 +1746,26 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
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
2.20.1

