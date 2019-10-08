Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAEBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCC921BE5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJHHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:06:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:64439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbfJHHGY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:06:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 00:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="196522475"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2019 00:06:22 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 5/5] perf report: Sort by sampled cycles percent per block for tui
Date:   Tue,  8 Oct 2019 15:05:02 +0800
Message-Id: <20191008070502.22551-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008070502.22551-1-yao.jin@linux.intel.com>
References: <20191008070502.22551-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patch has implemented a new sort option "total_cycles".
But there was only stdio mode supported.

This patch supports the tui mode and support '--percent-limit'
as well.

For example,

 perf record -b ./div
 perf report -s total_cycles --percent-limit 1

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

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c    | 30 +++++++++++++---
 tools/perf/ui/browsers/hists.c | 62 +++++++++++++++++++++++++++++++++-
 tools/perf/ui/browsers/hists.h |  2 ++
 tools/perf/util/hist.h         | 12 +++++++
 4 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 96e4d68b3884..c095c91dad1d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -873,6 +873,27 @@ static int hists__fprintf_all_blocks(struct hists *hists, struct report *rep)
 	return 0;
 }
 
+static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
+					       struct report *rep)
+{
+	struct block_hist *bh = &rep->block_hist;
+	struct evsel *pos;
+	int ret;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		get_block_hists(hists, bh, rep);
+		symbol_conf.report_individual_block = true;
+		ret = block_hists_tui_browse(bh, pos, rep->min_percent);
+		hists__delete_entries(&bh->block_hists);
+		if (ret != 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 					 struct report *rep,
 					 const char *help)
@@ -981,6 +1002,11 @@ static int report__browse_hists(struct report *rep)
 
 	switch (use_browser) {
 	case 1:
+		if (rep->total_cycles) {
+			ret = perf_evlist__tui_block_hists_browse(evlist, rep);
+			break;
+		}
+
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
 						    &session->header.env,
@@ -1775,10 +1801,6 @@ int cmd_report(int argc, const char **argv)
 	if (sort_order && strstr(sort_order, "total_cycles") &&
 	    (sort__mode == SORT_MODE__BRANCH)) {
 		report.total_cycles = true;
-		if (!report.use_stdio) {
-			pr_err("Error: -s total_cycles can be only used together with --stdio\n");
-			goto error;
-		}
 	}
 
 	if (strcmp(input_name, "-") != 0)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 7a7187e069b4..e0f3b1d4a43b 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -26,6 +26,7 @@
 #include "../../util/sort.h"
 #include "../../util/top.h"
 #include "../../util/thread.h"
+#include "../../util/block.h"
 #include "../../arch/common.h"
 #include "../../perf.h"
 
@@ -1783,7 +1784,11 @@ static unsigned int hist_browser__refresh(struct ui_browser *browser)
 			continue;
 		}
 
-		percent = hist_entry__get_percent_limit(h);
+		if (symbol_conf.report_individual_block)
+			percent = block_total_cycles_percent(h);
+		else
+			percent = hist_entry__get_percent_limit(h);
+
 		if (percent < hb->min_pcnt)
 			continue;
 
@@ -3443,3 +3448,58 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 					       warn_lost_event,
 					       annotation_opts);
 }
+
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
+int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
+			   float min_percent)
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
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4d87c7b4c1b2..9dc3c112157c 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -449,6 +449,8 @@ enum rstype {
 	A_SOURCE
 };
 
+struct block_hist;
+
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
@@ -474,6 +476,9 @@ void run_script(char *cmd);
 int res_sample_browse(struct res_sample *res_samples, int num_res,
 		      struct evsel *evsel, enum rstype rstype);
 void res_sample_init(void);
+
+int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
+			   float min_percent);
 #else
 static inline
 int perf_evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
@@ -516,6 +521,13 @@ static inline int res_sample_browse(struct res_sample *res_samples __maybe_unuse
 	return 0;
 }
 
+static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
+					 struct evsel *evsel __maybe_unused,
+					 float min_percent)
+{
+	return 0;
+}
+
 static inline void res_sample_init(void) {}
 
 #define K_LEFT  -1000
-- 
2.17.1

