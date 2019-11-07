Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E294C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FB12166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153782;
	bh=zju9gLs6fTaHYzhf/TDBJ0Vc4EDjVG0WDqTak4V2Prc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIb+8zaxUQo1nYp/iRxL9JWxuRRD/EgGZWuUfjNWH7xEprNGUx0CCRwt/GfpsxiTT
	 h9kyERHPINoL/JZ+wDdrmD4zeaeVQo6YDTOa1BZ4vSWk26r/K0cCa/+YoLa9H/cQtb
	 UYJrW9qmBXtgpMNiIlhcLHHjS7y0bbT76gQaPR1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfKGTJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfKGTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:09:40 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A10E222C2;
        Thu,  7 Nov 2019 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153778;
        bh=zju9gLs6fTaHYzhf/TDBJ0Vc4EDjVG0WDqTak4V2Prc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjqMptn6k6FNg2Z9G5NCpSZCU7B0exyipxvtkDiubYIPvNew+t/NqrZaW7unS6MA8
         FqQ73B92h5+UKs2U6Geq2xpbiuaIA2pPdUa2jQXvQfF+PP1FtWxxnkDlsf7pJnD2Rf
         6bm3jFlloQGI9eNAN0A/zJCb6cFzyIC7aUtiGAag=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 63/63] perf report: Sort by sampled cycles percent per block for tui
Date:   Thu,  7 Nov 2019 16:00:11 -0300
Message-Id: <20191107190011.23924-64-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previous patch has implemented a new option "--total-cycles".  But only
stdio mode is supported.

This patch supports the tui mode and support '--percent-limit'.

For example,

 perf record -b ./div
 perf report --total-cycles --percent-limit 1

 # Samples: 2753248 of event 'cycles'
 Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
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

--------------------------------------------------

 v7:
 ---
 1. Since we have used use_browser in report__browse_block_hists
    to support stdio mode, now we also add supporting for tui.

 2. Move block tui browser code from ui/browsers/hists.c
    to block-info.c.

 v6:
 ---
 Create report__tui_browse_block_hists in block-info.c
 (codes are moved from builtin-report.c).

 v5:
 ---
 Fix a crash issue when running perf report without
 '--total-cycles'. The issue is because the internal flag
 is renamed from 'total_cycles' to 'total_cycles_mode' in
 previous patch but this patch still uses 'total_cycles'
 to check if the '--total-cycles' option is enabled, which
 causes the code to be inconsistent.

 v4:
 ---
 Since the block collection is moved out of printing in
 previous patch, this patch is updated accordingly for
 tui supporting.

 v3:
 ---
 Minor change since the function name is changed:
 block_total_cycles_percent -> block_info__total_cycles_percent

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-8-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c    | 27 ++++++++++---
 tools/perf/ui/browsers/hists.c |  7 +++-
 tools/perf/ui/browsers/hists.h |  2 +
 tools/perf/util/block-info.c   | 74 +++++++++++++++++++++++++++++++++-
 4 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ca41187525ed..1e81985b7d56 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -485,6 +485,22 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
+static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
+					       struct report *rep)
+{
+	struct evsel *pos;
+	int i = 0, ret;
+
+	evlist__for_each_entry(evlist, pos) {
+		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
+						 rep->min_percent, pos);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 					 struct report *rep,
 					 const char *help)
