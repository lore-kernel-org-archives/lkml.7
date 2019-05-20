Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4860EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EC92081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfETFiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:38:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:24172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbfETFiL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:38:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 22:38:10 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 22:38:09 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 6/9] perf diff: Link same basic blocks among different data files
Date:   Mon, 20 May 2019 21:27:53 +0800
Message-Id: <1558358876-32211-7-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
References: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target is to compare the performance difference (cycles
diff) for the same basic blocks in different data files.

The same basic block means same function, same start address
and same end address. This patch finds the same basic blocks
from different data files and link them together.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 09551fe..72c33ab 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1073,8 +1073,69 @@ static int process_block_per_sym(struct data__file *d)
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
+		if (pair)
+			hist_entry__add_pair(pair, he);
+	}
+}
+
 static void basic_block_process(void)
 {
+	struct hists *hists_base = &data__files[0].block_hists.hists;
+	struct hists *hists;
 	struct data__file *d;
 	int i;
 
@@ -1085,6 +1146,11 @@ static void basic_block_process(void)
 		process_block_per_sym(d);
 	}
 
+	data__for_each_file_new(i, d) {
+		hists = &d->block_hists.hists;
+		block_hists_match(hists_base, hists);
+	}
+
 	data__for_each_file(i, d) {
 		hists__delete_entries(&d->block_hists.sym_hists);
 		hists__delete_entries(&d->block_hists.hists);
-- 
2.7.4

