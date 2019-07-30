Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0616820693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LmJVTiOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfG3SjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:39:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3SjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:39:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIbt7D3331733
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:37:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIbt7D3331733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511876;
        bh=N9O5myOX1Pb2gMNNs+ewiw0U+z4KOW8XuflRfKtUMdE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LmJVTiOeiYIJCa0Zsn8N3d2todm4/2aEPE6J2HBopAwyaqO0OByC2bOfcqli7prHx
         mf3twUP2OMBhx3mdCCRSHgfgJBAPdO69EvsVqKc334rdpPogvQ535c8T1kYsOh134W
         fQtsN7niUzZ/P2C9r5Jw4Lt9QLZI1c0QTh3d0+6d29RjrShg5ULqbKKvyLmNKSkHWU
         oMrZ5Jsc1TLiGYPtmxlpiuYBcdeNLnj1x62vk6Yo0JSCrokOk2QCxwlKN2AUmiDaRN
         yvg2vwSbwGLkJ6zOUC4VgcX8UF3W+AkNIKFNJjj/7zAAmuxxfdy2OgzGskK8l8u3jj
         7yPagVdZ4DmWA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIbtWI3331730;
        Tue, 30 Jul 2019 11:37:55 -0700
Date:   Tue, 30 Jul 2019 11:37:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6484d2f9dc3ecbf13f07100f7f771d1d779eda04@git.kernel.org>
Cc:     ak@linux.intel.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org,
        alexey.budankov@linux.intel.com, hpa@zytor.com, mpetlan@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        peterz@infradead.org, mingo@kernel.org
Reply-To: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
          namhyung@kernel.org, alexey.budankov@linux.intel.com,
          ak@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org
In-Reply-To: <20190721112506.12306-42-jolsa@kernel.org>
References: <20190721112506.12306-42-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add nr_entries to struct perf_evlist
Git-Commit-ID: 6484d2f9dc3ecbf13f07100f7f771d1d779eda04
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

Commit-ID:  6484d2f9dc3ecbf13f07100f7f771d1d779eda04
Gitweb:     https://git.kernel.org/tip/6484d2f9dc3ecbf13f07100f7f771d1d779eda04
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:28 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add nr_entries to struct perf_evlist

Move nr_entries count from 'struct perf' to into perf_evlist struct.

Committer notes:

Fix tools/perf/arch/s390/util/auxtrace.c case. And also the comment in
tools/perf/util/annotate.h.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-42-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/auxtrace.c     |  2 +-
 tools/perf/builtin-record.c              |  4 +-
 tools/perf/builtin-stat.c                |  4 +-
 tools/perf/builtin-top.c                 | 12 ++---
 tools/perf/builtin-trace.c               |  4 +-
 tools/perf/lib/evlist.c                  |  3 ++
 tools/perf/lib/include/internal/evlist.h |  1 +
 tools/perf/tests/parse-events.c          | 76 ++++++++++++++++----------------
 tools/perf/ui/browsers/annotate.c        |  2 +-
 tools/perf/ui/browsers/hists.c           |  2 +-
 tools/perf/util/annotate.c               |  2 +-
 tools/perf/util/annotate.h               |  2 +-
 tools/perf/util/evlist.c                 | 26 +++++------
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/header.c                 |  4 +-
 tools/perf/util/parse-events.c           |  4 +-
 tools/perf/util/python.c                 |  8 ++--
 tools/perf/util/record.c                 |  2 +-
 tools/perf/util/sort.c                   |  2 +-
 tools/perf/util/top.c                    |  2 +-
 20 files changed, 83 insertions(+), 80 deletions(-)

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 833f60fa9c5a..480ada281bdb 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -90,7 +90,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	int diagnose = 0;
 
 	*err = 0;
