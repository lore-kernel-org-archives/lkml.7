Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDDFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131892064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OUASoo3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfG3S3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:29:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3S3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:29:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UITY4a3330300
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:29:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UITY4a3330300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511374;
        bh=P6ANwuZqF5CeBz51PCYiPWpHnxIBMSbMZ0l5/mvMxw8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OUASoo3xdsTbOu7FJ6XD4ckOC9/w2w1Jl9ADXE6/xDcUj5LCPq47ToceeHBukJfKV
         ndeP+4Ob14xAg1/EdIN1gur7VbbmUs5JrmJ1xxE6+zFujmhKprnrhJm3Ug+79LmJeK
         /+xXCQ5OidNRdqtJXvP86a20UenHJPIjkRl/axIn6v+2P+wXj2yONDx9fs3A347Vw5
         PYpQy6+o30ZEd2L7ttRmDXnhSGKuzI6gfMRuQkCzlwytQkV66kEni96fAMnmPPkJqb
         2mH/dynZbjYmynulXvuxWTqGgvFuafc8PW5O2MXDimhBES4wprVxZ+ybWCDaFNZYzc
         56rs28qvD0FQg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UITXLl3330297;
        Tue, 30 Jul 2019 11:29:33 -0700
Date:   Tue, 30 Jul 2019 11:29:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-38f01d8da1d8d28678ea16a0a484f4d3eded34b2@git.kernel.org>
Cc:     namhyung@kernel.org, mpetlan@redhat.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
          namhyung@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, peterz@infradead.org,
          alexey.budankov@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com
In-Reply-To: <20190721112506.12306-31-jolsa@kernel.org>
References: <20190721112506.12306-31-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add
 perf_cpu_map__get()/perf_cpu_map__put()
Git-Commit-ID: 38f01d8da1d8d28678ea16a0a484f4d3eded34b2
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

Commit-ID:  38f01d8da1d8d28678ea16a0a484f4d3eded34b2
Gitweb:     https://git.kernel.org/tip/38f01d8da1d8d28678ea16a0a484f4d3eded34b2
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:17 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_cpu_map__get()/perf_cpu_map__put()

Moving the following functions:

  cpu_map__get()
  cpu_map__put()

to libperf with following names:

  perf_cpu_map__get()
  perf_cpu_map__put()

Committer notes:

Added fixes for arm/arm64

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-31-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c          |  6 +++---
 tools/perf/arch/arm64/util/header.c        |  4 ++--
 tools/perf/builtin-ftrace.c                |  2 +-
 tools/perf/builtin-stat.c                  |  4 ++--
 tools/perf/lib/cpumap.c                    | 24 ++++++++++++++++++++++++
 tools/perf/lib/include/perf/cpumap.h       |  2 ++
 tools/perf/lib/libperf.map                 |  2 ++
 tools/perf/tests/bitmap.c                  |  2 +-
 tools/perf/tests/code-reading.c            |  4 ++--
 tools/perf/tests/cpumap.c                  |  8 ++++----
 tools/perf/tests/event-times.c             |  4 ++--
 tools/perf/tests/event_update.c            |  4 ++--
 tools/perf/tests/keep-tracking.c           |  2 +-
 tools/perf/tests/mem2node.c                |  2 +-
 tools/perf/tests/mmap-basic.c              |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/sw-clock.c                |  2 +-
 tools/perf/tests/switch-tracking.c         |  2 +-
 tools/perf/tests/task-exit.c               |  2 +-
 tools/perf/tests/topology.c                |  2 +-
 tools/perf/util/cpumap.c                   | 22 ----------------------
 tools/perf/util/cpumap.h                   |  3 ---
 tools/perf/util/cputopo.c                  |  4 ++--
 tools/perf/util/env.c                      |  2 +-
 tools/perf/util/event.c                    |  2 +-
 tools/perf/util/evlist.c                   | 16 ++++++++--------
 tools/perf/util/evsel.c                    |  4 ++--
 tools/perf/util/parse-events.c             |  4 ++--
 tools/perf/util/pmu.c                      |  2 +-
 tools/perf/util/python.c                   |  2 +-
 tools/perf/util/record.c                   |  6 +++---
 tools/perf/util/session.c                  |  2 +-
 tools/perf/util/svghelper.c                |  2 +-
 33 files changed, 78 insertions(+), 75 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 268fcb31cd53..3a78b38e43ca 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -181,7 +181,7 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 
 	err = 0;
 out:
-	cpu_map__put(online_cpus);
+	perf_cpu_map__put(online_cpus);
 	return err;
 }
 
@@ -517,7 +517,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		}
 	}
 
