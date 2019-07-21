Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A627C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1F02085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708549;
	bh=YBsJKYDRHRLaHzLKKgM5jTsLctSk3WlnuKZA2feg+6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zY5mH9PK2jZ1X5nh872+/tH2Fwd/gXDD5B4npeu/92tiNydRQmK2UfmxQZBR2lBIq
	 ffsv8LIDVj/sm5WFhpt10YwTv/EzFRtLQ2g98+tWEVEsAtQNiRuWDW+wVoVPtErh3M
	 KszzGnEpPKqln1fjG9Nh98T1E/RpJ6qSG5tGnPqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfGUL3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96645308A98C;
        Sun, 21 Jul 2019 11:29:06 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24655D9D3;
        Sun, 21 Jul 2019 11:29:01 +0000 (UTC)
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
Subject: [PATCH 33/79] libperf: Add perf_thread_map__get/perf_thread_map__put
Date:   Sun, 21 Jul 2019 13:24:20 +0200
Message-Id: <20190721112506.12306-34-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 21 Jul 2019 11:29:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving following functions:
  thread_map__get
  thread_map__put
  thread_map__comm

under libperf with following names:
  perf_thread_map__get
  perf_thread_map__put
  perf_thread_map__comm

Adding perf_thread_map__comm function for it to work/compile.

Link: http://lkml.kernel.org/n/tip-2mhocgjehlsi3eo1z4eset8o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c                |  2 +-
 tools/perf/lib/include/perf/threadmap.h    |  4 +++
 tools/perf/lib/libperf.map                 |  3 ++
 tools/perf/lib/threadmap.c                 | 33 ++++++++++++++++++++++
 tools/perf/tests/code-reading.c            |  4 +--
 tools/perf/tests/event-times.c             |  4 +--
 tools/perf/tests/keep-tracking.c           |  2 +-
 tools/perf/tests/mmap-basic.c              |  2 +-
 tools/perf/tests/mmap-thread-lookup.c      |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/tests/sw-clock.c                |  2 +-
 tools/perf/tests/switch-tracking.c         |  2 +-
 tools/perf/tests/task-exit.c               |  2 +-
 tools/perf/tests/thread-map.c              | 18 ++++++------
 tools/perf/util/event.c                    |  4 +--
 tools/perf/util/evlist.c                   | 12 ++++----
 tools/perf/util/evsel.c                    |  2 +-
 tools/perf/util/parse-events.c             |  2 +-
 tools/perf/util/python.c                   |  2 +-
 tools/perf/util/stat-display.c             |  2 +-
 tools/perf/util/thread_map.c               | 26 -----------------
 tools/perf/util/thread_map.h               |  8 ------
 23 files changed, 74 insertions(+), 68 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c0962ddfad04..03fbe4600ca0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1060,7 +1060,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
 						 process_synthesized_event,
 						 &rec->session->machines.host,
 						 rec->opts.sample_address);
-	thread_map__put(thread_map);
+	perf_thread_map__put(thread_map);
 	return err;
 }
 
diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/perf/lib/include/perf/threadmap.h
index 34ed7f587101..456295273daa 100644
--- a/tools/perf/lib/include/perf/threadmap.h
+++ b/tools/perf/lib/include/perf/threadmap.h
@@ -10,5 +10,9 @@ struct perf_thread_map;
 LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
 
 LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
+LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
+
+LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
+LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
 
 #endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 6b4ec1c4d3f3..c4f611010ccc 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -6,6 +6,9 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__put;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
+		perf_thread_map__comm;
+		perf_thread_map__get;
+		perf_thread_map__put;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/threadmap.c b/tools/perf/lib/threadmap.c
index 23e628a1437a..4865b73e2586 100644
--- a/tools/perf/lib/threadmap.c
+++ b/tools/perf/lib/threadmap.c
@@ -4,6 +4,8 @@
 #include <linux/refcount.h>
 #include <internal/threadmap.h>
 #include <string.h>
+#include <asm/bug.h>
+#include <stdio.h>
 
 static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
 {
@@ -35,6 +37,11 @@ void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid
 	map->map[thread].pid = pid;
 }
 
+char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
+{
+	return map->map[thread].comm;
+}
+
 struct perf_thread_map *perf_thread_map__new_dummy(void)
 {
 	struct perf_thread_map *threads = thread_map__alloc(1);
@@ -46,3 +53,29 @@ struct perf_thread_map *perf_thread_map__new_dummy(void)
 	}
 	return threads;
 }
+
+static void perf_thread_map__delete(struct perf_thread_map *threads)
+{
+	if (threads) {
+		int i;
+
+		WARN_ONCE(refcount_read(&threads->refcnt) != 0,
+			  "thread map refcnt unbalanced\n");
+		for (i = 0; i < threads->nr; i++)
+			free(perf_thread_map__comm(threads, i));
+		free(threads);
+	}
+}
+
+struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map)
+{
+	if (map)
+		refcount_inc(&map->refcnt);
+	return map;
+}
+
+void perf_thread_map__put(struct perf_thread_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refcnt))
+		perf_thread_map__delete(map);
+}
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index ce2d3266286a..7b26be1dfb47 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -656,7 +656,7 @@ static int do_test_code_reading(bool try_kcore)
 				 * call. Getting refference to keep them alive.
 				 */
 				perf_cpu_map__get(cpus);
