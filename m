Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EEEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3685121773
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455580;
	bh=YvKgj1aIMLvuv9L7gPKfbT2KuhWy4lEfs1z+rJgcDwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ebz85xxgZCee7KtVlK7z1lGJdKurK0lEM8Hn5IHIOcAXOaVNqpnL+iAzJNNd1HxCx
	 +x7m4Uhgy5EuN/I3dSThykxK4QTQeSdZpYI9CfCZ3M4pxXMW10CGND+i8jmjGPQOn+
	 MbfnHF7GojxyRO/AMW1mkD/JawedxcFGKN7daJ7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfG3C7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbfG3C7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D9B2070B;
        Tue, 30 Jul 2019 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455575;
        bh=YvKgj1aIMLvuv9L7gPKfbT2KuhWy4lEfs1z+rJgcDwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cw0xym+bjZKVdS3YipUKf2eI+oe3w8qw8pEKmdKspe+kUXT7+DL7zJT0sbWwDUnZ0
         Pa7xYe27OYk1QOs9E2uN4AmeNpv8cP0OJNP7NwLvC3hus68G10WpaQhqwxVB2IuRqE
         5jKc99NQd5rojEMbhCbvWfDjxbZRw4ARXuFZnAKE=
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
Subject: [PATCH 059/107] libperf: Add perf_thread_map__new_dummy() function
Date:   Mon, 29 Jul 2019 23:55:22 -0300
Message-Id: <20190730025610.22603-60-acme@kernel.org>
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
 tools/perf/lib/include/perf/threadmap.h     |  7 +++
 tools/perf/lib/libperf.map                  |  2 +
 tools/perf/lib/threadmap.c                  | 43 +++++++++++++++
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/tests/thread-map.c               |  2 +-
 tools/perf/util/evlist.c                    |  4 +-
 tools/perf/util/thread_map.c                | 59 +++++----------------
 tools/perf/util/thread_map.h                |  7 +--
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
@@ -263,18 +240,6 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
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
-- 
2.21.0