-	cpu_map__put(online_cpus);
+	perf_cpu_map__put(online_cpus);
 
 	return (CS_ETM_HEADER_SIZE +
 	       (etmv4 * CS_ETMV4_PRIV_SIZE) +
@@ -679,7 +679,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 		if (cpu_map__has(cpu_map, i))
 			cs_etm_get_metadata(i, &offset, itr, info);
 
-	cpu_map__put(online_cpus);
+	perf_cpu_map__put(online_cpus);
 
 	return 0;
 }
diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index b3e73a413f5a..602caf550e7f 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -27,7 +27,7 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		return NULL;
 
 	/* read midr from list of cpus mapped to this pmu */
-	cpus = cpu_map__get(pmu->cpus);
+	cpus = perf_cpu_map__get(pmu->cpus);
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
 				sysfs, cpus->map[cpu]);
@@ -60,6 +60,6 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		buf = NULL;
 	}
 
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	return buf;
 }
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 105ef2a17a9c..6943352b8d94 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -206,7 +206,7 @@ static int reset_tracing_cpu(void)
 	int ret;
 
 	ret = set_tracing_cpumask(cpumap);
-	cpu_map__put(cpumap);
+	perf_cpu_map__put(cpumap);
 	return ret;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 36e66a4f3c57..39bd73d0e06e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -933,8 +933,8 @@ static int perf_stat_init_aggr_mode(void)
 
 static void perf_stat__exit_aggr_mode(void)
 {
-	cpu_map__put(stat_config.aggr_map);
-	cpu_map__put(stat_config.cpus_aggr_map);
+	perf_cpu_map__put(stat_config.aggr_map);
+	perf_cpu_map__put(stat_config.cpus_aggr_map);
 	stat_config.aggr_map = NULL;
 	stat_config.cpus_aggr_map = NULL;
 }
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 80d587ab95aa..f3cfb4c71106 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -3,6 +3,8 @@
 #include <stdlib.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+#include <asm/bug.h>
+#include <stdio.h>
 
 struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 {
@@ -16,3 +18,25 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 
 	return cpus;
 }
+
+static void cpu_map__delete(struct perf_cpu_map *map)
+{
+	if (map) {
+		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+			  "cpu_map refcnt unbalanced\n");
+		free(map);
+	}
+}
+
+struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
+{
+	if (map)
+		refcount_inc(&map->refcnt);
+	return map;
+}
+
+void perf_cpu_map__put(struct perf_cpu_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refcnt))
+		cpu_map__delete(map);
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index fa1e5aa9d662..e16c2515a499 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -7,5 +7,7 @@
 struct perf_cpu_map;
 
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
+LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 
 #endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 65201c6cbe7e..76ce3bc59dd8 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -2,6 +2,8 @@ LIBPERF_0.0.1 {
 	global:
 		libperf_set_print;
 		perf_cpu_map__dummy_new;
+		perf_cpu_map__get;
+		perf_cpu_map__put;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 74d0cd32a5c4..95304d29092e 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -21,7 +21,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	}
 
 	if (map)
-		cpu_map__put(map);
+		perf_cpu_map__put(map);
 	return bm;
 }
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index ec4b0bf28270..ce2d3266286a 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -655,7 +655,7 @@ static int do_test_code_reading(bool try_kcore)
 				 * and will be freed by following perf_evlist__set_maps
 				 * call. Getting refference to keep them alive.
 				 */
-				cpu_map__get(cpus);
+				perf_cpu_map__get(cpus);
 				thread_map__get(threads);
 				perf_evlist__set_maps(evlist, NULL, NULL);
 				evlist__delete(evlist);
@@ -705,7 +705,7 @@ out_err:
 	if (evlist) {
 		evlist__delete(evlist);
 	} else {
-		cpu_map__put(cpus);
+		perf_cpu_map__put(cpus);
 		thread_map__put(threads);
 	}
 	machine__delete_threads(machine);
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 10da4400493d..6c921087b0fe 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -39,7 +39,7 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 		TEST_ASSERT_VAL("wrong cpu", map->map[i] == i);
 	}
 
-	cpu_map__put(map);
+	perf_cpu_map__put(map);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong cpu", map->map[0] == 1);
 	TEST_ASSERT_VAL("wrong cpu", map->map[1] == 256);
 	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
-	cpu_map__put(map);
+	perf_cpu_map__put(map);
 	return 0;
 }
 
@@ -83,7 +83,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
 	TEST_ASSERT_VAL("failed to synthesize map",
 		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_mask, NULL));
 
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 
 	/* This one is better stores in cpu values. */
 	cpus = cpu_map__new("1,256");
