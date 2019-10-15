Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F1ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CFF21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfJOFfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfJOFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQy-000078-7W; Tue, 15 Oct 2019 07:31:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BBEFB1C04CE;
        Tue, 15 Oct 2019 07:31:39 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__read_init() from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-11-jolsa@kernel.org>
References: <20191007125344.14268-11-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749971.12254.1694152574214490441.tip-bot2@tip-bot2>
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

Commit-ID:     7c4d41824f9afc659ba425a41018546531cffd72
Gitweb:        https://git.kernel.org/tip/7c4d41824f9afc659ba425a41018546531cffd72
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:18 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 11:45:21 -03:00

libperf: Adopt perf_mmap__read_init() from tools/perf

Move perf_mmap__read_init() from tools/perf to libperf and export it in
perf/mmap.h header.

And add pr_debug2()/pr_debug3() macros support, because the code is
using them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/perf/core.h           |  2 +-
 tools/perf/lib/include/perf/mmap.h           |  1 +-
 tools/perf/lib/internal.h                    |  2 +-
 tools/perf/lib/libperf.map                   |  1 +-
 tools/perf/lib/mmap.c                        | 84 +++++++++++++++++++-
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
 tools/perf/util/mmap.c                       | 82 +-------------------
 tools/perf/util/mmap.h                       |  1 +-
 tools/perf/util/python.c                     |  2 +-
 23 files changed, 107 insertions(+), 98 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 3397898..6a0c3ff 100644
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
index 0c04c4c..b6a8078 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -760,7 +760,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 
 	*mmap_time = ULLONG_MAX;
 	md = &evlist->mmap[idx];
-	err = perf_mmap__read_init(md);
+	err = perf_mmap__read_init(&md->core);
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5fcf157..4a4bb7b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -870,7 +870,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	union perf_event *event;
 
 	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		return;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a57084..cd69d68 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3801,7 +3801,7 @@ again:
 		struct mmap *md;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index cfd70e7..2a80e4b 100644
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
index d3678d1..646e905 100644
--- a/tools/perf/lib/include/perf/mmap.h
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -7,5 +7,6 @@
 struct perf_mmap;
 
 LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
+LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
 
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
index dc92f24..37db745 100644
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
index d7b327f..bc3fbb2 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -41,6 +41,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__set_maps;
 		perf_evlist__poll;
 		perf_mmap__consume;
+		perf_mmap__read_init;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 4cada1c..fdbc6c5 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/mman.h>
+#include <inttypes.h>
+#include <asm/bug.h>
+#include <errno.h>
 #include <linux/ring_buffer.h>
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 #include <linux/kernel.h>
+#include "internal.h"
 
 void perf_mmap__init(struct perf_mmap *map, bool overwrite,
 		     libperf_unmap_cb_t unmap_cb)
@@ -91,3 +95,83 @@ void perf_mmap__consume(struct perf_mmap *map)
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
index 13f9a06..ff3a986 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -38,7 +38,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 		struct mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
 
-		perf_mmap__read_init(map);
+		perf_mmap__read_init(&map->core);
 		while ((event = perf_mmap__read_event(map)) != NULL) {
 			const u32 type = event->header.type;
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 6f0d239..73d26c6 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -185,7 +185,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		struct mmap *md;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index b5a57bb..cf992e0 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -426,7 +426,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md) < 0)
+		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 31c005e..e85da7e 100644
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
index b176acc..77f42f0 100644
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
index bbf8ba3..d6a5631 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -93,7 +93,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 			struct mmap *md;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md) < 0)
+			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6ebbcc6..2587cb8 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -171,7 +171,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 			struct mmap *md;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md) < 0)
+			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 1aeb558..8086695 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -100,7 +100,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	evlist__disable(evlist);
 
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 55728b3..bedfdec 100644
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
index a0f6895..035d423 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -118,7 +118,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 retry:
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 34ba47b..d9a4a4b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1809,7 +1809,7 @@ static void *perf_evlist__poll_thread(void *arg)
 			struct mmap *map = &evlist->mmap[i];
 			union perf_event *event;
 
-			if (perf_mmap__read_init(map))
+			if (perf_mmap__read_init(&map->core))
 				continue;
 			while ((event = perf_mmap__read_event(map)) != NULL) {
 				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index abe7cbe..5937911 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -365,86 +365,6 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
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
@@ -454,7 +374,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 	void *buf;
 	int rc = 0;
 
-	rc = perf_mmap__read_init(md);
+	rc = perf_mmap__read_init(&md->core);
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 1 : -1;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 89fb932..6d818ef 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -54,6 +54,5 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
-int perf_mmap__read_init(struct mmap *md);
 void perf_mmap__read_done(struct mmap *map);
 #endif /*__PERF_MMAP_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 82a4fa6..64eec2a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1023,7 +1023,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	if (!md)
 		return NULL;
 
-	if (perf_mmap__read_init(md) < 0)
+	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
 
 	event = perf_mmap__read_event(md);
