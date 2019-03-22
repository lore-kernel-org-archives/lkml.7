Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5117C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2C2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfCVWOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:14:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:14:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMETrs749102
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:14:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMESK7749097;
        Fri, 22 Mar 2019 15:14:28 -0700
Date:   Fri, 22 Mar 2019 15:14:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-6f3da20e151f4121548cf598730ae0f9559ae45d@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        ak@linux.intel.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
          ak@linux.intel.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190311144502.15423-7-andi@firstfloor.org>
References: <20190311144502.15423-7-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Support builtin perf script in
 scripts menu
Git-Commit-ID: 6f3da20e151f4121548cf598730ae0f9559ae45d
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

Commit-ID:  6f3da20e151f4121548cf598730ae0f9559ae45d
Gitweb:     https://git.kernel.org/tip/6f3da20e151f4121548cf598730ae0f9559ae45d
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 11 Mar 2019 07:44:57 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:33:19 -0300

perf report: Support builtin perf script in scripts menu

The scripts menu traditionally only showed custom perf scripts.

Allow to run standard perf script with useful default options too.

- Normal perf script
- perf script with assembler (needs xed installed)
- perf script with source code output (needs debuginfo)
- perf script with custom arguments

Then we automatically select the right options to display the
information in the perf.data file.

For example with -b display branch contexts.

It's not easily possible to check for xed's existence in advance.  perf
script usually gives sensible error messages when it's not available.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-7-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |   2 +-
 tools/perf/ui/browsers/hists.c    |  23 ++++---
 tools/perf/ui/browsers/scripts.c  | 127 ++++++++++++++++++++++++++++++--------
 tools/perf/util/hist.h            |   8 ++-
 4 files changed, 120 insertions(+), 40 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 35bdfd8b1e71..98d934a36d86 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -750,7 +750,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		case 'r':
 			{
-				script_browse(NULL);
+				script_browse(NULL, NULL);
 				continue;
 			}
 		case 'k':
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f98aeac607dd..fb4430f8982c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2344,6 +2344,7 @@ struct popup_action {
 	struct thread 		*thread;
 	struct map_symbol 	ms;
 	int			socket;
+	struct perf_evsel	*evsel;
 
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 };
@@ -2566,7 +2567,7 @@ do_run_script(struct hist_browser *browser __maybe_unused,
 		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
 	}
 
-	script_browse(script_opt);
+	script_browse(script_opt, act->evsel);
 	free(script_opt);
 	return 0;
 }
@@ -2575,7 +2576,7 @@ static int
 add_script_opt_2(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act, char **optstr,
 	       struct thread *thread, struct symbol *sym,
-	       const char *tstr)
+	       struct perf_evsel *evsel, const char *tstr)
 {
 
 	if (thread) {
@@ -2593,6 +2594,7 @@ add_script_opt_2(struct hist_browser *browser __maybe_unused,
 
 	act->thread = thread;
 	act->ms.sym = sym;
+	act->evsel = evsel;
 	act->fn = do_run_script;
 	return 1;
 }
@@ -2600,12 +2602,13 @@ add_script_opt_2(struct hist_browser *browser __maybe_unused,
 static int
 add_script_opt(struct hist_browser *browser,
 	       struct popup_action *act, char **optstr,
-	       struct thread *thread, struct symbol *sym)
+	       struct thread *thread, struct symbol *sym,
+	       struct perf_evsel *evsel)
 {
 	int n, j;
 	struct hist_entry *he;
 
-	n = add_script_opt_2(browser, act, optstr, thread, sym, "");
+	n = add_script_opt_2(browser, act, optstr, thread, sym, evsel, "");
 
 	he = hist_browser__selected_entry(browser);
 	if (sort_order && strstr(sort_order, "time")) {
@@ -2618,10 +2621,9 @@ add_script_opt(struct hist_browser *browser,
 					       sizeof tstr - j);
 		j += sprintf(tstr + j, "-");
 		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
-				          tstr + j,
-				          sizeof tstr - j);
+				          tstr + j, sizeof tstr - j);
 		n += add_script_opt_2(browser, act, optstr, thread, sym,
-					  tstr);
+					  evsel, tstr);
 		act->time = he->time;
 	}
 	return n;
@@ -3092,7 +3094,7 @@ skip_annotation:
 				nr_options += add_script_opt(browser,
 							     &actions[nr_options],
 							     &options[nr_options],
-							     thread, NULL);
+							     thread, NULL, evsel);
 			}
 			/*
 			 * Note that browser->selection != NULL
@@ -3107,11 +3109,12 @@ skip_annotation:
 				nr_options += add_script_opt(browser,
 							     &actions[nr_options],
 							     &options[nr_options],
-							     NULL, browser->selection->sym);
+							     NULL, browser->selection->sym,
+							     evsel);
 			}
 		}
 		nr_options += add_script_opt(browser, &actions[nr_options],
-					     &options[nr_options], NULL, NULL);
+					     &options[nr_options], NULL, NULL, evsel);
 		nr_options += add_switch_opt(browser, &actions[nr_options],
 					     &options[nr_options]);
 skip_scripting:
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 7f36630694bf..9e5f87558af6 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -17,36 +17,111 @@
  */
 #define SCRIPT_FULLPATH_LEN	256
 
