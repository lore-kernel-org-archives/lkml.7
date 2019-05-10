Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987FDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E8320989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfEJMmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:42:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:51358 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfEJMl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:41:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 05:41:58 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 05:41:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf intel-pt: Fix sample timestamp wrt non-taken branches
Date:   Fri, 10 May 2019 15:41:43 +0300
Message-Id: <20190510124143.27054-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510124143.27054-1-adrian.hunter@intel.com>
References: <20190510124143.27054-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sample timestamp is updated to ensure that the timestamp represents
the time of the sample and not a branch that the decoder is still
walking towards. The sample timestamp is updated when the decoder
returns, but the decoder does not return for non-taken branches. Update
the sample timestamp then also.

Note that commit 3f04d98e972b5 ("perf intel-pt: Improve sample timestamp")
was also a stable fix and appears, for example, in v4.4 stable tree as
commit a4ebb58fd124 ("perf intel-pt: Improve sample timestamp").

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 3f04d98e972b ("perf intel-pt: Improve sample timestamp")
Cc: stable@vger.kernel.org # v4.4+
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 9cbd587489bf..f4c3c84b090f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1318,8 +1318,11 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 				return 0;
 			}
 			decoder->ip += intel_pt_insn.length;
-			if (!decoder->tnt.count)
+			if (!decoder->tnt.count) {
+				decoder->sample_timestamp = decoder->timestamp;
+				decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
 				return -EAGAIN;
+			}
 			decoder->tnt.payload <<= 1;
 			continue;
 		}
-- 
2.17.1