-	if (evlist->nr_entries == 0)
+	if (evlist->core.nr_entries == 0)
 		return NULL;
 
 	evlist__for_each_entry(evlist, pos) {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 17bb0a536da3..778e46417f6b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1375,7 +1375,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * because we synthesize event name through the pipe
 	 * and need the id for that.
 	 */
-	if (data->is_pipe && rec->evlist->nr_entries == 1)
+	if (data->is_pipe && rec->evlist->core.nr_entries == 1)
 		rec->opts.sample_id = true;
 
 	if (record__open(rec) != 0) {
@@ -2386,7 +2386,7 @@ int cmd_record(int argc, const char **argv)
 	if (record.opts.overwrite)
 		record.opts.tail_synthesize = true;
 
-	if (rec->evlist->nr_entries == 0 &&
+	if (rec->evlist->core.nr_entries == 0 &&
 	    __perf_evlist__add_default(rec->evlist, !record.opts.no_samples) < 0) {
 		pr_err("Not enough memory for event selector list\n");
 		goto out;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 39bd73d0e06e..3ba184f2e64f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1366,7 +1366,7 @@ static int add_default_attributes(void)
 		free(str);
 	}
 
-	if (!evsel_list->nr_entries) {
+	if (!evsel_list->core.nr_entries) {
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
@@ -1683,7 +1683,7 @@ static void setup_system_wide(int forks)
 				return;
 		}
 
-		if (evsel_list->nr_entries)
+		if (evsel_list->core.nr_entries)
 			target.system_wide = true;
 	}
 }
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b103f1ba01cb..3291eff13e28 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -129,7 +129,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	notes = symbol__annotation(sym);
 	pthread_mutex_lock(&notes->lock);
 
-	if (!symbol__hists(sym, top->evlist->nr_entries)) {
+	if (!symbol__hists(sym, top->evlist->core.nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
@@ -404,7 +404,7 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 	fprintf(stdout, "\t[d]     display refresh delay.             \t(%d)\n", top->delay_secs);
 	fprintf(stdout, "\t[e]     display entries (lines).           \t(%d)\n", top->print_entries);
 
-	if (top->evlist->nr_entries > 1)
+	if (top->evlist->core.nr_entries > 1)
 		fprintf(stdout, "\t[E]     active event counter.              \t(%s)\n", perf_evsel__name(top->sym_evsel));
 
 	fprintf(stdout, "\t[f]     profile display filter (count).    \t(%d)\n", top->count_filter);
@@ -439,7 +439,7 @@ static int perf_top__key_mapped(struct perf_top *top, int c)
 		case 'S':
 			return 1;
 		case 'E':
-			return top->evlist->nr_entries > 1 ? 1 : 0;
+			return top->evlist->core.nr_entries > 1 ? 1 : 0;
 		default:
 			break;
 	}
@@ -485,7 +485,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 			}
 			break;
 		case 'E':
-			if (top->evlist->nr_entries > 1) {
+			if (top->evlist->core.nr_entries > 1) {
 				/* Select 0 as the default event: */
 				int counter = 0;
 
@@ -496,7 +496,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 
 				prompt_integer(&counter, "Enter details event counter");
 
-				if (counter >= top->evlist->nr_entries) {
+				if (counter >= top->evlist->core.nr_entries) {
 					top->sym_evsel = perf_evlist__first(top->evlist);
 					fprintf(stderr, "Sorry, no such event, using %s.\n", perf_evsel__name(top->sym_evsel));
 					sleep(1);
@@ -1536,7 +1536,7 @@ int cmd_top(int argc, const char **argv)
 	if (argc)
 		usage_with_options(top_usage, options);
 
-	if (!top.evlist->nr_entries &&
+	if (!top.evlist->core.nr_entries &&
 	    perf_evlist__add_default(top.evlist) < 0) {
 		pr_err("Not enough memory for event selector list\n");
 		goto out_delete_evlist;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bcd033e91de4..06fcd8b1f160 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4270,7 +4270,7 @@ int cmd_trace(int argc, const char **argv)
 		symbol_conf.use_callchain = true;
 	}
 
-	if (trace.evlist->nr_entries > 0) {
+	if (trace.evlist->core.nr_entries > 0) {
 		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
 		if (evlist__set_syscall_tp_fields(trace.evlist)) {
 			perror("failed to set syscalls:* tracepoint fields");
@@ -4368,7 +4368,7 @@ init_augmented_syscall_tp:
 		trace.summary = trace.summary_only;
 
 	if (!trace.trace_syscalls && !trace.trace_pgfaults &&
-	    trace.evlist->nr_entries == 0 /* Was --events used? */) {
+	    trace.evlist->core.nr_entries == 0 /* Was --events used? */) {
 		trace.trace_syscalls = true;
 	}
 
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 023fe4b44131..1b27fd2de9b9 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -7,16 +7,19 @@
 void perf_evlist__init(struct perf_evlist *evlist)
 {
 	INIT_LIST_HEAD(&evlist->entries);
+	evlist->nr_entries = 0;
 }
 
 void perf_evlist__add(struct perf_evlist *evlist,
 		      struct perf_evsel *evsel)
 {
 	list_add_tail(&evsel->node, &evlist->entries);
+	evlist->nr_entries += 1;
 }
 
 void perf_evlist__remove(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel)
 {
 	list_del_init(&evsel->node);
+	evlist->nr_entries -= 1;
 }
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 7fbfe5716652..a12c712a9197 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -4,6 +4,7 @@
 
 struct perf_evlist {
 	struct list_head	entries;
+	int			nr_entries;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 2365dd655c88..878140501edf 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -48,7 +48,7 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
@@ -61,7 +61,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", evlist->nr_entries > 1);
+	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
 	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -79,7 +79,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->attr.config);
 	return 0;
@@ -89,7 +89,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->attr.config);
 	return 0;
@@ -99,7 +99,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->attr.config);
@@ -110,7 +110,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->attr.config);
@@ -131,7 +131,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_PAGE_FAULTS == evsel->attr.config);
@@ -142,7 +142,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->attr.config);
 	return 0;
@@ -152,7 +152,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
@@ -166,7 +166,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
@@ -179,7 +179,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
@@ -194,7 +194,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
@@ -209,7 +209,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
@@ -237,7 +237,7 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", evlist->nr_entries > 1);
+	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user",
@@ -437,7 +437,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",    10 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->attr.config1);
@@ -455,7 +455,7 @@ static int test__checkevent_list(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 
 	/* r1 */
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
@@ -495,14 +495,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	struct evsel *evsel = perf_evlist__first(evlist);
 
 	/* cpu/config=1,name=krava/u */
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",  1 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong name", !strcmp(perf_evsel__name(evsel), "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = perf_evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",  2 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong name",
@@ -516,7 +516,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	struct evsel *evsel = perf_evlist__first(evlist);
 
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",  1 == evsel->attr.config);
 	/*
@@ -548,7 +548,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->attr.exclude_user);
@@ -567,7 +567,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	struct evsel *evsel = perf_evlist__first(evlist);
 
 	/* pmu-event:u */
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel",
@@ -578,7 +578,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 
 	/* cpu/pmu-event/u*/
 	evsel = perf_evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->attr.exclude_user);
@@ -638,7 +638,7 @@ static int test__group1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* instructions:k */
@@ -680,7 +680,7 @@ static int test__group2(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* faults + :ku modifier */
@@ -735,7 +735,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
 
 	/* group1 syscalls:sys_enter_openat:H */
@@ -827,7 +827,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles:u + p */
@@ -871,7 +871,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
 
 	/* cycles + G */
@@ -957,7 +957,7 @@ static int test__group_gh1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles + :H group modifier */
@@ -997,7 +997,7 @@ static int test__group_gh2(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles + :G group modifier */
@@ -1037,7 +1037,7 @@ static int test__group_gh3(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles:G + :u group modifier */
@@ -1077,7 +1077,7 @@ static int test__group_gh4(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles:G + :uG group modifier */
@@ -1117,7 +1117,7 @@ static int test__leader_sample1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 
 	/* cycles - sampling group leader */
 	evsel = leader = perf_evlist__first(evlist);
@@ -1170,7 +1170,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 
 	/* instructions - sampling group leader */
 	evsel = leader = perf_evlist__first(evlist);
@@ -1222,7 +1222,7 @@ static int test__pinned_group(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 
 	/* cycles - group leader */
 	evsel = leader = perf_evlist__first(evlist);
@@ -1253,7 +1253,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
@@ -1268,7 +1268,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config", 0 == evsel->attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
@@ -1296,7 +1296,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_TASK_CLOCK == evsel->attr.config);
@@ -1425,7 +1425,7 @@ static int count_tracepoints(void)
 static int test__all_tracepoints(struct evlist *evlist)
 {
 	TEST_ASSERT_VAL("wrong events count",
-			count_tracepoints() == evlist->nr_entries);
+			count_tracepoints() == evlist->core.nr_entries);
 
 	return test__checkevent_tracepoint_multi(evlist);
 }
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 64cc650c4543..e633eb42550d 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -422,7 +422,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	notes = symbol__annotation(dl->ops.target.sym);
 	pthread_mutex_lock(&notes->lock);
 
-	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->nr_entries)) {
+	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->core.nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ed5406ff9fe4..b195b1ba625b 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3404,7 +3404,7 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 				  bool warn_lost_event,
 				  struct annotation_options *annotation_opts)
 {
-	int nr_entries = evlist->nr_entries;
+	int nr_entries = evlist->core.nr_entries;
 
 single_entry:
 	if (nr_entries == 1) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6ea5d678a81c..d46f2ae2c695 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -936,7 +936,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 
 	if (sym == NULL)
 		return 0;
-	src = symbol__hists(sym, evsel->evlist->nr_entries);
+	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
 	return (src) ?  __symbol__inc_addr_samples(sym, map, src, evsel->idx,
 						   addr, sample) : 0;
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7c42f320efa2..d94be9140e31 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -245,7 +245,7 @@ struct cyc_hist {
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
  * @histograms: Array of addr hit histograms per event being monitored
- * nr_histograms: This may not be the same as evsel->evlist->nr_entries if
+ * nr_histograms: This may not be the same as evsel->evlist->core.nr_entries if
  * 		  we have more than a group in a evlist, where we will want
  * 		  to see each group separately, that is why symbol__annotate2()
  * 		  sets src->nr_histograms to evsel->nr_members.
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9b0108c23010..ce9f52215d60 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -125,7 +125,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 		evsel__delete(pos);
 	}
 
-	evlist->nr_entries = 0;
+	evlist->core.nr_entries = 0;
 }
 
 void perf_evlist__exit(struct evlist *evlist)
@@ -180,12 +180,13 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
-	perf_evlist__add(&evlist->core, &entry->core);
 	entry->evlist = evlist;
-	entry->idx = evlist->nr_entries;
+	entry->idx = evlist->core.nr_entries;
 	entry->tracking = !entry->idx;
 
-	if (!evlist->nr_entries++)
+	perf_evlist__add(&evlist->core, &entry->core);
+
+	if (evlist->core.nr_entries == 1)
 		perf_evlist__set_id_pos(evlist);
 
 	__perf_evlist__propagate_maps(evlist, entry);
@@ -195,7 +196,6 @@ void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	perf_evlist__remove(&evlist->core, &evsel->core);
-	evlist->nr_entries -= 1;
 }
 
 void perf_evlist__splice_list_tail(struct evlist *evlist,
@@ -225,8 +225,8 @@ void __perf_evlist__set_leader(struct list_head *list)
 
 void perf_evlist__set_leader(struct evlist *evlist)
 {
-	if (evlist->nr_entries) {
-		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
+	if (evlist->core.nr_entries) {
+		evlist->nr_groups = evlist->core.nr_entries > 1 ? 1 : 0;
 		__perf_evlist__set_leader(&evlist->core.entries);
 	}
 }
@@ -249,7 +249,7 @@ int perf_evlist__add_dummy(struct evlist *evlist)
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct evsel *evsel = perf_evsel__new_idx(&attr, evlist->nr_entries);
+	struct evsel *evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries);
 
 	if (evsel == NULL)
 		return -ENOMEM;
@@ -266,7 +266,7 @@ static int evlist__add_attrs(struct evlist *evlist,
 	size_t i;
 
 	for (i = 0; i < nr_attrs; i++) {
-		evsel = perf_evsel__new_idx(attrs + i, evlist->nr_entries + i);
+		evsel = perf_evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
 		if (evsel == NULL)
 			goto out_delete_partial_list;
 		list_add_tail(&evsel->core.node, &head);
@@ -581,7 +581,7 @@ struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id)
 {
 	struct perf_sample_id *sid;
 
-	if (evlist->nr_entries == 1 || !id)
+	if (evlist->core.nr_entries == 1 || !id)
 		return perf_evlist__first(evlist);
 
 	sid = perf_evlist__id2sid(evlist, id);
@@ -639,7 +639,7 @@ struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 	int hash;
 	u64 id;
 
-	if (evlist->nr_entries == 1)
+	if (evlist->core.nr_entries == 1)
 		return first;
 
 	if (!first->attr.sample_id_all &&
@@ -1222,7 +1222,7 @@ bool perf_evlist__valid_sample_type(struct evlist *evlist)
 {
 	struct evsel *pos;
 
-	if (evlist->nr_entries == 1)
+	if (evlist->core.nr_entries == 1)
 		return true;
 
 	if (evlist->id_pos < 0 || evlist->is_pos < 0)
@@ -1849,7 +1849,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 		attr->sample_id_all = 1;
 	}
 
-	evsel = perf_evsel__new_idx(attr, (*evlist)->nr_entries);
+	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
 	if (!evsel)
 		goto out_err;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 7117378a08e3..17dd83021a79 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -28,7 +28,6 @@ struct record_opts;
 struct evlist {
 	struct perf_evlist core;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
-	int		 nr_entries;
 	int		 nr_groups;
 	int		 nr_mmaps;
 	bool		 enabled;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 70ab6b8c715b..141de4425100 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -476,7 +476,7 @@ static int write_event_desc(struct feat_fd *ff,
 	u32 nre, nri, sz;
 	int ret;
 
-	nre = evlist->nr_entries;
+	nre = evlist->core.nr_entries;
 
 	/*
 	 * write number of events
@@ -3100,7 +3100,7 @@ int perf_session__write_header(struct perf_session *session,
 		.attr_size = sizeof(f_attr),
 		.attrs = {
 			.offset = attr_offset,
-			.size   = evlist->nr_entries * sizeof(f_attr),
+			.size   = evlist->core.nr_entries * sizeof(f_attr),
 		},
 		.data = {
 			.offset = header->data_offset,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a0b7d68d2f8e..10efc33c56a1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1909,7 +1909,7 @@ int parse_events(struct evlist *evlist, const char *str,
 {
 	struct parse_events_state parse_state = {
 		.list   = LIST_HEAD_INIT(parse_state.list),
-		.idx    = evlist->nr_entries,
+		.idx    = evlist->core.nr_entries,
 		.error  = err,
 		.evlist = evlist,
 	};
@@ -2040,7 +2040,7 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 	 *
 	 * So no need to WARN here, let *func do this.
 	 */
-	if (evlist->nr_entries > 0)
+	if (evlist->core.nr_entries > 0)
 		last = perf_evlist__last(evlist);
 
 	do {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 19d2feee91d5..cf0a18d49018 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -973,10 +973,10 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 
 	Py_INCREF(pevsel);
 	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
-	evsel->idx = evlist->nr_entries;
+	evsel->idx = evlist->core.nr_entries;
 	evlist__add(evlist, evsel);
 
-	return Py_BuildValue("i", evlist->nr_entries);
+	return Py_BuildValue("i", evlist->core.nr_entries);
 }
 
 static struct perf_mmap *get_md(struct evlist *evlist, int cpu)
@@ -1112,7 +1112,7 @@ static Py_ssize_t pyrf_evlist__length(PyObject *obj)
 {
 	struct pyrf_evlist *pevlist = (void *)obj;
 
-	return pevlist->evlist.nr_entries;
+	return pevlist->evlist.core.nr_entries;
 }
 
 static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
@@ -1120,7 +1120,7 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	struct pyrf_evlist *pevlist = (void *)obj;
 	struct evsel *pos;
 
-	if (i >= pevlist->evlist.nr_entries)
+	if (i >= pevlist->evlist.core.nr_entries)
 		return NULL;
 
 	evlist__for_each_entry(&pevlist->evlist, pos) {
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index fecccfd71aa1..3d3d732498e1 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -166,7 +166,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 		 */
 		use_sample_identifier = perf_can_sample_identifier();
 		sample_id = true;
-	} else if (evlist->nr_entries > 1) {
+	} else if (evlist->core.nr_entries > 1) {
 		struct evsel *first = perf_evlist__first(evlist);
 
 		evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d8e4392d6e18..fa3cc2112b82 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2323,7 +2323,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 	if (event_name[0] == '%') {
 		int nr = strtol(event_name+1, NULL, 0);
 
-		if (nr > evlist->nr_entries)
+		if (nr > evlist->core.nr_entries)
 			return NULL;
 
 		evsel = perf_evlist__first(evlist);
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 9f098db76e3c..3bbbdac2c550 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -70,7 +70,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 			       esamples_percent);
 	}
 
-	if (top->evlist->nr_entries == 1) {
+	if (top->evlist->core.nr_entries == 1) {
 		struct evsel *first = perf_evlist__first(top->evlist);
 		ret += SNPRINTF(bf + ret, size - ret, "%" PRIu64 "%s ",
 				(uint64_t)first->attr.sample_period,
