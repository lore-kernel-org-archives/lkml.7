Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EDAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A8921852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139186;
	bh=NG9vAxxYKSU/x+s+QLEQdi1P2/5YUpvQgB2pALodnP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=To/R4dAPdtTgBQSE82k1AbA5K1WSb9Xl92XgTRIAXHQMv8CoX/EVjCwz9vOL1uR+a
	 53rf/va9BMhgycFu5sttwcdDfmddqbA5jfHHuNx7yFk25FvIWxXR21wcXTKTVqszMt
	 iQGhd2h1maA+C8FwZHBRvRdt75osExvBiNB5heow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfDARTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731139AbfDARTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF2521473;
        Mon,  1 Apr 2019 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139181;
        bh=NG9vAxxYKSU/x+s+QLEQdi1P2/5YUpvQgB2pALodnP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYU2YLOmPMrj2jz9usZml0IlJKLrDLXnoowZoiRv0/5vAle2qUFJaw2dvEj8nvteu
         ctzhkS1by2Ch2S7+Zr3G90cy+l18CksH9ottfAI4nw3Rz5WKuu/DNLdOYLbdsKvTl5
         bKu26jGG67zS00Y/1CYRPOh3LUuZyEE6yGYF3Vss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 116/134] perf intel-pt: Fix TSC slip
Date:   Mon,  1 Apr 2019 19:02:32 +0200
Message-Id: <20190401170055.136710059@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit f3b4e06b3bda759afd042d3d5fa86bea8f1fe278 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -251,19 +251,15 @@ struct intel_pt_decoder *intel_pt_decode
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


