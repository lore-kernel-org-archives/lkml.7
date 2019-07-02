Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1151C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D621851
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034491;
	bh=iDU1JzZg88Ih/6Pg/OvIOVQZUHnM537smLpFrzF1Lss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgYRwGdYfydFfdZbGBnqU2X21oN30Oj08onazc1ZDdRhbEL4VYUjg7291bGko6tF5
	 Un2kZ3M6yNIr5CLRZ7kTaROL9/aXcxTdg3bU0ixEzTRW7V2f2PfPdkviARZo26WZ2O
	 vLrsqT2dJdGG4Ca9qFVHKf25bDyXoNsSD36Xf0q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGBC2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfGBC2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0C121721;
        Tue,  2 Jul 2019 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034488;
        bh=iDU1JzZg88Ih/6Pg/OvIOVQZUHnM537smLpFrzF1Lss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1HikcB43TM731xXFjjDxlq7buNMhZIpmpDM4TozYSVABKtSvFjeY9YNdosLzIjaQ
         zYlVH+Bn/sIrAVJiTerLMuP6pF19LcdoajNwTe6Tuq7hJaNQ9W93kOgsmMB+Iiiadt
         oEp9A4ArZTOWXuN+BQScuthd/KgGf2MAKriNLEas=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH 31/43] perf tools: Ditch rtrim(), use skip_spaces() to get closer to the kernel
Date:   Mon,  1 Jul 2019 23:26:04 -0300
Message-Id: <20190702022616.1259-32-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

