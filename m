Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A57C48BDB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0798204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0GUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:20:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:39130 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfF0GUK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="156135564"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 23:20:08 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 6/7] perf diff: Print the basic block cycles diff
Date:   Thu, 27 Jun 2019 22:09:28 +0800
Message-Id: <1561644569-22306-7-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 $ perf record -b ./div
 $ perf record -b ./div

Following is the default perf diff output

 $ perf diff

 # Event 'cycles'
 #
 # Baseline  Delta Abs  Shared Object     Symbol
 # ........  .........  ................  ..................................
 #
     48.75%     +0.33%  div               [.] main
      8.21%     -0.20%  div               [.] compute_flag
     19.02%     -0.12%  libc-2.23.so      [.] __random_r
     16.17%     -0.09%  libc-2.23.so      [.] __random
      2.27%     -0.03%  div               [.] rand@plt
                +0.02%  [i915]            [k] gen8_irq_handler
      5.52%     +0.02%  libc-2.23.so      [.] rand

This patch creates a new computation selection 'cycles'.

 $ perf diff -c cycles

 # Event 'cycles'
 #
 # Baseline                                       [Program Block Range] Cycles Diff  Shared Object     Symbol
 # ........  ......................................................................  ................  ..................................
 #
     48.75%                                             [div.c:42 -> div.c:45]  147  div               [.] main
     48.75%                                             [div.c:31 -> div.c:40]    4  div               [.] main
     48.75%                                             [div.c:40 -> div.c:40]    0  div               [.] main
     48.75%                                             [div.c:42 -> div.c:42]    0  div               [.] main
     48.75%                                             [div.c:42 -> div.c:44]    0  div               [.] main
     19.02%                                 [random_r.c:357 -> random_r.c:360]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:373]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:376]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:380]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:392]    0  libc-2.23.so      [.] __random_r
     16.17%                                     [random.c:288 -> random.c:291]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:288 -> random.c:291]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:288 -> random.c:295]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:288 -> random.c:297]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:291 -> random.c:291]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:293 -> random.c:293]    0  libc-2.23.so      [.] __random
      8.21%                                             [div.c:22 -> div.c:22]  148  div               [.] compute_flag
      8.21%                                             [div.c:22 -> div.c:25]    0  div               [.] compute_flag
      8.21%                                             [div.c:27 -> div.c:28]    0  div               [.] compute_flag
      5.52%                                           [rand.c:26 -> rand.c:27]    0  libc-2.23.so      [.] rand
      5.52%                                           [rand.c:26 -> rand.c:28]    0  libc-2.23.so      [.] rand
      2.27%                                         [rand@plt+0 -> rand@plt+0]    0  div               [.] rand@plt
      0.01%                                 [entry_64.S:694 -> entry_64.S:694]   16  [kernel.vmlinux]  [k] native_irq_return_iret
      0.00%                                       [fair.c:7676 -> fair.c:7665]  162  [kernel.vmlinux]  [k] update_blocked_averages

"[Program Block Range]" indicates the range of program basic block
(start -> end). If we can find the source line it prints the source
line otherwise it prints the symbol+offset instead.

 v4:
 ---
 Use source lines or symbol+offset to indicate the basic block. It should
 be easier to understand.

 v3:
 ---
 Cast 'struct hist_entry' to 'struct block_hist' in hist_entry__block_fprintf.
 Use symbol_conf.report_block to check if executing hist_entry__block_fprintf.

 v2:
 ---
 Keep standard perf diff format and display the 'Baseline' and
 'Shared Object'.

The output is sorted by "Baseline" and the basic blocks in the same
function are sorted by cycles diff.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c     | 80 ++++++++++++++++++++++++++++++++++++++++---
 tools/perf/ui/stdio/hist.c    | 27 +++++++++++++++
 tools/perf/util/hist.c        | 18 ++++++++++
 tools/perf/util/hist.h        |  3 ++
 tools/perf/util/srcline.c     |  4 ++-
 tools/perf/util/symbol_conf.h |  4 ++-
 6 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 864423a..c888927 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -21,6 +21,7 @@
 #include "util/config.h"
 #include "util/time-utils.h"
 #include "util/annotate.h"
+#include "util/map.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -46,6 +47,7 @@ enum {
 	PERF_HPP_DIFF__WEIGHTED_DIFF,
 	PERF_HPP_DIFF__FORMULA,
 	PERF_HPP_DIFF__DELTA_ABS,
