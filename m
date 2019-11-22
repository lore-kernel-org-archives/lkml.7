Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C696D207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434667;
	bh=D/KNEJRJZmUOFq159oQj4xe7T8oKKkUyPH3GKdGjmbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rt61r/e1R+NeIbIVd9IuQoPzb5qESt57HyzQ87JQronlP8DYeJSPWlIBCWpVdTpk+
	 wN6ZKHe9yUsmGSGtQ4IgTVFPnyK+7nzRird/aje2GWVDxQiZ3LwduivPjMmpjpe3CX
	 FGmMhWHM1a+m68xe+Rdr4YN/J/1xJL1Wd0cvXbs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfKVO5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfKVO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:43 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD78207DD;
        Fri, 22 Nov 2019 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434662;
        bh=D/KNEJRJZmUOFq159oQj4xe7T8oKKkUyPH3GKdGjmbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUud3ncuOhsr87Fm/p3cYz1rB7CdRZr+5ye5LvqGZQuvpXAlhCJUz+tqhn4H8B93o
         hqOikwwR53hQvwS0eZ7JHd5KSPKtXLNpnxLDJgU/kq+kuYMNpfGN4GaKWGG4OFi2xh
         CexTaD98Hos2aTvpzqb9Y1jwboWrJKFVk+s0IvcQ=
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
Subject: [PATCH 08/26] perf report: Jump to symbol source view from total cycles view
Date:   Fri, 22 Nov 2019 11:56:53 -0300
Message-Id: <20191122145711.3171-9-acme@kernel.org>
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

This patch supports jumping from tui total cycles view to symbol source
view.

For example,

  perf record -b ./div
  perf report --total-cycles

In total cycles view, we can select one entry and press 'a' or press
ENTER key to jump to symbol source view.

This patch also sets sort_order to NULL in cmd_report() which will use
the default branch sort order. The percent value in new annotate view
will be consistent with the percent in annotate view switched from perf
report (we observed the original percent gap with previous patches).

 v2:
 ---
 Fix the 'make NO_SLANG=1' error. (set __maybe_unused to
 annotation_opts in block_hists_tui_browse()).

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191118140849.20714-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c    |  9 ++++++---
 tools/perf/ui/browsers/hists.c | 25 +++++++++++++++++++++++--
 tools/perf/util/block-info.c   |  6 ++++--
 tools/perf/util/block-info.h   |  3 ++-
 tools/perf/util/hist.h         |  7 +++++--
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0b6157c02c88..ab0f6e516b03 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -493,7 +493,9 @@ static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, pos) {
 		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
-						 rep->min_percent, pos);
+						 rep->min_percent, pos,
+						 &rep->session->header.env,
+						 &rep->annotation_opts);
 		if (ret != 0)
 			return ret;
 	}
@@ -525,7 +527,8 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 
 		if (rep->total_cycles_mode) {
 			report__browse_block_hists(&rep->block_reports[i++].hist,
-						   rep->min_percent, pos);
+						   rep->min_percent, pos,
+						   NULL, NULL);
 			continue;
 		}
 
@@ -1418,7 +1421,7 @@ int cmd_report(int argc, const char **argv)
 		if (sort__mode != SORT_MODE__BRANCH)
 			report.total_cycles_mode = false;
 		else
-			sort_order = "sym";
+			sort_order = NULL;
 	}
 
 	if (strcmp(input_name, "-") != 0)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 87405dc4750c..d4d3558fdef4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2385,7 +2385,11 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	if (!notes->src)
 		return 0;
 
-	evsel = hists_to_evsel(browser->hists);
+	if (browser->block_evsel)
+		evsel = browser->block_evsel;
+	else
+		evsel = hists_to_evsel(browser->hists);
+
 	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt,
 				       browser->annotation_opts);
 	he = hist_browser__selected_entry(browser);
@@ -3461,11 +3465,13 @@ static int block_hists_browser__title(struct hist_browser *browser, char *bf,
 }
 
 int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
-			   float min_percent)
+			   float min_percent, struct perf_env *env,
+			   struct annotation_options *annotation_opts)
 {
 	struct hists *hists = &bh->block_hists;
 	struct hist_browser *browser;
 	int key = -1;
+	struct popup_action action;
 	static const char help[] =
 	" q             Quit \n";
 
@@ -3476,11 +3482,15 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
 	browser->block_evsel = evsel;
 	browser->title = block_hists_browser__title;
 	browser->min_pcnt = min_percent;
+	browser->env = env;
+	browser->annotation_opts = annotation_opts;
 
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
 
+	memset(&action, 0, sizeof(action));
+
 	while (1) {
 		key = hist_browser__run(browser, "? - help", true);
 
@@ -3490,6 +3500,17 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
 		case '?':
 			ui_browser__help_window(&browser->b, help);
 			break;
+		case 'a':
+		case K_ENTER:
+			if (!browser->selection ||
+			    !browser->selection->sym) {
+				continue;
+			}
+
+			action.ms.map = browser->selection->map;
+			action.ms.sym = browser->selection->sym;
+			do_annotate(browser, &action);
+			continue;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 5887f8f9149f..c4b030bf6ec2 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -441,7 +441,8 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 }
 
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
-			       struct evsel *evsel)
+			       struct evsel *evsel, struct perf_env *env,
+			       struct annotation_options *annotation_opts)
 {
 	int ret;
 
@@ -454,7 +455,8 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 		return 0;
 	case 1:
 		symbol_conf.report_individual_block = true;
-		ret = block_hists_tui_browse(bh, evsel, min_percent);
+		ret = block_hists_tui_browse(bh, evsel, min_percent,
+					     env, annotation_opts);
 		hists__delete_entries(&bh->block_hists);
 		return ret;
 	default:
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index e4d20bccd9b6..bef0d75e9819 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -71,7 +71,8 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 					       u64 total_cycles);
 
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
-			       struct evsel *evsel);
+			       struct evsel *evsel, struct perf_env *env,
+			       struct annotation_options *annotation_opts);
 
 float block_info__total_cycles_percent(struct hist_entry *he);
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 2aca8ce16b2c..45286900aacb 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -478,7 +478,8 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 void res_sample_init(void);
 
 int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
-			   float min_percent);
+			   float min_percent, struct perf_env *env,
+			   struct annotation_options *annotation_opts);
 #else
 static inline
 int perf_evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
@@ -525,7 +526,9 @@ static inline void res_sample_init(void) {}
 
 static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
 					 struct evsel *evsel __maybe_unused,
-					 float min_percent __maybe_unused)
+					 float min_percent __maybe_unused,
+					 struct perf_env *env __maybe_unused,
+					 struct annotation_options *annotation_opts __maybe_unused)
 {
 	return 0;
 }
-- 
2.21.0

