Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35B7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D4621872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfJVIIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:08:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:56434 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388047AbfJVIIP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:08:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 01:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="209620807"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2019 01:08:12 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per block for stdio
Date:   Tue, 22 Oct 2019 16:07:08 +0800
Message-Id: <20191022080710.6491-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022080710.6491-1-yao.jin@linux.intel.com>
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to support sorting for all blocks by the
sampled cycles percent per block. This is useful to concentrate
on the globally hottest blocks.

This patch implements a new sort option "total_cycles" which sorts
all blocks by 'Sampled Cycles%'. The 'Sampled Cycles%' is the
percent:

 percent = block sampled cycles aggregation / total sampled cycles

Note that, this patch only supports "--stdio" mode.

For example,

perf record -b ./div
perf report -s total_cycles --stdio

 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 2M of event 'cycles'
 # Event count (approx.): 2753248
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
 # ...............  ..............  ...........  ..........  .................................................................  ....................
 #
            26.04%            2.8M        0.40%          18                                             [div.c:42 -> div.c:39]                   div
            15.17%            1.2M        0.16%           7                                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
             5.11%          402.0K        0.04%           2                                             [div.c:27 -> div.c:28]                   div
             4.87%          381.6K        0.04%           2                                     [random.c:288 -> random.c:291]          libc-2.27.so
             4.53%          381.0K        0.04%           2                                             [div.c:40 -> div.c:40]                   div
             3.85%          300.9K        0.02%           1                                             [div.c:22 -> div.c:25]                   div
             3.08%          241.1K        0.02%           1                                           [rand.c:26 -> rand.c:27]          libc-2.27.so
             3.06%          240.0K        0.02%           1                                     [random.c:291 -> random.c:291]          libc-2.27.so
             2.78%          215.7K        0.02%           1                                     [random.c:298 -> random.c:298]          libc-2.27.so
             2.52%          198.3K        0.02%           1                                     [random.c:293 -> random.c:293]          libc-2.27.so
             2.36%          184.8K        0.02%           1                                           [rand.c:28 -> rand.c:28]          libc-2.27.so
             2.33%          180.5K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.28%          176.7K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.20%          168.8K        0.02%           1                                         [rand@plt+0 -> rand@plt+0]                   div
             1.98%          158.2K        0.02%           1                                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
             1.57%          123.3K        0.02%           1                                             [div.c:42 -> div.c:44]                   div
             1.44%          116.0K        0.42%          19                                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so
             0.25%          182.5K        0.02%           1                                 [random_r.c:388 -> random_r.c:391]          libc-2.27.so
             0.00%              48        1.07%          48                         [x86_pmu_enable+284 -> x86_pmu_enable+298]     [kernel.kallsyms]
             0.00%              74        1.64%          74                              [vm_mmap_pgoff+0 -> vm_mmap_pgoff+92]     [kernel.kallsyms]
             0.00%              73        1.62%          73                                          [vm_mmap+0 -> vm_mmap+48]     [kernel.kallsyms]
             0.00%              63        0.69%          31                                        [up_write+0 -> up_write+34]     [kernel.kallsyms]
             0.00%              13        0.29%          13                       [setup_arg_pages+396 -> setup_arg_pages+413]     [kernel.kallsyms]
             0.00%               3        0.07%           3                       [setup_arg_pages+418 -> setup_arg_pages+450]     [kernel.kallsyms]
             0.00%             616        6.84%         308                    [security_mmap_file+0 -> security_mmap_file+72]     [kernel.kallsyms]
             0.00%              23        0.51%          23                   [security_mmap_file+77 -> security_mmap_file+87]     [kernel.kallsyms]
             0.00%               4        0.02%           1                                   [sched_clock+0 -> sched_clock+4]     [kernel.kallsyms]
             0.00%               4        0.02%           1                                  [sched_clock+9 -> sched_clock+12]     [kernel.kallsyms]
             0.00%               1        0.02%           1                                 [rcu_nmi_exit+0 -> rcu_nmi_exit+9]     [kernel.kallsyms]
             0.00%               1        0.02%           1                               [rcu_nmi_exit+14 -> rcu_nmi_exit+15]     [kernel.kallsyms]
             0.00%               5        0.11%           5                                [rcu_irq_exit+0 -> rcu_irq_exit+79]     [kernel.kallsyms]
             0.00%               2        0.04%           2                          [printk_nmi_exit+0 -> printk_nmi_exit+16]     [kernel.kallsyms]
             0.00%               3        0.07%           3            [perf_sample_event_took+0 -> perf_sample_event_took+56]     [kernel.kallsyms]
             0.00%               1        0.02%           1         [perf_sample_event_took+184 -> perf_sample_event_took+185]     [kernel.kallsyms]
             0.00%              72        1.60%          72                        [perf_iterate_ctx+0 -> perf_iterate_ctx+50]     [kernel.kallsyms]
             0.00%               1        0.02%           1           [perf_event_nmi_handler+50 -> perf_event_nmi_handler+52]     [kernel.kallsyms]
             0.00%               1        0.02%           1           [perf_event_nmi_handler+57 -> perf_event_nmi_handler+63]     [kernel.kallsyms]
             0.00%               1        0.02%           1           [perf_event_nmi_handler+68 -> perf_event_nmi_handler+74]     [kernel.kallsyms]

 v3:
 ---
 1. Use common function block_info__process_sym to
    process the blocks per symbol.

 2. Remove the nasty hack for skipping calculation
    of column length

 3. Some minor cleanup

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  10 +
 tools/perf/builtin-report.c              | 343 ++++++++++++++++++++++-
 tools/perf/ui/stdio/hist.c               |  22 ++
 tools/perf/util/hist.c                   |   4 +
 tools/perf/util/sort.c                   |   5 +
 tools/perf/util/sort.h                   |   1 +
 tools/perf/util/symbol_conf.h            |   1 +
 7 files changed, 382 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7315f155803f..b1f9c93a91fd 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -124,6 +124,7 @@ OPTIONS
 	- in_tx: branch in TSX transaction
 	- abort: TSX transaction abort.
 	- cycles: Cycles in basic block
