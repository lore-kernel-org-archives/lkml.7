Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B387AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA6124655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594181;
	bh=XVpHmNreLLNB+QbMt8qUng6dJKnd7LnmO8+bZHGXAgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eaDyHTXhelJbdseIs5Cq2tYh8EcOL6N+xWg2M1/k2z5KQs+JX0cp9AaBxsmy7CuEO
	 r2rWUwKYd/BFGXRWcO/w2VvjKX9jHHAXAUJuP3SkTLlfg+2JnS+hXrgOe7DB4rCJ/c
	 Ad2ef9Hreqbob85+QMjmeMUdrLEv/sw4LSHsmCQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfLQOtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfLQOtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:49:15 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA7E24655;
        Tue, 17 Dec 2019 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594155;
        bh=XVpHmNreLLNB+QbMt8qUng6dJKnd7LnmO8+bZHGXAgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iaWDT/Mnc1M1kazFmjyxvoYpQtliqxaj+V8MKrsEWxvi18UA76eVJx4Me2JeGDZn
         duGZ6+I7R0Bwgf+vhmY4doyjOfNOMLW12EUUTdWmsOxfajp4fXwsj0N6y0d2+16Z99
         sTiVN5vtYHYyaKO11XN6vOK2TM6IhksrjSt0ij80=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Date:   Tue, 17 Dec 2019 11:48:23 -0300
Message-Id: <20191217144828.2460-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
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

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-i0kwpuicoy4p1tyrw5k054zq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c       |  4 ++--
 tools/perf/ui/browsers/hists.c | 13 +++++++------
 tools/perf/ui/browsers/hists.h |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

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
index 6dfdd8d5a743..3b7af5a8d101 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 }
 
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event)
+		      bool warn_lost_event, int key)
 {
-	int key;
 	char title[160];
 	struct hist_browser_timer *hbt = browser->hbt;
 	int delay_secs = hbt ? hbt->refresh : 0;
@@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
 		return -1;
 
+	if (key)
+		goto do_hotkey;
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
-
+do_hotkey:
 		switch (key) {
 		case K_TIMER: {
 			u64 nr_entries;
@@ -2994,8 +2996,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 		nr_options = 0;
 
-		key = hist_browser__run(browser, helpline,
-					warn_lost_event);
+		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3573,7 +3574,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
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
2.21.0

