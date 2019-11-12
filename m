Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8EFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496621D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583913;
	bh=F30wImNxsu6v96OwLMqxFooa4BCiSIVTvUrHfwYLmJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PbxOoadWqvMiUA2VPnSD6pigTCXGzXNCi5j+2BB4D0SHec6fW17wN5UJgzGKkW9NE
	 wPxpceBALXAa8AEXjcVOXioF/oX4r688JOAcrnyJMiIZinvJgU8O8C0it8rl34AWIm
	 dWerdm4hEv067za7fQGBzutavohIiSDkJVjygPZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfKLSic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:38:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfKLSib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:31 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB1921E6F;
        Tue, 12 Nov 2019 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583909;
        bh=F30wImNxsu6v96OwLMqxFooa4BCiSIVTvUrHfwYLmJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNp3HxHsi8uRYhjw3h3cygJliT0OY0yeBjTREIp6UhTgt3tm+fpZfZu/KxsMQzfBy
         A/6gIQNJhL7bA+21SmBY+Ki03EvR/GBxmB65Kx1xBemHiZNqzkrz8Je81ZuOUtj9XU
         CGdlpWGOcupUj+dLVM40TZcfbJ6JIeScrHF3g9qQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 05/15] perf annotate: Pass a 'map_symbol' in places receiving a pair of 'map' and 'symbol' pointers
Date:   Tue, 12 Nov 2019 15:37:47 -0300
Message-Id: <20191112183757.28660-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We are already passing things like:

  symbol__annotate(ms->sym, ms->map, ...)

So shorten the signature of such functions to receive the 'map_symbol'
pointer.

This also paves the way to having the 'struct map_groups' pointer in the
'struct map_symbol' so that we can get rid of 'struct map'->groups.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-23yx8v1t41nzpkpi7rdrozww@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c     |  4 +--
 tools/perf/builtin-report.c       |  2 +-
 tools/perf/builtin-top.c          |  6 ++--
 tools/perf/ui/browsers/annotate.c | 24 ++++++-------
 tools/perf/ui/gtk/annotate.c      | 27 ++++++++-------
 tools/perf/util/annotate.c        | 56 +++++++++++++++----------------
 tools/perf/util/annotate.h        | 22 +++++-------
 7 files changed, 66 insertions(+), 75 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6ab0cc45b287..680c59fafeaf 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -301,9 +301,9 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
-		return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel, &ann->opts);
+		return symbol__tty_annotate(&he->ms, evsel, &ann->opts);
 
-	return symbol__tty_annotate2(he->ms.sym, he->ms.map, evsel, &ann->opts);
+	return symbol__tty_annotate2(&he->ms, evsel, &ann->opts);
 }
 
 static void hists__find_annotations(struct hists *hists,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1e81985b7d56..585805f51f15 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -680,7 +680,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 	if (rep->symbol_ipc && sym && !sym->annotate2) {
 		struct evsel *evsel = hists_to_evsel(he->hists);
 
-		symbol__annotate2(sym, he->ms.map, evsel,
+		symbol__annotate2(&he->ms, evsel,
 				  &annotation__default_options, NULL);
 	}
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 14c52e4d47f6..dc80044bc46f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -143,12 +143,12 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, evsel, 0, &top->annotation_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
 		char msg[BUFSIZ];
-		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
+		symbol__strerror_disassemble(&he->ms, err, msg, sizeof(msg));
 		pr_err("Couldn't annotate %s: %s\n", sym->name, msg);
 	}
 
@@ -257,7 +257,7 @@ static void perf_top__show_details(struct perf_top *top)
 	printf("Showing %s for %s\n", perf_evsel__name(top->sym_evsel), symbol->name);
 	printf("  Events  Pcnt (>=%d%%)\n", top->annotation_opts.min_pcnt);
 
-	more = symbol__annotate_printf(symbol, he->ms.map, top->sym_evsel, &top->annotation_opts);
+	more = symbol__annotate_printf(&he->ms, top->sym_evsel, &top->annotation_opts);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 82207db8f97c..ad1fe5b6d0cd 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -410,7 +410,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 				    struct evsel *evsel,
 				    struct hist_browser_timer *hbt)
 {
-	struct map_symbol *ms = browser->b.priv;
+	struct map_symbol *ms = browser->b.priv, target_ms;
 	struct disasm_line *dl = disasm_line(browser->selection);
 	struct annotation *notes;
 	char title[SYM_TITLE_MAX_SIZE];
@@ -430,8 +430,10 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 		return true;
 	}
 