-				thread_map__get(threads);
+				perf_thread_map__get(threads);
 				perf_evlist__set_maps(evlist, NULL, NULL);
 				evlist__delete(evlist);
 				evlist = NULL;
@@ -706,7 +706,7 @@ static int do_test_code_reading(bool try_kcore)
 		evlist__delete(evlist);
 	} else {
 		perf_cpu_map__put(cpus);
-		thread_map__put(threads);
+		perf_thread_map__put(threads);
 	}
 	machine__delete_threads(machine);
 	machine__delete(machine);
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index dcfff4b20c92..9238180416b0 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -76,7 +76,7 @@ static int attach__current_disabled(struct evlist *evlist)
 		return err;
 	}
 
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return evsel__enable(evsel) == 0 ? TEST_OK : TEST_FAIL;
 }
 
@@ -96,7 +96,7 @@ static int attach__current_enabled(struct evlist *evlist)
 
 	err = perf_evsel__open_per_thread(evsel, threads);
 
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return err == 0 ? TEST_OK : TEST_FAIL;
 }
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 43e55fe98f8c..830fb3d7ea2e 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -150,7 +150,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 		evlist__delete(evlist);
 	} else {
 		perf_cpu_map__put(cpus);
-		thread_map__put(threads);
+		perf_thread_map__put(threads);
 	}
 
 	return err;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index d15282174b2e..72fbf55f4fc3 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -157,6 +157,6 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 out_free_cpus:
 	perf_cpu_map__put(cpus);
 out_free_threads:
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return err;
 }
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index ad6ca943e568..360d70deb855 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -147,7 +147,7 @@ static int synth_process(struct machine *machine)
 						perf_event__process,
 						machine, 0);
 
-	thread_map__put(map);
+	perf_thread_map__put(map);
 	return err;
 }
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 611f6ea9b702..674b0fa035ec 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -122,6 +122,6 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 out_cpu_map_delete:
 	perf_cpu_map__put(cpus);
 out_thread_map_delete:
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return err;
 }
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 20e353fbfdd0..87c212545767 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -61,6 +61,6 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 out_evsel_delete:
 	evsel__delete(evsel);
 out_thread_map_delete:
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return err;
 }
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index c464e301ade9..2decda2d4c17 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -126,7 +126,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 
 out_free_maps:
 	perf_cpu_map__put(cpus);
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 out_delete_evlist:
 	evlist__delete(evlist);
 	return err;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 27af7b7109a3..0935a5a1ecaa 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -570,7 +570,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		evlist__delete(evlist);
 	} else {
 		perf_cpu_map__put(cpus);
-		thread_map__put(threads);
+		perf_thread_map__put(threads);
 	}
 
 	return err;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index f026759a05d7..24257285844b 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -136,7 +136,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 out_free_maps:
 	perf_cpu_map__put(cpus);
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 out_delete_evlist:
 	evlist__delete(evlist);
 	return err;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 73bc404ed390..d61773cacf0b 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -28,11 +28,11 @@ int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unuse
 	TEST_ASSERT_VAL("wrong pid",
 			thread_map__pid(map, 0) == getpid());
 	TEST_ASSERT_VAL("wrong comm",
-			thread_map__comm(map, 0) &&
-			!strcmp(thread_map__comm(map, 0), NAME));
+			perf_thread_map__comm(map, 0) &&
+			!strcmp(perf_thread_map__comm(map, 0), NAME));
 	TEST_ASSERT_VAL("wrong refcnt",
 			refcount_read(&map->refcnt) == 1);
-	thread_map__put(map);
+	perf_thread_map__put(map);
 
 	/* test dummy pid */
 	map = perf_thread_map__new_dummy();
@@ -43,11 +43,11 @@ int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unuse
 	TEST_ASSERT_VAL("wrong nr", map->nr == 1);
 	TEST_ASSERT_VAL("wrong pid", thread_map__pid(map, 0) == -1);
 	TEST_ASSERT_VAL("wrong comm",
-			thread_map__comm(map, 0) &&
-			!strcmp(thread_map__comm(map, 0), "dummy"));
+			perf_thread_map__comm(map, 0) &&
+			!strcmp(perf_thread_map__comm(map, 0), "dummy"));
 	TEST_ASSERT_VAL("wrong refcnt",
 			refcount_read(&map->refcnt) == 1);
-	thread_map__put(map);
+	perf_thread_map__put(map);
 	return 0;
 }
 
