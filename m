Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8365CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4078B2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbfGYFg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:36:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:13453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403828AbfGYFg0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:36:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 22:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="181351413"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2019 22:36:22 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf diff: Report noisy for cycles diff
Date:   Thu, 25 Jul 2019 06:14:32 +0800
Message-Id: <20190724221432.26297-1-yao.jin@linux.intel.com>
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

 # Event 'cycles'
 #
 # Baseline                                       [Program Block Range] Cycles Diff  Shared Object      Symbol
 # ........  ......................................................................  .................  ................................
 #
     46.42%                                             [div.c:40 -> div.c:40]    0  div                [.] main
     46.42%                                             [div.c:42 -> div.c:44]    0  div                [.] main
     46.42%                                             [div.c:42 -> div.c:39]    0  div                [.] main
     20.72%                                 [random_r.c:357 -> random_r.c:394]   -2  libc-2.27.so       [.] __random_r
     20.72%                                 [random_r.c:357 -> random_r.c:380]   -1  libc-2.27.so       [.] __random_r
     20.72%                                 [random_r.c:388 -> random_r.c:388]    0  libc-2.27.so       [.] __random_r
     20.72%                                 [random_r.c:388 -> random_r.c:391]    0  libc-2.27.so       [.] __random_r
     17.58%                                     [random.c:288 -> random.c:291]    0  libc-2.27.so       [.] __random
     17.58%                                     [random.c:291 -> random.c:291]    0  libc-2.27.so       [.] __random
     17.58%                                     [random.c:293 -> random.c:293]    0  libc-2.27.so       [.] __random
     17.58%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
     17.58%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
     17.58%                                     [random.c:298 -> random.c:298]    0  libc-2.27.so       [.] __random
      8.33%                                             [div.c:22 -> div.c:25]    0  div                [.] compute_flag
      8.33%                                             [div.c:27 -> div.c:28]    0  div                [.] compute_flag
      4.80%                                           [rand.c:26 -> rand.c:27]    0  libc-2.27.so       [.] rand
      4.80%                                           [rand.c:28 -> rand.c:28]    0  libc-2.27.so       [.] rand
      2.14%                                         [rand@plt+0 -> rand@plt+0]    0  div                [.] rand@plt

When we enable the option '-n' or '--noisy', the output is

perf diff -c cycles -n

 # Event 'cycles'
 #
 # Baseline                                     [Program Block Range]/Cycles Diff/stddev/Hist  Shared Object      Symbol
 # ........  ................................................................................  .................  ................................
 #
     46.42%                                    [div.c:40 -> div.c:40]    0  ± 40.2% ▂███▁▂▁▁   div                [.] main
     46.42%                                    [div.c:42 -> div.c:44]    0  ±100.0% ▁▁▁▁█▁▁▁   div                [.] main
     46.42%                                    [div.c:42 -> div.c:39]    0  ± 15.3% ▃▃▂▆▃▂█▁   div                [.] main
     20.72%                        [random_r.c:357 -> random_r.c:394]   -2  ± 20.1% ▁▄▄▅▂▅█▁   libc-2.27.so       [.] __random_r
     20.72%                        [random_r.c:357 -> random_r.c:380]   -1  ± 20.9% ▁▆▇▁█▅▇█   libc-2.27.so       [.] __random_r
     20.72%                        [random_r.c:388 -> random_r.c:388]    0  ±  0.0%            libc-2.27.so       [.] __random_r
     20.72%                        [random_r.c:388 -> random_r.c:391]    0  ± 88.0% ▁▁▁▁▁▁▁█   libc-2.27.so       [.] __random_r
     17.58%                            [random.c:288 -> random.c:291]    0  ± 29.3% ▁████▁█▁   libc-2.27.so       [.] __random
     17.58%                            [random.c:291 -> random.c:291]    0  ± 29.3% ▁████▁▁█   libc-2.27.so       [.] __random
     17.58%                            [random.c:293 -> random.c:293]    0  ± 29.3% ▁████▁▁█   libc-2.27.so       [.] __random
     17.58%                            [random.c:295 -> random.c:295]    0  ±  0.0%            libc-2.27.so       [.] __random
     17.58%                            [random.c:295 -> random.c:295]    0  ±  0.0%            libc-2.27.so       [.] __random
     17.58%                            [random.c:298 -> random.c:298]    0  ±  0.0%            libc-2.27.so       [.] __random
      8.33%                                    [div.c:22 -> div.c:25]    0  ± 29.3% ▁████▁█▁   div                [.] compute_flag
      8.33%                                    [div.c:27 -> div.c:28]    0  ± 48.8% ▁██▁▁▁█▁   div                [.] compute_flag
      4.80%                                  [rand.c:26 -> rand.c:27]    0  ± 29.3% ▁████▁█▁   libc-2.27.so       [.] rand
      4.80%                                  [rand.c:28 -> rand.c:28]    0  ±  0.0%            libc-2.27.so       [.] rand
      2.14%                                [rand@plt+0 -> rand@plt+0]    0  ±  0.0%            div                [.] rand@plt

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
 tools/perf/Documentation/perf-diff.txt |  5 ++
 tools/perf/builtin-diff.c              | 94 +++++++++++++++++++++++---
 tools/perf/util/Build                  |  1 +
 tools/perf/util/annotate.c             |  4 ++
 tools/perf/util/annotate.h             |  2 +
 tools/perf/util/sort.h                 |  2 +
 tools/perf/util/spark.c                | 35 ++++++++++
 tools/perf/util/spark.h                |  6 ++
 tools/perf/util/stat.c                 | 37 ++++++++++
 tools/perf/util/stat.h                 | 10 +++
 tools/perf/util/symbol.h               |  2 +
 11 files changed, 187 insertions(+), 11 deletions(-)
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
index e91c0d798181..43ac0ed06679 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -48,6 +48,7 @@ enum {
 	PERF_HPP_DIFF__FORMULA,
 	PERF_HPP_DIFF__DELTA_ABS,
 	PERF_HPP_DIFF__CYCLES,
+	PERF_HPP_DIFF__CYCLES_NOISY,
 
 	PERF_HPP_DIFF__MAX_INDEX
 };
