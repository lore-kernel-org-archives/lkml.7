Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91743C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FF822CD1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfFCGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:46:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:39148 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfFCGqc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:46:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 23:46:31 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 23:46:29 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per symbol
Date:   Mon,  3 Jun 2019 22:36:14 +0800
Message-Id: <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hist__account_cycles() can account cycles per basic
block. The basic block information is saved in cycles_hist
structure.

This patch processes each symbol, get basic blocks from
cycles_hist and add the basic block entries to a new hists
(block_hists in hist_entry). Using a hists is because
we need to compare, sort and print the basic blocks.

 v2:
 ---
 v1 adds the basic block entries to per data-file hists
 but v2 adds the basic block entries to per symbol hists.
 That is to keep current perf-diff format. Will show the
 result in next patches.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h    |   6 ++
 2 files changed, 200 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index a7e0420..310ba2a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -20,6 +20,7 @@
 #include "util/data.h"
 #include "util/config.h"
 #include "util/time-utils.h"
+#include "util/annotate.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -64,6 +65,17 @@ struct data__file {
 	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
 };
 
+struct block_hpp_fmt {
+	struct perf_hpp_fmt	fmt;
+	struct data__file	*file;
+};
+
+struct block_hists {
+	struct hists		hists;
+	struct perf_hpp_list	list;
+	struct block_hpp_fmt	block_fmt;
+};
+
 static struct data__file *data__files;
 static int data__files_cnt;
 
@@ -87,11 +99,14 @@ static s64 compute_wdiff_w2;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 
+static struct addr_location dummy_al;
+
 enum {
 	COMPUTE_DELTA,
 	COMPUTE_RATIO,
 	COMPUTE_WEIGHTED_DIFF,
 	COMPUTE_DELTA_ABS,
+	COMPUTE_CYCLES,
 	COMPUTE_MAX,
 };
 
@@ -100,6 +115,7 @@ const char *compute_names[COMPUTE_MAX] = {
 	[COMPUTE_DELTA_ABS] = "delta-abs",
 	[COMPUTE_RATIO] = "ratio",
 	[COMPUTE_WEIGHTED_DIFF] = "wdiff",
+	[COMPUTE_CYCLES] = "cycles",
 };
 
 static int compute = COMPUTE_DELTA_ABS;
@@ -234,6 +250,8 @@ static int setup_compute(const struct option *opt, const char *str,
 	for (i = 0; i < COMPUTE_MAX; i++)
 		if (!strcmp(cstr, compute_names[i])) {
 			*cp = i;
+			if (i == COMPUTE_CYCLES)
+				break;
 			return setup_compute_opt(option);
 		}
 
@@ -368,6 +386,9 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		goto out_put;
 	}
 
