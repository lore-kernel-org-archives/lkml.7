Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FEDC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5188721850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124502;
	bh=/CQ/bbqXvFRJTehWl5gvIJgcgWjkaSRISBS/CsY7bYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5dslRTZOVmmf3+Qi2wdI6C1RFf6HPO0q85tpNiJS1O2H8w16bGvgWi/mXyE1J9WZ
	 s0MngYNX+fQJHpTZ60kHOx2+SoDXp1HeOxOCAn9WWcUEirZWI7s7gePoMWgtJ3cJXK
	 3VLv4A0ETevKjQYOfMFW56/yjYSJMDia6r3HA6q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGCD2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfGCD2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2A32189E;
        Wed,  3 Jul 2019 03:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124497;
        bh=/CQ/bbqXvFRJTehWl5gvIJgcgWjkaSRISBS/CsY7bYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDmG+naZXcUIMghopRmKQVi/tqdOcvTjJu/1DRT6/V5WOfmYsEeU6hzvIN2xQVVSY
         1QjNVTceFoc/jmks95u15xTvQ9gxuI61CDi4wIpPTR18LPFWnSo4wx+4BbC0ZmUHFw
         m9thXwKn5cExRb7Eq7K/ca6CQbgOtJV14JJJVnJQ=
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
Subject: [PATCH 06/18] perf diff: Link same basic blocks among different data
Date:   Wed,  3 Jul 2019 00:27:34 -0300
Message-Id: <20190703032746.21692-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The target is to compare the performance difference (cycles diff) for
the same basic blocks in different data files.

The same basic block means same function, same start address and same
end address. This patch finds the same basic blocks from different data
files and link them together and resort by the cycles diff.

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
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-6-git-send-email-yao.jin@linux.intel.com
[ sym->name is an array, not a pointer, so no need to check it for NULL, fixes de build in some distros ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 87 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 83b8c0f3fb16..fafb7b3f58fb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -641,6 +641,82 @@ static int process_block_per_sym(struct hist_entry *he)
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
+	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+
+	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
+		return 0;
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
@@ -653,6 +729,7 @@ static void hists__precompute(struct hists *hists)
 
 	next = rb_first_cached(root);
 	while (next != NULL) {
+		struct block_hist *bh, *pair_bh;
 		struct hist_entry *he, *pair;
 		struct data__file *d;
 		int i;
@@ -681,6 +758,16 @@ static void hists__precompute(struct hists *hists)
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
2.20.1

