Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B2CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CBF2339E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfFCGqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:46:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:39148 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFCGqf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:46:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 23:46:34 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 23:46:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 6/7] perf diff: Print the basic block cycles diff
Date:   Mon,  3 Jun 2019 22:36:16 +0800
Message-Id: <1559572577-25436-7-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf record -b ./div
perf record -b ./div

Following is the default perf diff output

 # perf diff

 # Event 'cycles'
 #
 # Baseline  Delta Abs  Shared Object     Symbol
 # ........  .........  ................  ....................................
 #
     49.03%     +0.30%  div               [.] main
     16.29%     -0.20%  libc-2.23.so      [.] __random
     18.82%     -0.07%  libc-2.23.so      [.] __random_r
      8.11%     -0.04%  div               [.] compute_flag
      2.25%     +0.01%  div               [.] rand@plt
      0.00%     +0.01%  [kernel.vmlinux]  [k] task_tick_fair
      5.46%     +0.01%  libc-2.23.so      [.] rand
      0.01%     -0.01%  [kernel.vmlinux]  [k] native_irq_return_iret
      0.00%     -0.00%  [kernel.vmlinux]  [k] interrupt_entry

This patch creates a new computation selection 'cycles'.

 # perf diff -c cycles

 # Event 'cycles'
 #
 # Baseline         Block cycles diff [start:end]  Shared Object     Symbol
 # ........  ....................................  ................  ....................................
 #
     49.03%        -9 [         4ef:         520]  div               [.] main
     49.03%         0 [         4e8:         4ea]  div               [.] main
     49.03%         0 [         4ef:         500]  div               [.] main
     49.03%         0 [         4ef:         51c]  div               [.] main
     49.03%         0 [         4ef:         535]  div               [.] main
     18.82%         0 [       3ac40:       3ac4d]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac40:       3ac5c]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac40:       3ac76]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac40:       3ac88]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac90:       3ac9c]  libc-2.23.so      [.] __random_r
     16.29%        -8 [       3aac0:       3aac0]  libc-2.23.so      [.] __random
     16.29%         0 [       3aac0:       3aad2]  libc-2.23.so      [.] __random
     16.29%         0 [       3aae0:       3aae7]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab03:       3ab0f]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab14:       3ab1b]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab28:       3ab2e]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab4a:       3ab53]  libc-2.23.so      [.] __random
      8.11%         0 [         640:         644]  div               [.] compute_flag
      8.11%         0 [         649:         659]  div               [.] compute_flag
      5.46%         0 [       3af60:       3af60]  libc-2.23.so      [.] rand
      5.46%         0 [       3af60:       3af64]  libc-2.23.so      [.] rand
      2.25%         0 [         490:         490]  div               [.] rand@plt
      0.01%        26 [      c00a27:      c00a27]  [kernel.vmlinux]  [k] native_irq_return_iret
      0.00%      -157 [      2bf9f2:      2bfa63]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%       -56 [      2bf980:      2bf9d3]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%        48 [      2bf934:      2bf942]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%         3 [      2bfb38:      2bfb67]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%         0 [      2bf968:      2bf97b]  [kernel.vmlinux]  [k] update_blocked_averages

"[start:end]" indicates the basic block range. The output is sorted
by "Baseline" and the basic blocks in the same function are sorted
by cycles diff.

 v2:
 ---
 Keep standard perf diff format and display the 'Baseline' and
 'Shared Object'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c  | 63 +++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/ui/stdio/hist.c | 26 +++++++++++++++++++
 tools/perf/util/hist.c     | 18 +++++++++++++
 tools/perf/util/hist.h     |  3 +++
 4 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index b50ed70..35e4c36 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -46,6 +46,7 @@ enum {
 	PERF_HPP_DIFF__WEIGHTED_DIFF,
 	PERF_HPP_DIFF__FORMULA,
 	PERF_HPP_DIFF__DELTA_ABS,
+	PERF_HPP_DIFF__CYCLES,
 
 	PERF_HPP_DIFF__MAX_INDEX
 };
@@ -125,6 +126,7 @@ static int compute_2_hpp[COMPUTE_MAX] = {
 	[COMPUTE_DELTA_ABS]	= PERF_HPP_DIFF__DELTA_ABS,
 	[COMPUTE_RATIO]		= PERF_HPP_DIFF__RATIO,
 	[COMPUTE_WEIGHTED_DIFF]	= PERF_HPP_DIFF__WEIGHTED_DIFF,
+	[COMPUTE_CYCLES]	= PERF_HPP_DIFF__CYCLES,
 };
 
 #define MAX_COL_WIDTH 70
