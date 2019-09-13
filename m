Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4313FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CF720640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381264;
	bh=liDOhdrjfDl+Uc8vsBQXTMRO5MS8qkzS+itCOqUDV08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOM6mJo0RWpFAzT6rrJj3+KyxL8h9axuaUTjn4LgmPGe7K4Jha+5zMN63lGzw7AF4
	 nnE1DrbxJHSckLepgBvShQ5+GFYvKLakUTRt6+aKtyV9cJi49Zk/cGYu0uUt+JOFb/
	 YsBON+WvSwjfqBfTs8JKGIed0xxUn2b0+7a/scLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbfIMN0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391505AbfIMN0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDB30307D91F;
        Fri, 13 Sep 2019 13:26:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E2975C22C;
        Fri, 13 Sep 2019 13:26:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 52/73] libperf: Add perf_evlist__mmap/munmap function
Date:   Fri, 13 Sep 2019 15:23:34 +0200
Message-Id: <20190913132355.21634-53-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 13:26:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding libperf's version of perf_evlist__mmap/munmap
functions and exporting them in perf/evlist.h header.

It's the backbone of what we have in perf code. The
following changes will add needed callbacks and then
we finally switch perf code to use libperf's version.

Adding mmap/mmap_ovw 'struct perf_mmap' object arrays
to hold maps for libperf's evlist.

Link: http://lkml.kernel.org/n/tip-smr1w2e6j37ncbmsd1eet228@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 215 +++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |   2 +
 tools/perf/lib/include/perf/evlist.h     |   3 +
 tools/perf/lib/libperf.map               |   2 +
 4 files changed, 222 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 160393cb9bed..168bc5d0a1c8 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -7,13 +7,20 @@
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
 
@@ -101,6 +108,8 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 
 void perf_evlist__delete(struct perf_evlist *evlist)
 {
+	free(evlist->mmap);
+	free(evlist->mmap_ovw);
 	free(evlist);
 }
 
@@ -279,3 +288,209 @@ int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
 {
 	return fdarray__poll(&evlist->pollfd, timeout);
 }
+
+static int perf_evlist__alloc_maps(struct perf_evlist *evlist)
+{
+	struct perf_mmap **map;
+
+	evlist->nr_mmaps = perf_cpu_map__nr(evlist->cpus);
+	if (perf_cpu_map__empty(evlist->cpus))
+		evlist->nr_mmaps = perf_thread_map__nr(evlist->threads);
+
+	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap *));
+	if (map)
+		evlist->mmap = map;
+
+	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap *));
+	if (map)
+		evlist->mmap_ovw = map;
+
+	return 0;
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
+		map = perf_mmap__new(overwrite, NULL);
+		if (map == NULL)
+			return -ENOMEM;
+
+		if (overwrite) {
+			mp->prot = PROT_READ;
+			output   = _output_overwrite;
+			evlist->mmap_ovw[idx] = map;
+		} else {
+			mp->prot = PROT_READ | PROT_WRITE;
+			output   = _output;
+			evlist->mmap[idx] = map;
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
+	if (!evlist->mmap && perf_evlist__alloc_maps(evlist))
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
+		for (i = 0; i < evlist->nr_mmaps; i++) {
+			struct perf_mmap *map = evlist->mmap[i];
+
+			perf_mmap__munmap(map);
+			free(map);
+		}
+	}
+
+	if (evlist->mmap_ovw) {
+		for (i = 0; i < evlist->nr_mmaps; i++) {
+			struct perf_mmap *map = evlist->mmap_ovw[i];
+
+			perf_mmap__munmap(map);
+			free(map);
+		}
+	}
+
+	zfree(&evlist->mmap);
+	zfree(&evlist->mmap_ovw);
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 9f440ab12b76..b136d1b4ea72 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -22,6 +22,8 @@ struct perf_evlist {
 	size_t			 mmap_len;
 	struct fdarray		 pollfd;
 	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
+	struct perf_mmap	**mmap;
+	struct perf_mmap	**mmap_ovw;
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
index 6e7d9be3c35f..198dcf305356 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -39,6 +39,8 @@ LIBPERF_0.0.1 {
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