+	target_ms.map = ms->map;
+	target_ms.sym = dl->ops.target.sym;
 	pthread_mutex_unlock(&notes->lock);
-	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
+	symbol__tui_annotate(&target_ms, evsel, hbt, browser->opts);
 	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -874,7 +876,7 @@ int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *opts)
 {
-	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt, opts);
+	return symbol__tui_annotate(ms, evsel, hbt, opts);
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
@@ -888,16 +890,12 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 	return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
 }
 
-int symbol__tui_annotate(struct symbol *sym, struct map *map,
-			 struct evsel *evsel,
+int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			 struct hist_browser_timer *hbt,
 			 struct annotation_options *opts)
 {
+	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct map_symbol ms = {
-		.map = map,
-		.sym = sym,
-	};
 	struct annotate_browser browser = {
 		.b = {
 			.refresh = annotate_browser__refresh,
@@ -905,7 +903,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			.write	 = annotate_browser__write,
 			.filter  = disasm_line__filter,
 			.extra_title_lines = 1, /* for hists__scnprintf_title() */
-			.priv	 = &ms,
+			.priv	 = ms,
 			.use_navkeypressed = true,
 		},
 		.opts = opts,
@@ -915,13 +913,13 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (sym == NULL)
 		return -1;
 
-	if (map->dso->annotate_warned)
+	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate2(sym, map, evsel, opts, &browser.arch);
+	err = symbol__annotate2(ms, evsel, opts, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
-		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
+		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 		goto out_free_offsets;
 	}
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 8e744af24f7c..22cc240f7371 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -54,10 +54,10 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 	return ret;
 }
 
-static int perf_gtk__get_offset(char *buf, size_t size, struct symbol *sym,
-				struct map *map, struct disasm_line *dl)
+static int perf_gtk__get_offset(char *buf, size_t size, struct map_symbol *ms,
+				struct disasm_line *dl)
 {
-	u64 start = map__rip_2objdump(map, sym->start);
+	u64 start = map__rip_2objdump(ms->map, ms->sym->start);
 
 	strcpy(buf, "");
 
@@ -91,10 +91,11 @@ static int perf_gtk__get_line(char *buf, size_t size, struct disasm_line *dl)
 	return ret;
 }
 
-static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
-				struct map *map, struct evsel *evsel,
+static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
+				struct evsel *evsel,
 				struct hist_browser_timer *hbt __maybe_unused)
 {
+	struct symbol *sym = ms->sym;
 	struct disasm_line *pos, *n;
 	struct annotation *notes;
 	GType col_types[MAX_ANN_COLS];
@@ -144,7 +145,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 
 		if (ret)
 			gtk_list_store_set(store, &iter, ANN_COL__PERCENT, s, -1);
-		if (perf_gtk__get_offset(s, sizeof(s), sym, map, pos))
+		if (perf_gtk__get_offset(s, sizeof(s), ms, pos))
 			gtk_list_store_set(store, &iter, ANN_COL__OFFSET, s, -1);
 		if (perf_gtk__get_line(s, sizeof(s), pos))
 			gtk_list_store_set(store, &iter, ANN_COL__LINE, s, -1);
@@ -160,23 +161,23 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 	return 0;
 }
 
-static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
-				struct evsel *evsel,
+static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 				struct hist_browser_timer *hbt)
 {
+	struct symbol *sym = ms->sym;
 	GtkWidget *window;
 	GtkWidget *notebook;
 	GtkWidget *scrolled_window;
 	GtkWidget *tab_label;
 	int err;
 
-	if (map->dso->annotate_warned)
+	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(sym, map, evsel, 0, &annotation__default_options, NULL);
+	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
-		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
+		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s: %s\n", sym->name, msg);
 		return -1;
 	}
@@ -234,7 +235,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	gtk_notebook_append_page(GTK_NOTEBOOK(notebook), scrolled_window,
 				 tab_label);
 
-	perf_gtk__annotate_symbol(scrolled_window, sym, map, evsel, hbt);
+	perf_gtk__annotate_symbol(scrolled_window, ms, evsel, hbt);
 	return 0;
 }
 
@@ -242,7 +243,7 @@ int hist_entry__gtk_annotate(struct hist_entry *he,
 			     struct evsel *evsel,
 			     struct hist_browser_timer *hbt)
 {
-	return symbol__gtk_annotate(he->ms.sym, he->ms.map, evsel, hbt);
+	return symbol__gtk_annotate(&he->ms, evsel, hbt);
 }
 
 void perf_gtk__show_annotations(void)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ecc024495f56..78ef3cc2eb66 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1583,10 +1583,9 @@ static void delete_last_nop(struct symbol *sym)
 	}
 }
 
