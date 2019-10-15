Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD7ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679B321848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfJOFby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:31:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfJOFbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQs-00005q-HG; Tue, 15 Oct 2019 07:31:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 218A51C04A9;
        Tue, 15 Oct 2019 07:31:39 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-14-jolsa@kernel.org>
References: <20191007125344.14268-14-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749906.12254.2831611483887542840.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d1a177595b3a824c72dacb0f9d1a4e5906eaef0e
Gitweb:        https://git.kernel.org/tip/d1a177595b3a824c72dacb0f9d1a4e5906eaef0e
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:21 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:15:58 -03:00

libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf

Add libperf's version of perf_evlist__mmap()/munmap() functions and
exporting them in the perf/evlist.h header.

It's the backbone of what we have in perf code. The following changes
will add needed callbacks and then we'll finally switch the perf code to
use libperf's version.

Add mmap/mmap_ovw 'struct perf_mmap' object arrays to hold maps for
libperf's evlist.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 236 ++++++++++++++++++++++-
 tools/perf/lib/include/internal/evlist.h |   2 +-
 tools/perf/lib/include/perf/evlist.h     |   3 +-
 tools/perf/lib/libperf.map               |   2 +-
 4 files changed, 243 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index d1496fe..250ad57 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -8,13 +8,20 @@
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <internal/xyarray.h>
+#include <internal/mmap.h>
+#include <internal/cpumap.h>
+#include <internal/threadmap.h>
+#include <internal/xyarray.h>
+#include <internal/lib.h>
 #include <linux/zalloc.h>
+#include <sys/ioctl.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <signal.h>
 #include <poll.h>
+#include <sys/mman.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <api/fd/array.h>
@@ -103,6 +110,10 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 
 void perf_evlist__delete(struct perf_evlist *evlist)
 {
+	if (evlist == NULL)
+		return;
+
+	perf_evlist__munmap(evlist);
 	free(evlist);
 }
 
@@ -281,3 +292,228 @@ int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
 {
 	return fdarray__poll(&evlist->pollfd, timeout);
 }
