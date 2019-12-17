Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B71C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594162;
	bh=tdHs1oYNdxlAXP274vD9Exa8++0/n2QNWUc9yKX5P0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ym8bUuE1GiRz60iSMfs9J3lHaXYLSXSbdg3g26+J1M1iH+31JndPubIt1cwMZHUVM
	 gJU0/jbAI5AnqlM1XQkUjAUcwOeCn7zYfkO+SteFLLc4mgiX9K4JJFi9kCfdmfzzF0
	 IipM99AvfJqLXS/kbgYtFkOMJP+Qf+vT2LfKuGyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfLQOtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfLQOtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:49:19 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC3724672;
        Tue, 17 Dec 2019 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594158;
        bh=tdHs1oYNdxlAXP274vD9Exa8++0/n2QNWUc9yKX5P0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9dmdHLPGO/w7BvOaq83NUqwYHnH4mTiGORyYtOOjxI7rKz7yT0w+ag10V7C1IDG6
         4byGdUxfrhX750ZE0pkqtL/DOIUWrGlq2G7C/d3pYUK8Qx8/XH+ISLPPfkEAuzQ+3Y
         aCMGXUB+mSZxTmODIDY7x6Iipfo5dxJBaMH/t2+w=
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
Subject: [PATCH 08/12] tools ui popup: Allow returning hotkeys
Date:   Tue, 17 Dec 2019 11:48:24 -0300
Message-Id: <20191217144828.2460-9-acme@kernel.org>
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

With this patch if an optional pointer is passed to ui__popup_menu()
then when any key that is not being handled (ENTER, ESC, etc) is typed,
it'll record that key in the pointer and return, allowing for hotkey
processing on the caller.

If NULL is passed, no change in logic, unhandled keys continue to be
ignored.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6ojn19mqzgmrdm8kdoigic0m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c      |  4 ++--
 tools/perf/ui/browsers/res_sample.c |  2 +-
 tools/perf/ui/browsers/scripts.c    |  2 +-
 tools/perf/ui/tui/util.c            | 12 ++++++++----
 tools/perf/ui/util.h                |  2 +-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3b7af5a8d101..da7de49b3553 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2389,7 +2389,7 @@ static int switch_data_file(void)
 	closedir(pwd_dir);
 
 	if (nr_options) {
-		choice = ui__popup_menu(nr_options, options);
+		choice = ui__popup_menu(nr_options, options, NULL);
 		if (choice < nr_options && choice >= 0) {
 			tmp = strdup(abs_path[choice]);
 			if (tmp) {
@@ -3275,7 +3275,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 		do {
 			struct popup_action *act;
 
-			choice = ui__popup_menu(nr_options, options);
+			choice = ui__popup_menu(nr_options, options, NULL);
 			if (choice == -1 || choice >= nr_options)
 				break;
 
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 76d356a18790..7cb2d6678039 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -56,7 +56,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 			return -1;
 		}
 	}
-	choice = ui__popup_menu(num_res, names);
+	choice = ui__popup_menu(num_res, names, NULL);
 	for (i = 0; i < num_res; i++)
 		zfree(&names[i]);
 	free(names);
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index fc733a6354d4..47d2c7a8cbe1 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -126,7 +126,7 @@ static int list_scripts(char *script_name, bool *custom,
 			SCRIPT_FULLPATH_LEN);
 	if (num < 0)
 		num = 0;
-	choice = ui__popup_menu(num + max_std, (char * const *)names);
+	choice = ui__popup_menu(num + max_std, (char * const *)names, NULL);
 	if (choice < 0) {
 		ret = -1;
 		goto out;
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index b98dd0e31dc1..0f562e2cb1e8 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -23,7 +23,7 @@ static void ui_browser__argv_write(struct ui_browser *browser,
 	ui_browser__write_nstring(browser, *arg, browser->width);
 }
 
-static int popup_menu__run(struct ui_browser *menu)
+static int popup_menu__run(struct ui_browser *menu, int *keyp)
 {
 	int key;
 
@@ -45,6 +45,11 @@ static int popup_menu__run(struct ui_browser *menu)
 			key = -1;
 			break;
 		default:
+			if (keyp) {
+				*keyp = key;
+				key = menu->nr_entries;
+				break;
+			}
 			continue;
 		}
 
@@ -55,7 +60,7 @@ static int popup_menu__run(struct ui_browser *menu)
 	return key;
 }
 
-int ui__popup_menu(int argc, char * const argv[])
+int ui__popup_menu(int argc, char * const argv[], int *keyp)
 {
 	struct ui_browser menu = {
 		.entries    = (void *)argv,
@@ -64,8 +69,7 @@ int ui__popup_menu(int argc, char * const argv[])
 		.write	    = ui_browser__argv_write,
 		.nr_entries = argc,
 	};
-
-	return popup_menu__run(&menu);
+	return popup_menu__run(&menu, keyp);
 }
 
 int ui_browser__input_window(const char *title, const char *text, char *input,
diff --git a/tools/perf/ui/util.h b/tools/perf/ui/util.h
index 40891942f465..e30cea807564 100644
--- a/tools/perf/ui/util.h
+++ b/tools/perf/ui/util.h
@@ -5,7 +5,7 @@
 #include <stdarg.h>
 
 int ui__getch(int delay_secs);
-int ui__popup_menu(int argc, char * const argv[]);
+int ui__popup_menu(int argc, char * const argv[], int *keyp);
 int ui__help_window(const char *text);
 int ui__dialog_yesno(const char *msg);
 void __ui__info_window(const char *title, const char *text, const char *exit_msg);
-- 
2.21.0