-int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *map,
-			      int errnum, char *buf, size_t buflen)
+int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = ms->map->dso;
 
 	BUG_ON(buflen == 0);
 
@@ -2143,11 +2142,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct symbol *sym, struct map *map,
-		     struct evsel *evsel, size_t privsize,
-		     struct annotation_options *options,
-		     struct arch **parch)
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel, size_t privsize,
+		     struct annotation_options *options, struct arch **parch)
 {
+	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
 		.privsize	= privsize,
@@ -2177,9 +2175,8 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
-	args.ms.map = map;
-	args.ms.sym = sym;
-	notes->start = map__rip_2objdump(map, sym->start);
+	args.ms = *ms;
+	notes->start = map__rip_2objdump(ms->map, sym->start);
 
 	return symbol__disassemble(sym, &args);
 }
@@ -2335,10 +2332,11 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 	return 0;
 }
 
-int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct evsel *evsel,
+int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 			    struct annotation_options *opts)
 {
+	struct map *map = ms->map;
+	struct symbol *sym = ms->sym;
 	struct dso *dso = map->dso;
 	char *filename;
 	const char *d_filename;
@@ -2742,30 +2740,29 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 	resort_source_line(root, &tmp_root);
 }
 
-static void symbol__calc_lines(struct symbol *sym, struct map *map,
-			       struct rb_root *root,
+static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root,
 			       struct annotation_options *opts)
 {
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes = symbol__annotation(ms->sym);
 
-	annotation__calc_lines(notes, map, root, opts);
+	annotation__calc_lines(notes, ms->map, root, opts);
 }
 
-int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct evsel *evsel,
+int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 			  struct annotation_options *opts)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = ms->map->dso;
+	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	struct hists *hists = evsel__hists(evsel);
 	char buf[1024];
 
-	if (symbol__annotate2(sym, map, evsel, opts, NULL) < 0)
+	if (symbol__annotate2(ms, evsel, opts, NULL) < 0)
 		return -1;
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line, opts);
+		symbol__calc_lines(ms, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
@@ -2779,25 +2776,25 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	return 0;
 }
 
-int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct evsel *evsel,
+int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 			 struct annotation_options *opts)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = ms->map->dso;
+	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(sym, map, evsel, 0, opts, NULL) < 0)
+	if (symbol__annotate(ms, evsel, 0, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line, opts);
+		symbol__calc_lines(ms, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
-	symbol__annotate_printf(sym, map, evsel, opts);
+	symbol__annotate_printf(ms, evsel, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -3051,9 +3048,10 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 				 wops->write_graph);
 }
 
-int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
+int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 		      struct annotation_options *options, struct arch **parch)
 {
+	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	size_t size = symbol__size(sym);
 	int nr_pcnt = 1, err;
@@ -3065,7 +3063,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(sym, map, evsel, 0, options, parch);
+	err = symbol__annotate(ms, evsel, 0, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3528bd4f8f21..7075d98f69d9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -349,11 +349,11 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *samp
 struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
-int symbol__annotate(struct symbol *sym, struct map *map,
+int symbol__annotate(struct map_symbol *ms,
 		     struct evsel *evsel, size_t privsize,
 		     struct annotation_options *options,
 		     struct arch **parch);
-int symbol__annotate2(struct symbol *sym, struct map *map,
+int symbol__annotate2(struct map_symbol *ms,
 		      struct evsel *evsel,
 		      struct annotation_options *options,
 		      struct arch **parch);
@@ -380,11 +380,9 @@ enum symbol_disassemble_errno {
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
 
-int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
-				 int errnum, char *buf, size_t buflen);
+int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
-int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct evsel *evsel,
+int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 			    struct annotation_options *options);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
@@ -395,20 +393,16 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 
 bool ui__has_annotation(void);
 
-int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct evsel *evsel, struct annotation_options *opts);
+int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel, struct annotation_options *opts);
 
-int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct evsel *evsel, struct annotation_options *opts);
+int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel, struct annotation_options *opts);
 
 #ifdef HAVE_SLANG_SUPPORT
-int symbol__tui_annotate(struct symbol *sym, struct map *map,
-			 struct evsel *evsel,
+int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			 struct hist_browser_timer *hbt,
 			 struct annotation_options *opts);
 #else
-static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
-				struct map *map __maybe_unused,
+static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 				struct evsel *evsel  __maybe_unused,
 				struct hist_browser_timer *hbt __maybe_unused,
 				struct annotation_options *opts __maybe_unused)
-- 
2.21.0

