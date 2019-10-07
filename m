Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F45205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452860;
	bh=HkrR38coITAqsEm4o/P/70Q7E7xNZmKBwhVW4WD2XmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rzsthumac8+b1FNAjdbzQO7T8zlvspgVWsnijbiE0csLgCq4Cv7UEI/czEUZ1lHJS
	 oBFa4TrztMC1beIMgu8g40fvVYSgKeTZETvtKaudJUkJ1WzYQJ98mhxIjbSqQty0Ax
	 eOI9x9dF1RoTZcOegHoFLCSb+1A2QOPZTNVM1Ixs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfJGMyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfJGMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58AED10C0929;
        Mon,  7 Oct 2019 12:54:15 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACF5A5D9CC;
        Mon,  7 Oct 2019 12:54:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 13/36] libperf: Add perf_evlist__mmap()/munmap() functions
Date:   Mon,  7 Oct 2019 14:53:21 +0200
Message-Id: <20191007125344.14268-14-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Mon, 07 Oct 2019 12:54:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-53-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 236 +++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |   2 +
 tools/perf/lib/include/perf/evlist.h     |   3 +
 tools/perf/lib/libperf.map               |   2 +
 4 files changed, 243 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index d1496fee810c..250ad5752589 100644
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
index 9f440ab12b76..4438a19ceba3 100644
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
index 8a2ce0757ab2..28b6a12a8a2b 100644
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
index 8bb0d73e0c6c..5a18fd1aacf2 100644
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
-- 
2.21.0

