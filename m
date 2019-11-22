Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CDBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8CA20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434663;
	bh=3EurERNc+cmNWEphjUMniT+S9sQVItIsZFQT6DUMflc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvEM723M0f7YkegMIowLLmlkIIavPbXWahN87SXGMk1c2zi2T7CSpoVeeQCZiCwqD
	 2aAdj1DOIoW4Ug63bnRZxWgcskYtXIFk80HCYe0fqEZkLmRk7ceA2vkUjyZgk7RlCM
	 l4EBn3M/4l45qI49Z4KeFPH7wYdQ4/oARIYjfrUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKVO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfKVO5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:40 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B31D2073F;
        Fri, 22 Nov 2019 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434659;
        bh=3EurERNc+cmNWEphjUMniT+S9sQVItIsZFQT6DUMflc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVMUFXr4CRgExthzsxTRjU+acdbDeKjP/L82NBR2z4mrfJeyKCxEPcSAIuOS3/kVT
         Bej6XoP+2UO4K4dgkB6w4QIVV6gSXG1MiVyV5emtcu0xQ0SIVlFTLqiFdVOaDULYvl
         y/HYgH421FY2JWmv/BX8tsz1cYyFBIJL6PIlv/8k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/26] perf util: Move block TUI function to ui browsers
Date:   Fri, 22 Nov 2019 11:56:52 -0300
Message-Id: <20191122145711.3171-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
 tools/perf/ui/browsers/hists.c | 55 ++++++++++++++++++++++++++++
 tools/perf/util/block-info.c   | 65 +---------------------------------
 tools/perf/util/hist.h         | 12 +++++++
 3 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 4d2d0acfd41a..87405dc4750c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3444,3 +3444,58 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
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
index 9abc201ebe63..5887f8f9149f 100644
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
index 4d87c7b4c1b2..2aca8ce16b2c 100644
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
-- 
2.21.0

