Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A10C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07AD222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458132;
	bh=EZdqYoNdmslt/EW96Fgw9BBFMyfUGt4EiB3BaKg2dd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULaEawSs+1Xf3cFHxH9y93c1uIbsJk3yA6cgW+RYizoFsUB9Sqta9MxKL6pOL/yz+
	 R00+okdJVZ6q2/yjMFu0ZbpNtEyE3Fr5ah1ztaa6txU8XzDIf5PyFWngS3lPkFXnoR
	 UcJFgcf8ld8kaD7fwE+fnmLYQiEdGWUUve6wsfXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbfIZAfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388739AbfIZAf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:28 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FB5222C4;
        Thu, 26 Sep 2019 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458126;
        bh=EZdqYoNdmslt/EW96Fgw9BBFMyfUGt4EiB3BaKg2dd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wx8accIMZMCoS+tMdISilXABY72rdAe0yDoj4wyT6SIvgmf49Aml0L3klFgar2SZS
         Zezr2bQBNheeqRjmDqwqRz2gpAyuZSgBDTxrF8wfpd/bvfRo+0WQh9LBAEWhgtBBDH
         MvofBIMMvpuRMid463UyEaX2nJIHw+3kz+O/W6S4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/66] libperf: Add perf_evsel__alloc_id/perf_evsel__free_id functions
Date:   Wed, 25 Sep 2019 21:32:19 -0300
Message-Id: <20190926003244.13962-42-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_evsel__alloc_id()/perf_evsel__free_id() functions to libperf as
internal functions.

Move 'struct perf_sample_id' to internal/evsel.h header and change
'struct perf_sample_id::evsel' to 'struct perf_evsel' and the related
code that touches it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-28-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 30 +++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h | 27 +++++++++++++++++++
 tools/perf/tests/event_update.c         |  2 +-
 tools/perf/util/evlist.c                | 10 +++----
 tools/perf/util/evsel.c                 | 36 +++----------------------
 tools/perf/util/evsel.h                 | 25 -----------------
 tools/perf/util/header.c                |  4 +--
 tools/perf/util/session.c               |  4 ++-
 8 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 24abc80dd767..a8cb582e2721 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -230,3 +230,33 @@ struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel)
 {
 	return &evsel->attr;
 }
+
+int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	if (ncpus == 0 || nthreads == 0)
+		return 0;
+
+	if (evsel->system_wide)
+		nthreads = 1;
+
+	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
+	if (evsel->sample_id == NULL)
+		return -ENOMEM;
+
+	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
+	if (evsel->id == NULL) {
+		xyarray__delete(evsel->sample_id);
+		evsel->sample_id = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void perf_evsel__free_id(struct perf_evsel *evsel)
+{
+	xyarray__delete(evsel->sample_id);
+	evsel->sample_id = NULL;
+	zfree(&evsel->id);
+	evsel->ids = 0;
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 385766f06591..a69b8299c36f 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -5,11 +5,35 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 #include <stdbool.h>
+#include <sys/types.h>
 
 struct perf_cpu_map;
 struct perf_thread_map;
 struct xyarray;
 
+/*
+ * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
+ * more than one entry in the evlist.
+ */
+struct perf_sample_id {
+	struct hlist_node	 node;
+	u64			 id;
+	struct perf_evsel	*evsel;
+       /*
+	* 'idx' will be used for AUX area sampling. A sample will have AUX area
+	* data that will be queued for decoding, where there are separate
+	* queues for each CPU (per-cpu tracing) or task (per-thread tracing).
+	* The sample ID can be used to lookup 'idx' which is effectively the
+	* queue number.
+	*/
+	int			 idx;
+	int			 cpu;
+	pid_t			 tid;
+
+	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
+	u64			 period;
+};
+
 struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
@@ -32,4 +56,7 @@ void perf_evsel__free_fd(struct perf_evsel *evsel);
 int perf_evsel__read_size(struct perf_evsel *evsel);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 
+int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__free_id(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 0497d900ced2..cf4f90170f90 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -95,7 +95,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("failed to allocate ids",
-			!perf_evsel__alloc_id(evsel, 1, 1));
+			!perf_evsel__alloc_id(&evsel->core, 1, 1));
 
 	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c6af7c622612..559db38594a8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -469,7 +469,7 @@ static void perf_evlist__id_hash(struct evlist *evlist,
 	struct perf_sample_id *sid = SID(evsel, cpu, thread);
 
 	sid->id = id;
-	sid->evsel = evsel;
+	sid->evsel = &evsel->core;
 	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
 	hlist_add_head(&sid->node, &evlist->core.heads[hash]);
 }
@@ -563,7 +563,7 @@ struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id)
 
 	sid = perf_evlist__id2sid(evlist, id);
 	if (sid)
-		return sid->evsel;
+		return container_of(sid->evsel, struct evsel, core);
 
 	if (!perf_evlist__sample_id_all(evlist))
 		return perf_evlist__first(evlist);
@@ -581,7 +581,7 @@ struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
 
 	sid = perf_evlist__id2sid(evlist, id);
 	if (sid)
-		return sid->evsel;
+		return container_of(sid->evsel, struct evsel, core);
 
 	return NULL;
 }