+struct script_config {
+	const char **names;
+	char **paths;
+	int index;
+	const char *perf;
+	char extra_format[256];
+};
+
+void attr_to_script(char *extra_format, struct perf_event_attr *attr)
+{
+	extra_format[0] = 0;
+	if (attr->read_format & PERF_FORMAT_GROUP)
+		strcat(extra_format, " -F +metric");
+	if (attr->sample_type & PERF_SAMPLE_BRANCH_STACK)
+		strcat(extra_format, " -F +brstackinsn --xed");
+	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
+		strcat(extra_format, " -F +iregs");
+	if (attr->sample_type & PERF_SAMPLE_REGS_USER)
+		strcat(extra_format, " -F +uregs");
+	if (attr->sample_type & PERF_SAMPLE_PHYS_ADDR)
+		strcat(extra_format, " -F +phys_addr");
+}
+
+static int add_script_option(const char *name, const char *opt,
+			     struct script_config *c)
+{
+	c->names[c->index] = name;
+	if (asprintf(&c->paths[c->index],
+		     "%s script %s -F +metric %s %s",
+		     c->perf, opt, symbol_conf.inline_name ? " --inline" : "",
+		     c->extra_format) < 0)
+		return -1;
+	c->index++;
+	return 0;
+}
+
 /*
  * When success, will copy the full path of the selected script
  * into  the buffer pointed by script_name, and return 0.
  * Return -1 on failure.
  */
-static int list_scripts(char *script_name)
+static int list_scripts(char *script_name, bool *custom,
+			struct perf_evsel *evsel)
 {
-	char *buf, *names[SCRIPT_MAX_NO], *paths[SCRIPT_MAX_NO];
-	int i, num, choice, ret = -1;
+	char *buf, *paths[SCRIPT_MAX_NO], *names[SCRIPT_MAX_NO];
+	int i, num, choice;
+	int ret = 0;
+	int max_std, custom_perf;
+	char pbuf[256];
+	const char *perf = perf_exe(pbuf, sizeof pbuf);
+	struct script_config scriptc = {
+		.names = (const char **)names,
+		.paths = paths,
+		.perf = perf
+	};
+
+	script_name[0] = 0;
 
 	/* Preset the script name to SCRIPT_NAMELEN */
 	buf = malloc(SCRIPT_MAX_NO * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN));
 	if (!buf)
-		return ret;
+		return -1;
+
+	if (evsel)
+		attr_to_script(scriptc.extra_format, &evsel->attr);
+	add_script_option("Show individual samples", "", &scriptc);
+	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+			  &scriptc);
+	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
+			  &scriptc);
+	custom_perf = scriptc.index;
+	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
+	i = scriptc.index;
+	max_std = i;
 
-	for (i = 0; i < SCRIPT_MAX_NO; i++) {
-		names[i] = buf + i * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN);
+	for (; i < SCRIPT_MAX_NO; i++) {
+		names[i] = buf + (i - max_std) * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN);
 		paths[i] = names[i] + SCRIPT_NAMELEN;
 	}
 
-	num = find_scripts(names, paths);
-	if (num > 0) {
-		choice = ui__popup_menu(num, names);
-		if (choice < num && choice >= 0) {
-			strcpy(script_name, paths[choice]);
-			ret = 0;
-		}
+	num = find_scripts(names + max_std, paths + max_std);
+	if (num < 0)
+		num = 0;
+	choice = ui__popup_menu(num + max_std, (char * const *)names);
+	if (choice < 0) {
+		ret = -1;
+		goto out;
 	}
+	if (choice == custom_perf) {
+		char script_args[50];
+		int key = ui_browser__input_window("perf script command",
+				"Enter perf script command line (without perf script prefix)",
+				script_args, "", 0);
+		if (key != K_ENTER)
+			return -1;
+		sprintf(script_name, "%s script %s", perf, script_args);
+	} else if (choice < num + max_std) {
+		strcpy(script_name, paths[choice]);
+	}
+	*custom = choice >= max_std;
 
+out:
 	free(buf);
+	for (i = 0; i < max_std; i++)
+		free(paths[i]);
 	return ret;
 }
 
@@ -66,27 +141,25 @@ static void run_script(char *cmd)
 	SLsmg_refresh();
 }
 
-int script_browse(const char *script_opt)
+int script_browse(const char *script_opt, struct perf_evsel *evsel)
 {
-	char cmd[SCRIPT_FULLPATH_LEN*2], script_name[SCRIPT_FULLPATH_LEN];
+	char *cmd, script_name[SCRIPT_FULLPATH_LEN];
+	bool custom = false;
 
 	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
-	if (list_scripts(script_name))
+	if (list_scripts(script_name, &custom, evsel))
 		return -1;
 
-	sprintf(cmd, "perf script -s %s ", script_name);
-
-	if (script_opt)
-		strcat(cmd, script_opt);
-
-	if (input_name) {
-		strcat(cmd, " -i ");
-		strcat(cmd, input_name);
-	}
-
-	strcat(cmd, " 2>&1 | less");
+	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
+			custom ? "perf script -s " : "",
+			script_name,
+			script_opt ? script_opt : "",
+			input_name ? "-i " : "",
+			input_name ? input_name : "") < 0)
+		return -1;
 
 	run_script(cmd);
+	free(cmd);
 
 	return 0;
 }
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6279eca56409..2113a6639cea 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -436,6 +436,8 @@ struct annotation_options;
 
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
+void attr_to_script(char *buf, struct perf_event_attr *attr);
+
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *annotation_opts);
@@ -450,7 +452,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct perf_env *env,
 				  bool warn_lost_event,
 				  struct annotation_options *annotation_options);
-int script_browse(const char *script_opt);
+
+int script_browse(const char *script_opt, struct perf_evsel *evsel);
 #else
 static inline
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
@@ -479,7 +482,8 @@ static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 	return 0;
 }
 
-static inline int script_browse(const char *script_opt __maybe_unused)
+static inline int script_browse(const char *script_opt __maybe_unused,
+				struct perf_evsel *evsel __maybe_unused)
 {
 	return 0;
 }
