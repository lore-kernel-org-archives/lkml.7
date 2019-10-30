Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA32CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A003A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJ3GFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:05:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:63903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfJ3GFx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:05:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="225217077"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2019 23:05:51 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 6/7] perf report: Support --percent-limit for --total-cycles
Date:   Wed, 30 Oct 2019 14:04:29 +0800
Message-Id: <20191030060430.23558-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030060430.23558-1-yao.jin@linux.intel.com>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already supported the '--total-cycles' option in previous
patch. It's also useful to show entries only above a threshold
percent.

This patch enables '--percent-limit' for not showing entries
under that percent.

For example,

 perf report --total-cycles --stdio --percent-limit 1

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

It only shows the entries which 'Sampled Cycles%' > 1%.

 v5:
 ---
 No functional change. Only fix the conflict issue because
 previous patches are changed.

 v4:
 ---
 No functional change. Only fix the build issue because
 previous patches are changed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c  |  6 +++---
 tools/perf/ui/stdio/hist.c   |  7 ++++++-
 tools/perf/util/block-info.c | 10 ++++++++++
 tools/perf/util/block-info.h |  2 ++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0c53371c286a..516243715190 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -485,10 +485,10 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
-static int hists__fprintf_all_blocks(struct block_hist *bh)
+static int hists__fprintf_all_blocks(struct block_hist *bh, float min_percent)
 {
 	symbol_conf.report_individual_block = true;
-	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
+	hists__fprintf(&bh->block_hists, true, 0, 0, min_percent,
 		       stdout, true);
 	hists__delete_entries(&bh->block_hists);
 	return 0;
@@ -519,7 +519,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 
 		if (rep->total_cycles_mode) {
 			block_hist = &rep->block_reports[i++].hist;
-			hists__fprintf_all_blocks(block_hist);
+			hists__fprintf_all_blocks(block_hist, rep->min_percent);
 			continue;
 		}
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 655ef7708cd0..132056c7d5b7 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -15,6 +15,7 @@
 #include "../../util/srcline.h"
 #include "../../util/string2.h"
 #include "../../util/thread.h"
+#include "../../util/block-info.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
@@ -856,7 +857,11 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (h->filtered)
 			continue;
 
-		percent = hist_entry__get_percent_limit(h);
+		if (symbol_conf.report_individual_block)
+			percent = block_info__total_cycles_percent(h);
+		else
+			percent = hist_entry__get_percent_limit(h);
+
 		if (percent < min_pcnt)
 			continue;
 
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 1242c3a33509..a7d108fe53c8 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -444,3 +444,13 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 
 	return block_reports;
 }
+
+float block_info__total_cycles_percent(struct hist_entry *he)
+{
+	struct block_info *bi = he->block_info;
+
+	if (bi->total_cycles)
+		return bi->cycles * 100.0 / bi->total_cycles;
+
+	return 0.0;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index b5266588d476..4a0bccbec66e 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -69,4 +69,6 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 struct block_report *block_info__create_report(struct evlist *evlist,
 					       u64 total_cycles);
 
+float block_info__total_cycles_percent(struct hist_entry *he);
+
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

