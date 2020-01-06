Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C3DC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF5C222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326894;
	bh=CaXw4yykSENX1JSjdIby0ztH22CIs6gZRgeYlY57d68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Q2oM1rNVCmlqSMr1KqqB7mvOPGM+RKcLwLK8ilTcjjGIO/zPS3naRxwwPZy1pleY
	 b4S/Rfi6YY8EgqBX5ulYXss+hLeKyz0n0PwdTM+VunP9HNOOLAZhpWJHc+69YJye/W
	 0vQO6MiygIPN6cmtFr/v4IIadNBoiDYUreNhFzlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgAFQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgAFQIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:08:10 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C200C2081E;
        Mon,  6 Jan 2020 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326889;
        bh=CaXw4yykSENX1JSjdIby0ztH22CIs6gZRgeYlY57d68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wNJn5YkM72+2BuNvlH3rLtY34fUp+68NzeN6O5+u79siUz/qb5E4rusWen4+YTux
         dDlk9c+sB0CL4eIfW/MpJuC4ecGvix+csy+U/DpP1fVVZh/+YiN+lTw2oWF7a4+4MW
         fL2BTgKJWbQJC6mVi/yGSrslykWKOpxPIGkeCT6w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 15/20] perf hists browser: Allow passing an initial hotkey
Date:   Mon,  6 Jan 2020 13:07:00 -0300
Message-Id: <20200106160705.10899-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Sometimes we're in an outer code, like the main hists browser popup menu
and the user follows a suggestion about using some hotkey, and that
hotkey is really handled by hists_browser__run(), so allow for calling
it with that hotkey, making it handle it instead of waiting for the user
to press one.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xv2l7i6o4urn37nv1h40ryfs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c       |   4 +-
 tools/perf/ui/browsers/hists.c | 153 +++++++++++++++++----------------
 tools/perf/ui/browsers/hists.h |   2 +-
 3 files changed, 82 insertions(+), 77 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f44941aad..346351260c0b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2384,7 +2384,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 's':
