Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9553FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCDC2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q8hbAwYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfFQTEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:04:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:04:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ44AK3555360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:04:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ44AK3555360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798245;
        bh=+I7MRD6ZoPKOj8pKwcV+haYZfA04nZmos5a2GJeH0JU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Q8hbAwYXv6KX+PnlnIGYtWg95bqX3wybMz2AB1M2BEI7AG4clLNIRQ8w2P9F3bcsp
         eKZsCqk1HR2QlZwLRFhDhsA3U8zL0JOjSzNAN0tVWrTlcuv9ISc5eaG6zoukTJkQrR
         M1iaOJsxvCvWgnXlXsOl1q3nSRVwR2fMsKwctBGPFj966/RcIfnaq83BFhXRdhmL8+
         qdzrGgXRUNvffLwvTocTtCZJ3KG3Ow0oztzPNRjRJT92kcDIUYnWe/4BMT1tE0a+x8
         lfrvbmyyXK5OI8ZBZoz7hoGliw34/sE7cZg5TLflM+HM4aqari4mzn50+PNdtJ3QBR
         QgOwIp73mEfbA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ44PH3555347;
        Mon, 17 Jun 2019 12:04:04 -0700
Date:   Mon, 17 Jun 2019 12:04:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-3f05516758bef438cef7adc47599f8b8faad7c3a@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, jolsa@redhat.com,
        acme@redhat.com
Reply-To: acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
          adrian.hunter@intel.com
In-Reply-To: <20190520113728.14389-12-adrian.hunter@intel.com>
References: <20190520113728.14389-12-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Accumulate cycle count from
 TSC/TMA/MTC packets
Git-Commit-ID: 3f05516758bef438cef7adc47599f8b8faad7c3a
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

Commit-ID:  3f05516758bef438cef7adc47599f8b8faad7c3a
Gitweb:     https://git.kernel.org/tip/3f05516758bef438cef7adc47599f8b8faad7c3a
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:17 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:56 -0300

perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets

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
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 51 ++++++++++++++++++++++
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
@@ -1776,6 +1825,7 @@ next:
 
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