@@ -595,6 +611,11 @@ static int report__browse_hists(struct report *rep)
 
 	switch (use_browser) {
 	case 1:
+		if (rep->total_cycles_mode) {
+			ret = perf_evlist__tui_block_hists_browse(evlist, rep);
+			break;
+		}
+
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
 						    &session->header.env,
@@ -1396,12 +1417,8 @@ int cmd_report(int argc, const char **argv)
 	if (report.total_cycles_mode) {
 		if (sort__mode != SORT_MODE__BRANCH)
 			report.total_cycles_mode = false;
-		else if (!report.use_stdio) {
-			pr_err("Error: --total-cycles can be only used together with --stdio\n");
-			goto error;
-		} else {
+		else
 			sort_order = "sym";
-		}
 	}
 
 	if (strcmp(input_name, "-") != 0)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 7a7187e069b4..334afc2139e7 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -26,6 +26,7 @@
 #include "../../util/sort.h"
 #include "../../util/top.h"
 #include "../../util/thread.h"
+#include "../../util/block-info.h"
 #include "../../arch/common.h"
 #include "../../perf.h"
 
@@ -1783,7 +1784,11 @@ static unsigned int hist_browser__refresh(struct ui_browser *browser)
 			continue;
 		}
 
-		percent = hist_entry__get_percent_limit(h);
+		if (symbol_conf.report_individual_block)
+			percent = block_info__total_cycles_percent(h);
+		else
+			percent = hist_entry__get_percent_limit(h);
+
 		if (percent < hb->min_pcnt)
 			continue;
 
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 91d3e18b50aa..078f2f2c7abd 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -5,6 +5,7 @@
 #include "ui/browser.h"
 
 struct annotation_options;
+struct evsel;
 
 struct hist_browser {
 	struct ui_browser   b;
@@ -15,6 +16,7 @@ struct hist_browser {
 	struct pstack	    *pstack;
 	struct perf_env	    *env;
 	struct annotation_options *annotation_opts;
+	struct evsel	    *block_evsel;
 	int		     print_seq;
 	bool		     show_dso;
 	bool		     show_headers;
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 597d1205fa6c..9abc201ebe63 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -10,6 +10,7 @@
 #include "map.h"
 #include "srcline.h"
 #include "evlist.h"
+#include "ui/browsers/hists.h"
 
 static struct block_header_column {
 	const char *name;
@@ -438,9 +439,75 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 	return block_reports;
 }
 
+#ifdef HAVE_SLANG_SUPPORT
+static int block_hists_browser__title(struct hist_browser *browser, char *bf,
+				      size_t size)
+{
+	struct hists *hists = evsel__hists(browser->block_evsel);
+	const char *evname = perf_evsel__name(browser->block_evsel);
+	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	int ret;
+
+	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
+	if (evname)
+		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
+
+	return 0;
+}
+
+static int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
+				  float min_percent)
+{
+	struct hists *hists = &bh->block_hists;
+	struct hist_browser *browser;
+	int key = -1;
+	static const char help[] =
+	" q             Quit \n";
+
+	browser = hist_browser__new(hists);
+	if (!browser)
+		return -1;
+
+	browser->block_evsel = evsel;
+	browser->title = block_hists_browser__title;
+	browser->min_pcnt = min_percent;
+
+	/* reset abort key so that it can get Ctrl-C as a key */
+	SLang_reset_tty();
+	SLang_init_tty(0, 0, 0);
+
+	while (1) {
+		key = hist_browser__run(browser, "? - help", true);
+
+		switch (key) {
+		case 'q':
+			goto out;
+		case '?':
+			ui_browser__help_window(&browser->b, help);
+			break;
+		default:
+			break;
+		}
+	}
+
+out:
+	hist_browser__delete(browser);
+	return 0;
+}
+#else
+static int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
+				  struct evsel *evsel __maybe_unused,
+				  float min_percent __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
-			       struct evsel *evsel __maybe_unused)
+			       struct evsel *evsel)
 {
+	int ret;
+
 	switch (use_browser) {
 	case 0:
 		symbol_conf.report_individual_block = true;
@@ -448,6 +515,11 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       stdout, true);
 		hists__delete_entries(&bh->block_hists);
 		return 0;
+	case 1:
+		symbol_conf.report_individual_block = true;
+		ret = block_hists_tui_browse(bh, evsel, min_percent);
+		hists__delete_entries(&bh->block_hists);
+		return ret;
 	default:
 		return -1;
 	}
-- 
2.21.0

