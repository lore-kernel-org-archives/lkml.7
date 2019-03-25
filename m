Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A5AC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDCA20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfCYNwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:52:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:16341 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCYNwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:52:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="154972584"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2019 06:52:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] perf intel-pt: Fix TSC slip
Date:   Mon, 25 Mar 2019 15:51:35 +0200
Message-Id: <20190325135135.18348-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A TSC packet can slip past MTC packets so that the timestamp appears to go
backwards. One estimate is that can be up to about 40 CPU cycles, which is
certainly less than 0x1000 TSC ticks, but accept slippage an order of
magnitude more to be on the safe side.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 79b58424b821c ("perf tools: Add Intel PT support for decoding MTC packets")
Cc: stable@vger.kernel.org
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 6e03db142091..872fab163585 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -251,19 +251,15 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 		if (!(decoder->tsc_ctc_ratio_n % decoder->tsc_ctc_ratio_d))
 			decoder->tsc_ctc_mult = decoder->tsc_ctc_ratio_n /
 						decoder->tsc_ctc_ratio_d;
-
-		/*
-		 * Allow for timestamps appearing to backwards because a TSC
-		 * packet has slipped past a MTC packet, so allow 2 MTC ticks
-		 * or ...
-		 */
-		decoder->tsc_slip = multdiv(2 << decoder->mtc_shift,
-					decoder->tsc_ctc_ratio_n,
-					decoder->tsc_ctc_ratio_d);
 	}
-	/* ... or 0x100 paranoia */
-	if (decoder->tsc_slip < 0x100)
-		decoder->tsc_slip = 0x100;
+
+	/*
+	 * A TSC packet can slip past MTC packets so that the timestamp appears
+	 * to go backwards. One estimate is that can be up to about 40 CPU
+	 * cycles, which is certainly less than 0x1000 TSC ticks, but accept
+	 * slippage an order of magnitude more to be on the safe side.
+	 */
+	decoder->tsc_slip = 0x10000;
 
 	intel_pt_log("timestamp: mtc_shift %u\n", decoder->mtc_shift);
 	intel_pt_log("timestamp: tsc_ctc_ratio_n %u\n", decoder->tsc_ctc_ratio_n);
-- 
2.17.1

