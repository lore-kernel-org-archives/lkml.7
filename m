Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD90C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFFB2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfHIXbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 19:31:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:37307 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfHIXbK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 19:31:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 16:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="374638329"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2019 16:31:07 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3] perf diff: Report noisy for cycles diff
Date:   Sat, 10 Aug 2019 07:30:29 +0800
Message-Id: <20190809233029.12265-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prints the stddev and hist for the cycles diff of
program block. It can help us to understand if the cycles diff
is noisy or not.

This patch is inspired by Andi Kleen's patch
https://lwn.net/Articles/600471/

We create new option '-n or --noisy'.

Example:

perf record -b ./div
perf record -b ./div
perf diff -c cycles

 # Baseline                                       [Program Block Range] Cycles Diff  Shared Object      Symbol
 # ........  ......................................................................  .................  ............................
 #
     46.72%                                             [div.c:40 -> div.c:40]    0  div                [.] main
     46.72%                                             [div.c:42 -> div.c:44]    0  div                [.] main
     46.72%                                             [div.c:42 -> div.c:39]    0  div                [.] main
     20.54%                                 [random_r.c:357 -> random_r.c:394]    1  libc-2.27.so       [.] __random_r
     20.54%                                 [random_r.c:357 -> random_r.c:380]    0  libc-2.27.so       [.] __random_r
     20.54%                                 [random_r.c:388 -> random_r.c:388]    0  libc-2.27.so       [.] __random_r
     20.54%                                 [random_r.c:388 -> random_r.c:391]    0  libc-2.27.so       [.] __random_r
     17.04%                                     [random.c:288 -> random.c:291]    0  libc-2.27.so       [.] __random
     17.04%                                     [random.c:291 -> random.c:291]    0  libc-2.27.so       [.] __random
     17.04%                                     [random.c:293 -> random.c:293]    0  libc-2.27.so       [.] __random
     17.04%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
     17.04%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
     17.04%                                     [random.c:298 -> random.c:298]    0  libc-2.27.so       [.] __random
      8.40%                                             [div.c:22 -> div.c:25]    0  div                [.] compute_flag
      8.40%                                             [div.c:27 -> div.c:28]    0  div                [.] compute_flag
      5.14%                                           [rand.c:26 -> rand.c:27]    0  libc-2.27.so       [.] rand
      5.14%                                           [rand.c:28 -> rand.c:28]    0  libc-2.27.so       [.] rand
      2.15%                                         [rand@plt+0 -> rand@plt+0]    0  div                [.] rand@plt
      0.00%                                                                          [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
      0.00%                                       [do_mmap+714 -> do_mmap+732]  -10  [kernel.kallsyms]  [k] do_mmap
      0.00%                                       [do_mmap+737 -> do_mmap+765]    1  [kernel.kallsyms]  [k] do_mmap
      0.00%                                       [do_mmap+262 -> do_mmap+299]    0  [kernel.kallsyms]  [k] do_mmap
      0.00%         [__x86_indirect_thunk_r15+0 -> __x86_indirect_thunk_r15+0]    7  [kernel.kallsyms]  [k] __x86_indirect_thunk_r15
      0.00%                   [native_sched_clock+0 -> native_sched_clock+119]   -1  [kernel.kallsyms]  [k] native_sched_clock
      0.00%                        [native_write_msr+0 -> native_write_msr+16]  -13  [kernel.kallsyms]  [k] native_write_msr

When we enable the option '-n' or '--noisy', the output is

perf diff -c cycles -n or perf diff -c cycles --noisy

 # Baseline                                       [Program Block Range] Cycles Diff        stddev/Hist  Shared Object      Symbol
 # ........  ......................................................................  .................  .................  ............................
 #
     46.72%                                             [div.c:40 -> div.c:40]    0  ± 37.8% ▁█▁▁██▁█   div                [.] main
     46.72%                                             [div.c:42 -> div.c:44]    0  ± 49.4% ▁▁▂█▂▂▂▂   div                [.] main
     46.72%                                             [div.c:42 -> div.c:39]    0  ± 24.1% ▃█▂▄▁▃▂▁   div                [.] main
     20.54%                                 [random_r.c:357 -> random_r.c:394]    1  ± 33.5% ▅▂▁█▃▁▂▁   libc-2.27.so       [.] __random_r
     20.54%                                 [random_r.c:357 -> random_r.c:380]    0  ± 39.4% ▁▁█▁██▅▁   libc-2.27.so       [.] __random_r
     20.54%                                 [random_r.c:388 -> random_r.c:388]    0                     libc-2.27.so       [.] __random_r
     20.54%                                 [random_r.c:388 -> random_r.c:391]    0  ± 41.2% ▁▃▁▂█▄▃▁   libc-2.27.so       [.] __random_r
     17.04%                                     [random.c:288 -> random.c:291]    0  ± 48.8% ▁▁▁▁███▁   libc-2.27.so       [.] __random
     17.04%                                     [random.c:291 -> random.c:291]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
     17.04%                                     [random.c:293 -> random.c:293]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
     17.04%                                     [random.c:295 -> random.c:295]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
     17.04%                                     [random.c:295 -> random.c:295]    0                     libc-2.27.so       [.] __random
     17.04%                                     [random.c:298 -> random.c:298]    0  ± 75.6% ▃█▁▁▁▁▁▁   libc-2.27.so       [.] __random
      8.40%                                             [div.c:22 -> div.c:25]    0  ± 42.1% ▁▃▁▁███▁   div                [.] compute_flag
      8.40%                                             [div.c:27 -> div.c:28]    0  ± 41.8% ██▁▁▄▁▁▄   div                [.] compute_flag
      5.14%                                           [rand.c:26 -> rand.c:27]    0  ± 37.8% ▁▁▁████▁   libc-2.27.so       [.] rand
      5.14%                                           [rand.c:28 -> rand.c:28]    0                     libc-2.27.so       [.] rand
      2.15%                                         [rand@plt+0 -> rand@plt+0]    0                     div                [.] rand@plt
      0.00%                                                                                             [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
      0.00%                                       [do_mmap+714 -> do_mmap+732]  -10                     [kernel.kallsyms]  [k] do_mmap
      0.00%                                       [do_mmap+737 -> do_mmap+765]    1                     [kernel.kallsyms]  [k] do_mmap
      0.00%                                       [do_mmap+262 -> do_mmap+299]    0                     [kernel.kallsyms]  [k] do_mmap
      0.00%         [__x86_indirect_thunk_r15+0 -> __x86_indirect_thunk_r15+0]    7                     [kernel.kallsyms]  [k] __x86_indirect_thunk_r15
      0.00%                   [native_sched_clock+0 -> native_sched_clock+119]   -1  ± 38.5% ▄█▁        [kernel.kallsyms]  [k] native_sched_clock
      0.00%                        [native_write_msr+0 -> native_write_msr+16]  -13  ± 47.1% ▁█▇▃▁▁     [kernel.kallsyms]  [k] native_write_msr

 v3:
 ---
 1. Move the histogram to a separate column
 2. Move the svals[] out of struct stats

 v2:
 ---
 Jiri got a compile error,

  CC       builtin-diff.o
builtin-diff.c: In function ‘compute_cycles_diff’:
builtin-diff.c:712:10: error: taking the absolute value of unsigned type ‘u64’ {aka ‘long unsigned int’} has no effect [-Werror=absolute-value]
  712 |          labs(pair->block_info->cycles_spark[i] -
      |          ^~~~

 Because the result of u64 - u64 is still u64. Now we change the type of
 cycles_spark[] to s64.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt |   5 +
 tools/perf/builtin-diff.c              | 150 ++++++++++++++++++++++++-
 tools/perf/util/Build                  |   1 +
 tools/perf/util/annotate.c             |   4 +
 tools/perf/util/annotate.h             |   2 +
 tools/perf/util/sort.h                 |   4 +
 tools/perf/util/spark.c                |  34 ++++++
 tools/perf/util/spark.h                |   8 ++
 tools/perf/util/symbol.h               |   2 +
 9 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/spark.c
 create mode 100644 tools/perf/util/spark.h

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index d5cc15e651cf..d9112f201a0d 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -95,6 +95,11 @@ OPTIONS
         diff.compute config option.  See COMPARISON METHODS section for
         more info.
 
+-n::
+--noisy::
+	Show cycles noisy data, such as stddev and hists. Should use
+	with '-c cycles'.
+
 -p::
 --period::
         Show period values for both compared hist entries.
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e91c0d798181..c1d205bfdf3d 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -21,6 +21,7 @@
 #include "util/time-utils.h"
 #include "util/annotate.h"
 #include "util/map.h"
+#include "util/spark.h"
 #include <linux/zalloc.h>
 
 #include <errno.h>
@@ -48,6 +49,7 @@ enum {
 	PERF_HPP_DIFF__FORMULA,
 	PERF_HPP_DIFF__DELTA_ABS,
 	PERF_HPP_DIFF__CYCLES,
+	PERF_HPP_DIFF__NOISY,
 
 	PERF_HPP_DIFF__MAX_INDEX
 };
@@ -82,6 +84,7 @@ static bool force;
 static bool show_period;
 static bool show_formula;
 static bool show_baseline_only;
+static bool show_noisy;
 static unsigned int sort_compute = 1;
 
 static s64 compute_wdiff_w1;
@@ -159,6 +162,10 @@ static struct header_column {
 	[PERF_HPP_DIFF__CYCLES] = {
 		.name  = "[Program Block Range] Cycles Diff",
 		.width = 70,
+	},
+	[PERF_HPP_DIFF__NOISY] = {
+		.name  = "stddev/Hist",
+		.width = NUM_SPARKS + 9,
 	}
 };
 
@@ -605,6 +612,9 @@ static void init_block_info(struct block_info *bi, struct symbol *sym,
 	bi->cycles_aggr = ch->cycles_aggr;
 	bi->num = ch->num;
 	bi->num_aggr = ch->num_aggr;
+
+	memcpy(bi->cycles_spark, ch->cycles_spark,
+	       NUM_SPARKS * sizeof(u64));
 }
 
 static int process_block_per_sym(struct hist_entry *he)
@@ -684,6 +694,21 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
 	return NULL;
 }
 
+static void init_spark_values(unsigned long *svals, int num)
+{
+	for (int i = 0; i < num; i++)
+		svals[i] = 0;
+}
+
+static void update_spark_value(unsigned long *svals, int num,
+			       struct stats *stats, u64 val)
+{
+	int n = stats->n;
+
+	if (n < num)
+		svals[n] = val;
+}
+
 static void compute_cycles_diff(struct hist_entry *he,
 				struct hist_entry *pair)
 {
@@ -692,6 +717,23 @@ static void compute_cycles_diff(struct hist_entry *he,
 		pair->diff.cycles =
 			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
 			he->block_info->cycles_aggr / he->block_info->num_aggr;
+
+		init_stats(&pair->diff.stats);
+		init_spark_values(pair->diff.svals, NUM_SPARKS);
+
+		for (int i = 0; i < pair->block_info->num; i++) {
+			u64 val;
+
+			if (i >= he->block_info->num || i >= NUM_SPARKS)
+				break;
+
+			val = labs(pair->block_info->cycles_spark[i] -
+				     he->block_info->cycles_spark[i]);
+
+			update_spark_value(pair->diff.svals, NUM_SPARKS,
+					   &pair->diff.stats, val);
+			update_stats(&pair->diff.stats, val);
+		}
 	}
 }
 
@@ -1250,6 +1292,8 @@ static const struct option options[] = {
 		    "Show period values."),
 	OPT_BOOLEAN('F', "formula", &show_formula,
 		    "Show formula."),
+	OPT_BOOLEAN('n', "noisy", &show_noisy,
+		    "Show cycles noisy - WARNING: use only with -c cycles."),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
@@ -1457,6 +1501,94 @@ static int hpp__color_cycles(struct perf_hpp_fmt *fmt,
 	return __hpp__color_compare(fmt, hpp, he, COMPUTE_CYCLES);
 }
 
+static int all_zero(unsigned long *vals, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (vals[i] != 0)
+			return 0;
+	return 1;
+}
+
+static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
+{
+	int len = n, printed;
+
+	if (len <= 1)
+		return 0;
+
+	if (len > NUM_SPARKS)
+		len = NUM_SPARKS;
+	if (all_zero(svals, len))
+		return 0;
+
+	printed = print_spark(bf, size, svals, len);
+	printed += scnprintf(bf + printed, size - printed, " ");
+
+	if (n > NUM_SPARKS)
+		printed += scnprintf(bf + printed, size - printed, "..");
+
+	return printed;
+}
+
+static int hpp__color_noisy(struct perf_hpp_fmt *fmt,
+			    struct perf_hpp *hpp, struct hist_entry *he)
+{
+	struct diff_hpp_fmt *dfmt =
+		container_of(fmt, struct diff_hpp_fmt, fmt);
+	struct hist_entry *pair = get_pair_fmt(he, dfmt);
+	struct block_hist *bh = container_of(he, struct block_hist, he);
+	struct block_hist *bh_pair;
+	struct hist_entry *block_he;
+	char spark[32], buf[128];
+	double r;
+	int ret, pad;
+
+	if (!pair) {
+		if (bh->block_idx)
+			hpp->skip = true;
+
+		goto no_print;
+	}
+
+	bh_pair = container_of(pair, struct block_hist, he);
+
+	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
+	if (!block_he) {
+		hpp->skip = true;
+		goto no_print;
+	}
+
+	ret = print_cycles_spark(spark, sizeof(spark), block_he->diff.svals,
+				 block_he->diff.stats.n);
+
+	r = rel_stddev_stats(stddev_stats(&block_he->diff.stats),
+			     avg_stats(&block_he->diff.stats));
+
+	if (ret) {
+		/*
+		 * Padding spaces if number of sparks less than NUM_SPARKS
+		 * otherwise the output is not aligned.
+		 */
+		pad = NUM_SPARKS - ((ret - 1) / 3);
+		scnprintf(buf, sizeof(buf), "%s%5.1f%% %s", "\u00B1", r, spark);
+		ret = scnprintf(hpp->buf, hpp->size, "%*s",
+				dfmt->header_width, buf);
+
+		if (pad) {
+			ret += scnprintf(hpp->buf + ret, hpp->size - ret,
+					 "%-*s", pad, " ");
+		}
+
+		return ret;
+	}
+
+no_print:
+	return scnprintf(hpp->buf, hpp->size, "%*s",
+			dfmt->header_width, " ");
+}
+
 static void
 hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
 {
@@ -1662,6 +1794,10 @@ static void data__hpp_register(struct data__file *d, int idx)
 		fmt->color = hpp__color_cycles;
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
+	case PERF_HPP_DIFF__NOISY:
+		fmt->color = hpp__color_noisy;
+		fmt->sort  = hist_entry__cmp_nop;
+		break;
 	default:
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
@@ -1688,8 +1824,15 @@ static int ui_init(void)
 		 *   PERF_HPP_DIFF__RATIO
 		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
 		 */
-		data__hpp_register(d, i ? compute_2_hpp[compute] :
-					  PERF_HPP_DIFF__BASELINE);
+		if (show_noisy && (compute == COMPUTE_CYCLES)) {
+			data__hpp_register(d, i ? PERF_HPP_DIFF__CYCLES :
+						  PERF_HPP_DIFF__BASELINE);
+			data__hpp_register(d, i ? PERF_HPP_DIFF__NOISY :
+						  PERF_HPP_DIFF__BASELINE);
+		} else {
+			data__hpp_register(d, i ? compute_2_hpp[compute] :
+						  PERF_HPP_DIFF__BASELINE);
+		}
 
 		/*
 		 * And the rest:
@@ -1845,6 +1988,9 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	if (show_noisy && (compute != COMPUTE_CYCLES))
+		usage_with_options(diff_usage, options);
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7abf05131889..8dc5b1dd9c5a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -89,6 +89,7 @@ perf-y += cloexec.o
 perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
+perf-y += spark.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 91d4fc3e78cf..d30723c9630a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -847,6 +847,10 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 			   ch[offset].start < start)
 			return 0;
 	}
+
+	if (ch[offset].num < NUM_SPARKS)
+		ch[offset].cycles_spark[ch[offset].num] = cycles;
+
 	ch[offset].have_start = have_start;
 	ch[offset].start = start;
 	ch[offset].cycles += cycles;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d94be9140e31..7776ff4480af 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <pthread.h>
 #include <asm/bug.h>
 #include "symbol_conf.h"
+#include "spark.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -235,6 +236,7 @@ struct cyc_hist {
 	u64	cycles_aggr;
 	u64	cycles_max;
 	u64	cycles_min;
+	s64	cycles_spark[NUM_SPARKS];
 	u32	num;
 	u32	num_aggr;
 	u8	have_start;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5e34676a98e8..14061e42a862 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -23,6 +23,8 @@
 #include "parse-events.h"
 #include "hist.h"
 #include "srcline.h"
+#include "stat.h"
+#include "spark.h"
 
 struct thread;
 
@@ -83,6 +85,8 @@ struct hist_entry_diff {
 		/* PERF_HPP_DIFF__CYCLES */
 		s64	cycles;
 	};
+	struct stats	stats;
+	unsigned long	svals[NUM_SPARKS];
 };
 
 struct hist_entry_ops {
diff --git a/tools/perf/util/spark.c b/tools/perf/util/spark.c
new file mode 100644
index 000000000000..70272a8b81a6
--- /dev/null
+++ b/tools/perf/util/spark.c
@@ -0,0 +1,34 @@
+#include <stdio.h>
+#include <limits.h>
+#include <string.h>
+#include <stdlib.h>
+#include "spark.h"
+#include "stat.h"
+
+#define SPARK_SHIFT 8
+
+/* Print spark lines on outf for numval values in val. */
+int print_spark(char *bf, int size, unsigned long *val, int numval)
+{
+	static const char *ticks[NUM_SPARKS] = {
+		"▁",  "▂", "▃", "▄", "▅", "▆", "▇", "█"
+	};
+	int i, printed = 0;
+	unsigned long min = ULONG_MAX, max = 0, f;
+
+	for (i = 0; i < numval; i++) {
+		if (val[i] < min)
+			min = val[i];
+		if (val[i] > max)
+			max = val[i];
+	}
+	f = ((max - min) << SPARK_SHIFT) / (NUM_SPARKS - 1);
+	if (f < 1)
+		f = 1;
+	for (i = 0; i < numval; i++) {
+		printed += scnprintf(bf + printed, size - printed, "%s",
+				     ticks[((val[i] - min) << SPARK_SHIFT) / f]);
+	}
+
+	return printed;
+}
diff --git a/tools/perf/util/spark.h b/tools/perf/util/spark.h
new file mode 100644
index 000000000000..25402d7d7a64
--- /dev/null
+++ b/tools/perf/util/spark.h
@@ -0,0 +1,8 @@
+#ifndef SPARK_H
+#define SPARK_H 1
+
+#define NUM_SPARKS 8
+
+int print_spark(char *bf, int size, unsigned long *val, int numval);
+
+#endif
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 12755b42ea93..ca4d55b68be4 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -12,6 +12,7 @@
 #include "branch.h"
 #include "path.h"
 #include "symbol_conf.h"
+#include "spark.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 #include <libelf.h>
@@ -137,6 +138,7 @@ struct block_info {
 	u64			end;
 	u64			cycles;
 	u64			cycles_aggr;
+	s64			cycles_spark[NUM_SPARKS];
 	int			num;
 	int			num_aggr;
 	refcount_t		refcnt;
-- 
2.17.1