@@ -635,7 +635,7 @@ struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 
 	hlist_for_each_entry(sid, head, node) {
 		if (sid->id == id)
-			return sid->evsel;
+			return container_of(sid->evsel, struct evsel, core);
 	}
 	return NULL;
 }
@@ -1018,7 +1018,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
 		    evsel->core.sample_id == NULL &&
-		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
+		    perf_evsel__alloc_id(&evsel->core, perf_cpu_map__nr(cpus), threads->nr) < 0)
 			return -ENOMEM;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 55638eb9299c..a4a492f11849 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1227,36 +1227,6 @@ int evsel__disable(struct evsel *evsel)
 	return err;
 }
 
-int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
-{
-	if (ncpus == 0 || nthreads == 0)
-		return 0;
-
-	if (evsel->core.system_wide)
-		nthreads = 1;
-
-	evsel->core.sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
-	if (evsel->core.sample_id == NULL)
-		return -ENOMEM;
-
-	evsel->core.id = zalloc(ncpus * nthreads * sizeof(u64));
-	if (evsel->core.id == NULL) {
-		xyarray__delete(evsel->core.sample_id);
-		evsel->core.sample_id = NULL;
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void perf_evsel__free_id(struct evsel *evsel)
-{
-	xyarray__delete(evsel->core.sample_id);
-	evsel->core.sample_id = NULL;
-	zfree(&evsel->core.id);
-	evsel->core.ids = 0;
-}
-
 static void perf_evsel__free_config_terms(struct evsel *evsel)
 {
 	struct perf_evsel_config_term *term, *h;
@@ -1273,7 +1243,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	assert(evsel->evlist == NULL);
 	perf_evsel__free_counts(evsel);
 	perf_evsel__free_fd(&evsel->core);
-	perf_evsel__free_id(evsel);
+	perf_evsel__free_id(&evsel->core);
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->core.cpus);
@@ -1992,7 +1962,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 void evsel__close(struct evsel *evsel)
 {
 	perf_evsel__close(&evsel->core);
-	perf_evsel__free_id(evsel);
+	perf_evsel__free_id(&evsel->core);
 }
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
@@ -2706,7 +2676,7 @@ int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 	struct perf_cpu_map *cpus = evsel->core.cpus;
 	struct perf_thread_map *threads = evsel->core.threads;
 
-	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
+	if (perf_evsel__alloc_id(&evsel->core, cpus->nr, threads->nr))
 		return -ENOMEM;
 
 	return store_evsel_ids(evsel, evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ed64395ec340..a5b29ac10da0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -17,29 +17,6 @@ struct addr_location;
 struct evsel;
 union perf_event;
 
-/*
- * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
- * more than one entry in the evlist.
- */
-struct perf_sample_id {
-	struct hlist_node 	node;
-	u64		 	id;
-	struct evsel		*evsel;
-       /*
-	* 'idx' will be used for AUX area sampling. A sample will have AUX area
-	* data that will be queued for decoding, where there are separate
-	* queues for each CPU (per-cpu tracing) or task (per-thread tracing).
-	* The sample ID can be used to lookup 'idx' which is effectively the
-	* queue number.
-	*/
-	int			idx;
-	int			cpu;
-	pid_t			tid;
-
-	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
-	u64			period;
-};
-
 struct cgroup;
 
 /*
@@ -272,8 +249,6 @@ const char *perf_evsel__name(struct evsel *evsel);
 const char *perf_evsel__group_name(struct evsel *evsel);
 int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
-int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads);
-
 void __perf_evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit);
 void __perf_evsel__reset_sample_bit(struct evsel *evsel,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 498f6a825656..fc5eac41e102 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3609,7 +3609,7 @@ int perf_session__read_header(struct perf_session *session)
 		 * for allocating the perf_sample_id table we fake 1 cpu and
 		 * hattr->ids threads.
 		 */
-		if (perf_evsel__alloc_id(evsel, 1, nr_ids))
+		if (perf_evsel__alloc_id(&evsel->core, 1, nr_ids))
 			goto out_delete_evlist;
 
 		lseek(fd, f_attr.ids.offset, SEEK_SET);
@@ -3750,7 +3750,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	 * for allocating the perf_sample_id table we fake 1 cpu and
 	 * hattr->ids threads.
 	 */
-	if (perf_evsel__alloc_id(evsel, 1, n_ids))
+	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
 	for (i = 0; i < n_ids; i++) {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a621c73bad42..84a30ff3968a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1324,6 +1324,7 @@ static int deliver_sample_value(struct evlist *evlist,
 				struct machine *machine)
 {
 	struct perf_sample_id *sid = perf_evlist__id2sid(evlist, v->id);
+	struct evsel *evsel;
 
 	if (sid) {
 		sample->id     = v->id;
@@ -1343,7 +1344,8 @@ static int deliver_sample_value(struct evlist *evlist,
 	if (!sample->period)
 		return 0;
 
-	return tool->sample(tool, event, sample, sid->evsel, machine);
+	evsel = container_of(sid->evsel, struct evsel, core);
+	return tool->sample(tool, event, sample, evsel, machine);
 }
 
 static int deliver_sample_group(struct evlist *evlist,
-- 
2.21.0