@@ -82,6 +83,7 @@ static bool force;
 static bool show_period;
 static bool show_formula;
 static bool show_baseline_only;
+static bool show_noisy;
 static unsigned int sort_compute = 1;
 
 static s64 compute_wdiff_w1;
@@ -159,6 +161,10 @@ static struct header_column {
 	[PERF_HPP_DIFF__CYCLES] = {
 		.name  = "[Program Block Range] Cycles Diff",
 		.width = 70,
+	},
+	[PERF_HPP_DIFF__CYCLES_NOISY] = {
+		.name  = "[Program Block Range]/Cycles Diff/stddev/Hist",
+		.width = 80,
 	}
 };
 
@@ -605,6 +611,9 @@ static void init_block_info(struct block_info *bi, struct symbol *sym,
 	bi->cycles_aggr = ch->cycles_aggr;
 	bi->num = ch->num;
 	bi->num_aggr = ch->num_aggr;
+
+	memcpy(bi->cycles_spark, ch->cycles_spark,
+	       NUM_SPARK_VALS * sizeof(u64));
 }
 
 static int process_block_per_sym(struct hist_entry *he)
@@ -692,6 +701,17 @@ static void compute_cycles_diff(struct hist_entry *he,
 		pair->diff.cycles =
 			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
 			he->block_info->cycles_aggr / he->block_info->num_aggr;
+
+		init_stats(&pair->diff.stats);
+
+		for (int i = 0; i < pair->block_info->num; i++) {
+			if (i >= he->block_info->num || i >= NUM_SPARK_VALS)
+				break;
+
+			update_stats(&pair->diff.stats,
+				     labs(pair->block_info->cycles_spark[i] -
+				     he->block_info->cycles_spark[i]));
+		}
 	}
 }
 
@@ -1250,6 +1270,8 @@ static const struct option options[] = {
 		    "Show period values."),
 	OPT_BOOLEAN('F', "formula", &show_formula,
 		    "Show formula."),
+	OPT_BOOLEAN('n', "noisy", &show_noisy,
+		    "Show cycles noisy - WARNING: use only with -c cycles."),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
@@ -1322,14 +1344,17 @@ static int hpp__entry_baseline(struct hist_entry *he, char *buf, size_t size)
 }
 
 static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
