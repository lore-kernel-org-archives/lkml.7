Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18079C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ADB208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="D7czRxN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfFQTAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:00:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:00:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIxr403554106
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:59:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIxr403554106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797993;
        bh=AdWGzLrvMBjUrfUtppcPJ8CSxypUpMmqKAy724o9P6M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=D7czRxN6p8ALVS9mq2lz18XZZjapj3vja1jFL/tqj5xGRLFy/O3hwc6t4Wsi8ocSN
         EWqzt2LHmV46s/ThaYykgUA+vbfta5AVECd/ecjKV9RzKXvptGq2ESzfsfqpG562WQ
         z/RKmzIDUxufQrFNHKbByw6niN/0Axxk413hSTzwVyWuXiTOiC7mHCJts226PcfJ16
         VFEa5jYlRMt81FoGD9IP+BeR/iWPrETYvQ9kEUyiLPkQSjKqG6P4WF+j/u1+B4DbTw
         ApokzsAQ2mdcdZDV+B8RF2Qo6aenThcUKPmCyp6PUyQeziOZ1LmfD3TCHFcilCMvUR
         BkvvilKLCjaPw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIxrUW3554103;
        Mon, 17 Jun 2019 11:59:53 -0700
Date:   Mon, 17 Jun 2019 11:59:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-7b4b4f83881e11b1fe5d8743953f81addb0871de@git.kernel.org>
Cc:     adrian.hunter@intel.com, jolsa@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: jolsa@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190520113728.14389-6-adrian.hunter@intel.com>
References: <20190520113728.14389-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Accumulate cycle count from CYC
 packets
Git-Commit-ID: 7b4b4f83881e11b1fe5d8743953f81addb0871de
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

Commit-ID:  7b4b4f83881e11b1fe5d8743953f81addb0871de
Gitweb:     https://git.kernel.org/tip/7b4b4f83881e11b1fe5d8743953f81addb0871de
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:11 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:54 -0300

perf intel-pt: Accumulate cycle count from CYC packets

In preparation for providing instructions-per-cycle (IPC) information,
accumulate cycle count from CYC packets.

Although CYC packets are optional (requires config term 'cyc' to enable
cycle-accurate mode when recording), the simplest way to count cycles is
with CYC packets.

The first complication is that cycles must be counted only when also
counting instructions.

That means when control flow packet generation is enabled i.e. between
TIP.PGE and TIP.PGD packets.

Also, sampling the cycle count follows the same rules as sampling the
timestamp, that is, not before the instruction to which the decoder is
walking is reached.

In addition, the cycle count is not accurate for any but the first
branch of a TNT packet.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 14 +++++++++++++-
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |  1 +
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