+	PERF_HPP_DIFF__CYCLES,
 
 	PERF_HPP_DIFF__MAX_INDEX
 };
@@ -114,6 +116,7 @@ static int compute_2_hpp[COMPUTE_MAX] = {
 	[COMPUTE_DELTA_ABS]	= PERF_HPP_DIFF__DELTA_ABS,
 	[COMPUTE_RATIO]		= PERF_HPP_DIFF__RATIO,
 	[COMPUTE_WEIGHTED_DIFF]	= PERF_HPP_DIFF__WEIGHTED_DIFF,
+	[COMPUTE_CYCLES]	= PERF_HPP_DIFF__CYCLES,
 };
 
 #define MAX_COL_WIDTH 70
@@ -152,6 +155,10 @@ static struct header_column {
 	[PERF_HPP_DIFF__FORMULA] = {
 		.name  = "Formula",
 		.width = MAX_COL_WIDTH,
+	},
+	[PERF_HPP_DIFF__CYCLES] = {
+		.name  = "[Program Block Range] Cycles Diff",
+		.width = 70,
 	}
 };
 
@@ -239,8 +246,6 @@ static int setup_compute(const struct option *opt, const char *str,
 	for (i = 0; i < COMPUTE_MAX; i++)
 		if (!strcmp(cstr, compute_names[i])) {
 			*cp = i;
-			if (i == COMPUTE_CYCLES)
-				break;
 			return setup_compute_opt(option);
 		}
 
@@ -983,6 +988,9 @@ static void hists__process(struct hists *hists)
 	hists__precompute(hists);
 	hists__output_resort(hists, NULL);
 
+	if (compute == COMPUTE_CYCLES)
+		symbol_conf.report_block = true;
+
 	hists__fprintf(hists, !quiet, 0, 0, 0, stdout,
 		       !symbol_conf.use_callchain);
 }
@@ -1238,7 +1246,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN('b', "baseline-only", &show_baseline_only,
 		    "Show only items with match in baseline"),
 	OPT_CALLBACK('c', "compute", &compute,
-		     "delta,delta-abs,ratio,wdiff:w1,w2 (default delta-abs)",
+		     "delta,delta-abs,ratio,wdiff:w1,w2 (default delta-abs),cycles",
 		     "Entries differential computation selection",
 		     setup_compute),
 	OPT_BOOLEAN('p', "period", &show_period,
@@ -1316,6 +1324,49 @@ static int hpp__entry_baseline(struct hist_entry *he, char *buf, size_t size)
 	return ret;
 }
 
+static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
+			 struct perf_hpp *hpp, int width)
+{
+	struct block_hist *bh = container_of(he, struct block_hist, he);
+	struct block_hist *bh_pair = container_of(pair, struct block_hist, he);
+	struct hist_entry *block_he;
+	struct block_info *bi;
+	char buf[128];
+	char *start_line, *end_line;
+
+	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
+	if (!block_he) {
+		hpp->skip = true;
+		return 0;
+	}
+
+	/*
+	 * Avoid printing the warning "addr2line_init failed for ..."
+	 */
+	symbol_conf.disable_add2line_warn = true;
+
+	bi = block_he->block_info;
+
+	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
+				  he->ms.sym);
+
+	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
+				he->ms.sym);
+
+	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
+			  start_line, end_line, block_he->diff.cycles);
+	} else {
+		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
+			  bi->start, bi->end, block_he->diff.cycles);
+	}
+
+	free_srcline(start_line);
+	free_srcline(end_line);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 				struct perf_hpp *hpp, struct hist_entry *he,
 				int comparison_method)
@@ -1327,8 +1378,17 @@ static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 	s64 wdiff;
 	char pfmt[20] = " ";
 
-	if (!pair)
+	if (!pair) {
+		if (comparison_method == COMPUTE_CYCLES) {
+			struct block_hist *bh;
+
+			bh = container_of(he, struct block_hist, he);
+			if (bh->block_idx)
+				hpp->skip = true;
+		}
+
 		goto no_print;
+	}
 
 	switch (comparison_method) {
 	case COMPUTE_DELTA:
@@ -1363,6 +1423,8 @@ static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 		return color_snprintf(hpp->buf, hpp->size,
 				get_percent_color(wdiff),
 				pfmt, wdiff);
+	case COMPUTE_CYCLES:
+		return cycles_printf(he, pair, hpp, dfmt->header_width);
 	default:
 		BUG_ON(1);
 	}
