Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06741C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B721B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BeIB81q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfG3SwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:52:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59795 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbfG3SwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:52:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIonfX3335707
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:50:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIonfX3335707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512650;
        bh=k7Sq4+EW5Y4vXc8rB45Ch/nurUvxc6mTv2n4IqE0nGQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BeIB81q94D5g0X5mWfsvlsDLTqj7duXk47cIfnvsULvKhmFEyffLO3j5dnh1qUn+o
         dfTtRNIEjFVOflJlOTuLJrRGNH/kk3DjTjkXFrckciAwS/XUv18bVHnNn7gxThbZb7
         i3hZq8yo9PbRAU5lp1c1oQ0SHO7XA/bqmN5bpypupSl5HsqBLElYYO3nw21lDwdzRD
         HCnWeY1bml2flHKiuD3+53pfaTLYb1MydXRbT0Y19mmrWuzaN21pJKhIShSOLwfdQy
         gvO2k3GyR8DYAOfHaTj0dXhSR+sv4fRRWZKgU9kdbrRNy1KrFT4d3uvFKcMGz9KNHl
         lNOxHmFUPQnXg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIon9U3335704;
        Tue, 30 Jul 2019 11:50:49 -0700
Date:   Tue, 30 Jul 2019 11:50:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-9dfcb7599084382884fec6d0fd9ca33945fa7578@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, ak@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, namhyung@kernel.org,
        mpetlan@redhat.com
Reply-To: ak@linux.intel.com, peterz@infradead.org, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, namhyung@kernel.org,
          mpetlan@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190721112506.12306-59-jolsa@kernel.org>
References: <20190721112506.12306-59-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Move fd array from perf's evsel to
 lobperf's perf_evsel class
Git-Commit-ID: 9dfcb7599084382884fec6d0fd9ca33945fa7578
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

Commit-ID:  9dfcb7599084382884fec6d0fd9ca33945fa7578
Gitweb:     https://git.kernel.org/tip/9dfcb7599084382884fec6d0fd9ca33945fa7578
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:45 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Move fd array from perf's evsel to lobperf's perf_evsel class

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
 tools/perf/util/evlist.c                | 10 +++++-----
 tools/perf/util/evsel.c                 | 30 +++++++++++++++---------------
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
@@ -90,7 +90,7 @@ set_methods:
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
 
@@ -2075,7 +2075,7 @@ out_close:
 
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
