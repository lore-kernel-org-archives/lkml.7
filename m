Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B58C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690102190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfCVWPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:15:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56425 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfCVWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:15:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMDp79749071
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:13:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMDoBl749068;
        Fri, 22 Mar 2019 15:13:50 -0700
Date:   Fri, 22 Mar 2019 15:13:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-1d6c49df74b0706af13a7d707638f0db374eaf88@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        ak@linux.intel.com
Reply-To: mingo@kernel.org, hpa@zytor.com, ak@linux.intel.com,
          tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190311144502.15423-6-andi@firstfloor.org>
References: <20190311144502.15423-6-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Support running scripts for current
 time range
Git-Commit-ID: 1d6c49df74b0706af13a7d707638f0db374eaf88
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

Commit-ID:  1d6c49df74b0706af13a7d707638f0db374eaf88
Gitweb:     https://git.kernel.org/tip/1d6c49df74b0706af13a7d707638f0db374eaf88
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 11 Mar 2019 07:44:56 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:33:19 -0300

perf report: Support running scripts for current time range

When using the time sort key, add new context menus to run scripts for
only the currently selected time range. Compute the correct range for
the selection add pass it as the --time option to perf script.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 83 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index aef800d97ea1..f98aeac607dd 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <linux/rbtree.h>
 #include <sys/ttydefaults.h>
+#include <linux/time64.h>
 
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
@@ -30,6 +31,7 @@
 #include "srcline.h"
 #include "string2.h"
 #include "units.h"
+#include "time-utils.h"
 
 #include "sane_ctype.h"
 
@@ -2338,6 +2340,7 @@ close_file_and_continue:
 }
 
 struct popup_action {
+	unsigned long		time;
 	struct thread 		*thread;
 	struct map_symbol 	ms;
 	int			socket;
@@ -2527,36 +2530,64 @@ static int
 do_run_script(struct hist_browser *browser __maybe_unused,
 	      struct popup_action *act)
 {
-	char script_opt[64];
-	memset(script_opt, 0, sizeof(script_opt));
+	char *script_opt;
+	int len;
+	int n = 0;
+
+	len = 100;
+	if (act->thread)
+		len += strlen(thread__comm_str(act->thread));
+	else if (act->ms.sym)
+		len += strlen(act->ms.sym->name);
+	script_opt = malloc(len);
+	if (!script_opt)
+		return -1;
 
+	script_opt[0] = 0;
 	if (act->thread) {
-		scnprintf(script_opt, sizeof(script_opt), " -c %s ",
+		n = scnprintf(script_opt, len, " -c %s ",
 			  thread__comm_str(act->thread));
 	} else if (act->ms.sym) {
-		scnprintf(script_opt, sizeof(script_opt), " -S %s ",
+		n = scnprintf(script_opt, len, " -S %s ",
 			  act->ms.sym->name);
 	}
 
+	if (act->time) {
+		char start[32], end[32];
+		unsigned long starttime = act->time;
+		unsigned long endtime = act->time + symbol_conf.time_quantum;
+
+		if (starttime == endtime) { /* Display 1ms as fallback */
+			starttime -= 1*NSEC_PER_MSEC;
+			endtime += 1*NSEC_PER_MSEC;
+		}
+		timestamp__scnprintf_usec(starttime, start, sizeof start);
+		timestamp__scnprintf_usec(endtime, end, sizeof end);
+		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
+	}
+
 	script_browse(script_opt);
+	free(script_opt);
 	return 0;
 }
 
 static int
-add_script_opt(struct hist_browser *browser __maybe_unused,
+add_script_opt_2(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act, char **optstr,
-	       struct thread *thread, struct symbol *sym)
+	       struct thread *thread, struct symbol *sym,
+	       const char *tstr)
 {
+
 	if (thread) {
-		if (asprintf(optstr, "Run scripts for samples of thread [%s]",
-			     thread__comm_str(thread)) < 0)
+		if (asprintf(optstr, "Run scripts for samples of thread [%s]%s",
+			     thread__comm_str(thread), tstr) < 0)
 			return 0;
 	} else if (sym) {
-		if (asprintf(optstr, "Run scripts for samples of symbol [%s]",
-			     sym->name) < 0)
+		if (asprintf(optstr, "Run scripts for samples of symbol [%s]%s",
+			     sym->name, tstr) < 0)
 			return 0;
 	} else {
-		if (asprintf(optstr, "Run scripts for all samples") < 0)
+		if (asprintf(optstr, "Run scripts for all samples%s", tstr) < 0)
 			return 0;
 	}
 
@@ -2566,6 +2597,36 @@ add_script_opt(struct hist_browser *browser __maybe_unused,
 	return 1;
 }
 
+static int
+add_script_opt(struct hist_browser *browser,
+	       struct popup_action *act, char **optstr,
+	       struct thread *thread, struct symbol *sym)
+{
+	int n, j;
+	struct hist_entry *he;
+
+	n = add_script_opt_2(browser, act, optstr, thread, sym, "");
+
+	he = hist_browser__selected_entry(browser);
+	if (sort_order && strstr(sort_order, "time")) {
+		char tstr[128];
+
+		optstr++;
+		act++;
+		j = sprintf(tstr, " in ");
+		j += timestamp__scnprintf_usec(he->time, tstr + j,
+					       sizeof tstr - j);
+		j += sprintf(tstr + j, "-");
+		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
+				          tstr + j,
+				          sizeof tstr - j);
+		n += add_script_opt_2(browser, act, optstr, thread, sym,
+					  tstr);
+		act->time = he->time;
+	}
+	return n;
+}
+
 static int
 do_switch_data(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act __maybe_unused)
