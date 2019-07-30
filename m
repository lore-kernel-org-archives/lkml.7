Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7861A20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X0CmS1ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbfG3S4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:56:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbfG3Sz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:55:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIskE83336559
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:54:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIskE83336559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512887;
        bh=fSCLIe3j6EZzsggIqaE+OspmHe1D5RK1XJCtsAnzztc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X0CmS1eaNKWiO8XV/LC7ZYKOuwf24LiDKhi2gn3pAsD1Ub3PxYhcIF11QHLiFr0LF
         Oha/0IrjNnMce7jFt0aJ/Xn63leC3z25MtypyTndS5SRyZ09Q5pDFjWn5tzREIiuAm
         ShYgZz+ybkgLOnKSlScjZnQxauVX7+SsmtQzMVvNv+KW28pbAo2pVMvfBTQLvhK5qD
         fCo6CkYnsUpxASZb44IZPyIu9NZu2/1ZK6ZD/8b16osLfDVccs6avkL036aRkINcTX
         Z4RY3XHu4snaE/I40OCF5t6eigdrlCjqsk2IFrZBcbHrb6sPOl/4SX4pPLgleX6i5R
         U/wThe7io61Og==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIskY63336555;
        Tue, 30 Jul 2019 11:54:46 -0700
Date:   Tue, 30 Jul 2019 11:54:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-88761fa1f1e3fb2df86727ac99f88abf2ac7e00b@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, namhyung@kernel.org,
        mpetlan@redhat.com, mingo@kernel.org, peterz@infradead.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        hpa@zytor.com, acme@redhat.com
Reply-To: acme@redhat.com, ak@linux.intel.com, hpa@zytor.com,
          namhyung@kernel.org, tglx@linutronix.de, mpetlan@redhat.com,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com
In-Reply-To: <20190721112506.12306-64-jolsa@kernel.org>
References: <20190721112506.12306-64-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt simplified perf_evsel__close()
 function from tools/perf
Git-Commit-ID: 88761fa1f1e3fb2df86727ac99f88abf2ac7e00b
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

Commit-ID:  88761fa1f1e3fb2df86727ac99f88abf2ac7e00b
Gitweb:     https://git.kernel.org/tip/88761fa1f1e3fb2df86727ac99f88abf2ac7e00b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:50 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt simplified perf_evsel__close() function from tools/perf

Add perf_evsel__close() function to libperf while keeping a tools/perf
specific evsel__close() to free ids.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-64-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                 |  2 +-
 tools/perf/lib/evsel.c                     | 26 ++++++++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h    |  2 ++
 tools/perf/lib/include/perf/evsel.h        |  1 +
 tools/perf/lib/libperf.map                 |  1 +
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/util/evlist.c                   |  5 +++--
 tools/perf/util/evsel.c                    | 27 +++------------------------
 tools/perf/util/evsel.h                    |  3 +--
 10 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 35f3684f5327..75eb3811e942 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2401,7 +2401,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
 				evsel__disable(evsel);
-				perf_evsel__close(evsel);
+				evsel__close(evsel);
 			}
 		}
 	}
diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 7027dacb50f6..50f09e939229 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -111,3 +111,29 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	return err;
 }
+
+void perf_evsel__close_fd(struct perf_evsel *evsel)
+{
+	int cpu, thread;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+			close(FD(evsel, cpu, thread));
+			FD(evsel, cpu, thread) = -1;
+		}
+}
+
+void perf_evsel__free_fd(struct perf_evsel *evsel)
+{
+	xyarray__delete(evsel->fd);
+	evsel->fd = NULL;
+}
+
+void perf_evsel__close(struct perf_evsel *evsel)
+{
+	if (evsel->fd == NULL)
+		return;
+
+	perf_evsel__close_fd(evsel);
+	perf_evsel__free_fd(evsel);
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 3cb9a0f5f32e..878e2cf41ffc 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -21,5 +21,7 @@ struct perf_evsel {
 };
 
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__close_fd(struct perf_evsel *evsel);
+void perf_evsel__free_fd(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index e9fbaa8fb51a..aa5c48f822d2 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -15,5 +15,6 @@ LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 				 struct perf_thread_map *threads);
+LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 7594d3d89c5f..0b90999dcdcb 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -15,6 +15,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__delete;
 		perf_evsel__init;
 		perf_evsel__open;
+		perf_evsel__close;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index d161b1a78703..8322b6aa4047 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -116,7 +116,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 
 	perf_evsel__free_counts(evsel);
 out_close_fd:
-	perf_evsel__close_fd(evsel);
+	perf_evsel__close_fd(&evsel->core);
 out_evsel_delete:
 	evsel__delete(evsel);
 out_cpu_map_delete:
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 87c212545767..f217972977e0 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -57,7 +57,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 
 	err = 0;
 out_close_fd:
-	perf_evsel__close_fd(evsel);
+	perf_evsel__close_fd(&evsel->core);
 out_evsel_delete:
 	evsel__delete(evsel);
 out_thread_map_delete:
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index eac4d634b9c7..c6b4883b2d49 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -34,6 +34,7 @@
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <perf/evlist.h>
+#include <perf/evsel.h>
 #include <perf/cpumap.h>
 
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
@@ -1303,7 +1304,7 @@ void evlist__close(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry_reverse(evlist, evsel)
-		perf_evsel__close(evsel);
+		evsel__close(evsel);
 }
 
 static int perf_evlist__create_syswide_maps(struct evlist *evlist)
@@ -1772,7 +1773,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				perf_evsel__close(c2);
+				evsel__close(c2);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d3c8488f7069..8d8ed36377f5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1265,12 +1265,6 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	return 0;
 }
 
-static void perf_evsel__free_fd(struct evsel *evsel)
-{
-	xyarray__delete(evsel->core.fd);
-	evsel->core.fd = NULL;
-}
-
 static void perf_evsel__free_id(struct evsel *evsel)
 {
 	xyarray__delete(evsel->sample_id);
@@ -1289,23 +1283,12 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 	}
 }
 
-void perf_evsel__close_fd(struct evsel *evsel)
-{
-	int cpu, thread;
-
-	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++)
-		for (thread = 0; thread < xyarray__max_y(evsel->core.fd); ++thread) {
-			close(FD(evsel, cpu, thread));
-			FD(evsel, cpu, thread) = -1;
-		}
-}
-
 void perf_evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	perf_evsel__free_counts(evsel);
-	perf_evsel__free_fd(evsel);
+	perf_evsel__free_fd(&evsel->core);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
@@ -2057,13 +2040,9 @@ out_close:
 	return err;
 }
 
-void perf_evsel__close(struct evsel *evsel)
+void evsel__close(struct evsel *evsel)
 {
-	if (evsel->core.fd == NULL)
-		return;
-
-	perf_evsel__close_fd(evsel);
-	perf_evsel__free_fd(evsel);
+	perf_evsel__close(&evsel->core);
 	perf_evsel__free_id(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index afd3a5b7bcc3..03fc8edad492 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -268,7 +268,6 @@ const char *perf_evsel__group_name(struct evsel *evsel);
 int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
 int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads);
-void perf_evsel__close_fd(struct evsel *evsel);
 
 void __perf_evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit);
@@ -298,7 +297,7 @@ int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
-void perf_evsel__close(struct evsel *evsel);
+void evsel__close(struct evsel *evsel);
 
 struct perf_sample;
 
