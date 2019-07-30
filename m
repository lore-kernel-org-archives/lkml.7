Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38FDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E3A2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fB8GKHiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfG3ScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:32:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39269 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfG3ScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:32:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIV5gV3330608
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:31:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIV5gV3330608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511466;
        bh=O2EU35nwSeMwofPHovZ7Nv7whXvY/mSA3cxIIai6sAs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fB8GKHiCAOFb9pVwKKD3Y0INCqXnyW2umZgH2X7nTk46KjdYFUrwFzYSws0nWhaF8
         mIwjz+lIqJZh5bhMau/qjcHzqlMTX/6+Matv2Pj9qr8G7+DHiP/O9ujgl6PiCRGocF
         XV42Iy8zwCBnx39viBHwsEsirIIhI904+1Lfpy+9QNWo1TvNHJV62A5L0rVX3jSzmz
         DbsV8E28AUwRrsvt7VBryDOZgqNJOpIesm3lKZHsXCbjgeOuG4RaF0m3drXsBtNpJV
         i5K/mAUZbXnzujk46awI33TlanAuc53q4QMnzWYn8i1aArrfJCHf5bUOZOf8OQEGFS
         DYpLqnP0+TraA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIV48w3330605;
        Tue, 30 Jul 2019 11:31:04 -0700
Date:   Tue, 30 Jul 2019 11:31:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4b49cce25e719587e934b745fe9bbb5bc8c4ba29@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        ak@linux.intel.com, mpetlan@redhat.com, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, peterz@infradead.org
Reply-To: peterz@infradead.org, namhyung@kernel.org, acme@redhat.com,
          mpetlan@redhat.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, alexey.budankov@linux.intel.com
In-Reply-To: <20190721112506.12306-33-jolsa@kernel.org>
References: <20190721112506.12306-33-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_thread_map__new_dummy() function
Git-Commit-ID: 4b49cce25e719587e934b745fe9bbb5bc8c4ba29
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

Commit-ID:  4b49cce25e719587e934b745fe9bbb5bc8c4ba29
Gitweb:     https://git.kernel.org/tip/4b49cce25e719587e934b745fe9bbb5bc8c4ba29
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:19 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_thread_map__new_dummy() function

Moving the following functions:

  thread_map__new_dummy()
  thread_map__realloc()
  thread_map__set_pid()

to libperf with the following names:

  perf_thread_map__new_dummy()
  perf_thread_map__realloc()
  perf_thread_map__set_pid()

the other 2 functions are dependencies of the
perf_thread_map__new_dummy() function.

The perf_thread_map__realloc() function is not exported.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-33-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/threadmap.h |  2 +
 tools/perf/lib/include/perf/threadmap.h     |  7 ++++
 tools/perf/lib/libperf.map                  |  2 +
 tools/perf/lib/threadmap.c                  | 43 +++++++++++++++++++++
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/tests/thread-map.c               |  2 +-
 tools/perf/util/evlist.c                    |  4 +-
 tools/perf/util/thread_map.c                | 59 ++++++-----------------------
 tools/perf/util/thread_map.h                |  7 +---
 9 files changed, 71 insertions(+), 57 deletions(-)

diff --git a/tools/perf/lib/include/internal/threadmap.h b/tools/perf/lib/include/internal/threadmap.h
index c8088005a9ab..df748baf9eda 100644
--- a/tools/perf/lib/include/internal/threadmap.h
+++ b/tools/perf/lib/include/internal/threadmap.h
@@ -18,4 +18,6 @@ struct perf_thread_map {
 	struct thread_map_data map[];
 };
 
+struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr);
+
 #endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/perf/lib/include/perf/threadmap.h
index dc3a3837b56f..34ed7f587101 100644
--- a/tools/perf/lib/include/perf/threadmap.h
+++ b/tools/perf/lib/include/perf/threadmap.h
@@ -2,6 +2,13 @@
 #ifndef __LIBPERF_THREADMAP_H
 #define __LIBPERF_THREADMAP_H
 
+#include <perf/core.h>
+#include <sys/types.h>
+
 struct perf_thread_map;
 
+LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
+
+LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
+
 #endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 76ce3bc59dd8..6b4ec1c4d3f3 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -4,6 +4,8 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__dummy_new;
 		perf_cpu_map__get;
 		perf_cpu_map__put;