+	- total_cycles: sort all blocks by the 'Sampled Cycles%'.
 
 	And default sort keys are changed to comm, dso_from, symbol_from, dso_to
 	and symbol_to, see '--branch-stack'.
@@ -136,6 +137,15 @@ OPTIONS
 	executed, such as a memory access bottleneck. If a function has high overhead
 	and low IPC, it's worth further analyzing it to optimize its performance.
 
+	When the total_cycles is specified, it supports sorting for all blocks by the
+	'Sampled Cycles%'. This is useful to concentrate on the globally slowest blocks.
+	In output, there are some new columns:
+	'Sampled Cycles%' - block sampled cycles aggregation / total sampled cycles
+	'Sampled Cycles' - block sampled cycles aggregation
+	'Avg Cycles%' - block average sampled cycles / sum of total block average
+	sampled cycles
+	'Avg Cycles' - block average sampled cycles
+
 	If the --mem-mode option is used, the following sort keys are also available
 	(incompatible with --branch-stack):
 	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index cdb436d6e11f..44aed40e9071 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -51,6 +51,7 @@
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
+#include "util/block-info.h"
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -96,10 +97,64 @@ struct report {
 	float			min_percent;
 	u64			nr_entries;
 	u64			queue_size;
+	u64			cycles_count;
+	u64			block_cycles;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
 	bool			symbol_ipc;
+	bool			total_cycles;
+	struct block_hist	block_hist;
+};
+
+struct block_fmt {
+	struct perf_hpp_fmt	fmt;
+	int			idx;
+	int			width;
+	const char		*header;
+	struct report		*rep;
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
+static struct block_fmt block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
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
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -277,7 +332,8 @@ static int process_sample_event(struct perf_tool *tool,
 		if (!sample->branch_stack)
 			goto out_put;
 
-		iter.add_entry_cb = hist_iter__branch_callback;
+		if (!rep->total_cycles)
+			iter.add_entry_cb = hist_iter__branch_callback;
 		iter.ops = &hist_iter_branch;
 	} else if (rep->mem_mode) {
 		iter.ops = &hist_iter_mem;
@@ -290,9 +346,10 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
-	if (ui__has_annotation() || rep->symbol_ipc) {
+	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
-				     rep->nonany_branch_mode, NULL);
+				     rep->nonany_branch_mode,
+				     &rep->cycles_count);
 	}
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
@@ -480,6 +537,269 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
+static int block_column_header(struct perf_hpp_fmt *fmt __maybe_unused,
+			       struct perf_hpp *hpp __maybe_unused,
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
+static int block_column_width(struct perf_hpp_fmt *fmt __maybe_unused,
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
+	struct report *rep = block_fmt->rep;
+	struct block_info *bi = he->block_info;
+	double ratio = 0.0;
+	char buf[16];
+
+	if (rep->cycles_count)
+		ratio = (double)bi->cycles / (double)rep->cycles_count;
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
+	struct report *rep = block_fmt->rep;
+	struct block_info *bi_l = left->block_info;
+	struct block_info *bi_r = right->block_info;
+	double l, r;
+
+	if (rep->cycles_count) {
+		l = ((double)bi_l->cycles / (double)rep->cycles_count) * 1000.0;
+		r = ((double)bi_r->cycles / (double)rep->cycles_count) * 1000.0;
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
+	struct report *rep = block_fmt->rep;
+	struct block_info *bi = he->block_info;
+	double ratio = 0.0;
+	u64 avg;
+	char buf[16];
+
+	if (rep->block_cycles && bi->num_aggr) {
+		avg = bi->cycles_aggr / bi->num_aggr;
+		ratio = (double)avg / (double)rep->block_cycles;
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
+static void block_hpp_register(struct block_fmt *block_fmt, int idx,
+			       struct perf_hpp_list *hpp_list,
+			       struct report *rep)
+{
+	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
+
+	block_fmt->rep = rep;
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
+				   struct report *rep)
+{
+	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
+		block_hpp_register(&block_fmts[i], i, hpp_list, rep);
+}
+
+static void init_block_hist(struct block_hist *bh, struct report *rep)
+{
+	__hists__init(&bh->block_hists, &bh->block_list);
+	perf_hpp_list__init(&bh->block_list);
+	bh->block_list.nr_header_lines = 1;
+
+	register_block_columns(&bh->block_list, rep);
+
+	perf_hpp_list__register_sort_field(&bh->block_list,
+		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
+}
+
+static void get_block_hists(struct hists *hists, struct block_hist *bh,
+			    struct report *rep)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	struct hist_entry *he;
+
+	init_block_hist(bh, rep);
+
+	while (next) {
+		he = rb_entry(next, struct hist_entry, rb_node);
+		block_info__process_sym(he, bh, &rep->block_cycles,
+					rep->cycles_count);
+		next = rb_next(&he->rb_node);
+	}
+
+	hists__output_resort(&bh->block_hists, NULL);
+}
+
+static int hists__fprintf_all_blocks(struct hists *hists, struct report *rep)
+{
+	struct block_hist *bh = &rep->block_hist;
+
+	get_block_hists(hists, bh, rep);
+	symbol_conf.report_individual_block = true;
+	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
+		       stdout, true);
+	hists__delete_entries(&bh->block_hists);
+	return 0;
+}
+
 static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 					 struct report *rep,
 					 const char *help)
@@ -500,6 +820,12 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 			continue;
 
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
+
+		if (rep->total_cycles) {
+			hists__fprintf_all_blocks(hists, rep);
+			continue;
+		}
+
 		hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
 			       !(symbol_conf.use_callchain ||
 			         symbol_conf.show_branchflag_count));
@@ -1373,6 +1699,15 @@ int cmd_report(int argc, const char **argv)
 		goto error;
 	}
 
