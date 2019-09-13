Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E81C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AFE20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381267;
	bh=UMO/HsCpDOA8P3vU6ZzMS4lj0kU8hw6yNNp/XhL8xMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tD+UF3Unpj7nONKUazzyeLwPFFCku48WPaANpB4ZUkAqvPGilx9PaOeaEH+VGKB1v
	 h/4vBwkaELh/yzyJgxS6cE/v/7L+OryPLGIoIwSaPHEUDNdtgqQPlRVd9litpQMUhY
	 z/+P9GO5ARG5lwXpLogKaDVVAzmziZz67fOcw1EI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbfIMN0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391458AbfIMNZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A052308FBFC;
        Fri, 13 Sep 2019 13:25:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 618DA5C1D4;
        Fri, 13 Sep 2019 13:25:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 49/73] libperf: Add perf_mmap__read_init function
Date:   Fri, 13 Sep 2019 15:23:31 +0200
Message-Id: <20190913132355.21634-50-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 13 Sep 2019 13:25:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__read_init function under libperf
and export it in perf/mmap.h header.

And add pr_debug2/pr_debug3 macros support, because
the code is using them.

Link: http://lkml.kernel.org/n/tip-il44mm7h1m93imk0x84q7klp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/perf/core.h           |  2 +
 tools/perf/lib/include/perf/mmap.h           |  1 +
 tools/perf/lib/internal.h                    |  2 +
 tools/perf/lib/libperf.map                   |  1 +
 tools/perf/lib/mmap.c                        | 84 ++++++++++++++++++++
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  2 +-
 tools/perf/tests/code-reading.c              |  2 +-
 tools/perf/tests/keep-tracking.c             |  2 +-
 tools/perf/tests/mmap-basic.c                |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/sw-clock.c                  |  2 +-
 tools/perf/tests/switch-tracking.c           |  2 +-
 tools/perf/tests/task-exit.c                 |  2 +-
 tools/perf/util/evlist.c                     |  2 +-
 tools/perf/util/mmap.c                       | 82 +------------------
 tools/perf/util/mmap.h                       |  1 -
 tools/perf/util/python.c                     |  2 +-
 23 files changed, 107 insertions(+), 98 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index c9b359a16f75..ca5e483c3fda 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -118,7 +118,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index fea07ee4c68b..ca7e48379f57 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -756,7 +756,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 
 	*mmap_time = ULLONG_MAX;
 	md = &evlist->mmap[idx];
-	err = perf_mmap__read_init(md);
+	err = perf_mmap__read_init(&md->core);
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 19775c7a5563..86b7a71dc5ed 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -866,7 +866,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	union perf_event *event;
 
 	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		return;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fa8296e8be2a..fcdb30e93a81 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3447,7 +3447,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		struct mmap *md;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index cfd70e720c1c..2a80e4b6f819 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -12,6 +12,8 @@ enum libperf_print_level {
 	LIBPERF_WARN,
 	LIBPERF_INFO,
 	LIBPERF_DEBUG,
+	LIBPERF_DEBUG2,
+	LIBPERF_DEBUG3,
 };
 
 typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
index d3678d1834d9..646e9052b003 100644
--- a/tools/perf/lib/include/perf/mmap.h
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -7,5 +7,6 @@
 struct perf_mmap;
 
 LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
+LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
 
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
index dc92f241732e..37db745e1502 100644
--- a/tools/perf/lib/internal.h
+++ b/tools/perf/lib/internal.h
@@ -14,5 +14,7 @@ do {                            \
 #define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
 #define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
+#define pr_debug2(fmt, ...)     __pr(LIBPERF_DEBUG2, fmt, ##__VA_ARGS__)
+#define pr_debug3(fmt, ...)     __pr(LIBPERF_DEBUG3, fmt, ##__VA_ARGS__)
 
 #endif /* __LIBPERF_INTERNAL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 8c876fbc1fa3..fba8cdfb3987 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -40,6 +40,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__set_maps;
 		perf_evlist__poll;
 		perf_mmap__consume;
+		perf_mmap__read_init;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 8545e7a03691..15f91b976ce7 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/mman.h>
+#include <inttypes.h>
+#include <asm/bug.h>
+#include <errno.h>
 #include <linux/zalloc.h>
 #include <linux/ring_buffer.h>
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
+#include "internal.h"
 
 void perf_mmap__init(struct perf_mmap *map, bool overwrite,
 		     libperf_unmap_cb_t unmap_cb)
@@ -101,3 +105,83 @@ void perf_mmap__consume(struct perf_mmap *map)
 	if (refcount_read(&map->refcnt) == 1 && perf_mmap__empty(map))
 		perf_mmap__put(map);
 }
