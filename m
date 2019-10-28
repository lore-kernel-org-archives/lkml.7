Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A297CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6966620B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfJ1Bes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:34:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:49091 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfJ1Beo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:34:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 18:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="224492450"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2019 18:34:42 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 4/7] perf util: Support block formats with compare/sort/display
Date:   Mon, 28 Oct 2019 09:33:27 +0800
Message-Id: <20191028013330.18319-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028013330.18319-1-yao.jin@linux.intel.com>
References: <20191028013330.18319-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides helper routines to support new
columns for block info output.

The new columns are:

Sampled Cycles%
Sampled Cycles
Avg Cycles%
Avg Cycles
[Program Block Range]
Shared Object

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 244 +++++++++++++++++++++++++++++++++++
 tools/perf/util/block-info.h |  29 +++++
 2 files changed, 273 insertions(+)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index b9954a32b8f4..4d8d5ad1086c 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -6,6 +6,39 @@
 #include "sort.h"
 #include "annotate.h"
 #include "symbol.h"
+#include "dso.h"
+#include "map.h"
+#include "srcline.h"
+
+static struct block_header_column{
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
@@ -127,3 +160,214 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 
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
+			(double)block_fmt->total_cycles) * 1000.0;
+		r = ((double)bi_r->cycles /
+			(double)block_fmt->total_cycles) * 1000.0;
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
+void block_info__hpp_register(struct block_fmt *block_fmt, int idx,
+			      struct perf_hpp_list *hpp_list)
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
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index d55dfc2fda6f..3431806dce49 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -20,6 +20,25 @@ struct block_info {
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
 struct block_hist;
 
 struct block_info *block_info__new(void);
@@ -40,4 +59,14 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 			    u64 *block_cycles_aggr, u64 total_cycles);
 
+void block_info__hpp_register(struct block_fmt *block_fmt, int idx,
+			      struct perf_hpp_list *hpp_list);
+
+static inline void block_info__set_fmt(struct block_fmt *block_fmt,
+				       u64 total_cycles, u64 block_cycles)
+{
+	block_fmt->total_cycles = total_cycles;
+	block_fmt->block_cycles = block_cycles;
+}
+
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

