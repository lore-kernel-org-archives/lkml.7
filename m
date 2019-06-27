Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26AC48BDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC8C2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfF0GUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:20:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:39130 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfF0GUI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:20:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="156135547"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 23:20:06 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 5/7] perf diff: Link same basic blocks among different data
Date:   Thu, 27 Jun 2019 22:09:27 +0800
Message-Id: <1561644569-22306-6-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target is to compare the performance difference (cycles
diff) for the same basic blocks in different data files.

The same basic block means same function, same start address
and same end address. This patch finds the same basic blocks
from different data files and link them together and resort
by the cycles diff.

 v3:
 ---
 The block stuffs are maintained by new structure 'block_hist',
 so this patch is update accordingly.

 v2:
 ---
 Since now the basic block hists is changed to per symbol,
 the patch only links the basic block hists for the same
 symbol in different data files.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ff2c076..864423a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -641,6 +641,85 @@ static int process_block_per_sym(struct hist_entry *he)
 	return 0;
 }
 
+static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
+{
+	struct block_info *bi_a = a->block_info;
+	struct block_info *bi_b = b->block_info;
+	int cmp;
+
+	if (!bi_a->sym || !bi_b->sym)
+		return -1;
+
+	if (bi_a->sym->name && bi_b->sym->name) {
+		cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+		if ((!cmp) && (bi_a->start == bi_b->start) &&
+		    (bi_a->end == bi_b->end)) {
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static struct hist_entry *get_block_pair(struct hist_entry *he,
+					 struct hists *hists_pair)
+{
+	struct rb_root_cached *root = hists_pair->entries_in;
+	struct rb_node *next = rb_first_cached(root);
+	int cmp;
+
+	while (next != NULL) {
+		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
+						      rb_node_in);
+
+		next = rb_next(&he_pair->rb_node_in);
+
+		cmp = block_pair_cmp(he_pair, he);
+		if (!cmp)
+			return he_pair;
+	}
+
+	return NULL;
+}
+
+static void compute_cycles_diff(struct hist_entry *he,
+				struct hist_entry *pair)
+{
+	pair->diff.computed = true;
+	if (pair->block_info->num && he->block_info->num) {
+		pair->diff.cycles =
+			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
+			he->block_info->cycles_aggr / he->block_info->num_aggr;
+	}
+}
+
+static void block_hists_match(struct hists *hists_base,
+			      struct hists *hists_pair)
+{
+	struct rb_root_cached *root = hists_base->entries_in;
+	struct rb_node *next = rb_first_cached(root);
+
+	while (next != NULL) {
+		struct hist_entry *he = rb_entry(next, struct hist_entry,
+						 rb_node_in);
+		struct hist_entry *pair = get_block_pair(he, hists_pair);
+
+		next = rb_next(&he->rb_node_in);
+
+		if (pair) {
+			hist_entry__add_pair(pair, he);
+			compute_cycles_diff(he, pair);
+		}
+	}
+}
+
+static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
+{
+	/* Skip the calculation of column length in output_resort */
+	he->filtered = true;
+	return 0;
+}
+
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -653,6 +732,7 @@ static void hists__precompute(struct hists *hists)
 
 	next = rb_first_cached(root);
 	while (next != NULL) {
+		struct block_hist *bh, *pair_bh;
 		struct hist_entry *he, *pair;
 		struct data__file *d;
 		int i;
@@ -681,6 +761,16 @@ static void hists__precompute(struct hists *hists)
 				break;
 			case COMPUTE_CYCLES:
 				process_block_per_sym(pair);
+				bh = container_of(he, struct block_hist, he);
+				pair_bh = container_of(pair, struct block_hist,
+						       he);
+
+				if (bh->valid && pair_bh->valid) {
+					block_hists_match(&bh->block_hists,
+							  &pair_bh->block_hists);
+					hists__output_resort_cb(&pair_bh->block_hists,
+								NULL, filter_cb);
+				}
 				break;
 			default:
 				BUG_ON(1);
-- 
2.7.4

