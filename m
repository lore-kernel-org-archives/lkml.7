Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33590C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018A220851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfETFid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:38:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:24172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbfETFiJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:38:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 22:38:09 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 22:38:07 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 5/9] perf diff: Use hists to manage basic blocks
Date:   Mon, 20 May 2019 21:27:52 +0800
Message-Id: <1558358876-32211-6-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
References: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hist__account_cycles() can account cycles per basic
block. The basic block information are saved in a per-symbol
cycles_hist structure.

This patch processes each symbol, get basic blocks from cycles_hist
and add the basic block entry to a hists. Using a hists is because
we need to compare, sort and print the basic blocks.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e067ac6..09551fe 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -20,6 +20,7 @@
 #include "util/data.h"
 #include "util/config.h"
 #include "util/time-utils.h"
+#include "util/annotate.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -30,6 +31,9 @@ struct block_hists {
 	struct hists		sym_hists;
 	struct perf_hpp_list	sym_list;
 	struct perf_hpp_fmt	sym_fmt;
+	struct hists		hists;
+	struct perf_hpp_list	list;
+	struct perf_hpp_fmt	fmt;
 };
 
 struct perf_diff {
@@ -73,6 +77,8 @@ struct data__file {
 	struct block_hists       block_hists;
 };
 
+static struct addr_location dummy_al;
+
 static struct data__file *data__files;
 static int data__files_cnt;
 
@@ -378,6 +384,7 @@ static int diff__process_sample_event(struct perf_tool *tool,
 			pr_warning("problem counting symbol for basic block\n");
 			goto out_put;
 		}
+		hist__account_cycles(sample->branch_stack, &al, sample, false);
 	} else {
 		if (!hists__add_entry(hists, &al, NULL, NULL, NULL,
 				      sample, true)) {
@@ -938,13 +945,149 @@ static int block_sym_hists_init(struct block_hists *hists)
 	return 0;
 }
 
+static int64_t block_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			 struct hist_entry *left, struct hist_entry *right)
+{
+	struct block_info *bi_l = left->block_info;
+	struct block_info *bi_r = right->block_info;
+	int cmp;
+
+	if (!bi_l->sym || !bi_r->sym) {
+		if (!bi_l->sym && !bi_r->sym)
+			return 0;
+		else if (!bi_l->sym)
+			return -1;
+		else
+			return 1;
+	}
+
+	if (bi_l->sym == bi_r->sym) {
+		if (bi_l->start == bi_r->start) {
+			if (bi_l->end == bi_r->end)
+				return 0;
+			else
+				return (int64_t)(bi_r->end - bi_l->end);
+		} else
+			return (int64_t)(bi_r->start - bi_l->start);
+	} else {
+		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+		return cmp;
+	}
+
+	if (bi_l->sym->start != bi_r->sym->start)
+		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
+
+	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
+}
+
+static int block_hists_init(struct block_hists *hists)
+{
+	struct perf_hpp_fmt *fmt;
+
+	__hists__init(&hists->hists, &hists->list);
+	perf_hpp_list__init(&hists->list);
+	fmt = &hists->fmt;
+	INIT_LIST_HEAD(&fmt->list);
+	INIT_LIST_HEAD(&fmt->sort_list);
+
+	fmt->cmp = block_cmp;
+
+	perf_hpp_list__register_sort_field(&hists->list, fmt);
+	return 0;
+}
+
+static void *block_he_zalloc(size_t size)
+{
+	return zalloc(size + sizeof(struct hist_entry));
+}
+
+static void block_he_free(void *he)
+{
+	struct block_info *bi = ((struct hist_entry *)he)->block_info;
+
+	block_info__put(bi);
+	free(he);
+}
+
+struct hist_entry_ops block_he_ops = {
+	.new	= block_he_zalloc,
+	.free	= block_he_free,
+};
+
+static void init_block_info(struct block_info *bi, struct symbol *sym,
+			    struct cyc_hist *ch, int offset)
+{
+	bi->sym = sym;
+	bi->start = ch->start;
+	bi->end = offset;
+	bi->cycles = ch->cycles;
+	bi->cycles_aggr = ch->cycles_aggr;
+	bi->num = ch->num;
+	bi->num_aggr = ch->num_aggr;
+}
+
+static int process_block_per_sym(struct data__file *d)
+{
+	struct hists *hists = &d->block_hists.sym_hists;
+	struct rb_root_cached *root = hists->entries_in;
+	struct rb_node *next = rb_first_cached(root);
+	struct annotation *notes;
+	struct cyc_hist *ch;
+	unsigned int i;
+	struct block_info *bi;
+	struct hist_entry *he, *he_block;
+
+	while (next != NULL) {
+		he = rb_entry(next, struct hist_entry, rb_node_in);
+		next = rb_next(&he->rb_node_in);
+
+		if (!he->ms.map || !he->ms.sym)
+			continue;
+
+		notes = symbol__annotation(he->ms.sym);
+		if (!notes || !notes->src || !notes->src->cycles_hist)
+			continue;
+
+		ch = notes->src->cycles_hist;
+
+		for (i = 0; i < symbol__size(he->ms.sym); i++) {
+			if (ch[i].num_aggr) {
+				bi = block_info__new();
+				if (!bi)
+					return -ENOMEM;
+
+				init_block_info(bi, he->ms.sym, &ch[i], i);
+
+				he_block = hists__add_entry_block(
+							&d->block_hists.hists,
+							&block_he_ops,
+							&dummy_al, bi);
+				if (!he_block) {
+					block_info__put(bi);
+					return -ENOMEM;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 static void basic_block_process(void)
 {
 	struct data__file *d;
 	int i;
 
+	memset(&dummy_al, 0, sizeof(dummy_al));
+
+	data__for_each_file(i, d) {
+		block_hists_init(&d->block_hists);
+		process_block_per_sym(d);
+	}
+
 	data__for_each_file(i, d) {
 		hists__delete_entries(&d->block_hists.sym_hists);
+		hists__delete_entries(&d->block_hists.hists);
 	}
 }
 
@@ -1575,6 +1718,8 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	symbol__annotation_init();
+
 	if (symbol__init(NULL) < 0)
 		return -1;
 
-- 
2.7.4