@@ -91,7 +91,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
 	TEST_ASSERT_VAL("failed to synthesize map",
 		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_cpus, NULL));
 
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	return 0;
 }
 
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index bf00d3d792fb..dcfff4b20c92 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -132,7 +132,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 		return err;
 	}
 
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	return evsel__enable(evsel);
 }
 
@@ -154,7 +154,7 @@ static int attach__cpu_enabled(struct evlist *evlist)
 	if (err == -EACCES)
 		return TEST_SKIP;
 
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	return err ? TEST_FAIL : TEST_OK;
 }
 
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index eb0dd359762d..415d12e96834 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -73,7 +73,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong cpus", map->map[0] == 1);
 	TEST_ASSERT_VAL("wrong cpus", map->map[1] == 2);
 	TEST_ASSERT_VAL("wrong cpus", map->map[2] == 3);
-	cpu_map__put(map);
+	perf_cpu_map__put(map);
 	return 0;
 }
 
@@ -113,6 +113,6 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
-	cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->own_cpus);
 	return 0;
 }
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 7bfc859971e5..43e55fe98f8c 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -149,7 +149,7 @@ out_err:
 		evlist__disable(evlist);
 		evlist__delete(evlist);
 	} else {
-		cpu_map__put(cpus);
+		perf_cpu_map__put(cpus);
 		thread_map__put(threads);
 	}
 
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index e12eedfba781..6fe2c1e7918b 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -32,7 +32,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	}
 
 	if (map)
-		cpu_map__put(map);
+		perf_cpu_map__put(map);
 	else
 		free(bm);
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 40511025208f..d15282174b2e 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -155,7 +155,7 @@ out_delete_evlist:
 	cpus	= NULL;
 	threads = NULL;
 out_free_cpus:
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 out_free_threads:
 	thread_map__put(threads);
 	return err;
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index f96cbd304024..611f6ea9b702 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -120,7 +120,7 @@ out_close_fd:
 out_evsel_delete:
 	evsel__delete(evsel);
 out_cpu_map_delete:
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index c6d3f4488b73..c464e301ade9 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -125,7 +125,7 @@ out_init:
 	}
 
 out_free_maps:
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	thread_map__put(threads);
 out_delete_evlist:
 	evlist__delete(evlist);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index d5537edb47db..27af7b7109a3 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -569,7 +569,7 @@ out:
 		evlist__disable(evlist);
 		evlist__delete(evlist);
 	} else {
-		cpu_map__put(cpus);
+		perf_cpu_map__put(cpus);
 		thread_map__put(threads);
 	}
 
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index c094fb8cc877..f026759a05d7 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -135,7 +135,7 @@ out_init:
 	}
 
 out_free_maps:
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	thread_map__put(threads);
 out_delete_evlist:
 	evlist__delete(evlist);
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 443d0272ebbd..1b57ded58d59 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -133,7 +133,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 	}
 
 	ret = check_cpu_topology(path, map);
-	cpu_map__put(map);
+	perf_cpu_map__put(map);
 
 free_path:
 	unlink(path);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index acda9bfb4002..44082e5eabde 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -273,28 +273,6 @@ struct perf_cpu_map *cpu_map__empty_new(int nr)
 	return cpus;
 }
 
-static void cpu_map__delete(struct perf_cpu_map *map)
-{
-	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
-			  "cpu_map refcnt unbalanced\n");
-		free(map);
-	}
-}
-
-struct perf_cpu_map *cpu_map__get(struct perf_cpu_map *map)
-{
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
-}
-
-void cpu_map__put(struct perf_cpu_map *map)
-{
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_map__delete(map);
-}
-
 static int cpu__get_topology_int(int cpu, const char *name, int *value)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 0ce3f6bd9449..b7af2cb68c19 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -29,9 +29,6 @@ int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct perf_cpu_map **diep
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **corep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
-struct perf_cpu_map *cpu_map__get(struct perf_cpu_map *map);
-void cpu_map__put(struct perf_cpu_map *map);
-
 static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
 {
 	if (!sock || s > sock->nr || s < 0)
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 157b0988435e..0cd99c460cd4 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -219,7 +219,7 @@ struct cpu_topology *cpu_topology__new(void)
 	}
 
 out_free:
-	cpu_map__put(map);
+	perf_cpu_map__put(map);
 	if (ret) {
 		cpu_topology__delete(tp);
 		tp = NULL;
@@ -335,7 +335,7 @@ struct numa_topology *numa_topology__new(void)
 out:
 	free(buf);
 	fclose(fp);
-	cpu_map__put(node_map);
+	perf_cpu_map__put(node_map);
 	return tp;
 }
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9909ec40c6d2..d77912b2b5e7 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -179,7 +179,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->cpu);
 
 	for (i = 0; i < env->nr_numa_nodes; i++)