-			 struct perf_hpp *hpp, int width)
+			 struct perf_hpp *hpp, int width __maybe_unused)
 {
 	struct block_hist *bh = container_of(he, struct block_hist, he);
 	struct block_hist *bh_pair = container_of(pair, struct block_hist, he);
 	struct hist_entry *block_he;
 	struct block_info *bi;
-	char buf[128];
+	char buf[128], spark[32];
 	char *start_line, *end_line;
+	int ret = 0, pad;
+	char pfmt[20] = " ";
+	double d;
 
 	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
 	if (!block_he) {
@@ -1350,18 +1375,56 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
-		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
-			  start_line, end_line, block_he->diff.cycles);
+	if (show_noisy) {
+		ret = print_stat_spark(spark, sizeof(spark),
+				       &block_he->diff.stats);
+		d = rel_stddev_stats(stddev_stats(&block_he->diff.stats),
+				     avg_stats(&block_he->diff.stats));
+
+		if ((start_line != SRCLINE_UNKNOWN) &&
+		    (end_line != SRCLINE_UNKNOWN)) {
+			scnprintf(buf, sizeof(buf),
+				  "[%s -> %s] %4ld  %s%5.1f%% %s",
+				  start_line, end_line, block_he->diff.cycles,
+				  "\u00B1", d, spark);
+		} else {
+			scnprintf(buf, sizeof(buf),
+				  "[%7lx -> %7lx] %4ld  %s%5.1f%% %s",
+				  bi->start, bi->end, block_he->diff.cycles,
+				  "\u00B1", d, spark);
+		}
+
+		if (ret > 0) {
+			pad = 8 - ((ret - 1) / 3);
+			scnprintf(pfmt, 20, "%%%ds",
+				  81 + (2 * ((ret - 1) / 3)) - pad);
+			ret = scnprintf(hpp->buf, hpp->size, pfmt, buf);
+			if (pad > 0) {
+				ret += scnprintf(hpp->buf + ret,
+						 hpp->size - ret,
+						 "%-*s", pad, " ");
+			}
+		} else {
+			ret = scnprintf(hpp->buf, hpp->size, "%73s", buf);
+			ret += scnprintf(hpp->buf + ret, hpp->size - ret,
+					 "%-*s", 8, " ");
+		}
 	} else {
-		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
-			  bi->start, bi->end, block_he->diff.cycles);
+		if ((start_line != SRCLINE_UNKNOWN) &&
+		    (end_line != SRCLINE_UNKNOWN)) {
+			scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
+				  start_line, end_line, block_he->diff.cycles);
+		} else {
+			scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
+				  bi->start, bi->end, block_he->diff.cycles);
+		}
+
+		ret = scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
 	}
 
 	free_srcline(start_line);
 	free_srcline(end_line);
-
-	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+	return ret;
 }
 
 static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
@@ -1659,6 +1722,7 @@ static void data__hpp_register(struct data__file *d, int idx)
 		fmt->sort  = hist_entry__cmp_delta_abs;
 		break;
 	case PERF_HPP_DIFF__CYCLES:
+	case PERF_HPP_DIFF__CYCLES_NOISY:
 		fmt->color = hpp__color_cycles;
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
@@ -1688,8 +1752,13 @@ static int ui_init(void)
 		 *   PERF_HPP_DIFF__RATIO
 		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
 		 */
-		data__hpp_register(d, i ? compute_2_hpp[compute] :
-					  PERF_HPP_DIFF__BASELINE);
+		if (!show_noisy) {
+			data__hpp_register(d, i ? compute_2_hpp[compute] :
+						  PERF_HPP_DIFF__BASELINE);
+		} else if (compute == COMPUTE_CYCLES) {
+			data__hpp_register(d, i ? PERF_HPP_DIFF__CYCLES_NOISY :
+						  PERF_HPP_DIFF__BASELINE);
+		}
 
 		/*
 		 * And the rest:
@@ -1845,6 +1914,9 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	if (show_noisy && (compute != COMPUTE_CYCLES))
+		usage_with_options(diff_usage, options);
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 08f670d21615..49ac5c8d0bba 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -90,6 +90,7 @@ perf-y += cloexec.o
 perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
+perf-y += spark.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d46f2ae2c695..c47ab902dbb6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -847,6 +847,10 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 			   ch[offset].start < start)
 			return 0;
 	}
+
+	if (ch[offset].num < NUM_SPARK_VALS)
+		ch[offset].cycles_spark[ch[offset].num] = cycles;
+
 	ch[offset].have_start = have_start;
 	ch[offset].start = start;
 	ch[offset].cycles += cycles;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d94be9140e31..54ce7f3231f2 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <pthread.h>
 #include <asm/bug.h>
 #include "symbol_conf.h"
+#include "stat.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -235,6 +236,7 @@ struct cyc_hist {
 	u64	cycles_aggr;
 	u64	cycles_max;
 	u64	cycles_min;
+	s64	cycles_spark[NUM_SPARK_VALS];
 	u32	num;
 	u32	num_aggr;
 	u8	have_start;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5e34676a98e8..267abf743ffd 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -23,6 +23,7 @@
 #include "parse-events.h"
 #include "hist.h"
 #include "srcline.h"
+#include "stat.h"
 
 struct thread;
 
@@ -83,6 +84,7 @@ struct hist_entry_diff {
 		/* PERF_HPP_DIFF__CYCLES */
 		s64	cycles;
 	};
