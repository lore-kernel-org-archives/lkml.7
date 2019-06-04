Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014AA248B9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfFDNCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfFDNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:01 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] perf intel-pt: Add reposition parameter to intel_pt_get_data()
Date:   Tue,  4 Jun 2019 16:00:05 +0300
Message-Id: <20190604130017.31207-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the decoder gets the next trace buffer, some state is reset if the
buffer is not consecutive to the previous buffer. Add a parameter
'reposition' so that can be done also to support a "fast forward" facility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 70bff7bb79f3..dde6a7a97a7a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -502,7 +502,7 @@ static void intel_pt_reposition(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 }
 
-static int intel_pt_get_data(struct intel_pt_decoder *decoder)
+static int intel_pt_get_data(struct intel_pt_decoder *decoder, bool reposition)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
 	int ret;
@@ -519,7 +519,7 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 		intel_pt_log("No more data\n");
 		return -ENODATA;
 	}
-	if (!buffer.consecutive) {
+	if (!buffer.consecutive || reposition) {
 		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
 		decoder->state.trace_nr = buffer.trace_nr;
@@ -531,10 +531,11 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 	return 0;
 }
 
-static int intel_pt_get_next_data(struct intel_pt_decoder *decoder)
+static int intel_pt_get_next_data(struct intel_pt_decoder *decoder,
+				  bool reposition)
 {
 	if (!decoder->next_buf)
-		return intel_pt_get_data(decoder);
+		return intel_pt_get_data(decoder, reposition);
 
 	decoder->buf = decoder->next_buf;
 	decoder->len = decoder->next_len;
@@ -553,7 +554,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
 	len = decoder->len;
 	memcpy(buf, decoder->buf, len);
 
-	ret = intel_pt_get_data(decoder);
+	ret = intel_pt_get_data(decoder, false);
 	if (ret) {
 		decoder->pos += old_len;
 		return ret < 0 ? ret : -EINVAL;
@@ -879,7 +880,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 		decoder->len -= decoder->pkt_step;
 
 		if (!decoder->len) {
-			ret = intel_pt_get_next_data(decoder);
+			ret = intel_pt_get_next_data(decoder, false);
 			if (ret)
 				return ret;
 		}
@@ -2369,7 +2370,7 @@ static int intel_pt_get_split_psb(struct intel_pt_decoder *decoder,
 	decoder->pos += decoder->len;
 	decoder->len = 0;
 
-	ret = intel_pt_get_next_data(decoder);
+	ret = intel_pt_get_next_data(decoder, false);
 	if (ret)
 		return ret;
 
@@ -2395,7 +2396,7 @@ static int intel_pt_scan_for_psb(struct intel_pt_decoder *decoder)
 	intel_pt_log("Scanning for PSB\n");
 	while (1) {
 		if (!decoder->len) {
-			ret = intel_pt_get_next_data(decoder);
+			ret = intel_pt_get_next_data(decoder, false);
 			if (ret)
 				return ret;
 		}
-- 
2.17.1

