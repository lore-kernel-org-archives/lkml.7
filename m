Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75841C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DCD2063F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139531;
	bh=h7fgKKfrivNK8f7FnPMgbvqn3LZEGqUSiiAe1OtLPrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrRgeSyGZkFPE7DZgjDNTRiFPemkelMB5hV3dy2YAXqL4cXavpbBLaQBWvZY9T0ZT
	 IjtNri5Q42VLXE9HrifBsfIgNnDwTYQm8/UlcssvDopbu8UfaPATRc1qZpxDUBnO4r
	 EZiO5phouQedLbEWajQIKwUxpbKxA/tSEzN8HzJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfDARZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732410AbfDARZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4A620830;
        Mon,  1 Apr 2019 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139525;
        bh=h7fgKKfrivNK8f7FnPMgbvqn3LZEGqUSiiAe1OtLPrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrlR1DpvVIwvLKnzNj7XT070W1qGx3i8j+nXVjbfSxKXdPtT0FeadfsbwsJCUIKb1
         WC/WkSeGJb6H9y02XlpMMvHmVyG3CbLeLQVQVuxUX2EF0lQ4p+4txjzLs6aJ5AZ/4R
         mrCPSzq/4i2GxYvkS2SuojZhNwHBNBIDzA44Ap0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.14 101/107] perf intel-pt: Fix TSC slip
Date:   Mon,  1 Apr 2019 19:02:56 +0200
Message-Id: <20190401170054.872417463@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


