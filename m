Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4776BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093F421850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Lv/iRWgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGCOXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:23:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:23:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EMlIa3324073
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:22:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EMlIa3324073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163768;
        bh=asRdQDUdVvfJZBDCEK0C3V5Hc2aX1e6s9d/FDulFQdY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Lv/iRWgz1rgIc3XYDByT1A6x0K6zBxF0IzHe2EcmC2fAHX0rIi+qq+NyTq69r3gvu
         axSnh61m4FS4LjWxNvTnu7V0hKb7Dtktm6fj3KnyajZL32u3IY9TbvMt6N51rlWZXv
         OKKOIHWYn5w+6TWsRIsO5iF6XMEhuqzAdBjO46cLpxoz6XJPKAJL6LfQqYBxpAvLz6
         pUzYIzQF7hRIOBcbY9zsnp7YWPibTU4gHrdbRuGr6F2xFykIT/BW0ehRHzO/WitVjQ
         3+jblsrdcUiI20d9VSU4/FMlMvYGXGbjWyBvqVI2XnD3K/Sn1Nw3lteBuzqdJy1JDZ
         M6JoPJvTYMNwA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EMl3K3324070;
        Wed, 3 Jul 2019 07:22:47 -0700
Date:   Wed, 3 Jul 2019 07:22:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a85lkptkt0ru40irpga8yf54@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
        acme@redhat.com, andre.goddard@gmail.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, andre.goddard@gmail.com,
          tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
          hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Ditch rtrim(), use skip_spaces() to get
 closer to the kernel
Git-Commit-ID: 328584804edc950fb4608c9a38e396ac71ef22b6
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

Commit-ID:  328584804edc950fb4608c9a38e396ac71ef22b6
Gitweb:     https://git.kernel.org/tip/328584804edc950fb4608c9a38e396ac71ef22b6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 11:42:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 11:42:03 -0300

perf tools: Ditch rtrim(), use skip_spaces() to get closer to the kernel

No change in behaviour, just using the same kernel idiom for such
operation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-a85lkptkt0ru40irpga8yf54@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c    | 12 ++++++------
 tools/perf/ui/browser.c        |  2 +-
 tools/perf/ui/browsers/hists.c |  2 +-
 tools/perf/ui/gtk/hists.c      |  4 ++--
 tools/perf/ui/stdio/hist.c     |  2 +-
 tools/perf/util/annotate.c     | 10 +++++-----
 tools/perf/util/event.c        |  4 +---
 tools/perf/util/pmu.c          |  3 ++-
 tools/perf/util/stat-display.c |  4 ++--
 tools/perf/util/string.c       | 14 --------------
 tools/perf/util/string2.h      |  4 ++--
 11 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0131f7a0d48d..520e5b6b9ef9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2880,7 +2880,7 @@ static int read_script_info(struct script_desc *desc, const char *filename)
 		return -1;
 
 	while (fgets(line, sizeof(line), fp)) {
-		p = ltrim(line);
+		p = skip_spaces(line);
 		if (strlen(p) == 0)
 			continue;
 		if (*p != '#')
@@ -2889,19 +2889,19 @@ static int read_script_info(struct script_desc *desc, const char *filename)
 		if (strlen(p) && *p == '!')
 			continue;
 
-		p = ltrim(p);
+		p = skip_spaces(p);
 		if (strlen(p) && p[strlen(p) - 1] == '\n')
 			p[strlen(p) - 1] = '\0';
 
 		if (!strncmp(p, "description:", strlen("description:"))) {
 			p += strlen("description:");
-			desc->half_liner = strdup(ltrim(p));
+			desc->half_liner = strdup(skip_spaces(p));
 			continue;
 		}
 
 		if (!strncmp(p, "args:", strlen("args:"))) {
 			p += strlen("args:");
-			desc->args = strdup(ltrim(p));
+			desc->args = strdup(skip_spaces(p));
 			continue;
 		}
 	}