@@ -70,11 +70,11 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong pid",
 			thread_map__pid(threads, 0) == getpid());
 	TEST_ASSERT_VAL("wrong comm",
-			thread_map__comm(threads, 0) &&
-			!strcmp(thread_map__comm(threads, 0), NAME));
+			perf_thread_map__comm(threads, 0) &&
+			!strcmp(perf_thread_map__comm(threads, 0), NAME));
 	TEST_ASSERT_VAL("wrong refcnt",
 			refcount_read(&threads->refcnt) == 1);
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return 0;
 }
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1a3db35f9f7d..f440fdc3e953 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -992,7 +992,7 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 
 	for (i = 0; i < threads->nr; i++) {
 		struct thread_map_event_entry *entry = &event->thread_map.entries[i];
-		char *comm = thread_map__comm(threads, i);
+		char *comm = perf_thread_map__comm(threads, i);
 
 		if (!comm)
 			comm = (char *) "";
@@ -1387,7 +1387,7 @@ size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp)
 	else
 		ret += fprintf(fp, "failed to get threads from event\n");
 
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return ret;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 88d131769df4..38a3c6d16b4b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -142,7 +142,7 @@ void evlist__delete(struct evlist *evlist)
 	perf_evlist__munmap(evlist);
 	evlist__close(evlist);
 	perf_cpu_map__put(evlist->cpus);
-	thread_map__put(evlist->threads);
+	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
 	evlist->threads = NULL;
 	perf_evlist__purge(evlist);
@@ -165,8 +165,8 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
-	thread_map__put(evsel->threads);
-	evsel->threads = thread_map__get(evlist->threads);
+	perf_thread_map__put(evsel->threads);
+	evsel->threads = perf_thread_map__get(evlist->threads);
 }
 
 static void perf_evlist__propagate_maps(struct evlist *evlist)
@@ -1100,7 +1100,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 	return 0;
 
 out_delete_threads:
-	thread_map__put(threads);
+	perf_thread_map__put(threads);
 	return -1;
 }
 
@@ -1120,8 +1120,8 @@ void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
 	}
 
 	if (threads != evlist->threads) {
-		thread_map__put(evlist->threads);
-		evlist->threads = thread_map__get(threads);
+		perf_thread_map__put(evlist->threads);
+		evlist->threads = perf_thread_map__get(threads);
 	}
 
 	perf_evlist__propagate_maps(evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 72c0e6948e83..652e53279b28 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1327,7 +1327,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->cpus);
 	perf_cpu_map__put(evsel->own_cpus);
-	thread_map__put(evsel->threads);
+	perf_thread_map__put(evsel->threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	perf_evsel__object.fini(evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8c9928feb38a..38eeca6fa1fc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2337,7 +2337,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		evsel__delete(evsel);
 	}
 
-	thread_map__put(tmap);
+	perf_thread_map__put(tmap);
 	return ret;
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 677c93f91c6c..19d2feee91d5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -626,7 +626,7 @@ static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
 
 static void pyrf_thread_map__delete(struct pyrf_thread_map *pthreads)
 {
-	thread_map__put(pthreads->threads);
+	perf_thread_map__put(pthreads->threads);
 	Py_TYPE(pthreads)->tp_free((PyObject*)pthreads);
 }
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f7666d2e6e0c..1f099823a1f9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -116,7 +116,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
 			config->csv_output ? 0 : 16,
-			thread_map__comm(evsel->threads, id),
+			perf_thread_map__comm(evsel->threads, id),
 			config->csv_output ? 0 : -8,
 			thread_map__pid(evsel->threads, id),
 			config->csv_sep);
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 06dd9f2e4ce5..c58385ea05be 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -304,32 +304,6 @@ struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid,
 	return thread_map__new_by_tid_str(tid);
 }
 
-static void thread_map__delete(struct perf_thread_map *threads)
-{
-	if (threads) {
-		int i;
-
-		WARN_ONCE(refcount_read(&threads->refcnt) != 0,
-			  "thread map refcnt unbalanced\n");
-		for (i = 0; i < threads->nr; i++)
-			free(thread_map__comm(threads, i));
-		free(threads);
-	}
-}
-
-struct perf_thread_map *thread_map__get(struct perf_thread_map *map)
-{
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
-}
-
-void thread_map__put(struct perf_thread_map *map)
-{
-	if (map && refcount_dec_and_test(&map->refcnt))
-		thread_map__delete(map);
-}
-
 size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp)
 {
 	int i;
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 94a1f9565f5e..ba45c760be72 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -18,9 +18,6 @@ struct perf_thread_map *thread_map__new_all_cpus(void);
 struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
 struct perf_thread_map *thread_map__new_event(struct thread_map_event *event);
 
-struct perf_thread_map *thread_map__get(struct perf_thread_map *map);
-void thread_map__put(struct perf_thread_map *map);
-
 struct perf_thread_map *thread_map__new_str(const char *pid,
 		const char *tid, uid_t uid, bool all_threads);
 
@@ -38,11 +35,6 @@ static inline pid_t thread_map__pid(struct perf_thread_map *map, int thread)
 	return map->map[thread].pid;
 }
 
-static inline char *thread_map__comm(struct perf_thread_map *map, int thread)
-{
-	return map->map[thread].comm;
-}
-
 void thread_map__read_comms(struct perf_thread_map *threads);
 bool thread_map__has(struct perf_thread_map *threads, pid_t pid);
 int thread_map__remove(struct perf_thread_map *threads, int idx);
-- 
2.21.0

