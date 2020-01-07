Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B447C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBBD206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgAHG3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:29:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:23681 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgAHG3l (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:29:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 22:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="233506770"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga002.jf.intel.com with ESMTP; 07 Jan 2020 22:29:39 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/4] perf util: Move block_pair_cmp to block-info
Date:   Wed,  8 Jan 2020 07:03:51 +0800
Message-Id: <20200107230354.30132-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block_pair_cmp() is a function which is used to compare
two blocks. Moving it from builtin-diff.c to block-info.c
to let it can be used by other builtins.

 v3:
 ---
 Separate it from original patch for good tracking.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c    | 17 -----------------
 tools/perf/util/block-info.c | 17 +++++++++++++++++
 tools/perf/util/block-info.h |  2 ++
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..5ff1e21082cb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
 	bh->valid = true;
 }
 
-static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
-{
-	struct block_info *bi_a = a->block_info;
-	struct block_info *bi_b = b->block_info;
-	int cmp;
-
-	if (!bi_a->sym || !bi_b->sym)
-		return -1;
-
-	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
-
-	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
-		return 0;
-
-	return -1;
-}
-
 static struct hist_entry *get_block_pair(struct hist_entry *he,
 					 struct hists *hists_pair)
 {
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index c4b030bf6ec2..f0f38bdd496a 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -475,3 +475,20 @@ float block_info__total_cycles_percent(struct hist_entry *he)
 
 	return 0.0;
 }
+
+int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
+{
+	struct block_info *bi_a = a->block_info;
+	struct block_info *bi_b = b->block_info;
+	int cmp;
+
+	if (!bi_a->sym || !bi_b->sym)
+		return -1;
+
+	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+
+	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
+		return 0;
+
+	return -1;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index bef0d75e9819..4fa91eeae92e 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -76,4 +76,6 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 
 float block_info__total_cycles_percent(struct hist_entry *he);
 
+int block_pair_cmp(struct hist_entry *a, struct hist_entry *b);
+
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

