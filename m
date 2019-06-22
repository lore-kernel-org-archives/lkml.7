Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F65FC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5A9208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="okFmO69t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfFVGl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:41:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:41:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6fb3t2006079
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:41:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6fb3t2006079
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185697;
        bh=0qdvfn8NMoVmsxtjZF1Ou3wfu2/DHeev/hGZEidgLrM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=okFmO69t5BQKQ6e0tZWGC/1du5mvlq141DnW+VZMAFj97OyJqtGtg378pmkyk+cW7
         IdAOLHIMAPfweNheJPWO7/Tc98JbmjcKEr1p6bTBmoCyXXb4bCIV0GnTPQOL6Vg95Z
         wokkBW9PIzSts5vv2bvFGtc2MZSWMquUQgBxp8x1PwjoVZ5kr3Vq8PmEhZBJ11MvP+
         KjhdxDURPsj0i3P/2CyKXReikMWGiFSYW6x3sQTe6ZYdmidFhBW9z0j8ZDTg/63FxE
         tzeIRl+3bC8/tNTWDBWXBzz0dlGyHQfUyJa6TP9HzXtdf4r7UhprmTSPBrxNRNvo7j
         K8qKr8fp13qQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6fa1H2006074;
        Fri, 21 Jun 2019 23:41:36 -0700
Date:   Fri, 21 Jun 2019 23:41:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-aa62afd7daac4b4cc95cd2454e3f43aa23f519c1@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        acme@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
          adrian.hunter@intel.com, hpa@zytor.com
In-Reply-To: <20190610072803.10456-10-adrian.hunter@intel.com>
References: <20190610072803.10456-10-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add LBR information to synthesized
 PEBS sample
Git-Commit-ID: aa62afd7daac4b4cc95cd2454e3f43aa23f519c1
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

Commit-ID:  aa62afd7daac4b4cc95cd2454e3f43aa23f519c1
Gitweb:     https://git.kernel.org/tip/aa62afd7daac4b4cc95cd2454e3f43aa23f519c1
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:28:01 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Add LBR information to synthesized PEBS sample

Add LBR information from PEBS data in the Intel PT trace to the
synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
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
 