+	if (compute == COMPUTE_CYCLES)
+		hist__account_cycles(sample->branch_stack, &al, sample, false);
+
 	/*
 	 * The total_period is updated here before going to the output
 	 * tree since normally only the baseline hists will call
@@ -475,6 +496,155 @@ static void hists__baseline_only(struct hists *hists)
 	}
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
+static int64_t block_cycles_diff_cmp(struct hist_entry *left,
+				     struct hist_entry *right)
+{
+	bool pairs_left  = hist_entry__has_pairs(left);
+	bool pairs_right = hist_entry__has_pairs(right);
+	s64 l, r;
+
+	if (!pairs_left && !pairs_right)
+		return 0;
+
+	l = abs(left->diff.cycles);
+	r = abs(right->diff.cycles);
+	return r - l;
+}
+
+static int64_t block_sort(struct perf_hpp_fmt *fmt __maybe_unused,
+			  struct hist_entry *left, struct hist_entry *right)
+{
+	return block_cycles_diff_cmp(right, left);
+}
+
+static struct block_hists *alloc_block_hists(struct data__file *d)
+{
+	struct block_hists *block_hists = zalloc(sizeof(*block_hists));
+	struct block_hpp_fmt *block_fmt;
+
+	if (block_hists) {
+		__hists__init(&block_hists->hists, &block_hists->list);
+		perf_hpp_list__init(&block_hists->list);
+
+		block_fmt = &block_hists->block_fmt;
+		INIT_LIST_HEAD(&block_fmt->fmt.list);
+		INIT_LIST_HEAD(&block_fmt->fmt.sort_list);
+		block_fmt->fmt.cmp = block_cmp;
+		block_fmt->fmt.sort = block_sort;
+		block_fmt->file = d;
+		perf_hpp_list__register_sort_field(&block_hists->list,
+						   &block_fmt->fmt);
+	}
+
+	return block_hists;
+}
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
+	.new    = block_he_zalloc,
+	.free   = block_he_free,
+};
+
+static int process_block_per_sym(struct hist_entry *he, struct data__file *d)
+{
+	struct annotation *notes;
+	struct cyc_hist *ch;
+
+	if (!he->ms.map || !he->ms.sym)
+		return 0;
+
+	notes = symbol__annotation(he->ms.sym);
+	if (!notes || !notes->src || !notes->src->cycles_hist)
+		return 0;
+
+	he->block_hists = alloc_block_hists(d);
+	if (!he->block_hists)
+		return -1;
+
+	ch = notes->src->cycles_hist;
+	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
+		if (ch[i].num_aggr) {
+			struct block_info *bi;
+			struct hist_entry *he_block;
+			struct block_hists *block_hists = he->block_hists;
+
+			bi = block_info__new();
+			if (!bi)
+				return -1;
+
+			init_block_info(bi, he->ms.sym, &ch[i], i);
+			he_block = hists__add_entry_block(&block_hists->hists,
+							  &block_he_ops,
+							  &dummy_al, bi);
+			if (!he_block) {
+				block_info__put(bi);
+				return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -494,6 +664,9 @@ static void hists__precompute(struct hists *hists)
 		he   = rb_entry(next, struct hist_entry, rb_node_in);
 		next = rb_next(&he->rb_node_in);
 
+		if (compute == COMPUTE_CYCLES)
+			process_block_per_sym(he, &data__files[0]);
+
 		data__for_each_file_new(i, d) {
 			pair = get_pair_data(he, d);
 			if (!pair)
@@ -510,6 +683,9 @@ static void hists__precompute(struct hists *hists)
 			case COMPUTE_WEIGHTED_DIFF:
 				compute_wdiff(he, pair);
 				break;
+			case COMPUTE_CYCLES:
+				process_block_per_sym(pair, d);
+				break;
 			default:
 				BUG_ON(1);
 			}
@@ -713,6 +889,14 @@ hist_entry__cmp_wdiff_idx(struct perf_hpp_fmt *fmt __maybe_unused,
 					   sort_compute);
 }
 
+static int64_t
+hist_entry__cmp_cycles_idx(struct perf_hpp_fmt *fmt __maybe_unused,
+			   struct hist_entry *left __maybe_unused,
+			   struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
 static void hists__process(struct hists *hists)
 {
 	if (show_baseline_only)
@@ -746,6 +930,8 @@ static void data_process(void)
 	struct perf_evsel *evsel_base;
 	bool first = true;
 
+	memset(&dummy_al, 0, sizeof(dummy_al));
+
 	evlist__for_each_entry(evlist_base, evsel_base) {
 		struct hists *hists_base = evsel__hists(evsel_base);
 		struct data__file *d;
@@ -1411,6 +1597,9 @@ static int ui_init(void)
 	case COMPUTE_DELTA_ABS:
 		fmt->sort = hist_entry__cmp_delta_abs_idx;
 		break;
+	case COMPUTE_CYCLES:
+		fmt->sort = hist_entry__cmp_cycles_idx;
+		break;
 	default:
 		BUG_ON(1);
 	}
@@ -1507,6 +1696,8 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	symbol__annotation_init();
+
 	if (symbol__init(NULL) < 0)
 		return -1;
 
@@ -1516,6 +1707,9 @@ int cmd_diff(int argc, const char **argv)
 	if (check_file_brstack() < 0)
 		return -1;
 
+	if (compute == COMPUTE_CYCLES && !pdiff.has_br_stack)
+		return -1;
+
 	if (ui_init() < 0)
 		return -1;
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 43623fa..d1641da 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -79,6 +79,9 @@ struct hist_entry_diff {
 
 		/* HISTC_WEIGHTED_DIFF */
 		s64	wdiff;
+
+		/* PERF_HPP_DIFF__CYCLES */
+		s64	cycles;
 	};
 };
 
@@ -143,6 +146,9 @@ struct hist_entry {
 	struct branch_info	*branch_info;
 	long			time;
 	struct hists		*hists;
+	void			*block_hists;
+	int			block_idx;
+	int			block_num;
 	struct mem_info		*mem_info;
 	struct block_info	*block_info;
 	void			*raw_data;
-- 
2.7.4

