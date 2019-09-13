Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEBDC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9260420640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381269;
	bh=CoJSejnQWnBbdTzSXgILH8c2iuzmGWLqM4glXzExH1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUKiWOVIS5qFo8sgqNim/c8+X+vPLErCLmFSR1q4EAKyQnbIlqv5lCxxWa2BCNf/9
	 5NWejKbh2Gu31LW3vzCpN4wIAeIazW1DU3gKcTZT79YYkRkb0Z/+E/IDSd+OqeIC/S
	 WDReFKi8a0KZC73zbcM0/JojWPVY8cIyFlO/fwF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391108AbfIMN1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32557 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391458AbfIMN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E599618CB8EA;
        Fri, 13 Sep 2019 13:26:02 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46D945C1D4;
        Fri, 13 Sep 2019 13:26:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 51/73] libperf: Add perf_mmap__read_event function
Date:   Fri, 13 Sep 2019 15:23:33 +0200
Message-Id: <20190913132355.21634-52-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 13 Sep 2019 13:26:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving perf_mmap__read_event function into libperf
and export it in perf/mmap.h header.

Link: http://lkml.kernel.org/n/tip-0ymfpbtfneihnkkmi6xrsyuy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/internal/mmap.h       |  1 +
 tools/perf/lib/include/perf/mmap.h           |  1 +
 tools/perf/lib/libperf.map                   |  1 +
 tools/perf/lib/mmap.c                        | 79 ++++++++++++++++++++
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
 tools/perf/util/mmap.c                       | 77 -------------------
 tools/perf/util/mmap.h                       |  2 -
 tools/perf/util/python.c                     |  2 +-
 22 files changed, 98 insertions(+), 95 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 04da28d15039..128c61c866d7 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -121,7 +121,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			struct perf_sample sample;
 
 			if (event->header.type != PERF_RECORD_COMM ||
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4b281d77d22c..9bcf025343a6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -760,7 +760,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
 			perf_mmap__consume(&md->core);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c122aa1e9ca1..0141afd2f3ff 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -869,7 +869,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	if (perf_mmap__read_init(&md->core) < 0)
 		return;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		int ret;
 
 		ret = perf_evlist__parse_sample_timestamp(evlist, event, &last_timestamp);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1ae249d9ecf0..a6f57d1c9a70 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3450,7 +3450,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			++trace->nr_events;
 
 			err = trace__deliver_event(trace, event);
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 30e34ec622bf..98e31f8ab461 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -11,6 +11,7 @@
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
 struct perf_mmap;
+union perf_event;
 
 typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
 
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
index 4f946e7f724b..396c6543d95d 100644
--- a/tools/perf/lib/include/perf/mmap.h
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -9,5 +9,6 @@ struct perf_mmap;
 LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
 LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
 LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
+LIBPERF_API union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index eca40c75b753..6e7d9be3c35f 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
+		perf_mmap__read_event;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index f27cb743183c..f8816c7bee87 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -3,10 +3,12 @@
 #include <inttypes.h>
 #include <asm/bug.h>
 #include <errno.h>
+#include <string.h>
 #include <linux/zalloc.h>
 #include <linux/ring_buffer.h>
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
+#include <perf/event.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 #include "internal.h"
@@ -202,3 +204,80 @@ void perf_mmap__read_done(struct perf_mmap *map)
 
 	map->prev = perf_mmap__read_head(map);
 }
+
+/* When check_messup is true, 'end' must points to a good entry */
+static union perf_event *perf_mmap__read(struct perf_mmap *map,
+					 u64 *startp, u64 end)
+{
+	unsigned char *data = map->base + page_size;
+	union perf_event *event = NULL;
+	int diff = end - *startp;
+
+	if (diff >= (int)sizeof(event->header)) {
+		size_t size;
+
+		event = (union perf_event *)&data[*startp & map->mask];
+		size = event->header.size;
+
+		if (size < sizeof(event->header) || diff < (int)size)
+			return NULL;
+
+		/*
+		 * Event straddles the mmap boundary -- header should always
+		 * be inside due to u64 alignment of output.
+		 */
+		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
+			unsigned int offset = *startp;
+			unsigned int len = min(sizeof(*event), size), cpy;
+			void *dst = map->event_copy;
+
+			do {
+				cpy = min(map->mask + 1 - (offset & map->mask), len);
+				memcpy(dst, &data[offset & map->mask], cpy);
+				offset += cpy;
+				dst += cpy;
+				len -= cpy;
+			} while (len);
+
+			event = (union perf_event *)map->event_copy;
+		}
+
+		*startp += size;
+	}
+
+	return event;
+}
+
+/*
+ * Read event from ring buffer one by one.
+ * Return one event for each call.
+ *
+ * Usage:
+ * perf_mmap__read_init()
+ * while(event = perf_mmap__read_event()) {
+ *	//process the event
+ *	perf_mmap__consume()
+ * }
+ * perf_mmap__read_done()
+ */
+union perf_event *perf_mmap__read_event(struct perf_mmap *map)
+{
+	union perf_event *event;
+
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return NULL;
+
+	/* non-overwirte doesn't pause the ringbuffer */
+	if (!map->overwrite)
+		map->end = perf_mmap__read_head(map);
+
+	event = perf_mmap__read(map, &map->start, map->end);
+
+	if (!map->overwrite)
+		map->prev = map->start;
+
+	return event;
+}
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 4b5625ac257c..a63b95bd0c52 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -38,7 +38,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 		union perf_event *event;
 
 		perf_mmap__read_init(&map->core);
