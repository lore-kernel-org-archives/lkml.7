Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E4C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F2A2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455510;
	bh=wf6nVJXlyVB00vPk3QXhGrLs5HmSO5Q2NPZOtG/cz2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ol5fMhBVuDexIM+SUbZKJ2Puh5jX50VSBkxgRF3cXR1p60jtP4sTDwNW3a+D7fN+Z
	 0SkhO3OBCxS9jAuonTOQhFcyibBgx0an41H2sdskovE5m4XcyXvKdVIC14uMl4cIb6
	 Ijc9Pm2KS2jl4ECxSLuhCLTA9Q6SAIeArjFH1vW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfG3C63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731987AbfG3C6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81D6217D7;
        Tue, 30 Jul 2019 02:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455504;
        bh=wf6nVJXlyVB00vPk3QXhGrLs5HmSO5Q2NPZOtG/cz2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7XCflCJiiZabknELsbKDWW77K6zzVSXSXfOcJ5ckcoeC45Egf9xIL8O2/do43BfQ
         hFLLiZZqQM9dT0oP+tqPjIOXknReNb47S6BbtVk7aWR9spS1JhD/oiAYKjpNIQXl/0
         +b8zdGlQUoTQK6DOtWdhaxsahtsZ/IwIw0Qsq4gE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 039/107] perf evlist: Rename perf_evlist__add() to evlist__add()
Date:   Mon, 29 Jul 2019 23:55:02 -0300
Message-Id: <20190730025610.22603-40-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evlist__add() to evlist__add(), so we don't have a name
clash when we add perf_evlist__add() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                  | 12 ++++++------
 tools/perf/tests/mmap-basic.c               |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/tests/sw-clock.c                 |  2 +-
 tools/perf/util/evlist.c                    | 16 ++++++++--------
 tools/perf/util/evlist.h                    |  2 +-
 tools/perf/util/header.c                    |  4 ++--
 tools/perf/util/python.c                    |  2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c5eb47f4e42e..89ae4737ef74 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2616,7 +2616,7 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
-static bool perf_evlist__add_vfs_getname(struct evlist *evlist)
+static bool evlist__add_vfs_getname(struct evlist *evlist)
 {
 	bool found = false;
 	struct evsel *evsel, *tmp;
@@ -2719,8 +2719,8 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	perf_evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
 	perf_evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
 
-	perf_evlist__add(evlist, sys_enter);
-	perf_evlist__add(evlist, sys_exit);
+	evlist__add(evlist, sys_enter);
+	evlist__add(evlist, sys_exit);
 
 	if (callchain_param.enabled && !trace->kernel_syscallchains) {
 		/*
@@ -3264,7 +3264,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			goto out_error_raw_syscalls;
 
 		if (trace->trace_syscalls)
-			trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+			trace->vfs_getname = evlist__add_vfs_getname(evlist);
 	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMAJ)) {
@@ -3272,7 +3272,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (pgfault_maj == NULL)
 			goto out_error_mem;
 		perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
-		perf_evlist__add(evlist, pgfault_maj);
+		evlist__add(evlist, pgfault_maj);
 	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMIN)) {
@@ -3280,7 +3280,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (pgfault_min == NULL)
 			goto out_error_mem;
 		perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
-		perf_evlist__add(evlist, pgfault_min);
+		evlist__add(evlist, pgfault_min);
 	}
 
 	if (trace->sched &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 7f96bb72f7e5..16b8a4e5de8f 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -82,7 +82,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		evsels[i]->attr.wakeup_events = 1;
 		perf_evsel__set_sample_id(evsels[i], false);
 
-		perf_evlist__add(evlist, evsels[i]);
+		evlist__add(evlist, evsels[i]);
 
 		if (perf_evsel__open(evsels[i], cpus, threads) < 0) {
 			pr_debug("failed to open counter: %s, "
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 0263420f4495..f822c3c181f3 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -48,7 +48,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	err = perf_evlist__create_maps(evlist, &opts.target);
 	if (err < 0) {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 247d3734686e..3ab11291174c 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -54,7 +54,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		pr_debug("perf_evsel__new\n");
 		goto out_delete_evlist;
 	}
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	cpus = cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(getpid());
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 986d20c15778..7741e12bdcb0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -177,7 +177,7 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-void perf_evlist__add(struct evlist *evlist, struct evsel *entry)
+void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
 	list_add_tail(&entry->node, &evlist->entries);
@@ -204,7 +204,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 
 	__evlist__for_each_entry_safe(list, temp, evsel) {
 		list_del_init(&evsel->node);
-		perf_evlist__add(evlist, evsel);
+		evlist__add(evlist, evsel);
 	}
 }
 
@@ -237,7 +237,7 @@ int __perf_evlist__add_default(struct evlist *evlist, bool precise)
 	if (evsel == NULL)
 		return -ENOMEM;
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
 }
 
@@ -253,11 +253,11 @@ int perf_evlist__add_dummy(struct evlist *evlist)
 	if (evsel == NULL)
 		return -ENOMEM;
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
 }
 
-static int perf_evlist__add_attrs(struct evlist *evlist,
+static int evlist__add_attrs(struct evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
@@ -289,7 +289,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
 	for (i = 0; i < nr_attrs; i++)
 		event_attr_init(attrs + i);
 
-	return perf_evlist__add_attrs(evlist, attrs, nr_attrs);
+	return evlist__add_attrs(evlist, attrs, nr_attrs);
 }
 
 struct evsel *
@@ -330,7 +330,7 @@ int perf_evlist__add_newtp(struct evlist *evlist,
 		return -1;
 
 	evsel->handler = handler;
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
 }
 
@@ -1854,7 +1854,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 
 	evsel->side_band.cb = cb;
 	evsel->side_band.data = data;
-	perf_evlist__add(*evlist, evsel);
+	evlist__add(*evlist, evsel);
 	return 0;
 
 out_err:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 12a5fd6972df..d52b29a1d852 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -73,7 +73,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 void perf_evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
-void perf_evlist__add(struct evlist *evlist, struct evsel *entry);
+void evlist__add(struct evlist *evlist, struct evsel *entry);
 void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct evlist *evlist, bool precise);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7760ddc4bc18..5e0093251f26 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3593,7 +3593,7 @@ int perf_session__read_header(struct perf_session *session)
 		 * Do it before so that if perf_evsel__alloc_id fails, this
 		 * entry gets purged too at evlist__delete().
 		 */
-		perf_evlist__add(session->evlist, evsel);
+		evlist__add(session->evlist, evsel);
 
 		nr_ids = f_attr.ids.size / sizeof(u64);
 		/*
@@ -4025,7 +4025,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (evsel == NULL)
 		return -ENOMEM;
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	ids = event->header.size;
 	ids -= (void *)&event->attr.id - (void *)event;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ade4e85c6d81..48c951a4a76b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -974,7 +974,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	Py_INCREF(pevsel);
 	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
 	evsel->idx = evlist->nr_entries;
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	return Py_BuildValue("i", evlist->nr_entries);
 }
-- 
2.21.0

