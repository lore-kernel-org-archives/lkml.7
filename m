Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC33C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EEF2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfEJMl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:41:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:51358 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfEJMly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:41:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 05:41:54 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 05:41:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf intel-pt: Fix instructions sampling rate
Date:   Fri, 10 May 2019 15:41:41 +0300
Message-Id: <20190510124143.27054-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510124143.27054-1-adrian.hunter@intel.com>
References: <20190510124143.27054-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timestamp used to determine if an instruction sample is made, is an
estimate based on the number of instructions since the last known
timestamp. A consequence is that it might go backwards, which results in
extra samples. Change it so that a sample is only made when the timestamp
goes forwards.

Note this does not affect a sampling period of 0 or sampling periods
specified as a count of instructions.

Example:

 Before:

 $ perf script --itrace=i10us
 ls 13812 [003] 2167315.222583:       3270 instructions:u:      7fac71e2e494 __GI___tunables_init+0xf4 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:      30902 instructions:u:      7fac71e2da0f _dl_cache_libcmp+0x2f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         10 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          8 instructions:u:      7fac71e2d9ea _dl_cache_libcmp+0xa (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         14 instructions:u:      7fac71e2d9ea _dl_cache_libcmp+0xa (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          6 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:         14 instructions:u:      7fac71e2d9ff _dl_cache_libcmp+0x1f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:          4 instructions:u:      7fac71e2dab2 _dl_cache_libcmp+0xd2 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222728:      16423 instructions:u:      7fac71e2477a _dl_map_object_deps+0x1ba (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222734:      12731 instructions:u:      7fac71e27938 _dl_name_match_p+0x68 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ...

 After:
 $ perf script --itrace=i10us
 ls 13812 [003] 2167315.222583:       3270 instructions:u:      7fac71e2e494 __GI___tunables_init+0xf4 (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222667:      30902 instructions:u:      7fac71e2da0f _dl_cache_libcmp+0x2f (/lib/x86_64-linux-gnu/ld-2.28.so)
 ls 13812 [003] 2167315.222728:      16479 instructions:u:      7fac71e2477a _dl_map_object_deps+0x1ba (/lib/x86_64-linux-gnu/ld-2.28.so)
 ...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: f4aa081949e7b ("perf tools: Add Intel PT decoder")
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 872fab163585..26dbf11e071a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -888,16 +888,20 @@ static uint64_t intel_pt_next_period(struct intel_pt_decoder *decoder)
 	timestamp = decoder->timestamp + decoder->timestamp_insn_cnt;
 	masked_timestamp = timestamp & decoder->period_mask;
 	if (decoder->continuous_period) {
-		if (masked_timestamp != decoder->last_masked_timestamp)
+		if (masked_timestamp > decoder->last_masked_timestamp)
 			return 1;
 	} else {
 		timestamp += 1;
 		masked_timestamp = timestamp & decoder->period_mask;
-		if (masked_timestamp != decoder->last_masked_timestamp) {
+		if (masked_timestamp > decoder->last_masked_timestamp) {
 			decoder->last_masked_timestamp = masked_timestamp;
 			decoder->continuous_period = true;
 		}
 	}
+
+	if (masked_timestamp < decoder->last_masked_timestamp)
+		return decoder->period_ticks;
+
 	return decoder->period_ticks - (timestamp - masked_timestamp);
 }
 
@@ -926,7 +930,10 @@ static void intel_pt_sample_insn(struct intel_pt_decoder *decoder)
 	case INTEL_PT_PERIOD_TICKS:
 		timestamp = decoder->timestamp + decoder->timestamp_insn_cnt;
 		masked_timestamp = timestamp & decoder->period_mask;
-		decoder->last_masked_timestamp = masked_timestamp;
+		if (masked_timestamp > decoder->last_masked_timestamp)
+			decoder->last_masked_timestamp = masked_timestamp;
+		else
+			decoder->last_masked_timestamp += decoder->period_ticks;
 		break;
 	case INTEL_PT_PERIOD_NONE:
 	case INTEL_PT_PERIOD_MTC:
-- 
2.17.1

