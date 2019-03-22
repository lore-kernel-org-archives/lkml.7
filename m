Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A227C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CA2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfCVWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:07:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:07:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM7EVu747872
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:07:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM7EuT747869;
        Fri, 22 Mar 2019 15:07:14 -0700
Date:   Fri, 22 Mar 2019 15:07:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-75065a85a9705ad4c0135f07fd4467d46ff342a3@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, feng.tang@intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, ak@linux.intel.com
Reply-To: tglx@linutronix.de, acme@redhat.com, feng.tang@intel.com,
          ak@linux.intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190309055628.21617-8-andi@firstfloor.org>
References: <20190309055628.21617-8-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Use less for scripts output
Git-Commit-ID: 75065a85a9705ad4c0135f07fd4467d46ff342a3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  75065a85a9705ad4c0135f07fd4467d46ff342a3
Gitweb:     https://git.kernel.org/tip/75065a85a9705ad4c0135f07fd4467d46ff342a3
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 8 Mar 2019 21:56:20 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 14:03:43 -0300

perf report: Use less for scripts output

The UI viewer for scripts output has a lot of limitations: limited size,
no search or save function, slow, and various other issues.

Just use 'less' to display directly on the terminal instead.

This won't work in GTK mode, but GTK doesn't support these context menus
anyways. If that is ever done could use an terminal for the output.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Feng Tang <feng.tang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190309055628.21617-8-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/scripts.c | 130 +++++----------------------------------
 1 file changed, 17 insertions(+), 113 deletions(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 90a32ac69e76..7f36630694bf 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,35 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <elf.h>
-#include <inttypes.h>
-#include <sys/ttydefaults.h>
-#include <string.h>
 #include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
-#include "../helpline.h"
 #include "../libslang.h"
 
-/* 2048 lines should be enough for a script output */
-#define MAX_LINES		2048
-
-/* 160 bytes for one output line */
-#define AVERAGE_LINE_LEN	160
-
-struct script_line {
-	struct list_head node;
-	char line[AVERAGE_LINE_LEN];
-};
-
-struct perf_script_browser {
-	struct ui_browser b;
-	struct list_head entries;
-	const char *script_name;
-	int nr_lines;
-};
-
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
 /*
@@ -73,69 +50,29 @@ static int list_scripts(char *script_name)
 	return ret;
 }
 
-static void script_browser__write(struct ui_browser *browser,
-				   void *entry, int row)
+static void run_script(char *cmd)
 {
-	struct script_line *sline = list_entry(entry, struct script_line, node);
-	bool current_entry = ui_browser__is_current_entry(browser, row);
-
-	ui_browser__set_color(browser, current_entry ? HE_COLORSET_SELECTED :
-						       HE_COLORSET_NORMAL);
-
-	ui_browser__write_nstring(browser, sline->line, browser->width);
+	pr_debug("Running %s\n", cmd);
+	SLang_reset_tty();
+	if (system(cmd) < 0)
+		pr_warning("Cannot run %s\n", cmd);
+	/*
+	 * SLang doesn't seem to reset the whole terminal, so be more
+	 * forceful to get back to the original state.
+	 */
+	printf("\033[c\033[H\033[J");
+	fflush(stdout);
+	SLang_init_tty(0, 0, 0);
+	SLsmg_refresh();
 }
 
-static int script_browser__run(struct perf_script_browser *browser)
-{
-	int key;
-
-	if (ui_browser__show(&browser->b, browser->script_name,
-			     "Press ESC to exit") < 0)
-		return -1;
-
-	while (1) {
-		key = ui_browser__run(&browser->b, 0);
-
-		/* We can add some special key handling here if needed */
-		break;
-	}
-
-	ui_browser__hide(&browser->b);
-	return key;
-}
-
-
 int script_browse(const char *script_opt)
 {
 	char cmd[SCRIPT_FULLPATH_LEN*2], script_name[SCRIPT_FULLPATH_LEN];
-	char *line = NULL;
-	size_t len = 0;
-	ssize_t retlen;
-	int ret = -1, nr_entries = 0;
-	FILE *fp;
-	void *buf;
-	struct script_line *sline;
-
-	struct perf_script_browser script = {
-		.b = {
-			.refresh    = ui_browser__list_head_refresh,
-			.seek	    = ui_browser__list_head_seek,
-			.write	    = script_browser__write,
-		},
-		.script_name = script_name,
-	};
-
-	INIT_LIST_HEAD(&script.entries);
-
-	/* Save each line of the output in one struct script_line object. */
-	buf = zalloc((sizeof(*sline)) * MAX_LINES);
-	if (!buf)
-		return -1;
-	sline = buf;
 
 	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
 	if (list_scripts(script_name))
-		goto exit;
+		return -1;
 
 	sprintf(cmd, "perf script -s %s ", script_name);
 
@@ -147,42 +84,9 @@ int script_browse(const char *script_opt)
 		strcat(cmd, input_name);
 	}
 
-	strcat(cmd, " 2>&1");
-
-	fp = popen(cmd, "r");
-	if (!fp)
-		goto exit;
-
-	while ((retlen = getline(&line, &len, fp)) != -1) {
-		strncpy(sline->line, line, AVERAGE_LINE_LEN);
-
-		/* If one output line is very large, just cut it short */
-		if (retlen >= AVERAGE_LINE_LEN) {
-			sline->line[AVERAGE_LINE_LEN - 1] = '\0';
-			sline->line[AVERAGE_LINE_LEN - 2] = '\n';
-		}
-		list_add_tail(&sline->node, &script.entries);
-
-		if (script.b.width < retlen)
-			script.b.width = retlen;
-
-		if (nr_entries++ >= MAX_LINES - 1)
-			break;
-		sline++;
-	}
-
-	if (script.b.width > AVERAGE_LINE_LEN)
-		script.b.width = AVERAGE_LINE_LEN;
-
-	free(line);
-	pclose(fp);
+	strcat(cmd, " 2>&1 | less");
 
-	script.nr_lines = nr_entries;
-	script.b.nr_entries = nr_entries;
-	script.b.entries = &script.entries;
+	run_script(cmd);
 
-	ret = script_browser__run(&script);
-exit:
-	free(buf);
-	return ret;
+	return 0;
 }