@@ -1392,6 +1454,12 @@ static int hpp__color_wdiff(struct perf_hpp_fmt *fmt,
 	return __hpp__color_compare(fmt, hpp, he, COMPUTE_WEIGHTED_DIFF);
 }
 
+static int hpp__color_cycles(struct perf_hpp_fmt *fmt,
+			     struct perf_hpp *hpp, struct hist_entry *he)
+{
+	return __hpp__color_compare(fmt, hpp, he, COMPUTE_CYCLES);
+}
+
 static void
 hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
 {
@@ -1593,6 +1661,10 @@ static void data__hpp_register(struct data__file *d, int idx)
 		fmt->color = hpp__color_delta;
 		fmt->sort  = hist_entry__cmp_delta_abs;
 		break;
+	case PERF_HPP_DIFF__CYCLES:
+		fmt->color = hpp__color_cycles;
+		fmt->sort  = hist_entry__cmp_nop;
+		break;
 	default:
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index a60f299..4e74bb7 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -531,6 +531,30 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 	return printed;
 }
 
+static int hist_entry__block_fprintf(struct hist_entry *he,
+				     char *bf, size_t size,
+				     FILE *fp)
+{
+	struct block_hist *bh = container_of(he, struct block_hist, he);
+	int ret = 0;
+
+	for (unsigned int i = 0; i < bh->block_hists.nr_entries; i++) {
+		struct perf_hpp hpp = {
+			.buf		= bf,
+			.size		= size,
+			.skip		= false,
+		};
+
+		bh->block_idx = i;
+		hist_entry__snprintf(he, &hpp);
+
+		if (!hpp.skip)
+			ret += fprintf(fp, "%s\n", bf);
+	}
+
+	return ret;
+}
+
 static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 			       char *bf, size_t bfsz, FILE *fp,
 			       bool ignore_callchains)
@@ -550,6 +574,9 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 	if (symbol_conf.report_hierarchy)
 		return hist_entry__hierarchy_fprintf(he, &hpp, hists, fp);
 
+	if (symbol_conf.report_block)
+		return hist_entry__block_fprintf(he, bf, size, fp);
+
 	hist_entry__snprintf(he, &hpp);
 
 	ret = fprintf(fp, "%s\n", bf);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1ef5235..4569600 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -376,6 +376,24 @@ void hists__delete_entries(struct hists *hists)
 	}
 }
 
+struct hist_entry *hists__get_entry(struct hists *hists, int idx)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	struct hist_entry *n;
+	int i = 0;
+
+	while (next) {
+		n = rb_entry(next, struct hist_entry, rb_node);
+		if (i == idx)
+			return n;
+
+		next = rb_next(&n->rb_node);
+		i++;
+	}
+
+	return NULL;
+}
+
 /*
  * histogram, sorted on item, collects periods
  */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c8f7d66..9124b54 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -184,6 +184,8 @@ void hists__decay_entries(struct hists *hists, bool zap_user, bool zap_kernel);
 void hists__delete_entries(struct hists *hists);
 void hists__output_recalc_col_len(struct hists *hists, int max_rows);
 
+struct hist_entry *hists__get_entry(struct hists *hists, int idx);
+
 u64 hists__total_period(struct hists *hists);
 void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
@@ -249,6 +251,7 @@ struct perf_hpp {
 	size_t size;
 	const char *sep;
 	void *ptr;
+	bool skip;
 };
 
 struct perf_hpp_fmt {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 10ca153..0675ec9 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -10,6 +10,7 @@
 #include "util/util.h"
 #include "util/debug.h"
 #include "util/callchain.h"
+#include "util/symbol_conf.h"
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -287,7 +288,8 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 
 	if (a2l == NULL) {
-		pr_warning("addr2line_init failed for %s\n", dso_name);
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("addr2line_init failed for %s\n", dso_name);
 		return 0;
 	}
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 382ba63..e688078 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -39,7 +39,9 @@ struct symbol_conf {
 			hide_unresolved,
 			raw_trace,
 			report_hierarchy,
-			inline_name;
+			report_block,
+			inline_name,
+			disable_add2line_warn;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.7.4

