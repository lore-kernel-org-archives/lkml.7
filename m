Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A532CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BDB2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfJ3GFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:05:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:63903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3GFm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:05:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="225217042"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2019 23:05:40 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 1/7] perf diff: Don't use hack to skip column length calculation
Date:   Wed, 30 Oct 2019 14:04:24 +0800
Message-Id: <20191030060430.23558-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030060430.23558-1-yao.jin@linux.intel.com>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we use a nasty hack to skip the hists__calc_col_len for
block since this function is not very suitable for block column
length calculation.

This patch removes the hack code and add a check at the entry of
hists__calc_col_len to skip for block case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
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
2.17.1

