Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F91AC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF2248B9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfFDNCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfFDNB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:01:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:01:58 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:01:56 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] perf intel-pt: Factor out intel_pt_8b_tsc()
Date:   Tue,  4 Jun 2019 16:00:03 +0300
Message-Id: <20190604130017.31207-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out intel_pt_8b_tsc() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 13123b195083..c06dceb774e9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1369,6 +1369,21 @@ static int intel_pt_mode_tsx(struct intel_pt_decoder *decoder, bool *no_tip)
 	return 0;
 }
 
+static uint64_t intel_pt_8b_tsc(uint64_t timestamp, uint64_t ref_timestamp)
+{
+	timestamp |= (ref_timestamp & (0xffULL << 56));
+
+	if (timestamp < ref_timestamp) {
+		if (ref_timestamp - timestamp > (1ULL << 55))
+			timestamp += (1ULL << 56);
+	} else {
+		if (timestamp - ref_timestamp > (1ULL << 55))
+			timestamp -= (1ULL << 56);
+	}
+
+	return timestamp;
+}
+
 static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 {
 	uint64_t timestamp;
@@ -1376,15 +1391,8 @@ static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 
 	if (decoder->ref_timestamp) {
-		timestamp = decoder->packet.payload |
-			    (decoder->ref_timestamp & (0xffULL << 56));
-		if (timestamp < decoder->ref_timestamp) {
-			if (decoder->ref_timestamp - timestamp > (1ULL << 55))
-				timestamp += (1ULL << 56);
-		} else {
-			if (timestamp - decoder->ref_timestamp > (1ULL << 55))
-				timestamp -= (1ULL << 56);
-		}
+		timestamp = intel_pt_8b_tsc(decoder->packet.payload,
+					    decoder->ref_timestamp);
 		decoder->tsc_timestamp = timestamp;
 		decoder->timestamp = timestamp;
 		decoder->ref_timestamp = 0;
-- 
2.17.1