+
+static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
+{
+	struct perf_event_header *pheader;
+	u64 evt_head = *start;
+	int size = mask + 1;
+
+	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
+	pheader = (struct perf_event_header *)(buf + (*start & mask));
+	while (true) {
+		if (evt_head - *start >= (unsigned int)size) {
+			pr_debug("Finished reading overwrite ring buffer: rewind\n");
+			if (evt_head - *start > (unsigned int)size)
+				evt_head -= pheader->size;
+			*end = evt_head;
+			return 0;
+		}
+
+		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
+
+		if (pheader->size == 0) {
+			pr_debug("Finished reading overwrite ring buffer: get start\n");
+			*end = evt_head;
+			return 0;
+		}
+
+		evt_head += pheader->size;
+		pr_debug3("move evt_head: %"PRIx64"\n", evt_head);
+	}
+	WARN_ONCE(1, "Shouldn't get here\n");
+	return -1;
+}
+
+/*
+ * Report the start and end of the available data in ringbuffer
+ */
+static int __perf_mmap__read_init(struct perf_mmap *md)
+{
+	u64 head = perf_mmap__read_head(md);
+	u64 old = md->prev;
+	unsigned char *data = md->base + page_size;
+	unsigned long size;
+
+	md->start = md->overwrite ? head : old;
+	md->end = md->overwrite ? old : head;
+
+	if ((md->end - md->start) < md->flush)
+		return -EAGAIN;
+
+	size = md->end - md->start;
+	if (size > (unsigned long)(md->mask) + 1) {
+		if (!md->overwrite) {
+			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
+
+			md->prev = head;
+			perf_mmap__consume(md);
+			return -EAGAIN;
+		}
+
+		/*
+		 * Backward ring buffer is full. We still have a chance to read
+		 * most of data from it.
+		 */
+		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+int perf_mmap__read_init(struct perf_mmap *map)
+{
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return -ENOENT;
+
+	return __perf_mmap__read_init(map);
+}
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 6d8a49b0d4e0..085e4d632be4 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -37,7 +37,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 		struct mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
 
-		perf_mmap__read_init(map);
+		perf_mmap__read_init(&map->core);
 		while ((event = perf_mmap__read_event(map)) != NULL) {
 			const u32 type = event->header.type;
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 79acb857841c..d7e328d2d1f2 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -184,7 +184,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		struct mmap *md;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 8ce99aeadb34..3c5de881b43c 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -425,7 +425,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 2169d74d9872..3cdee969958d 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -39,7 +39,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
 	found = 0;
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			if (event->header.type == PERF_RECORD_COMM &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 18dd25ed8a2c..e9c1fbe5a9aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -114,7 +114,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		}
 
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 878d32237fb3..6c04753fe5f0 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -92,7 +92,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 			struct mmap *md;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md) < 0)
+			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index b2552ee06329..086cabb56db2 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -170,7 +170,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 			struct mmap *md;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md) < 0)
+			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 67615d90cd73..4b13d746f264 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -99,7 +99,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	evlist__disable(evlist);
 
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 529b39f39299..f774b50f926e 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -270,7 +270,7 @@ static int process_events(struct evlist *evlist,
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 4fd52522357a..6a1ca5d6dfdf 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -117,7 +117,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 retry:
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e9cc637881b8..38fd27f5bf0f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1752,7 +1752,7 @@ static void *perf_evlist__poll_thread(void *arg)
 			struct mmap *map = &evlist->mmap[i];
 			union perf_event *event;
 
-			if (perf_mmap__read_init(map))
+			if (perf_mmap__read_init(&map->core))
 				continue;
 			while ((event = perf_mmap__read_event(map)) != NULL) {
 				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5ec12483e79d..5913f7354232 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -364,86 +364,6 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	return perf_mmap__aio_mmap(map, mp);
 }
 
-static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
-{
-	struct perf_event_header *pheader;
-	u64 evt_head = *start;
-	int size = mask + 1;
-
-	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
-	pheader = (struct perf_event_header *)(buf + (*start & mask));
-	while (true) {
-		if (evt_head - *start >= (unsigned int)size) {
-			pr_debug("Finished reading overwrite ring buffer: rewind\n");
-			if (evt_head - *start > (unsigned int)size)
-				evt_head -= pheader->size;
-			*end = evt_head;
-			return 0;
-		}
-
-		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
-
-		if (pheader->size == 0) {
-			pr_debug("Finished reading overwrite ring buffer: get start\n");
-			*end = evt_head;
-			return 0;
-		}
-
-		evt_head += pheader->size;
-		pr_debug3("move evt_head: %"PRIx64"\n", evt_head);
-	}
-	WARN_ONCE(1, "Shouldn't get here\n");
-	return -1;
-}
-
-/*
- * Report the start and end of the available data in ringbuffer
- */
-static int __perf_mmap__read_init(struct mmap *md)
-{
-	u64 head = perf_mmap__read_head(&md->core);
-	u64 old = md->core.prev;
-	unsigned char *data = md->core.base + page_size;
-	unsigned long size;
-
-	md->core.start = md->core.overwrite ? head : old;
-	md->core.end = md->core.overwrite ? old : head;
-
-	if ((md->core.end - md->core.start) < md->core.flush)
-		return -EAGAIN;
-
-	size = md->core.end - md->core.start;
-	if (size > (unsigned long)(md->core.mask) + 1) {
-		if (!md->core.overwrite) {
-			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
-
-			md->core.prev = head;
-			perf_mmap__consume(&md->core);
-			return -EAGAIN;
-		}
-
-		/*
-		 * Backward ring buffer is full. We still have a chance to read
-		 * most of data from it.
-		 */
-		if (overwrite_rb_find_range(data, md->core.mask, &md->core.start, &md->core.end))
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-int perf_mmap__read_init(struct mmap *map)
-{
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->core.refcnt))
-		return -ENOENT;
-
-	return __perf_mmap__read_init(map);
-}
-
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size))
 {
@@ -453,7 +373,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 	void *buf;
 	int rc = 0;
 
-	rc = perf_mmap__read_init(md);
+	rc = perf_mmap__read_init(&md->core);
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 1 : -1;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d90554168127..3849bcbbe9ce 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -82,6 +82,5 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
-int perf_mmap__read_init(struct mmap *md);
 void perf_mmap__read_done(struct mmap *map);
 #endif /*__PERF_MMAP_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 04c1d350a9c5..ba7a7cace740 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1017,7 +1017,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	if (!md)
 		return NULL;
 
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
 
 	event = perf_mmap__read_event(md);
-- 
2.21.0

