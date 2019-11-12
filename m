Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B34022469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfKLLWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:22:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33553 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfKLLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBC-0000Cq-Ff; Tue, 12 Nov 2019 12:17:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2AA071C0357;
        Tue, 12 Nov 2019 12:17:50 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:49 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf hist: Support block formats with compare/sort/display
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191107074719.26139-5-yao.jin@linux.intel.com>
References: <20191107074719.26139-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157355746983.29376.2156714111336090167.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b65a7d372b1a55db6fb48a5b3c48941eb68716cb
Gitweb:        https://git.kernel.org/tip/b65a7d372b1a55db6fb48a5b3c48941eb68716cb
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Thu, 07 Nov 2019 15:47:16 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 10:14:05 -03:00

perf hist: Support block formats with compare/sort/display

This patch provides helper routines to support new columns for block
info output.

The new columns are:

  Sampled Cycles%
  Sampled Cycles
  Avg Cycles%
  Avg Cycles
  [Program Block Range]
  Shared Object

 v5:
 ---
 1. Move more block related functions from builtin-report.c to
    block-info.c

 2. Set ms (map+sym) in block hist_entry. Because this info
    is needed for reporting the block range (i.e. source line)

Committer notes:

Remove unused set_fmt() function, some build were not completing with:

  util/block-info.c:396:20: error: unused function 'set_fmt' [-Werror,-Wunused-function]
  static inline void set_fmt(struct block_fmt *block_fmt,
                     ^
  1 error generated.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-5-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/block-info.c | 310 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/block-info.h |  33 +++-
 tools/perf/util/hist.c       |   4 +-
 3 files changed, 345 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index b9954a3..4a7bac9 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -6,6 +6,40 @@
 #include "sort.h"
 #include "annotate.h"
 #include "symbol.h"
+#include "dso.h"
+#include "map.h"
+#include "srcline.h"
+#include "evlist.h"
+
+static struct block_header_column {
+	const char *name;
+	int width;
+} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
+	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT] = {
+		.name = "Sampled Cycles%",
+		.width = 15,
+	},
+	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
+		.name = "Sampled Cycles",
+		.width = 14,
+	},
+	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
+		.name = "Avg Cycles%",
+		.width = 11,
+	},
+	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
+		.name = "Avg Cycles",
+		.width = 10,
+	},
+	[PERF_HPP_REPORT__BLOCK_RANGE] = {
+		.name = "[Program Block Range]",
+		.width = 70,
+	},
+	[PERF_HPP_REPORT__BLOCK_DSO] = {
+		.name = "Shared Object",
+		.width = 20,
+	}
+};
 
 struct block_info *block_info__get(struct block_info *bi)
 {
@@ -127,3 +161,279 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 
 	return 0;
 }
