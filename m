Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7703AC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DB421773
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455673;
	bh=Eou2b580aS8VwS7Q8DAs08BC0hpjaBM2h59e4dEbGCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KZkyENeIOto/KRggTkxdv2nm2GXhkh9tSf0nG9wHtMthOSyarJO8R61uzXb/Sz2lD
	 QP1biN7yo4ebZlZccR1L1xKw5PxHOQZ96mrazDtn7OVJbOzShlx5BBB69xKMaZDyN9
	 t9ZvpuYb7zRwVqvor9UPMFs8RiCEo7f1DEMAqOYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfG3DBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732538AbfG3DBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A9B217D4;
        Tue, 30 Jul 2019 03:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455668;
        bh=Eou2b580aS8VwS7Q8DAs08BC0hpjaBM2h59e4dEbGCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lc+aKi+tjQyzOYHagFcwYig8jIu3/ommous+lhbcKNdXOlAhgh26+EnXIGHASGlxL
         te3bi3hUAQy03IRZwIVDL+ThkHeFp2lTPyi4ABaJQIlTH7b+gkv12ICEGBukTj4j0E
         /g6RWISiTB/YUHbdXxe3eNGmVCw9z97QW3EM0uHw=
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
Subject: [PATCH 085/107] libperf: Move fd array from perf's evsel to lobperf's perf_evsel class
Date:   Mon, 29 Jul 2019 23:55:48 -0300
Message-Id: <20190730025610.22603-86-acme@kernel.org>
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

Move the fd array from perf's evsel to libperf's perf_evsel class.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-59-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/bpf-loader.c            |  2 +-
 tools/perf/util/evlist.c                | 10 ++++-----
 tools/perf/util/evsel.c                 | 30 ++++++++++++-------------
 tools/perf/util/evsel.h                 |  1 -
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 8340fd883a3d..df4078194e9a 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -14,6 +14,7 @@ struct perf_evsel {
 	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
+	struct xyarray		*fd;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 4df8bdea14ac..9c219d413e57 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1403,7 +1403,7 @@ static int
 apply_config_evsel_for_key(const char *name, int map_fd, void *pkey,
 			   struct evsel *evsel)
 {
-	struct xyarray *xy = evsel->fd;
+	struct xyarray *xy = evsel->core.fd;
 	struct perf_event_attr *attr;
 	unsigned int key, events;
 	bool check_pass = false;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4433b656cfb7..e4b1a9914ea4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -40,7 +40,7 @@
 int sigqueue(pid_t pid, int sig, const union sigval value);
 #endif
 
-#define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
@@ -321,7 +321,7 @@ void evlist__disable(struct evlist *evlist)
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->fd)
+		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
 		evsel__disable(pos);
 	}
@@ -334,7 +334,7 @@ void evlist__enable(struct evlist *evlist)
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (!perf_evsel__is_group_leader(pos) || !pos->fd)
+		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
 		evsel__enable(pos);
 	}
@@ -353,7 +353,7 @@ static int perf_evlist__enable_event_cpu(struct evlist *evlist,
 	int thread;
 	int nr_threads = perf_evlist__nr_threads(evlist, evsel);
 
-	if (!evsel->fd)
+	if (!evsel->core.fd)
 		return -EINVAL;
 
 	for (thread = 0; thread < nr_threads; thread++) {
@@ -371,7 +371,7 @@ static int perf_evlist__enable_event_thread(struct evlist *evlist,
 	int cpu;
 	int nr_cpus = cpu_map__nr(evlist->core.cpus);
 
-	if (!evsel->fd)
+	if (!evsel->core.fd)
 		return -EINVAL;
 
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f7758ce0dd5c..8d087d0e55f1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -90,7 +90,7 @@ int perf_evsel__object_config(size_t object_size,
 	return 0;
 }
 
-#define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
 int __perf_evsel__sample_size(u64 sample_type)
 {
@@ -1155,9 +1155,9 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 
 static int perf_evsel__alloc_fd(struct evsel *evsel, int ncpus, int nthreads)
 {
-	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
+	evsel->core.fd = xyarray__new(ncpus, nthreads, sizeof(int));
 
-	if (evsel->fd) {
+	if (evsel->core.fd) {
 		int cpu, thread;
 		for (cpu = 0; cpu < ncpus; cpu++) {
 			for (thread = 0; thread < nthreads; thread++) {
@@ -1166,7 +1166,7 @@ static int perf_evsel__alloc_fd(struct evsel *evsel, int ncpus, int nthreads)
 		}
 	}
 
-	return evsel->fd != NULL ? 0 : -ENOMEM;
+	return evsel->core.fd != NULL ? 0 : -ENOMEM;
 }
 
 static int perf_evsel__run_ioctl(struct evsel *evsel,
@@ -1174,8 +1174,8 @@ static int perf_evsel__run_ioctl(struct evsel *evsel,
 {
 	int cpu, thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->core.fd); thread++) {
 			int fd = FD(evsel, cpu, thread),
 			    err = ioctl(fd, ioc, arg);
 
@@ -1283,8 +1283,8 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 
 static void perf_evsel__free_fd(struct evsel *evsel)
 {
-	xyarray__delete(evsel->fd);
-	evsel->fd = NULL;
+	xyarray__delete(evsel->core.fd);
+	evsel->core.fd = NULL;
 }
 
 static void perf_evsel__free_id(struct evsel *evsel)
@@ -1309,8 +1309,8 @@ void perf_evsel__close_fd(struct evsel *evsel)
 {
 	int cpu, thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++)
+		for (thread = 0; thread < xyarray__max_y(evsel->core.fd); ++thread) {
 			close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
@@ -1555,7 +1555,7 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	 * Leader must be already processed/open,
 	 * if not it's a bug.
 	 */
-	BUG_ON(!leader->fd);
+	BUG_ON(!leader->core.fd);
 
 	fd = FD(leader, cpu, thread);
 	BUG_ON(fd == -1);
@@ -1865,7 +1865,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	else
 		nthreads = threads->nr;
 
-	if (evsel->fd == NULL &&
+	if (evsel->core.fd == NULL &&
 	    perf_evsel__alloc_fd(evsel, cpus->nr, nthreads) < 0)
 		return -ENOMEM;
 
@@ -2075,7 +2075,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 void perf_evsel__close(struct evsel *evsel)
 {
-	if (evsel->fd == NULL)
+	if (evsel->core.fd == NULL)
 		return;
 
 	perf_evsel__close_fd(evsel);
@@ -3048,8 +3048,8 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	int cpu, thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->fd);
+	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
 		     thread++) {
 			int fd = FD(evsel, cpu, thread);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f9f66fe43f4..6056ce64bfdf 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,7 +104,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist	*evlist;
 	char			*filter;
-	struct xyarray		*fd;
 	struct xyarray		*sample_id;
 	u64			*id;
 	struct perf_counts	*counts;
-- 
2.21.0