@@ -3008,7 +3008,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 		return -1;
 
 	while (fgets(line, sizeof(line), fp)) {
-		p = ltrim(line);
+		p = skip_spaces(line);
 		if (*p == '#')
 			continue;
 
@@ -3018,7 +3018,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 				break;
 
 			p += 2;
-			p = ltrim(p);
+			p = skip_spaces(p);
 			len = strcspn(p, " \t");
 			if (!len)
 				break;
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 8812c1564995..55ff05a46e0b 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -594,7 +594,7 @@ static int ui_browser__color_config(const char *var, const char *value,
 			break;
 
 		*bg = '\0';
-		bg = ltrim(++bg);
+		bg = skip_spaces(bg + 1);
 		ui_browser__colorsets[i].bg = bg;
 		ui_browser__colorsets[i].fg = fg;
 		return 0;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 59483bdb0027..04a56114df92 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1470,7 +1470,7 @@ static int hist_browser__show_hierarchy_entry(struct hist_browser *browser,
 				int i = 0;
 
 				width -= fmt->entry(fmt, &hpp, entry);
-				ui_browser__printf(&browser->b, "%s", ltrim(s));
+				ui_browser__printf(&browser->b, "%s", skip_spaces(s));
 
 				while (isspace(s[i++]))
 					width++;
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 0c08890f006a..6341c421a8f7 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -459,7 +459,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 			advance_hpp(hpp, ret + 2);
 		}
 
-		gtk_tree_store_set(store, &iter, col_idx, ltrim(rtrim(bf)), -1);
+		gtk_tree_store_set(store, &iter, col_idx, trim(bf), -1);
 
 		if (!he->leaf) {
 			hpp->buf = bf;
@@ -555,7 +555,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 			first_col = false;
 
 			fmt->header(fmt, &hpp, hists, 0, NULL);
-			strcat(buf, ltrim(rtrim(hpp.buf)));
+			strcat(buf, trim(hpp.buf));
 		}
 	}
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 4b1a6e921d1c..594e56628904 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -516,7 +516,7 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 		 * dynamic entries are right-aligned but we want left-aligned
 		 * in the hierarchy mode
 		 */
-		printed += fprintf(fp, "%s%s", sep ?: "  ", ltrim(buf));
+		printed += fprintf(fp, "%s%s", sep ?: "  ", skip_spaces(buf));
 	}
 	printed += putc('\n', fp);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 65005ccea232..783e2628cc8e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -557,7 +557,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (comment == NULL)
 		return 0;
 
-	comment = ltrim(comment);
+	comment = skip_spaces(comment);
 	comment__symbol(ops->source.raw, comment + 1, &ops->source.addr, &ops->source.name);
 	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
@@ -602,7 +602,7 @@ static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops
 	if (comment == NULL)
 		return 0;
 
-	comment = ltrim(comment);
+	comment = skip_spaces(comment);
 	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
@@ -1098,7 +1098,7 @@ static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, str
 
 static int disasm_line__parse(char *line, const char **namep, char **rawp)
 {
-	char tmp, *name = ltrim(line);
+	char tmp, *name = skip_spaces(line);
 
 	if (name[0] == '\0')
 		return -1;
@@ -1116,7 +1116,7 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 		goto out_free_name;
 
 	(*rawp)[0] = tmp;
-	*rawp = ltrim(*rawp);
+	*rawp = skip_spaces(*rawp);
 
 	return 0;
 
@@ -1503,7 +1503,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 		return 0;
 	}
 
-	tmp = ltrim(parsed_line);
+	tmp = skip_spaces(parsed_line);
 	if (*tmp) {
 		/*
 		 * Parse hexa addresses followed by ':'
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index d8f8a20543c5..e1d0c5ba1f92 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -158,9 +158,7 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	if (name) {
 		char *nl;
 
-		name += 5;  /* strlen("Name:") */
-		name = ltrim(name);
-
+		name = skip_spaces(name + 5);  /* strlen("Name:") */
 		nl = strchr(name, '\n');
 		if (nl)
 			*nl = '\0';
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index faa8eb231e1b..38dc0c6e28b8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <sys/types.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -1339,7 +1340,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 			break;
 		s += wlen;
 		column += n;
-		s = ltrim(s);
+		s = skip_spaces(s);
 	}
 }
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ce993d29cca5..90df41169113 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -212,7 +212,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
-	ends = vals = ltrim(buf);
+	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
@@ -280,7 +280,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
 	snprintf(buf, sizeof buf, fmt, val);
-	ends = vals = ltrim(buf);
+	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index d28e723e2790..99a555ea4a9f 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -318,20 +318,6 @@ char *strxfrchar(char *s, char from, char to)
 	return s;
 }
 
-/**
- * ltrim - Removes leading whitespace from @s.
- * @s: The string to be stripped.
- *
- * Return pointer to the first non-whitespace character in @s.
- */
-char *ltrim(char *s)
-{
-	while (isspace(*s))
-		s++;
-
-	return s;
-}
-
 /**
  * rtrim - Removes trailing whitespace from @s.
  * @s: The string to be stripped.
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 07fd37568543..db02059e31c5 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -2,6 +2,7 @@
 #ifndef PERF_STRING_H
 #define PERF_STRING_H
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <stddef.h>
 #include <string.h>
@@ -22,12 +23,11 @@ static inline bool strisglob(const char *str)
 int strtailcmp(const char *s1, const char *s2);
 char *strxfrchar(char *s, char from, char to);
 
-char *ltrim(char *s);
 char *rtrim(char *s);
 
 static inline char *trim(char *s)
 {
-	return ltrim(rtrim(s));
+	return skip_spaces(rtrim(s));
 }
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
