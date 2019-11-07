Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93223C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694F621D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153743;
	bh=4HauTmkU2H1IrBsMQ4RhSvqdWyz3iDAG6Hl+ie0WlMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ao02VVcMhR76SXtS3Au1LLcpV8t5XXXXoyo9IrHNaxHnGoSvPaymAhh6HGdHxsMmP
	 ijPMBGqi/+Jl2pVVzZuOdhRA2YHKkloDX3exud0gQ1gCCNaRDmZlFbfRDauTEQpUyo
	 g0mAJsVyQj/EpSEyoa+gA0jz7qJPd7E9tSyU77LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfKGTJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbfKGTI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:59 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8612084D;
        Thu,  7 Nov 2019 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153739;
        bh=4HauTmkU2H1IrBsMQ4RhSvqdWyz3iDAG6Hl+ie0WlMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8ZV3SUL3EkNRtZkkH8BYbAUL+y6933DhxbvA5UKipqihtIN4S3n4DE/hQn+BOIzm
         vPSrhugyY1dhwRWMn+hiNfHrL50GTxqcgNbE63v5BeR/trBsurEI5g0t/wMuT3s7aS
         F52MM1/B+HH9j8JlXEOue4IaoKvevzOL0/1nVHHo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 57/63] perf diff: Don't use hack to skip column length calculation
Date:   Thu,  7 Nov 2019 16:00:05 -0300
Message-Id: <20191107190011.23924-58-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously we use a nasty hack to skip the hists__calc_col_len for block
since this function is not very suitable for block column length
calculation.

This patch removes the hack code and add a check at the entry of
hists__calc_col_len to skip for block case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 11 ++---------
 tools/perf/util/hist.c    |  2 ++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5281629c27b1..faf99a81ad3e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -765,13 +765,6 @@ static void block_hists_match(struct hists *hists_base,
 	}
 }
 
-static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
-{
-	/* Skip the calculation of column length in output_resort */
-	he->filtered = true;
-	return 0;
-}
-
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -820,8 +813,8 @@ static void hists__precompute(struct hists *hists)
 				if (bh->valid && pair_bh->valid) {
 					block_hists_match(&bh->block_hists,
 							  &pair_bh->block_hists);
-					hists__output_resort_cb(&pair_bh->block_hists,
-								NULL, filter_cb);
+					hists__output_resort(&pair_bh->block_hists,
+							     NULL);
 				}
 				break;
 			default:
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..daa6eef4fde0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -80,6 +80,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	int symlen;
 	u16 len;
 
+	if (h->block_info)
+		return;
 	/*
 	 * +4 accounts for '[x] ' priv level info
 	 * +2 accounts for 0x prefix on raw addresses
-- 
2.21.0