@@ -2453,7 +2453,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6dfdd8d5a743..ac118aef5ed1 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -672,10 +672,81 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
+static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_lost_event, char *title, int key)
+{
+	switch (key) {
+	case K_TIMER: {
+		struct hist_browser_timer *hbt = browser->hbt;
+		u64 nr_entries;
+
+		WARN_ON_ONCE(!hbt);
+
+		if (hbt)
+			hbt->timer(hbt->arg);
+
+		if (hist_browser__has_filter(browser) || symbol_conf.report_hierarchy)
+			hist_browser__update_nr_entries(browser);
+
+		nr_entries = hist_browser__nr_entries(browser);
+		ui_browser__update_nr_entries(&browser->b, nr_entries);
+
+		if (warn_lost_event &&
+		    (browser->hists->stats.nr_lost_warned !=
+		    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
+			browser->hists->stats.nr_lost_warned =
+				browser->hists->stats.nr_events[PERF_RECORD_LOST];
+			ui_browser__warn_lost_events(&browser->b);
+		}
+
+		hist_browser__title(browser, title, sizeof(title));
+		ui_browser__show_title(&browser->b, title);
+		break;
+	}
+	case 'D': { /* Debug */
+		struct hist_entry *h = rb_entry(browser->b.top, struct hist_entry, rb_node);
+		static int seq;
+
+		ui_helpline__pop();
+		ui_helpline__fpush("%d: nr_ent=(%d,%d), etl: %d, rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
+				   seq++, browser->b.nr_entries, browser->hists->nr_entries,
+				   browser->b.extra_title_lines, browser->b.rows,
+				   browser->b.index, browser->b.top_idx, h->row_offset, h->nr_rows);
+	}
+		break;
+	case 'C':
+		/* Collapse the whole world. */
+		hist_browser__set_folding(browser, false);
+		break;
+	case 'c':
+		/* Collapse the selected entry. */
+		hist_browser__set_folding_selected(browser, false);
+		break;
+	case 'E':
+		/* Expand the whole world. */
+		hist_browser__set_folding(browser, true);
+		break;
+	case 'e':
+		/* Expand the selected entry. */
+		hist_browser__set_folding_selected(browser, true);
+		break;
+	case 'H':
+		browser->show_headers = !browser->show_headers;
+		hist_browser__update_rows(browser);
+		break;
+	case '+':
+		if (hist_browser__toggle_fold(browser))
+			break;
+		/* fall thru */
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event)
+		      bool warn_lost_event, int key)
 {
-	int key;
 	char title[160];
 	struct hist_browser_timer *hbt = browser->hbt;
 	int delay_secs = hbt ? hbt->refresh : 0;
@@ -688,79 +759,14 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
 		return -1;
 
+	if (key && hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
+		goto out;
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
-		switch (key) {
-		case K_TIMER: {
-			u64 nr_entries;
-
-			WARN_ON_ONCE(!hbt);
-
-			if (hbt)
-				hbt->timer(hbt->arg);
-
-			if (hist_browser__has_filter(browser) ||
-			    symbol_conf.report_hierarchy)
-				hist_browser__update_nr_entries(browser);
-
-			nr_entries = hist_browser__nr_entries(browser);
-			ui_browser__update_nr_entries(&browser->b, nr_entries);
-
-			if (warn_lost_event &&
-			    (browser->hists->stats.nr_lost_warned !=
-			    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
-				browser->hists->stats.nr_lost_warned =
-					browser->hists->stats.nr_events[PERF_RECORD_LOST];
-				ui_browser__warn_lost_events(&browser->b);
-			}
-
-			hist_browser__title(browser, title, sizeof(title));
-			ui_browser__show_title(&browser->b, title);
-			continue;
-		}
-		case 'D': { /* Debug */
-			static int seq;
-			struct hist_entry *h = rb_entry(browser->b.top,
-							struct hist_entry, rb_node);
-			ui_helpline__pop();
-			ui_helpline__fpush("%d: nr_ent=(%d,%d), etl: %d, rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
-					   seq++, browser->b.nr_entries,
-					   browser->hists->nr_entries,
-					   browser->b.extra_title_lines,
-					   browser->b.rows,
-					   browser->b.index,
-					   browser->b.top_idx,
-					   h->row_offset, h->nr_rows);
-		}
-			break;
-		case 'C':
-			/* Collapse the whole world. */
-			hist_browser__set_folding(browser, false);
-			break;
-		case 'c':
-			/* Collapse the selected entry. */
-			hist_browser__set_folding_selected(browser, false);
-			break;
-		case 'E':
-			/* Expand the whole world. */
-			hist_browser__set_folding(browser, true);
+		if (hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
 			break;
-		case 'e':
-			/* Expand the selected entry. */
-			hist_browser__set_folding_selected(browser, true);
-			break;
-		case 'H':
-			browser->show_headers = !browser->show_headers;
-			hist_browser__update_rows(browser);
-			break;
-		case '+':
-			if (hist_browser__toggle_fold(browser))
-				break;
-			/* fall thru */
-		default:
-			goto out;
-		}
 	}
 out:
 	ui_browser__hide(&browser->b);
@@ -2994,8 +3000,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 		nr_options = 0;
 
-		key = hist_browser__run(browser, helpline,
-					warn_lost_event);
+		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3573,7 +3578,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
 	memset(&action, 0, sizeof(action));
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 078f2f2c7abd..1e938d9ffa5e 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -34,7 +34,7 @@ struct hist_browser {
 struct hist_browser *hist_browser__new(struct hists *hists);
 void hist_browser__delete(struct hist_browser *browser);
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event);
+		      bool warn_lost_event, int key);
 void hist_browser__init(struct hist_browser *browser,
 			struct hists *hists);
 #endif /* _PERF_UI_BROWSER_HISTS_H_ */
-- 
2.21.1

