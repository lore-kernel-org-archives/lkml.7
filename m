Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BDB217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfJOFff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfJOFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQx-00006G-TO; Tue, 15 Oct 2019 07:31:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 574111C04C9;
        Tue, 15 Oct 2019 07:31:39 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__read_event() from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-13-jolsa@kernel.org>
References: <20191007125344.14268-13-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749929.12254.14404945766581551571.tip-bot2@tip-bot2>
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

Commit-ID:     151ed5d70da87720022e4171227733a008b3c719
Gitweb:        https://git.kernel.org/tip/151ed5d70da87720022e4171227733a008b3c719
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:20 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 11:49:46 -03:00

libperf: Adopt perf_mmap__read_event() from tools/perf

Move perf_mmap__read_event() from tools/perf to libperf and export it in
the perf/mmap.h header.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/perf/mmap.h           |  2 +-
 tools/perf/lib/libperf.map                   |  1 +-
 tools/perf/lib/mmap.c                        | 79 +++++++++++++++++++-
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
 tools/perf/util/mmap.c                       | 77 +-------------------
 tools/perf/util/mmap.h                       |  2 +-
 tools/perf/util/python.c                     |  2 +-
 21 files changed, 98 insertions(+), 95 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index c90d925..909ead0 100644
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
index 4c087a8..858da89 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -764,7 +764,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
 			perf_mmap__consume(&md->core);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1a54069..d96f24c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -873,7 +873,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	if (perf_mmap__read_init(&md->core) < 0)
 		return;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		int ret;
 
 		ret = perf_evlist__parse_sample_timestamp(evlist, event, &last_timestamp);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2311628..144d417 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3804,7 +3804,7 @@ again:
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			++trace->nr_events;
 
 			err = trace__deliver_event(trace, event);
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
index 4f946e7..9508ad9 100644
--- a/tools/perf/lib/include/perf/mmap.h
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -5,9 +5,11 @@
 #include <perf/core.h>
 
 struct perf_mmap;
+union perf_event;
 
 LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
 LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
 LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
+LIBPERF_API union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 7e3ea2e..8bb0d73 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -43,6 +43,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
+		perf_mmap__read_event;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 97297cb..0752c19 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -3,9 +3,11 @@
 #include <inttypes.h>
 #include <asm/bug.h>
 #include <errno.h>
+#include <string.h>
 #include <linux/ring_buffer.h>
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
+#include <perf/event.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 #include <linux/kernel.h>
@@ -192,3 +194,80 @@ void perf_mmap__read_done(struct perf_mmap *map)
 
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
index 13e67cd..a4cd30c 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -39,7 +39,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 		union perf_event *event;
 
 		perf_mmap__read_init(&map->core);
-		while ((event = perf_mmap__read_event(map)) != NULL) {
+		while ((event = perf_mmap__read_event(&map->core)) != NULL) {
 			const u32 type = event->header.type;
 
 			switch (type) {
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index fd45529..5d20bf8 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -188,7 +188,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			const u32 type = event->header.type;
 
 			if (type == PERF_RECORD_SAMPLE)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9947cda..1f017e1 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -429,7 +429,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 		if (perf_mmap__read_init(&md->core) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md)) != NULL) {
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
 			perf_mmap__consume(&md->core);
 			if (ret < 0)
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index e950907..50a0c9f 100644
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
index bb15d40..5f4c0db 100644
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
index c95eb1b..c6b2d7a 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -96,7 +96,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
-			while ((event = perf_mmap__read_event(md)) != NULL) {
+			while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 				const u32 type = event->header.type;
 				int tp_flags;
 				struct perf_sample sample;
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 92a53be..2195fc2 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -174,7 +174,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 			if (perf_mmap__read_init(&md->core) < 0)
 				continue;
 
-			while ((event = perf_mmap__read_event(md)) != NULL) {
+			while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 				const u32 type = event->header.type;
 				const char *name = perf_event__name(type);
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index ace2092..bfb9986 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -103,7 +103,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 8400fb1..fcb0d03 100644
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
index c6a1394..4965f8b 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -121,7 +121,7 @@ retry:
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md)) != NULL) {
+	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6e070ee..a9b189a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1811,7 +1811,7 @@ static void *perf_evlist__poll_thread(void *arg)
 
 			if (perf_mmap__read_init(&map->core))
 				continue;
-			while ((event = perf_mmap__read_event(map)) != NULL) {
+			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
 				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
 
 				if (evsel && evsel->side_band.cb)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2dedef9..2a8bf0a 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -29,83 +29,6 @@ size_t mmap__mmap_len(struct mmap *map)
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
index 0b15702..bee4e83 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -47,8 +47,6 @@ void mmap__munmap(struct mmap *map);
 
 union perf_event *perf_mmap__read_forward(struct mmap *map);
 
-union perf_event *perf_mmap__read_event(struct mmap *map);
-
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size));
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 64eec2a..2511860 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1026,7 +1026,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
 
-	event = perf_mmap__read_event(md);
+	event = perf_mmap__read_event(&md->core);
 	if (event != NULL) {
 		PyObject *pyevent = pyrf_event__new(event);
 		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
