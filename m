Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F7BC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83612071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKWIPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfKWIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZR-0002bo-IT; Sat, 23 Nov 2019 09:15:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9BE911C1AD9;
        Sat, 23 Nov 2019 09:15:02 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:02 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf util: Move block TUI function to ui browsers
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191118140849.20714-1-yao.jin@linux.intel.com>
References: <20191118140849.20714-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157449690252.21853.2731655639237747932.tip-bot2@tip-bot2>
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

Commit-ID:     5cb456af99f58378fe90649d6faaab25e379be06
Gitweb:        https://git.kernel.org/tip/5cb456af99f58378fe90649d6faaab25e379be06
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Mon, 18 Nov 2019 22:08:48 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 19:33:40 -03:00

perf util: Move block TUI function to ui browsers

It would be nice if we could jump to the assembler/source view (like the
normal perf report) from total cycles view.

This patch moves the block_hists_tui_browse from block-info.c to
ui/browsers/hists.c in order to reuse some browser codes (i.e
do_annotate) for implementing new annotation view.

 v2:
 ---
 Fix the 'make NO_SLANG=1' error. (Change 'int block_hists_tui_browse()'
 to 'static inline int block_hists_tui_browse()')

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191118140849.20714-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 55 ++++++++++++++++++++++++++++-
 tools/perf/util/block-info.c   | 65 +---------------------------------
 tools/perf/util/hist.h         | 12 ++++++-
 3 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 4d2d0ac..87405dc 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3444,3 +3444,58 @@ single_entry:
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
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 9abc201..5887f8f 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -10,6 +10,7 @@
 #include "map.h"
 #include "srcline.h"
 #include "evlist.h"
+#include "hist.h"
 #include "ui/browsers/hists.h"
 
 static struct block_header_column {
@@ -439,70 +440,6 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 	return block_reports;
 }
 
-#ifdef HAVE_SLANG_SUPPORT
-static int block_hists_browser__title(struct hist_browser *browser, char *bf,
-				      size_t size)
-{
-	struct hists *hists = evsel__hists(browser->block_evsel);
-	const char *evname = perf_evsel__name(browser->block_evsel);
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
-	int ret;
-
-	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
-	if (evname)
-		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
-
-	return 0;
-}
-
-static int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
-				  float min_percent)
-{
-	struct hists *hists = &bh->block_hists;
-	struct hist_browser *browser;
-	int key = -1;
-	static const char help[] =
-	" q             Quit \n";
-
-	browser = hist_browser__new(hists);
-	if (!browser)
-		return -1;
-
-	browser->block_evsel = evsel;
-	browser->title = block_hists_browser__title;
-	browser->min_pcnt = min_percent;
-
-	/* reset abort key so that it can get Ctrl-C as a key */
-	SLang_reset_tty();
-	SLang_init_tty(0, 0, 0);
-
-	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
-
-		switch (key) {
-		case 'q':
-			goto out;
-		case '?':
-			ui_browser__help_window(&browser->b, help);
-			break;
-		default:
-			break;
-		}
-	}
-
-out:
-	hist_browser__delete(browser);
-	return 0;
-}
-#else
-static int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
-				  struct evsel *evsel __maybe_unused,
-				  float min_percent __maybe_unused)
-{
-	return 0;
-}
-#endif
-
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel)
 {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4d87c7b..2aca8ce 100644
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
@@ -518,6 +523,13 @@ static inline int res_sample_browse(struct res_sample *res_samples __maybe_unuse
 
 static inline void res_sample_init(void) {}
 
+static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
+					 struct evsel *evsel __maybe_unused,
+					 float min_percent __maybe_unused)
+{
+	return 0;
+}
+
 #define K_LEFT  -1000
 #define K_RIGHT -2000
 #define K_SWITCH_INPUT_DATA -3000