+	struct stats	stats;
 };
 
 struct hist_entry_ops {
diff --git a/tools/perf/util/spark.c b/tools/perf/util/spark.c
new file mode 100644
index 000000000000..25f280d547a6
--- /dev/null
+++ b/tools/perf/util/spark.c
@@ -0,0 +1,35 @@
+#include <stdio.h>
+#include <limits.h>
+#include <string.h>
+#include <stdlib.h>
+#include "spark.h"
+#include "stat.h"
+
+#define NUM_SPARKS 8
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
index 000000000000..19bab3adcd3a
--- /dev/null
+++ b/tools/perf/util/spark.h
@@ -0,0 +1,6 @@
+#ifndef SPARK_H
+#define SPARK_H 1
+
+int print_spark(char *bf, int size, unsigned long *val, int numval);
+
+#endif
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 799f3c0a9050..81ce99c14e52 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -6,11 +6,16 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
+#include "spark.h"
 #include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
 {
 	double delta;
+	int n = stats->n;
+
+	if (n < NUM_SPARK_VALS)
+		stats->svals[n] = val;
 
 	stats->n++;
 	delta = val - stats->mean;
@@ -24,6 +29,38 @@ void update_stats(struct stats *stats, u64 val)
 		stats->min = val;
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
+int print_stat_spark(char *bf, int size, struct stats *stat)
+{
+	int len, printed;
+
+	if (stat->n <= 1)
+		return 0;
+
+	len = stat->n;
+	if (len > NUM_SPARK_VALS)
+		len = NUM_SPARK_VALS;
+	if (all_zero(stat->svals, len))
+		return 0;
+
+	printed = print_spark(bf, size, stat->svals, len);
+	printed += scnprintf(bf + printed, size - printed, " ");
+
+	if (stat->n > NUM_SPARK_VALS)
+		printed += scnprintf(bf + printed, size - printed, "..");
+
+	return printed;
+}
+
 double avg_stats(struct stats *stats)
 {
 	return stats->mean;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 95b4de7a9d51..3448d319a220 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -8,14 +8,18 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
+#include <stdio.h>
 #include "xyarray.h"
 #include "rblist.h"
 #include "perf.h"
 #include "event.h"
 
+#define NUM_SPARK_VALS	8 /* support spark line on first N items */
+
 struct stats {
 	double n, mean, M2;
 	u64 max, min;
+	unsigned long svals[NUM_SPARK_VALS];
 };
 
 enum perf_stat_evsel_id {
@@ -134,13 +138,19 @@ double avg_stats(struct stats *stats);
 double stddev_stats(struct stats *stats);
 double rel_stddev_stats(double stddev, double avg);
 
+int print_stat_spark(char *bf, int size, struct stats *stat);
+
 static inline void init_stats(struct stats *stats)
 {
+	int i;
+
 	stats->n    = 0.0;
 	stats->mean = 0.0;
 	stats->M2   = 0.0;
 	stats->min  = (u64) -1;
 	stats->max  = 0;
+	for (i = 0; i < NUM_SPARK_VALS; i++)
+		stats->svals[i] = 0;
 }
 
 struct evsel;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 12755b42ea93..3b8212f0a738 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -12,6 +12,7 @@
 #include "branch.h"
 #include "path.h"
 #include "symbol_conf.h"
+#include "stat.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 #include <libelf.h>
@@ -137,6 +138,7 @@ struct block_info {
 	u64			end;
 	u64			cycles;
 	u64			cycles_aggr;
+	s64			cycles_spark[NUM_SPARK_VALS];
 	int			num;
 	int			num_aggr;
 	refcount_t		refcnt;
-- 
2.17.1