@@ -163,6 +165,10 @@ static struct header_column {
 	[PERF_HPP_DIFF__FORMULA] = {
 		.name  = "Formula",
 		.width = MAX_COL_WIDTH,
+	},
+	[PERF_HPP_DIFF__CYCLES] = {
+		.name  = "Block cycles diff [start:end]",
+		.width = 36,
 	}
 };
 
@@ -250,8 +256,6 @@ static int setup_compute(const struct option *opt, const char *str,
 	for (i = 0; i < COMPUTE_MAX; i++)
 		if (!strcmp(cstr, compute_names[i])) {
 			*cp = i;
-			if (i == COMPUTE_CYCLES)
-				break;
 			return setup_compute_opt(option);
 		}
 
@@ -949,6 +953,14 @@ hist_entry__cmp_wdiff(struct perf_hpp_fmt *fmt,
 }
 
 static int64_t
+hist_entry__cmp_cycles(struct perf_hpp_fmt *fmt __maybe_unused,
+		       struct hist_entry *left __maybe_unused,
+		       struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
+static int64_t
 hist_entry__cmp_delta_idx(struct perf_hpp_fmt *fmt __maybe_unused,
 			  struct hist_entry *left, struct hist_entry *right)
 {
@@ -1253,7 +1265,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN('b', "baseline-only", &show_baseline_only,
 		    "Show only items with match in baseline"),
 	OPT_CALLBACK('c', "compute", &compute,
-		     "delta,delta-abs,ratio,wdiff:w1,w2 (default delta-abs)",
+		     "delta,delta-abs,ratio,wdiff:w1,w2 (default delta-abs),cycles",
 		     "Entries differential computation selection",
 		     setup_compute),
 	OPT_BOOLEAN('p', "period", &show_period,
@@ -1331,6 +1343,33 @@ static int hpp__entry_baseline(struct hist_entry *he, char *buf, size_t size)
 	return ret;
 }
 
+static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
+			 struct perf_hpp *hpp, int width)
+{
+	struct block_hists *p = pair->block_hists;
+	struct hist_entry *block_he;
+	struct block_info *bi;
+	char buf[128];
+
+	if (!p) {
+		hpp->skip = true;
+		return 0;
+	}
+
+	block_he = hists__get_entry(&p->hists, he->block_idx);
+	if (!block_he) {
+		hpp->skip = true;
+		return 0;
+	}
+
+	bi = block_he->block_info;
+	scnprintf(buf, sizeof(buf), "%ld [%12lx:%12lx]",
+		  block_he->diff.cycles, bi->sym->start + bi->start,
+		  bi->sym->start + bi->end);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 				struct perf_hpp *hpp, struct hist_entry *he,
 				int comparison_method)
@@ -1342,8 +1381,12 @@ static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 	s64 wdiff;
 	char pfmt[20] = " ";
 
-	if (!pair)
+	if (!pair) {
+		if (comparison_method == COMPUTE_CYCLES && he->block_idx)
+			hpp->skip = true;
+
 		goto no_print;
+	}
 
 	switch (comparison_method) {
 	case COMPUTE_DELTA:
@@ -1378,6 +1421,8 @@ static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 		return color_snprintf(hpp->buf, hpp->size,
 				get_percent_color(wdiff),
 				pfmt, wdiff);
+	case COMPUTE_CYCLES:
+		return cycles_printf(he, pair, hpp, dfmt->header_width);
 	default:
 		BUG_ON(1);
 	}
@@ -1407,6 +1452,12 @@ static int hpp__color_wdiff(struct perf_hpp_fmt *fmt,
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
@@ -1608,6 +1659,10 @@ static void data__hpp_register(struct data__file *d, int idx)
 		fmt->color = hpp__color_delta;
 		fmt->sort  = hist_entry__cmp_delta_abs;
 		break;
+	case PERF_HPP_DIFF__CYCLES:
+		fmt->color = hpp__color_cycles;
+		fmt->sort  = hist_entry__cmp_cycles;
+		break;
 	default:
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index a60f299..0bc03b8 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -531,6 +531,29 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 	return printed;
 }
 
+static int hist_entry__block_fprintf(struct hist_entry *he,
+				     char *bf, size_t size,
+				     FILE *fp)
+{
+	int ret = 0;
+
+	for (int i = 0; i < he->block_num; i++) {
+		struct perf_hpp hpp = {
+			.buf		= bf,
+			.size		= size,
+			.skip		= false,
+		};
+
+		he->block_idx = i;
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
@@ -550,6 +573,9 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 	if (symbol_conf.report_hierarchy)
 		return hist_entry__hierarchy_fprintf(he, &hpp, hists, fp);
 
+	if (he->block_hists)
+		return hist_entry__block_fprintf(he, bf, size, fp);
+
 	hist_entry__snprintf(he, &hpp);
 
 	ret = fprintf(fp, "%s\n", bf);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 10ab45a..169899f6 100644
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
-- 
2.7.4

