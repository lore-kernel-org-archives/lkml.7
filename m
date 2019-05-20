Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED25DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2FE20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfETLiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733099AbfETLhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:55 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/22] perf intel-pt: Record when decoding PSB+ packets
Date:   Mon, 20 May 2019 14:37:15 +0300
Message-Id: <20190520113728.14389-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using MTC packets to count cycles, record whether
decoding is between a PSB and PSBEND packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ef3a1c1cd250..a2384a314990 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -116,6 +116,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	bool in_psb;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -1549,14 +1550,17 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_TIP_PGD:
 		case INTEL_PT_TIP_PGE:
@@ -1574,10 +1578,12 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			decoder->have_tma = false;
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -EAGAIN;
+			err = -EAGAIN;
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_TSC:
 			intel_pt_calc_tsc_timestamp(decoder);
@@ -1623,6 +1629,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
@@ -1996,10 +2006,12 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
@@ -2015,7 +2027,8 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_FUP:
 			decoder->pge = true;
@@ -2074,16 +2087,20 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 				decoder->pkt_state = INTEL_PT_STATE_ERR4;
 			else
 				decoder->pkt_state = INTEL_PT_STATE_ERR3;
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_BAD: /* Does not happen */
-			return intel_pt_bug(decoder);
+			err = intel_pt_bug(decoder);
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_PSB:
 		case INTEL_PT_VMCS:
@@ -2093,6 +2110,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
-- 
2.17.1

