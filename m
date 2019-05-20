Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB24C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06420645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbfETLhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:37:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETLht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:48 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/22] perf intel-pt: Accumulate cycle count from CYC packets
Date:   Mon, 20 May 2019 14:37:11 +0300
Message-Id: <20190520113728.14389-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for providing instructions-per-cycle (IPC) information,
accumulate cycle count from CYC packets.

Although CYC packets are optional (requires config term 'cyc' to enable
cycle-accurate mode when recording), the simplest way to count cycles is
with CYC packets. The first complication is that cycles must be counted
only when also counting instructions. That means when control flow packet
generation is enabled i.e. between TIP.PGE and TIP.PGD packets. Also,
sampling the cycle count follows the same rules as sampling the timestamp,
that is, not before the instruction to which the decoder is walking is
reached. In addition, the cycle count is not accurate for any but the first
branch of a TNT packet.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 14 +++++++++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 1ab4070b5633..ef3a1c1cd250 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -160,6 +160,8 @@ struct intel_pt_decoder {
 	uint64_t period_mask;
 	uint64_t period_ticks;
 	uint64_t last_masked_timestamp;
+	uint64_t tot_cyc_cnt;
+	uint64_t sample_tot_cyc_cnt;
 	bool continuous_period;
 	bool overflow;
 	bool set_fup_tx_flags;
@@ -167,6 +169,7 @@ struct intel_pt_decoder {
 	bool set_fup_mwait;
 	bool set_fup_pwre;
 	bool set_fup_exstop;
+	bool sample_cyc;
 	unsigned int fup_tx_flags;
 	unsigned int tx_flags;
 	uint64_t fup_ptw_payload;
@@ -1323,6 +1326,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 				decoder->ip += intel_pt_insn.length;
 				return 0;
 			}
+			decoder->sample_cyc = false;
 			decoder->ip += intel_pt_insn.length;
 			if (!decoder->tnt.count) {
 				intel_pt_update_sample_time(decoder);
@@ -1515,6 +1519,9 @@ static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
 	decoder->have_cyc = true;
 
 	decoder->cycle_cnt += decoder->packet.payload;
+	if (decoder->pge)
+		decoder->tot_cyc_cnt += decoder->packet.payload;
+	decoder->sample_cyc = true;
 
 	if (!decoder->cyc_ref_timestamp)
 		return;
@@ -2419,6 +2426,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		decoder->state.err = intel_pt_ext_err(err);
 		decoder->state.from_ip = decoder->ip;
 		intel_pt_update_sample_time(decoder);
+		decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
 	} else {
 		decoder->state.err = 0;
 		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
@@ -2426,14 +2434,18 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
-		if (intel_pt_sample_time(decoder->pkt_state))
+		if (intel_pt_sample_time(decoder->pkt_state)) {
 			intel_pt_update_sample_time(decoder);
+			if (decoder->sample_cyc)
+				decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
+		}
 	}
 
 	decoder->state.timestamp = decoder->sample_timestamp;
 	decoder->state.est_timestamp = intel_pt_est_timestamp(decoder);
 	decoder->state.cr3 = decoder->cr3;
 	decoder->state.tot_insn_cnt = decoder->tot_insn_cnt;
+	decoder->state.tot_cyc_cnt = decoder->sample_tot_cyc_cnt;
 
 	return &decoder->state;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index ed088d4726ba..6a61773dc44b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -77,6 +77,7 @@ struct intel_pt_state {
 	uint64_t to_ip;
 	uint64_t cr3;
 	uint64_t tot_insn_cnt;
+	uint64_t tot_cyc_cnt;
 	uint64_t timestamp;
 	uint64_t est_timestamp;
 	uint64_t trace_nr;
-- 
2.17.1

