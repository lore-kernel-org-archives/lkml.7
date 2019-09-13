Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1959C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB2920640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381282;
	bh=cEpCiBTM4klF+7gdxAVauRZfO1aWn3zY7SHGU453yYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cGY3KC1aBB/ymhdbQUp5QTTt28WJ1nJbp/Sdk0XFtHzss5gELXHnN5EaZC3LO3tip
	 B3nQXhsH/nPzpEfy9CLBhrjf2TEA2pfe2/R0r/DHQEfAA1nvDeo6jQlcQbWS0C4a06
	 F/NYol8FUGQRl1nwp2C4XvZ/Q2dxCLLW94/+Ql1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbfIMNZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391391AbfIMNZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40FE618CB8EE;
        Fri, 13 Sep 2019 13:25:35 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEF95C1D4;
        Fri, 13 Sep 2019 13:25:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 38/73] libperf: Add perf_evlist__poll function
Date:   Fri, 13 Sep 2019 15:23:20 +0200
Message-Id: <20190913132355.21634-39-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 13 Sep 2019 13:25:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_evlist__poll function under libperf,
it will be used in following patches. And rename
the existing perf's function to evlist__poll.

Link: http://lkml.kernel.org/n/tip-hvilw6n69knpyhdndrslgtdu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c                 | 2 +-
 tools/perf/builtin-top.c                    | 4 ++--
 tools/perf/builtin-trace.c                  | 2 +-
 tools/perf/lib/evlist.c                     | 5 +++++
 tools/perf/lib/include/perf/evlist.h        | 1 +
 tools/perf/lib/libperf.map                  | 1 +
 tools/perf/tests/openat-syscall-tp-fields.c | 2 +-
 tools/perf/tests/perf-record.c              | 2 +-
 tools/perf/tests/task-exit.c                | 2 +-
 tools/perf/util/evlist.c                    | 6 +++---
 tools/perf/util/evlist.h                    | 2 +-
 tools/perf/util/python.c                    | 2 +-
 12 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cb5d750cbbdf..7b12877de27c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1610,7 +1610,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (hits == rec->samples) {
 			if (done || draining)
 				break;
-			err = perf_evlist__poll(rec->evlist, -1);
+			err = evlist__poll(rec->evlist, -1);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0942e8d4c93b..fb62e10f4d4f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1304,7 +1304,7 @@ static int __cmd_top(struct perf_top *top)
 	}
 
 	/* Wait for a minimal set of events before starting the snapshot */
-	perf_evlist__poll(top->evlist, 100);
+	evlist__poll(top->evlist, 100);
 
 	perf_top__mmap_read(top);
 
@@ -1314,7 +1314,7 @@ static int __cmd_top(struct perf_top *top)
 		perf_top__mmap_read(top);
 
 		if (opts->overwrite || (hits == top->samples))
-			ret = perf_evlist__poll(top->evlist, 100);
+			ret = evlist__poll(top->evlist, 100);
 
 		if (resize) {
 			perf_top__resize(top);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 685935b533f4..55daadb001f6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3472,7 +3472,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->nr_events == before) {
 		int timeout = done ? 100 : -1;
 
-		if (!draining && perf_evlist__poll(evlist, timeout) > 0) {
+		if (!draining && evlist__poll(evlist, timeout) > 0) {
 			if (evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
 				draining = true;
 
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index a2c01dcec5ae..160393cb9bed 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -274,3 +274,8 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 
 	return pos;
 }
+
+int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
+{
+	return fdarray__poll(&evlist->pollfd, timeout);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 38365f8f3fba..8a2ce0757ab2 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -31,5 +31,6 @@ LIBPERF_API void perf_evlist__disable(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
 				       struct perf_cpu_map *cpus,
 				       struct perf_thread_map *threads);
+LIBPERF_API int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 507b4cc4784c..2672f21b4908 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -38,6 +38,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__remove;
 		perf_evlist__next;
 		perf_evlist__set_maps;
+		perf_evlist__poll;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index abf4d4f5e429..a5daf4cf17ac 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -126,7 +126,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		}
 
 		if (nr_events == before)
-			perf_evlist__poll(evlist, 10);
+			evlist__poll(evlist, 10);
 
 		if (++nr_polls > 5) {
 			pr_debug("%s: no events!\n", __func__);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 80da5b2c6bdc..1b313da8bce9 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -286,7 +286,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 		 * perf_event_attr.wakeup_events, just PERF_EVENT_SAMPLE does.
 		 */
 		if (total_events == before && false)
-			perf_evlist__poll(evlist, -1);
+			evlist__poll(evlist, -1);
 
 		sleep(1);
 		if (++wakeups > 5) {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 81c57a6b627f..e6e8a7a970b6 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -129,7 +129,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 out_init:
 	if (!exited || !nr_exit) {
-		perf_evlist__poll(evlist, -1);
+		evlist__poll(evlist, -1);
 		goto retry;
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 449425d9a033..dcc4accd3180 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -417,9 +417,9 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 			       perf_evlist__munmap_filtered, NULL);
 }
 
-int perf_evlist__poll(struct evlist *evlist, int timeout)
+int evlist__poll(struct evlist *evlist, int timeout)
 {
-	return fdarray__poll(&evlist->core.pollfd, timeout);
+	return perf_evlist__poll(&evlist->core, timeout);
 }
 
 static void perf_evlist__set_sid_idx(struct evlist *evlist,
@@ -1735,7 +1735,7 @@ static void *perf_evlist__poll_thread(void *arg)
 			draining = true;
 
 		if (!draining)
-			perf_evlist__poll(evlist, 1000);
+			evlist__poll(evlist, 1000);
 
 		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			struct mmap *map = &evlist->mmap[i];
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 6c5455cf5829..0042eac7e627 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -116,7 +116,7 @@ perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 int evlist__add_pollfd(struct evlist *evlist, int fd);
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
-int perf_evlist__poll(struct evlist *evlist, int timeout);
+int evlist__poll(struct evlist *evlist, int timeout);
 
 struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id);
 struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fdc787cfa9f7..48fd93a6a247 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -918,7 +918,7 @@ static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|i", kwlist, &timeout))
 		return NULL;
 
-	n = perf_evlist__poll(evlist, timeout);
+	n = evlist__poll(evlist, timeout);
 	if (n < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
-- 
2.21.0

