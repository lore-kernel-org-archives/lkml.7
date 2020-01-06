Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9140AC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D57620715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAGDLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:11:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:30988 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgAGDLR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:11:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 19:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="217009574"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jan 2020 19:11:15 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/3] perf util: Move block_pair_cmp to block-info
Date:   Tue,  7 Jan 2020 03:45:23 +0800
Message-Id: <20200106194525.12228-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block_pair_cmp() is a function which is used to compare
two blocks. Moving it from builtin-diff.c to block-info.c
to let it be used by other builtins.

In block_pair_cmp, there is a minor change. It checks valid
for map, dso and sym first. If they are invalid, we will not
compare the address because the address might not make sense.

 v2:
 ---
 New patch created in v2

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c    | 17 -----------------
 tools/perf/util/block-info.c | 23 +++++++++++++++++++++++
 tools/perf/util/block-info.h |  2 ++
 3 files changed, 25 insertions(+), 17 deletions(-)

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
index c4b030bf6ec2..18a445938681 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -475,3 +475,26 @@ float block_info__total_cycles_percent(struct hist_entry *he)
 
 	return 0.0;
 }
+
+int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he)
+{
+	struct block_info *bi_p = pair->block_info;
+	struct block_info *bi_h = he->block_info;
+	struct map_symbol *ms_p = &pair->ms;
+	struct map_symbol *ms_h = &he->ms;
+	int cmp;
+
+	if (!ms_p->map || !ms_p->map->dso || !ms_p->sym ||
+	    !ms_h->map || !ms_h->map->dso || !ms_h->sym) {
+		return -1;
+	}
+
+	cmp = strcmp(ms_p->sym->name, ms_h->sym->name);
+	if (cmp)
+		return -1;
+
+	if ((bi_p->start == bi_h->start) && (bi_p->end == bi_h->end))
+		return 0;
+
+	return -1;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index bef0d75e9819..bfa22c59195d 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -76,4 +76,6 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 
 float block_info__total_cycles_percent(struct hist_entry *he);
 
+int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he);
+
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