+		perf_thread_map__new_dummy;
+		perf_thread_map__set_pid;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/threadmap.c b/tools/perf/lib/threadmap.c
index 163dc609b909..23e628a1437a 100644
--- a/tools/perf/lib/threadmap.c
+++ b/tools/perf/lib/threadmap.c
@@ -3,3 +3,46 @@
 #include <stdlib.h>
 #include <linux/refcount.h>
 #include <internal/threadmap.h>
+#include <string.h>
+
+static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
+{
+	size_t size = (nr - start) * sizeof(map->map[0]);
+
+	memset(&map->map[start], 0, size);
+	map->err_thread = -1;
+}
+
+struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr)
+{
+	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
+	int start = map ? map->nr : 0;
+
+	map = realloc(map, size);
+	/*
+	 * We only realloc to add more items, let's reset new items.
+	 */
+	if (map)
+		perf_thread_map__reset(map, start, nr);
+
+	return map;
+}
+
+#define thread_map__alloc(__nr) perf_thread_map__realloc(NULL, __nr)
+
+void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid)
+{
+	map->map[thread].pid = pid;
+}
+
+struct perf_thread_map *perf_thread_map__new_dummy(void)
+{
+	struct perf_thread_map *threads = thread_map__alloc(1);
+
+	if (threads != NULL) {
+		perf_thread_map__set_pid(threads, 0, -1);
+		threads->nr = 1;
+		refcount_set(&threads->refcnt, 1);
+	}
+	return threads;
+}
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index c7182b7840e5..1de79208e690 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -58,7 +58,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 	perf_evsel__config(evsel, &opts, NULL);
 
-	thread_map__set_pid(evlist->threads, 0, getpid());
+	perf_thread_map__set_pid(evlist->threads, 0, getpid());
 
 	err = evlist__open(evlist);
 	if (err < 0) {
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 367dfe708e4c..73bc404ed390 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -35,7 +35,7 @@ int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unuse
 	thread_map__put(map);
 
 	/* test dummy pid */
-	map = thread_map__new_dummy();
+	map = perf_thread_map__new_dummy();
 	TEST_ASSERT_VAL("failed to alloc map", map);
 
 	thread_map__read_comms(map);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 35020d50f51e..88d131769df4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1375,7 +1375,7 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 	if (!cpus)
 		goto out;
 
-	threads = thread_map__new_dummy();
+	threads = perf_thread_map__new_dummy();
 	if (!threads)
 		goto out_put;
 
@@ -1504,7 +1504,7 @@ int perf_evlist__prepare_workload(struct evlist *evlist, struct target *target,
 				__func__, __LINE__);
 			goto out_close_pipes;
 		}
-		thread_map__set_pid(evlist->threads, 0, evlist->workload.pid);
+		perf_thread_map__set_pid(evlist->threads, 0, evlist->workload.pid);
 	}
 
 	close(child_ready_pipe[1]);
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index e89496c39d58..06dd9f2e4ce5 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -28,30 +28,7 @@ static int filter(const struct dirent *dir)
 		return 1;
 }
 
