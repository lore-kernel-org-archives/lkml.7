Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D957FC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B757524591
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfFCGqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:46:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:39148 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfFCGqd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:46:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 23:46:33 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 23:46:31 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 5/7] perf diff: Link same basic blocks among different data files
Date:   Mon,  3 Jun 2019 22:36:15 +0800
Message-Id: <1559572577-25436-6-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
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

 v2:
 ---
 Since now the basic block hists is changed to per symbol,
 the patch only links the basic block hists for the same
 symbol in different data files.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/hist.c    |  2 +-
 tools/perf/util/sort.h    |  1 +
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 310ba2a..b50ed70 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -645,6 +645,84 @@ static int process_block_per_sym(struct hist_entry *he, struct data__file *d)
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
+	he->not_collen = true;
+	return 0;
+}
+
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -659,13 +737,19 @@ static void hists__precompute(struct hists *hists)
 	while (next != NULL) {
 		struct hist_entry *he, *pair;
 		struct data__file *d;
+		struct block_hists *b;
+		struct block_hists *p;
 		int i;
 
 		he   = rb_entry(next, struct hist_entry, rb_node_in);
 		next = rb_next(&he->rb_node_in);
 
-		if (compute == COMPUTE_CYCLES)
+		if (compute == COMPUTE_CYCLES) {
 			process_block_per_sym(he, &data__files[0]);
+			b = he->block_hists;
+			if (b)
+				he->block_num = b->hists.nr_entries;
+		}
 
 		data__for_each_file_new(i, d) {
 			pair = get_pair_data(he, d);
@@ -685,6 +769,13 @@ static void hists__precompute(struct hists *hists)
 				break;
 			case COMPUTE_CYCLES:
 				process_block_per_sym(pair, d);
+				b = he->block_hists;
+				p = pair->block_hists;
+				if (b && p) {
+					block_hists_match(&b->hists, &p->hists);
+					hists__output_resort_cb(&p->hists, NULL,
+								filter_cb);
+				}
 				break;
 			default:
 				BUG_ON(1);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 680ad93..10ab45a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1846,7 +1846,7 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 		__hists__insert_output_entry(&hists->entries, n, min_callchain_hits, use_callchain);
 		hists__inc_stats(hists, n);
 
-		if (!n->filtered)
+		if ((!n->filtered) && (!n->not_collen))
 			hists__calc_col_len(hists, n);
 
 		if (prog)
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d1641da..1b9752d 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -122,6 +122,7 @@ struct hist_entry {
 
 	char			level;
 	u8			filtered;
+	bool			not_collen;
 
 	u16			callchain_size;
 	union {
-- 
2.7.4

