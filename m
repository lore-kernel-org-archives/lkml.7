Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03702C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5721773
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455518;
	bh=326TBnmKODpsVVEYZvBiUcu3RIRQTH/gVOfNe0Advw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KjNc5JIud3ZYbmkZ1YhvbLqj9uew0iWEec6rnC+Br88hYSL2nJdwt73QiNkFi17Yd
	 9YYm5zckcB2Y5IMlzxWKfcpYd3MV86uL9iNXg0hTeyfdBDpmn4m+ZW/xP4kHT8WdE6
	 Fo7AS7iuvh7bXzZSI+pADX4mfePaVoHYoXHZg4TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfG3C6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732012AbfG3C6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57242070B;
        Tue, 30 Jul 2019 02:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455512;
        bh=326TBnmKODpsVVEYZvBiUcu3RIRQTH/gVOfNe0Advw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9IQtoISduMzYSw/Oc38TOImKhj6Ulss5Of05HQN4pR5gmfYBYoikQ59l6RnqZDPl
         K1R/DvqrJF9GeLUEyEcFI+CMlWbDqsx849YAkd7OYWIl+EIE7UwL8B9WzbR5U1SgXB
         yw0IPmRHAiDb1GJmPt0JUdiZ26VyfZEzZfvCtLag=
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
Subject: [PATCH 041/107] perf evsel: Rename perf_evsel__open() to evsel__open()
Date:   Mon, 29 Jul 2019 23:55:04 -0300
Message-Id: <20190730025610.22603-42-acme@kernel.org>
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

Rename perf_evsel__open() to evsel__open(), so we don't have a name
clash when we add perf_evsel__open() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c                | 2 +-
 tools/perf/builtin-top.c                   | 2 +-
 tools/perf/tests/mmap-basic.c              | 2 +-
 tools/perf/tests/openat-syscall-all-cpus.c | 2 +-
 tools/perf/util/evlist.c                   | 4 ++--
 tools/perf/util/evsel.c                    | 8 ++++----
 tools/perf/util/evsel.h                    | 4 ++--
 tools/perf/util/parse-events.c             | 4 ++--
 tools/perf/util/python.c                   | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 06966a2c2cdd..7f933997b6d0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -739,7 +739,7 @@ static int record__open(struct record *rec)
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
-		if (perf_evsel__open(pos, pos->cpus, pos->threads) < 0) {
+		if (evsel__open(pos, pos->cpus, pos->threads) < 0) {
 			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6c0c2b78093a..5886389f6a40 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -989,7 +989,7 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (perf_evsel__open(counter, top->evlist->cpus,
+		if (evsel__open(counter, top->evlist->cpus,
 				     top->evlist->threads) < 0) {
 
 			/*
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 16b8a4e5de8f..40511025208f 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -84,7 +84,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 		evlist__add(evlist, evsels[i]);
 
-		if (perf_evsel__open(evsels[i], cpus, threads) < 0) {
+		if (evsel__open(evsels[i], cpus, threads) < 0) {
 			pr_debug("failed to open counter: %s, "
 				 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 				 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 001a0e8e6998..f96cbd304024 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -48,7 +48,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 		goto out_cpu_map_delete;
 	}
 
-	if (perf_evsel__open(evsel, cpus, threads) < 0) {
+	if (evsel__open(evsel, cpus, threads) < 0) {
 		pr_debug("failed to open counter: %s, "
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47516db62424..4627cc47de3e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1405,7 +1405,7 @@ int perf_evlist__open(struct evlist *evlist)
 	perf_evlist__update_id_pos(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
+		err = evsel__open(evsel, evsel->cpus, evsel->threads);
 		if (err < 0)
 			goto out_err;
 	}
@@ -1918,7 +1918,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 		goto out_delete_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
-		if (perf_evsel__open(counter, evlist->cpus,
+		if (evsel__open(counter, evlist->cpus,
 				     evlist->threads) < 0)
 			goto out_delete_evlist;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c9723c2d57c9..f365d0685268 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1825,8 +1825,8 @@ static int perf_event_open(struct evsel *evsel,
 	return fd;
 }
 
-int perf_evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-		     struct perf_thread_map *threads)
+int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads)
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
@@ -2086,13 +2086,13 @@ void perf_evsel__close(struct evsel *evsel)
 int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus)
 {
-	return perf_evsel__open(evsel, cpus, NULL);
+	return evsel__open(evsel, cpus, NULL);
 }
 
 int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads)
 {
-	return perf_evsel__open(evsel, NULL, threads);
+	return evsel__open(evsel, NULL, threads);
 }
 
 static int perf_evsel__parse_id_sample(const struct evsel *evsel,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ecea51a918e0..d43409bb07c5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -302,8 +302,8 @@ int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus);
 int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads);
-int perf_evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-		     struct perf_thread_map *threads);
+int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads);
 void perf_evsel__close(struct evsel *evsel);
 
 struct perf_sample;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 40087cf74dd1..decb66d243ca 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2320,7 +2320,7 @@ static bool is_event_supported(u8 type, unsigned config)
 
 	evsel = evsel__new(&attr);
 	if (evsel) {
-		open_return = perf_evsel__open(evsel, NULL, tmap);
+		open_return = evsel__open(evsel, NULL, tmap);
 		ret = open_return >= 0;
 
 		if (open_return == -EACCES) {
@@ -2332,7 +2332,7 @@ static bool is_event_supported(u8 type, unsigned config)
 			 *
 			 */
 			evsel->attr.exclude_kernel = 1;
-			ret = perf_evsel__open(evsel, NULL, tmap) >= 0;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
 		}
 		evsel__delete(evsel);
 	}
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 48c951a4a76b..3eb7348d29f8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -817,7 +817,7 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	 * This will group just the fds for this single evsel, to group
 	 * multiple events, use evlist.open().
 	 */
-	if (perf_evsel__open(evsel, cpus, threads) < 0) {
+	if (evsel__open(evsel, cpus, threads) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
-- 
2.21.0