+
+static int block_column_header(struct perf_hpp_fmt *fmt,
+			       struct perf_hpp *hpp,
+			       struct hists *hists __maybe_unused,
+			       int line __maybe_unused,
+			       int *span __maybe_unused)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+			 block_fmt->header);
+}
+
+static int block_column_width(struct perf_hpp_fmt *fmt,
+			      struct perf_hpp *hpp __maybe_unused,
+			      struct hists *hists __maybe_unused)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+
+	return block_fmt->width;
+}
+
+static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
+					struct perf_hpp *hpp,
+					struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct block_info *bi = he->block_info;
+	double ratio = 0.0;
+	char buf[16];
+
+	if (block_fmt->total_cycles)
+		ratio = (double)bi->cycles / (double)block_fmt->total_cycles;
+
+	sprintf(buf, "%.2f%%", 100.0 * ratio);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+}
+
+static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
+					   struct hist_entry *left,
+					   struct hist_entry *right)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct block_info *bi_l = left->block_info;
+	struct block_info *bi_r = right->block_info;
+	double l, r;
+
+	if (block_fmt->total_cycles) {
+		l = ((double)bi_l->cycles /
+			(double)block_fmt->total_cycles) * 100000.0;
+		r = ((double)bi_r->cycles /
+			(double)block_fmt->total_cycles) * 100000.0;
+		return (int64_t)l - (int64_t)r;
+	}
+
+	return 0;
+}
+
+static void cycles_string(u64 cycles, char *buf, int size)
+{
+	if (cycles >= 1000000)
+		scnprintf(buf, size, "%.1fM", (double)cycles / 1000000.0);
+	else if (cycles >= 1000)
+		scnprintf(buf, size, "%.1fK", (double)cycles / 1000.0);
+	else
+		scnprintf(buf, size, "%1d", cycles);
+}
+
+static int block_cycles_lbr_entry(struct perf_hpp_fmt *fmt,
+				  struct perf_hpp *hpp, struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct block_info *bi = he->block_info;
+	char cycles_buf[16];
+
+	cycles_string(bi->cycles_aggr, cycles_buf, sizeof(cycles_buf));
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+			 cycles_buf);
+}
+
+static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
+				  struct perf_hpp *hpp, struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct block_info *bi = he->block_info;
+	double ratio = 0.0;
+	u64 avg;
+	char buf[16];
+
+	if (block_fmt->block_cycles && bi->num_aggr) {
+		avg = bi->cycles_aggr / bi->num_aggr;
+		ratio = (double)avg / (double)block_fmt->block_cycles;
+	}
+
+	sprintf(buf, "%.2f%%", 100.0 * ratio);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+}
+
+static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
+				  struct perf_hpp *hpp,
+				  struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct block_info *bi = he->block_info;
+	char cycles_buf[16];
+
+	cycles_string(bi->cycles_aggr / bi->num_aggr, cycles_buf,
+		      sizeof(cycles_buf));
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+			 cycles_buf);
+}
+
+static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			     struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct block_info *bi = he->block_info;
+	char buf[128];
+	char *start_line, *end_line;
+
+	symbol_conf.disable_add2line_warn = true;
+
+	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
+				  he->ms.sym);
+
+	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
+				he->ms.sym);
+
+	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+		scnprintf(buf, sizeof(buf), "[%s -> %s]",
+			  start_line, end_line);
+	} else {
+		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx]",
+			  bi->start, bi->end);
+	}
+
+	free_srcline(start_line);
+	free_srcline(end_line);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+}
+
+static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
+{
+	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
+	struct map *map = he->ms.map;
+
+	if (map && map->dso) {
+		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+				 map->dso->short_name);
+	}
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
+			 "[unknown]");
+}
+
+static void init_block_header(struct block_fmt *block_fmt)
+{
+	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
+
+	BUG_ON(block_fmt->idx >= PERF_HPP_REPORT__BLOCK_MAX_INDEX);
+
+	block_fmt->header = block_columns[block_fmt->idx].name;
+	block_fmt->width = block_columns[block_fmt->idx].width;
+
+	fmt->header = block_column_header;
+	fmt->width = block_column_width;
+}
+
+static void hpp_register(struct block_fmt *block_fmt, int idx,
+			 struct perf_hpp_list *hpp_list)
+{
+	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
+
+	block_fmt->idx = idx;
+	INIT_LIST_HEAD(&fmt->list);
+	INIT_LIST_HEAD(&fmt->sort_list);
+
+	switch (idx) {
+	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
+		fmt->entry = block_total_cycles_pct_entry;
+		fmt->cmp = block_info__cmp;
+		fmt->sort = block_total_cycles_pct_sort;
+		break;
+	case PERF_HPP_REPORT__BLOCK_LBR_CYCLES:
+		fmt->entry = block_cycles_lbr_entry;
+		break;
+	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
+		fmt->entry = block_cycles_pct_entry;
+		break;
+	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
+		fmt->entry = block_avg_cycles_entry;
+		break;
+	case PERF_HPP_REPORT__BLOCK_RANGE:
+		fmt->entry = block_range_entry;
+		break;
+	case PERF_HPP_REPORT__BLOCK_DSO:
+		fmt->entry = block_dso_entry;
+		break;
+	default:
+		return;
+	}
+
+	init_block_header(block_fmt);
+	perf_hpp_list__column_register(hpp_list, fmt);
+}
+
+static void register_block_columns(struct perf_hpp_list *hpp_list,
+				   struct block_fmt *block_fmts)
+{
+	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
+		hpp_register(&block_fmts[i], i, hpp_list);
+}
+
+static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts)
+{
+	__hists__init(&bh->block_hists, &bh->block_list);
+	perf_hpp_list__init(&bh->block_list);
+	bh->block_list.nr_header_lines = 1;
+
+	register_block_columns(&bh->block_list, block_fmts);
+
+	perf_hpp_list__register_sort_field(&bh->block_list,
+		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
+}
+
+static void process_block_report(struct hists *hists,
+				 struct block_report *block_report,
+				 u64 total_cycles)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	struct block_hist *bh = &block_report->hist;
+	struct hist_entry *he;
+
+	init_block_hist(bh, block_report->fmts);
+
+	while (next) {
+		he = rb_entry(next, struct hist_entry, rb_node);
+		block_info__process_sym(he, bh, &block_report->cycles,
+					total_cycles);
+		next = rb_next(&he->rb_node);
+	}
+
+	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++) {
+		block_report->fmts[i].total_cycles = total_cycles;
+		block_report->fmts[i].block_cycles = block_report->cycles;
+	}
+
+	hists__output_resort(&bh->block_hists, NULL);
+}
+
+struct block_report *block_info__create_report(struct evlist *evlist,
+					       u64 total_cycles)
+{
+	struct block_report *block_reports;
+	int nr_hists = evlist->core.nr_entries, i = 0;
+	struct evsel *pos;
+
+	block_reports = calloc(nr_hists, sizeof(struct block_report));
+	if (!block_reports)
+		return NULL;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		process_block_report(hists, &block_reports[i], total_cycles);
+		i++;
+	}
+
+	return block_reports;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index d55dfc2..b526658 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -4,8 +4,9 @@
 
 #include <linux/types.h>
 #include <linux/refcount.h>
-#include "util/hist.h"
-#include "util/symbol.h"
+#include "hist.h"
+#include "symbol.h"
+#include "sort.h"
 
 struct block_info {
 	struct symbol		*sym;
@@ -20,6 +21,31 @@ struct block_info {
 	refcount_t		refcnt;
 };
 
+struct block_fmt {
+	struct perf_hpp_fmt	fmt;
+	int			idx;
+	int			width;
+	const char		*header;
+	u64			total_cycles;
+	u64			block_cycles;
+};
+
+enum {
+	PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
+	PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
+	PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
+	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
+	PERF_HPP_REPORT__BLOCK_RANGE,
+	PERF_HPP_REPORT__BLOCK_DSO,
+	PERF_HPP_REPORT__BLOCK_MAX_INDEX
+};
+
+struct block_report {
+	struct block_hist	hist;
+	u64			cycles;
+	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
+};
+
 struct block_hist;
 
 struct block_info *block_info__new(void);
@@ -40,4 +66,7 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 			    u64 *block_cycles_aggr, u64 total_cycles);
 
+struct block_report *block_info__create_report(struct evlist *evlist,
+					       u64 total_cycles);
+
 #endif /* __PERF_BLOCK_H */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0e27d68..7cf137b 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
 	struct hist_entry entry = {
 		.block_info = block_info,
 		.hists = hists,
+		.ms = {
+			.map = al->map,
+			.sym = al->sym,
+		},
 	}, *he = hists__findnew_entry(hists, &entry, al, false);
 
 	return he;