+	if (sort_order && strstr(sort_order, "total_cycles") &&
+	    (sort__mode == SORT_MODE__BRANCH)) {
+		report.total_cycles = true;
+		if (!report.use_stdio) {
+			pr_err("Error: -s total_cycles can be only used together with --stdio\n");
+			goto error;
+		}
+	}
+
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
 	else
@@ -1423,7 +1758,7 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation() || report.symbol_ipc) {
+	if (ui__has_annotation() || report.symbol_ipc || report.total_cycles) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 5365606e9dad..655ef7708cd0 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -558,6 +558,25 @@ static int hist_entry__block_fprintf(struct hist_entry *he,
 	return ret;
 }
 
+static int hist_entry__individual_block_fprintf(struct hist_entry *he,
+						char *bf, size_t size,
+						FILE *fp)
+{
+	int ret = 0;
+
+	struct perf_hpp hpp = {
+		.buf		= bf,
+		.size		= size,
+		.skip		= false,
+	};
+
+	hist_entry__snprintf(he, &hpp);
+	if (!hpp.skip)
+		ret += fprintf(fp, "%s\n", bf);
+
+	return ret;
+}
+
 static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 			       char *bf, size_t bfsz, FILE *fp,
 			       bool ignore_callchains)
@@ -580,6 +599,9 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 	if (symbol_conf.report_block)
 		return hist_entry__block_fprintf(he, bf, size, fp);
 
+	if (symbol_conf.report_individual_block)
+		return hist_entry__individual_block_fprintf(he, bf, size, fp);
+
 	hist_entry__snprintf(he, &hpp);
 
 	ret = fprintf(fp, "%s\n", bf);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0e27d6830011..7cf137b0451b 100644
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
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 43d1d410854a..eb286700a8a9 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -492,6 +492,10 @@ struct sort_entry sort_sym_ipc_null = {
 	.se_width_idx	= HISTC_SYMBOL_IPC,
 };
 
+struct sort_entry sort_block_cycles = {
+	.se_cmp		= sort__sym_cmp,
+};
+
 /* --sort srcfile */
 
 static char no_srcfile[1];
@@ -1695,6 +1699,7 @@ static struct sort_dimension bstack_sort_dimensions[] = {
 	DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
 	DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
 	DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
+	DIM(SORT_BLOCK_CYCLES, "total_cycles", sort_block_cycles),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5aff9542d9b7..2ede6c70ad56 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -239,6 +239,7 @@ enum sort_type {
 	SORT_SRCLINE_FROM,
 	SORT_SRCLINE_TO,
 	SORT_SYM_IPC,
+	SORT_BLOCK_CYCLES,
 
 	/* memory mode specific sort keys */
 	__SORT_MEMORY_MODE,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index e6880789864c..10f1ec3e0349 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -40,6 +40,7 @@ struct symbol_conf {
 			raw_trace,
 			report_hierarchy,
 			report_block,
+			report_individual_block,
 			inline_name,
 			disable_add2line_warn;
 	const char	*vmlinux_name,
-- 
2.17.1