-		while ((event = perf_mmap__read_event(map)) != NULL) {
+		while ((event = perf_mmap__read_event(&map->core)) != NULL) {
 			const u32 type = event->header.type;
 
 			switch (type) {
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index a0b559c90f9b..ec7f236d6da9 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -187,7 +187,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			const u32 type = event->header.type;
 
 			if (type == PERF_RECORD_SAMPLE)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3306d75cb596..00f2109249f4 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -428,7 +428,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
 			perf_mmap__consume(&md->core);
 			if (ret < 0)
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 10ea5112b996..8909ed382268 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -41,7 +41,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			if (event->header.type == PERF_RECORD_COMM &&
 			    (pid_t)event->comm.pid == getpid() &&
 			    (pid_t)event->comm.tid == getpid() &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 65b84032ee13..b4919cb87796 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -117,7 +117,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 771d1671f1fe..072a5e3bb441 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -95,7 +95,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
-			while ((event = perf_mmap__read_event(md)) != NULL) {
+			while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 				const u32 type = event->header.type;
 				int tp_flags;
 				struct perf_sample sample;
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index a0a2d9a49157..ee7ec9e21886 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -173,7 +173,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
-			while ((event = perf_mmap__read_event(md)) != NULL) {
+			while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 				const u32 type = event->header.type;
 				const char *name = perf_event__name(type);
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index d2612960669f..2ee9a5d4a221 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -102,7 +102,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index e2beb68281e2..05bc3b1c87ce 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -273,7 +273,7 @@ static int process_events(struct evlist *evlist,
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
 			 perf_mmap__consume(&md->core);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 988739fcaf8d..e4bae44babc4 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -120,7 +120,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4f92b65e702c..a9fc35d25a59 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1754,7 +1754,7 @@ static void *perf_evlist__poll_thread(void *arg)
 
 			if (perf_mmap__read_init(&map->core))
 				continue;
-			while ((event = perf_mmap__read_event(map)) != NULL) {
+			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
 				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
 
 				if (evsel && evsel->side_band.cb)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5ede1d2c84b1..bb81dd0c438f 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -28,83 +28,6 @@ size_t mmap__mmap_len(struct mmap *map)
 	return perf_mmap__mmap_len(&map->core);
 }
 
-/* When check_messup is true, 'end' must points to a good entry */
-static union perf_event *perf_mmap__read(struct mmap *map,
-					 u64 *startp, u64 end)
-{
-	unsigned char *data = map->core.base + page_size;
-	union perf_event *event = NULL;
-	int diff = end - *startp;
-
-	if (diff >= (int)sizeof(event->header)) {
-		size_t size;
-
-		event = (union perf_event *)&data[*startp & map->core.mask];
-		size = event->header.size;
-
-		if (size < sizeof(event->header) || diff < (int)size)
-			return NULL;
-
-		/*
-		 * Event straddles the mmap boundary -- header should always
-		 * be inside due to u64 alignment of output.
-		 */
-		if ((*startp & map->core.mask) + size != ((*startp + size) & map->core.mask)) {
-			unsigned int offset = *startp;
-			unsigned int len = min(sizeof(*event), size), cpy;
-			void *dst = map->core.event_copy;
-
-			do {
-				cpy = min(map->core.mask + 1 - (offset & map->core.mask), len);
-				memcpy(dst, &data[offset & map->core.mask], cpy);
-				offset += cpy;
-				dst += cpy;
-				len -= cpy;
-			} while (len);
-
-			event = (union perf_event *)map->core.event_copy;
-		}
-
-		*startp += size;
-	}
-
-	return event;
-}
-
-/*
- * Read event from ring buffer one by one.
- * Return one event for each call.
- *
- * Usage:
- * perf_mmap__read_init()
- * while(event = perf_mmap__read_event()) {
- *	//process the event
- *	perf_mmap__consume()
- * }
- * perf_mmap__read_done()
- */
-union perf_event *perf_mmap__read_event(struct mmap *map)
-{
-	union perf_event *event;
-
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->core.refcnt))
-		return NULL;
-
-	/* non-overwirte doesn't pause the ringbuffer */
-	if (!map->core.overwrite)
-		map->core.end = perf_mmap__read_head(&map->core);
-
-	event = perf_mmap__read(map, &map->core.start, map->core.end);
-
-	if (!map->core.overwrite)
-		map->core.prev = map->core.start;
-
-	return event;
-}
-
 int __weak auxtrace_mmap__mmap(struct auxtrace_mmap *mm __maybe_unused,
 			       struct auxtrace_mmap_params *mp __maybe_unused,
 			       void *userpg __maybe_unused,
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index efc2392747ba..beb90531ea7f 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -75,8 +75,6 @@ void mmap__munmap(struct mmap *map);
 
 union perf_event *perf_mmap__read_forward(struct mmap *map);
 
-union perf_event *perf_mmap__read_event(struct mmap *map);
-
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size));
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ba7a7cace740..7ea4086942aa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1020,7 +1020,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
 
-	event = perf_mmap__read_event(md);
+	event = perf_mmap__read_event(&md->core);
 	if (event != NULL) {
 		PyObject *pyevent = pyrf_event__new(event);
 		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
-- 
2.21.0

