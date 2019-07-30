Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96843C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A1208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455692;
	bh=9W1zvRx2pqNneA2oI2wds/bYg+kTo11avF82Nos2DwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTgTL0AUeyN2MdNTEaaPdvm+AO04NBu2dBdsy8z0ri1x53N4ZNsf8Zzg4InuKnXy7
	 mQGsCdl5s7wuzr7Oqq/E1N/sejjRYfAPyc7cAnwoh9N29RfUMJk+E01pTyuw88H/I4
	 8edpFWsXPBgbHHgyDwtt7DUsfj7zzib872WQUFLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfG3DBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732588AbfG3DB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F74216C8;
        Tue, 30 Jul 2019 03:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455685;
        bh=9W1zvRx2pqNneA2oI2wds/bYg+kTo11avF82Nos2DwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anorqtPzskdmM3oRhA1B2FurzBTGCXDaH3qj6xVcGaNbYTJblqPhdF6wWLA/OOfnP
         s6k2xyaSj3uRhtlX+uw++6YWSZ0d+kCfLc+hNx5YQw8Pzu5lwGwziwiTNr7Y5jr7R5
         eXm8moxUnMpTPst+vQg2RmPol+8K/Ldw0mQw7lOk=
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
Subject: [PATCH 090/107] libperf: Adopt simplified perf_evsel__close() function from tools/perf
Date:   Mon, 29 Jul 2019 23:55:53 -0300
Message-Id: <20190730025610.22603-91-acme@kernel.org>
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
 tools/perf/lib/evsel.c                     | 26 +++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h    |  2 ++
 tools/perf/lib/include/perf/evsel.h        |  1 +
 tools/perf/lib/libperf.map                 |  1 +
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/util/evlist.c                   |  5 ++--
 tools/perf/util/evsel.c                    | 27 +++-------------------
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
@@ -2057,13 +2040,9 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
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
 
-- 
2.21.0