+
+static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, bool overwrite)
+{
+	int i;
+	struct perf_mmap *map;
+
+	evlist->nr_mmaps = perf_cpu_map__nr(evlist->cpus);
+	if (perf_cpu_map__empty(evlist->cpus))
+		evlist->nr_mmaps = perf_thread_map__nr(evlist->threads);
+
+	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
+	if (!map)
+		return NULL;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		/*
+		 * When the perf_mmap() call is made we grab one refcount, plus
+		 * one extra to let perf_mmap__consume() get the last
+		 * events after all real references (perf_mmap__get()) are
+		 * dropped.
+		 *
+		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
+		 * thus does perf_mmap__get() on it.
+		 */
+		perf_mmap__init(&map[i], overwrite, NULL);
+	}
+
+	return map;
+}
+
+static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
+				     struct perf_evsel *evsel, int idx, int cpu,
+				     int thread)
+{
+	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+
+	sid->idx = idx;
+	if (evlist->cpus && cpu >= 0)
+		sid->cpu = evlist->cpus->map[cpu];
+	else
+		sid->cpu = -1;
+	if (!evsel->system_wide && evlist->threads && thread >= 0)
+		sid->tid = perf_thread_map__pid(evlist->threads, thread);
+	else
+		sid->tid = -1;
+}
+
+static struct perf_mmap*
+perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
+{
+	struct perf_mmap *map = &evlist->mmap[idx];
+
+	if (overwrite) {
+		if (!evlist->mmap_ovw) {
+			evlist->mmap_ovw = perf_evlist__alloc_mmap(evlist, true);
+			if (!evlist->mmap_ovw)
+				return NULL;
+		}
+		map = &evlist->mmap_ovw[idx];
+	}
+
+	return map;
+}
+
+#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+
+static int
+mmap_per_evsel(struct perf_evlist *evlist, int idx,
+	       struct perf_mmap_param *mp, int cpu_idx,
+	       int thread, int *_output, int *_output_overwrite)
+{
+	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
+	struct perf_evsel *evsel;
+	int revent;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		bool overwrite = evsel->attr.write_backward;
+		struct perf_mmap *map;
+		int *output, fd, cpu;
+
+		if (evsel->system_wide && thread)
+			continue;
+
+		cpu = perf_cpu_map__idx(evsel->cpus, evlist_cpu);
+		if (cpu == -1)
+			continue;
+
+		map = perf_evlist__map_get(evlist, overwrite, idx);
+		if (map == NULL)
+			return -ENOMEM;
+
+		if (overwrite) {
+			mp->prot = PROT_READ;
+			output   = _output_overwrite;
+		} else {
+			mp->prot = PROT_READ | PROT_WRITE;
+			output   = _output;
+		}
+
+		fd = FD(evsel, cpu, thread);
+
+		if (*output == -1) {
+			*output = fd;
+
+			if (perf_mmap__mmap(map, mp, *output, evlist_cpu) < 0)
+				return -1;
+		} else {
+			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
+				return -1;
+
+			perf_mmap__get(map);
+		}
+
+		revent = !overwrite ? POLLIN : 0;
+
+		if (!evsel->system_wide &&
+		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
+			perf_mmap__put(map);
+			return -1;
+		}
+
+		if (evsel->attr.read_format & PERF_FORMAT_ID) {
+			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
+						   fd) < 0)
+				return -1;
+			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
+						 thread);
+		}
+	}
+
+	return 0;
+}
+
+static int
+mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+{
+	int thread;
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+
+	for (thread = 0; thread < nr_threads; thread++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
+				   &output, &output_overwrite))
+			goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	perf_evlist__munmap(evlist);
+	return -1;
+}
+
+static int
+mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+{
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nr_cpus    = perf_cpu_map__nr(evlist->cpus);
+	int cpu, thread;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		for (thread = 0; thread < nr_threads; thread++) {
+			if (mmap_per_evsel(evlist, cpu, mp, cpu,
+					   thread, &output, &output_overwrite))
+				goto out_unmap;
+		}
+	}
+
+	return 0;
+
+out_unmap:
+	perf_evlist__munmap(evlist);
+	return -1;
+}
+
+int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+{
+	struct perf_evsel *evsel;
+	const struct perf_cpu_map *cpus = evlist->cpus;
+	const struct perf_thread_map *threads = evlist->threads;
+	struct perf_mmap_param mp;
+
+	if (!evlist->mmap)
+		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
+	if (!evlist->mmap)
+		return -ENOMEM;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
+		    evsel->sample_id == NULL &&
+		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
+			return -ENOMEM;
+	}
+
+	evlist->mmap_len = (pages + 1) * page_size;
+	mp.mask = evlist->mmap_len - page_size - 1;
+
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, &mp);
+
+	return mmap_per_cpu(evlist, &mp);
+}
+
+void perf_evlist__munmap(struct perf_evlist *evlist)
+{
+	int i;
+
+	if (evlist->mmap) {
+		for (i = 0; i < evlist->nr_mmaps; i++)
+			perf_mmap__munmap(&evlist->mmap[i]);
+	}
+
+	if (evlist->mmap_ovw) {
+		for (i = 0; i < evlist->nr_mmaps; i++)
+			perf_mmap__munmap(&evlist->mmap_ovw[i]);
+	}
+
+	zfree(&evlist->mmap);
+	zfree(&evlist->mmap_ovw);
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 9f440ab..4438a19 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -22,6 +22,8 @@ struct perf_evlist {
 	size_t			 mmap_len;
 	struct fdarray		 pollfd;
 	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
+	struct perf_mmap	*mmap;
+	struct perf_mmap	*mmap_ovw;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 8a2ce07..28b6a12 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -33,4 +33,7 @@ LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
 				       struct perf_thread_map *threads);
 LIBPERF_API int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
 
+LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
+LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 8bb0d73..5a18fd1 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -40,6 +40,8 @@ LIBPERF_0.0.1 {
 		perf_evlist__next;
 		perf_evlist__set_maps;
 		perf_evlist__poll;
+		perf_evlist__mmap;
+		perf_evlist__munmap;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
