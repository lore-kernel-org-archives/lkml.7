Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9DB2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfC2Uf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:35:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfC2Uf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:35:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKZJWg3937454
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:35:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKZHUl3937448;
        Fri, 29 Mar 2019 13:35:17 -0700
Date:   Fri, 29 Mar 2019 13:35:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f3b4e06b3bda759afd042d3d5fa86bea8f1fe278@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@redhat.com, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20190325135135.18348-1-adrian.hunter@intel.com>
References: <20190325135135.18348-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Fix TSC slip
Git-Commit-ID: f3b4e06b3bda759afd042d3d5fa86bea8f1fe278
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

Commit-ID:  f3b4e06b3bda759afd042d3d5fa86bea8f1fe278
Gitweb:     https://git.kernel.org/tip/f3b4e06b3bda759afd042d3d5fa86bea8f1fe278
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 25 Mar 2019 15:51:35 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:31:55 -0300

perf intel-pt: Fix TSC slip

A TSC packet can slip past MTC packets so that the timestamp appears to
go backwards. One estimate is that can be up to about 40 CPU cycles,
which is certainly less than 0x1000 TSC ticks, but accept slippage an
order of magnitude more to be on the safe side.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 79b58424b821c ("perf tools: Add Intel PT support for decoding MTC packets")
Link: http://lkml.kernel.org/r/20190325135135.18348-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 20 ++++++++------------
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
