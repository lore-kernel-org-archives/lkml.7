Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C0DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8393F20862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfETLhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:37:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733038AbfETLhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:47 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/22] perf intel-pt: Factor out intel_pt_update_sample_time
Date:   Mon, 20 May 2019 14:37:10 +0300
Message-Id: <20190520113728.14389-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To eliminate some duplication and make the code more understandable, factor
out intel_pt_update_sample_time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f4c3c84b090f..1ab4070b5633 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -479,6 +479,12 @@ static int intel_pt_bad_packet(struct intel_pt_decoder *decoder)
 	return -EBADMSG;
 }
 
+static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
+{
+	decoder->sample_timestamp = decoder->timestamp;
+	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+}
+
 static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
@@ -1319,8 +1325,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 			}
 			decoder->ip += intel_pt_insn.length;
 			if (!decoder->tnt.count) {
-				decoder->sample_timestamp = decoder->timestamp;
-				decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+				intel_pt_update_sample_time(decoder);
 				return -EAGAIN;
 			}
 			decoder->tnt.payload <<= 1;
@@ -2413,8 +2418,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 	if (err) {
 		decoder->state.err = intel_pt_ext_err(err);
 		decoder->state.from_ip = decoder->ip;
-		decoder->sample_timestamp = decoder->timestamp;
-		decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+		intel_pt_update_sample_time(decoder);
 	} else {
 		decoder->state.err = 0;
 		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
@@ -2422,10 +2426,8 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
-		if (intel_pt_sample_time(decoder->pkt_state)) {
-			decoder->sample_timestamp = decoder->timestamp;
-			decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
-		}
+		if (intel_pt_sample_time(decoder->pkt_state))
+			intel_pt_update_sample_time(decoder);
 	}
 
 	decoder->state.timestamp = decoder->sample_timestamp;
-- 
2.17.1

