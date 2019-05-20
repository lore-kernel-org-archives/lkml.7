Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E00C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC46208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfETLiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733105AbfETLh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:58 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:56 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/22] perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
Date:   Mon, 20 May 2019 14:37:17 +0300
Message-Id: <20190520113728.14389-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CYC packets are not available, it is still possible to count cycles
using TSC/TMA/MTC timestamps. As the timestamp increments in TSC ticks,
convert to CPU cycles using the current core-to-bus ratio. Do not
accumulate cycles when control flow packet generation is not enabled, nor
when time has been "lost", typically due to mwait, which is indicated by a
TSC/TMA packet that is not part of PSB+.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 99773445872d..9eb778f9c911 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -163,6 +163,9 @@ struct intel_pt_decoder {
 	uint64_t last_masked_timestamp;
 	uint64_t tot_cyc_cnt;
 	uint64_t sample_tot_cyc_cnt;
+	uint64_t base_cyc_cnt;
+	uint64_t cyc_cnt_timestamp;
+	double tsc_to_cyc;
 	bool continuous_period;
 	bool overflow;
 	bool set_fup_tx_flags;
@@ -1423,6 +1426,42 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	return -EOVERFLOW;
 }
 
+static inline void intel_pt_mtc_cyc_cnt_pge(struct intel_pt_decoder *decoder)
+{
+	if (decoder->have_cyc)
+		return;
+
+	decoder->cyc_cnt_timestamp = decoder->timestamp;
+	decoder->base_cyc_cnt = decoder->tot_cyc_cnt;
+}
+
+static inline void intel_pt_mtc_cyc_cnt_cbr(struct intel_pt_decoder *decoder)
+{
+	decoder->tsc_to_cyc = decoder->cbr / decoder->max_non_turbo_ratio_fp;
+
+	if (decoder->pge)
+		intel_pt_mtc_cyc_cnt_pge(decoder);
+}
+
+static inline void intel_pt_mtc_cyc_cnt_upd(struct intel_pt_decoder *decoder)
+{
+	uint64_t tot_cyc_cnt, tsc_delta;
+
+	if (decoder->have_cyc)
+		return;
+
+	decoder->sample_cyc = true;
+
+	if (!decoder->pge || decoder->timestamp <= decoder->cyc_cnt_timestamp)
+		return;
+
+	tsc_delta = decoder->timestamp - decoder->cyc_cnt_timestamp;
+	tot_cyc_cnt = tsc_delta * decoder->tsc_to_cyc + decoder->base_cyc_cnt;
+
+	if (tot_cyc_cnt > decoder->tot_cyc_cnt)
+		decoder->tot_cyc_cnt = tot_cyc_cnt;
+}
+
 static void intel_pt_calc_tma(struct intel_pt_decoder *decoder)
 {
 	uint32_t ctc = decoder->packet.payload;
@@ -1432,6 +1471,11 @@ static void intel_pt_calc_tma(struct intel_pt_decoder *decoder)
 	if (!decoder->tsc_ctc_ratio_d)
 		return;
 
+	if (decoder->pge && !decoder->in_psb)
+		intel_pt_mtc_cyc_cnt_pge(decoder);
+	else
+		intel_pt_mtc_cyc_cnt_upd(decoder);
+
 	decoder->last_mtc = (ctc >> decoder->mtc_shift) & 0xff;
 	decoder->ctc_timestamp = decoder->tsc_timestamp - fc;
 	if (decoder->tsc_ctc_mult) {
@@ -1487,6 +1531,8 @@ static void intel_pt_calc_mtc_timestamp(struct intel_pt_decoder *decoder)
 	else
 		decoder->timestamp = timestamp;
 
+	intel_pt_mtc_cyc_cnt_upd(decoder);
+
 	decoder->timestamp_insn_cnt = 0;
 	decoder->last_mtc = mtc;
 
@@ -1511,6 +1557,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+
+	intel_pt_mtc_cyc_cnt_cbr(decoder);
 }
 
 static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
@@ -1706,6 +1754,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 				decoder->state.to_ip = decoder->ip;
 			}
 			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
+			intel_pt_mtc_cyc_cnt_pge(decoder);
 			return 0;
 
 		case INTEL_PT_TIP:
@@ -1776,6 +1825,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_TIP_PGE: {
 			decoder->pge = true;
+			intel_pt_mtc_cyc_cnt_pge(decoder);
 			if (decoder->packet.count == 0) {
 				intel_pt_log_at("Skipping zero TIP.PGE",
 						decoder->pos);
@@ -2138,6 +2188,7 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_TIP_PGE:
 			decoder->pge = true;
+			intel_pt_mtc_cyc_cnt_pge(decoder);
 			if (intel_pt_have_ip(decoder))
 				intel_pt_set_ip(decoder);
 			if (!decoder->ip)
-- 
2.17.1