-static void thread_map__reset(struct perf_thread_map *map, int start, int nr)
-{
-	size_t size = (nr - start) * sizeof(map->map[0]);
-
-	memset(&map->map[start], 0, size);
-	map->err_thread = -1;
-}
-
-static struct perf_thread_map *thread_map__realloc(struct perf_thread_map *map, int nr)
-{
-	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
-	int start = map ? map->nr : 0;
-
-	map = realloc(map, size);
-	/*
-	 * We only realloc to add more items, let's reset new items.
-	 */
-	if (map)
-		thread_map__reset(map, start, nr);
-
-	return map;
-}
-
-#define thread_map__alloc(__nr) thread_map__realloc(NULL, __nr)
+#define thread_map__alloc(__nr) perf_thread_map__realloc(NULL, __nr)
 
 struct perf_thread_map *thread_map__new_by_pid(pid_t pid)
 {
@@ -69,7 +46,7 @@ struct perf_thread_map *thread_map__new_by_pid(pid_t pid)
 	threads = thread_map__alloc(items);
 	if (threads != NULL) {
 		for (i = 0; i < items; i++)
-			thread_map__set_pid(threads, i, atoi(namelist[i]->d_name));
+			perf_thread_map__set_pid(threads, i, atoi(namelist[i]->d_name));
 		threads->nr = items;
 		refcount_set(&threads->refcnt, 1);
 	}
@@ -86,7 +63,7 @@ struct perf_thread_map *thread_map__new_by_tid(pid_t tid)
 	struct perf_thread_map *threads = thread_map__alloc(1);
 
 	if (threads != NULL) {
-		thread_map__set_pid(threads, 0, tid);
+		perf_thread_map__set_pid(threads, 0, tid);
 		threads->nr = 1;
 		refcount_set(&threads->refcnt, 1);
 	}
@@ -142,7 +119,7 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 		if (grow) {
 			struct perf_thread_map *tmp;
 
-			tmp = thread_map__realloc(threads, max_threads);
+			tmp = perf_thread_map__realloc(threads, max_threads);
 			if (tmp == NULL)
 				goto out_free_namelist;
 
@@ -150,8 +127,8 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 		}
 
 		for (i = 0; i < items; i++) {
-			thread_map__set_pid(threads, threads->nr + i,
-					    atoi(namelist[i]->d_name));
+			perf_thread_map__set_pid(threads, threads->nr + i,
+						    atoi(namelist[i]->d_name));
 		}
 
 		for (i = 0; i < items; i++)
@@ -233,14 +210,14 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 			goto out_free_threads;
 
 		total_tasks += items;
-		nt = thread_map__realloc(threads, total_tasks);
+		nt = perf_thread_map__realloc(threads, total_tasks);
 		if (nt == NULL)
 			goto out_free_namelist;
 
 		threads = nt;
 
 		for (i = 0; i < items; i++) {
-			thread_map__set_pid(threads, j++, atoi(namelist[i]->d_name));
+			perf_thread_map__set_pid(threads, j++, atoi(namelist[i]->d_name));
 			zfree(&namelist[i]);
 		}
 		threads->nr = total_tasks;
@@ -263,18 +240,6 @@ out_free_threads:
 	goto out;
 }
 
-struct perf_thread_map *thread_map__new_dummy(void)
-{
-	struct perf_thread_map *threads = thread_map__alloc(1);
-
-	if (threads != NULL) {
-		thread_map__set_pid(threads, 0, -1);
-		threads->nr = 1;
-		refcount_set(&threads->refcnt, 1);
-	}
-	return threads;
-}
-
 struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 {
 	struct perf_thread_map *threads = NULL, *nt;
@@ -287,7 +252,7 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 
 	/* perf-stat expects threads to be generated even if tid not given */
 	if (!tid_str)
-		return thread_map__new_dummy();
+		return perf_thread_map__new_dummy();
 
 	slist = strlist__new(tid_str, &slist_config);
 	if (!slist)
@@ -304,13 +269,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 			continue;
 
 		ntasks++;
-		nt = thread_map__realloc(threads, ntasks);
+		nt = perf_thread_map__realloc(threads, ntasks);
 
 		if (nt == NULL)
 			goto out_free_threads;
 
 		threads = nt;
-		thread_map__set_pid(threads, ntasks - 1, tid);
+		perf_thread_map__set_pid(threads, ntasks - 1, tid);
 		threads->nr = ntasks;
 	}
 out:
@@ -437,7 +402,7 @@ static void thread_map__copy_event(struct perf_thread_map *threads,
 	threads->nr = (int) event->nr;
 
 	for (i = 0; i < event->nr; i++) {
-		thread_map__set_pid(threads, i, (pid_t) event->entries[i].pid);
+		perf_thread_map__set_pid(threads, i, (pid_t) event->entries[i].pid);
 		threads->map[i].comm = strndup(event->entries[i].comm, 16);
 	}
 
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 5a7be6f8934f..94a1f9565f5e 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <linux/refcount.h>
 #include <internal/threadmap.h>
+#include <perf/threadmap.h>
 
 struct thread_map_event;
 
@@ -37,12 +38,6 @@ static inline pid_t thread_map__pid(struct perf_thread_map *map, int thread)
 	return map->map[thread].pid;
 }
 
-static inline void
-thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid)
-{
-	map->map[thread].pid = pid;
-}
-
 static inline char *thread_map__comm(struct perf_thread_map *map, int thread)
 {
 	return map->map[thread].comm;
