Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77071C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BC221851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279613;
	bh=gmvtI42QXE3toSRixxmr8BNV9iYSxU4eZF95oUW1sic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/2ZTQaUYuGvXtS85NBDSZWzIqT6dt20I4+Yh30W/Z0xfdjOy9LzaWZxj4ORL5xc3
	 HMoj93VMIB0YYGlPpi4YxwOuoKgRijc1PhsZBgKUrtRn+1JoRiWzDK8tzFj/oL83PA
	 rn9fCnwifLkSYsMcYeVz9PiNduqtxooulJ5l+E4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407168AbfFKTAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKTAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E122421871;
        Tue, 11 Jun 2019 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279610;
        bh=gmvtI42QXE3toSRixxmr8BNV9iYSxU4eZF95oUW1sic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJFylStSM+qnYQzNOMCP1EUiEs/Td8WMQhR1hZvxrAfmiyhcQQSwP/LUvAfi6R4W0
         ZJ/IoiUagAmVz/37rqoIO597FtQN7zAdGlp4NflqixnwUBI54FtF+9J8YwS/qPavb4
         +7rxjPsf0bqUqrt8i9ZIw/P0K4C7AVP/z1xmgRvM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/85] perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
Date:   Tue, 11 Jun 2019 15:58:00 -0300
Message-Id: <20190611185911.11645-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When CYC packets are not available, it is still possible to count cycles
using TSC/TMA/MTC timestamps.

As the timestamp increments in TSC ticks, convert to CPU cycles using
the current core-to-bus ratio.

Do not accumulate cycles when control flow packet generation is not
enabled, nor when time has been "lost", typically due to mwait, which is
indicated by a TSC/TMA packet that is not part of PSB+.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

