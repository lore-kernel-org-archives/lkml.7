Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4520ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031A920B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfJ1Be7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:34:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:49091 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbfJ1Beq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:34:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 18:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="224492460"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2019 18:34:44 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 5/7] perf report: Sort by sampled cycles percent per block for stdio
Date:   Mon, 28 Oct 2019 09:33:28 +0800
Message-Id: <20191028013330.18319-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028013330.18319-1-yao.jin@linux.intel.com>
References: <20191028013330.18319-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to support sorting for all blocks by the
sampled cycles percent per block. This is useful to concentrate
on the globally hottest blocks.

This patch implements a new option "--total-cycles" which sorts
all blocks by 'Sampled Cycles%'. The 'Sampled Cycles%' is the
percent:

 percent = block sampled cycles aggregation / total sampled cycles

Note that, this patch only supports "--stdio" mode.

For example,

perf record -b ./div
perf report --total-cycles --stdio

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

 v4:
 ---
 1. Use new option '--total-cycles' to replace
    '-s total_cycles' in v3.

 2. Move block info collection out of block info
    printing.

 v3:
 ---
 1. Use common function block_info__process_sym to
    process the blocks per symbol.

 2. Remove the nasty hack for skipping calculation
    of column length

 3. Some minor cleanup

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  11 ++
 tools/perf/builtin-report.c              | 125 ++++++++++++++++++++++-
 tools/perf/ui/stdio/hist.c               |  22 ++++
 tools/perf/util/hist.c                   |   4 +
 tools/perf/util/symbol_conf.h            |   1 +
 5 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7315f155803f..8dbe2119686a 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -525,6 +525,17 @@ include::itrace.txt[]
 	Configure time quantum for time sort key. Default 100ms.
 	Accepts s, us, ms, ns units.
 
+--total-cycles::
+	When --total-cycles is specified, it supports sorting for all blocks by
+	'Sampled Cycles%'. This is useful to concentrate on the globally hottest
+	blocks. In output, there are some new columns:
+
+	'Sampled Cycles%' - block sampled cycles aggregation / total sampled cycles
+	'Sampled Cycles'  - block sampled cycles aggregation
+	'Avg Cycles%'     - block average sampled cycles / sum of total block average
+			    sampled cycles
+	'Avg Cycles'      - block average sampled cycles
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index cdb436d6e11f..a687d9e4aeca 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -51,6 +51,7 @@
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
+#include "util/block-info.h"
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -67,6 +68,12 @@
 #include <unistd.h>
 #include <linux/mman.h>
 
+struct block_report {
+	struct block_hist	block_hist;
+	u64			block_cycles;
+	struct block_fmt	block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
+};
+
 struct report {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -96,10 +103,13 @@ struct report {
 	float			min_percent;
 	u64			nr_entries;
 	u64			queue_size;
+	u64			total_cycles;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
 	bool			symbol_ipc;
+	bool			total_cycles_mode;
+	struct block_report	*block_reports;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -290,9 +300,10 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
-	if (ui__has_annotation() || rep->symbol_ipc) {
+	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
-				     rep->nonany_branch_mode, NULL);
+				     rep->nonany_branch_mode,
+				     &rep->total_cycles);
 	}
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
@@ -480,11 +491,21 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
+static int hists__fprintf_all_blocks(struct block_hist *bh)
+{
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
 {
 	struct evsel *pos;
+	int i = 0;
 
 	if (!quiet) {
 		fprintf(stdout, "#\n# Total Lost Samples: %" PRIu64 "\n#\n",
@@ -494,12 +515,20 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 		const char *evname = perf_evsel__name(pos);
+		struct block_hist *block_hist;
 
 		if (symbol_conf.event_group &&
 		    !perf_evsel__is_group_leader(pos))
 			continue;
 
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
+
+		if (rep->total_cycles_mode) {
+			block_hist = &rep->block_reports[i++].block_hist;
+			hists__fprintf_all_blocks(block_hist);
+			continue;
+		}
+
 		hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
 			       !(symbol_conf.use_callchain ||
 			         symbol_conf.show_branchflag_count));
@@ -668,6 +697,72 @@ static void report__output_resort(struct report *rep)
 	ui_progress__finish();
 }
 
+static void register_block_columns(struct perf_hpp_list *hpp_list,
+				   struct block_fmt *block_fmts)
+{
+	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
+		block_info__hpp_register(&block_fmts[i], i, hpp_list);
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
+				 struct report *rep)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	struct block_hist *bh = &block_report->block_hist;
+	struct hist_entry *he;
+
+	init_block_hist(bh, block_report->block_fmts);
+
+	while (next) {
+		he = rb_entry(next, struct hist_entry, rb_node);
+		block_info__process_sym(he, bh, &block_report->block_cycles,
+					rep->total_cycles);
+		next = rb_next(&he->rb_node);
+	}
+
+	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++) {
+		block_info__set_fmt(&block_report->block_fmts[i],
+				    rep->total_cycles,
+				    block_report->block_cycles);
+	}
+
+	hists__output_resort(&bh->block_hists, NULL);
+}
+
+static int create_block_reports(struct evlist *evlist, struct report *rep)
+{
+	struct block_report *block_reports;
+	int nr_hists = evlist->core.nr_entries, i = 0;
+	struct evsel *pos;
+
+	block_reports = calloc(nr_hists, sizeof(struct block_report));
+	if (!block_reports)
+		return -1;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		process_block_report(hists, &block_reports[i], rep);
+		i++;
+	}
+
+	rep->block_reports = block_reports;
+	return 0;
+}
+
 static void stats_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
@@ -927,6 +1022,12 @@ static int __cmd_report(struct report *rep)
 
 	report__output_resort(rep);
 
+	if (rep->total_cycles_mode) {
+		ret = create_block_reports(session->evlist, rep);
+		if (ret)
+			return ret;
+	}
+
 	return report__browse_hists(rep);
 }
 
@@ -1211,6 +1312,8 @@ int cmd_report(int argc, const char **argv)
 		     "Set time quantum for time sort key (default 100ms)",
 		     parse_time_quantum),
 	OPTS_EVSWITCH(&report.evswitch),
+	OPT_BOOLEAN(0, "total-cycles", &report.total_cycles_mode,
+		    "Sort all blocks by 'Sampled Cycles%'"),
 	OPT_END()
 	};
 	struct perf_data data = {
@@ -1373,6 +1476,17 @@ int cmd_report(int argc, const char **argv)
 		goto error;
 	}
 
+	if (report.total_cycles_mode) {
+		if (sort__mode != SORT_MODE__BRANCH)
+			report.total_cycles_mode = false;
+		else if (!report.use_stdio) {
+			pr_err("Error: --total-cycles can be only used together with --stdio\n");
+			goto error;
+		} else {
+			sort_order = "sym";
+		}
+	}
+
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
 	else
@@ -1423,7 +1537,8 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation() || report.symbol_ipc) {
+	if (ui__has_annotation() || report.symbol_ipc ||
+	    report.total_cycles_mode) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
@@ -1484,6 +1599,10 @@ int cmd_report(int argc, const char **argv)
 		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&report.ptime_range);
 	}
+
+	if (report.block_reports)
+		zfree(&report.block_reports);
+
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return ret;
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