-		cpu_map__put(env->numa_nodes[i].map);
+		perf_cpu_map__put(env->numa_nodes[i].map);
 	zfree(&env->numa_nodes);
 
 	for (i = 0; i < env->caches_cnt; i++)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f78837788b14..1a3db35f9f7d 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1403,7 +1403,7 @@ size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp)
 	else
 		ret += fprintf(fp, "failed to get cpumap from event\n");
 
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	return ret;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 461c1e68e9e7..35020d50f51e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -141,7 +141,7 @@ void evlist__delete(struct evlist *evlist)
 
 	perf_evlist__munmap(evlist);
 	evlist__close(evlist);
-	cpu_map__put(evlist->cpus);
+	perf_cpu_map__put(evlist->cpus);
 	thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
 	evlist->threads = NULL;
@@ -158,11 +158,11 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 * keep it, if there's no target cpu list defined.
 	 */
 	if (!evsel->own_cpus || evlist->has_user_cpus) {
-		cpu_map__put(evsel->cpus);
-		evsel->cpus = cpu_map__get(evlist->cpus);
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evlist->cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
-		cpu_map__put(evsel->cpus);
-		evsel->cpus = cpu_map__get(evsel->own_cpus);
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
 	thread_map__put(evsel->threads);
@@ -1115,8 +1115,8 @@ void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
 	 * the caller to increase the reference count.
 	 */
 	if (cpus != evlist->cpus) {
-		cpu_map__put(evlist->cpus);
-		evlist->cpus = cpu_map__get(cpus);
+		perf_cpu_map__put(evlist->cpus);
+		evlist->cpus = perf_cpu_map__get(cpus);
 	}
 
 	if (threads != evlist->threads) {
@@ -1383,7 +1383,7 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 out:
 	return err;
 out_put:
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 	goto out;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a389752840a9..72c0e6948e83 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1325,8 +1325,8 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
-	cpu_map__put(evsel->cpus);
-	cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->cpus);
+	perf_cpu_map__put(evsel->own_cpus);
 	thread_map__put(evsel->threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index decb66d243ca..8c9928feb38a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -332,8 +332,8 @@ __add_event(struct list_head *list, int *idx,
 		return NULL;
 
 	(*idx)++;
-	evsel->cpus        = cpu_map__get(cpus);
-	evsel->own_cpus    = cpu_map__get(cpus);
+	evsel->cpus        = perf_cpu_map__get(cpus);
+	evsel->own_cpus    = perf_cpu_map__get(cpus);
 	evsel->system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4929a50c0973..d355f9506a1c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -626,7 +626,7 @@ static bool pmu_is_uncore(const char *name)
 
 	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
 	cpus = __pmu_cpumask(path);
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 
 	return !!cpus;
 }
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc4af99ab190..677c93f91c6c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -557,7 +557,7 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map *pcpus,
 
 static void pyrf_cpu_map__delete(struct pyrf_cpu_map *pcpus)
 {
-	cpu_map__put(pcpus->cpus);
+	perf_cpu_map__put(pcpus->cpus);
 	Py_TYPE(pcpus)->tp_free((PyObject*)pcpus);
 }
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 9f8841548539..fecccfd71aa1 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -67,7 +67,7 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	if (!cpus)
 		return false;
 	cpu = cpus->map[0];
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 
 	do {
 		ret = perf_do_probe_api(fn, cpu, try[i++]);
@@ -122,7 +122,7 @@ bool perf_can_record_cpu_wide(void)
 	if (!cpus)
 		return false;
 	cpu = cpus->map[0];
-	cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
 
 	fd = sys_perf_event_open(&attr, -1, cpu, -1, 0);
 	if (fd < 0)
@@ -278,7 +278,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 		struct perf_cpu_map *cpus = cpu_map__new(NULL);
 
 		cpu =  cpus ? cpus->map[0] : 0;
-		cpu_map__put(cpus);
+		perf_cpu_map__put(cpus);
 	} else {
 		cpu = evlist->cpus->map[0];
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c191dc152175..62d37440cbee 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2310,7 +2310,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	err = 0;
 
 out_delete_map:
-	cpu_map__put(map);
+	perf_cpu_map__put(map);
 	return err;
 }
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 99132c6a30a6..a9ca5c4fffee 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -745,7 +745,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 		set_bit(c, cpumask_bits(b));
 	}
 
-	cpu_map__put(m);
+	perf_cpu_map__put(m);
 
 	return ret;
 }
