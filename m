Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B80C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8012147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708435;
	bh=FfP65fd/FAhZSLIcl6AbgN7Xp7XxiMiFUaXL+UXOpE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i4J/ppqveBlmhustnmxa5Ev8wtZqt5MOJOjveSBjf40K2ls+2+mHvdPADsKijM/yk
	 HIOFOUSUt8NYZ8LtQwQhxYJ8dwoicM9+a0lYKTVYyasEhpwlXnp2ajrSEuWDkoHRMG
	 oAxTXhTkW/2CdnvukI9AC8SStaOjeZHMdn0YkOXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfGUL1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F29A3086262;
        Sun, 21 Jul 2019 11:27:13 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D090F5D9D3;
        Sun, 21 Jul 2019 11:27:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 12/79] perf tools: Rename perf_evlist__add to evlist__add
Date:   Sun, 21 Jul 2019 13:23:59 +0200
Message-Id: <20190721112506.12306-13-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 21 Jul 2019 11:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__add to evlist__add, so we don't
have a name clash when we add perf_evlist__add in libperf.

Link: http://lkml.kernel.org/n/tip-cjaidjrd4uae9t6ms1q5e3tx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 9d27307069a1..8e2a0c08e0a3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2628,7 +2628,7 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
-static bool perf_evlist__add_vfs_getname(struct evlist *evlist)
+static bool evlist__add_vfs_getname(struct evlist *evlist)
 {
 	bool found = false;
 	struct evsel *evsel, *tmp;
@@ -2731,8 +2731,8 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	perf_evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
 	perf_evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
 
-	perf_evlist__add(evlist, sys_enter);
-	perf_evlist__add(evlist, sys_exit);
+	evlist__add(evlist, sys_enter);
+	evlist__add(evlist, sys_exit);
 
 	if (callchain_param.enabled && !trace->kernel_syscallchains) {
 		/*
@@ -3263,7 +3263,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			goto out_error_raw_syscalls;
 
 		if (trace->trace_syscalls)
-			trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+			trace->vfs_getname = evlist__add_vfs_getname(evlist);
 	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMAJ)) {
@@ -3271,7 +3271,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (pgfault_maj == NULL)
 			goto out_error_mem;
 		perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
-		perf_evlist__add(evlist, pgfault_maj);
+		evlist__add(evlist, pgfault_maj);
 	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMIN)) {
@@ -3279,7 +3279,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
index f3d8fdca53ae..9c43a372d8ad 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3586,7 +3586,7 @@ int perf_session__read_header(struct perf_session *session)
 		 * Do it before so that if perf_evsel__alloc_id fails, this
 		 * entry gets purged too at evlist__delete().
 		 */
-		perf_evlist__add(session->evlist, evsel);
+		evlist__add(session->evlist, evsel);
 
 		nr_ids = f_attr.ids.size / sizeof(u64);
 		/*
@@ -4018,7 +4018,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
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

