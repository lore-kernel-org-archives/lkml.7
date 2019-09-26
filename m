Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A3C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566F21D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458044;
	bh=OvJeXun5fRBWDo1+HOVLHwGApQ8t/l9RaqARGX0fIzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GEJfFqWCowHPhOBu4q3EPe0z5KFdt45XKcljVnI+G787gS/y85GUC3JzEarxj3lWJ
	 QvRxO0+kQ76tEUaGC8kAZe99bngkObaCOXzdVerdMfbcAcMJpe+WFmrh0Pz+tMi8Lp
	 XGVDMjUMXGf7wZ26gl2zzYSO0KA1vYnJFWfyvDyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbfIZAeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388236AbfIZAeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:01 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73671222C2;
        Thu, 26 Sep 2019 00:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458039;
        bh=OvJeXun5fRBWDo1+HOVLHwGApQ8t/l9RaqARGX0fIzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cA2bmYY5MxJf0zQYhjk3SKFR9Nw27LuOTm7xKoMNcyYp/yb3udffIAywNNqHi7Ap
         lEgqRIT+e8AqnYZrT6R9pXqpKeyDGhuf2FX59ooQu36ab31Ec76l1F/B1sosDfSyLu
         MIMrbFQCgjkebyCl8cFt0TW77gXo6udB5ULwK/XQ=
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
Subject: [PATCH 15/66] perf tools: Rename 'struct perf_mmap' to 'struct mmap'
Date:   Wed, 25 Sep 2019 21:31:53 -0300
Message-Id: <20190926003244.13962-16-acme@kernel.org>
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

Rename 'struct perf_evlist' to 'struct evlist', so we don't have a name
clash when we add 'struct perf_mmap' to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-record.c                  | 34 ++++++------
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
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
 tools/perf/util/auxtrace.c                   |  6 +--
 tools/perf/util/auxtrace.h                   |  8 +--
 tools/perf/util/evlist.c                     | 14 ++---
 tools/perf/util/evlist.h                     |  4 +-
 tools/perf/util/mmap.c                       | 54 ++++++++++----------
 tools/perf/util/mmap.h                       | 32 ++++++------
 tools/perf/util/python.c                     |  6 +--
 22 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 0a4570b340fa..c83abb1ed0ff 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -65,7 +65,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	union perf_event *event;
 	u64 test_tsc, comm1_tsc, comm2_tsc;
 	u64 test_time, comm1_time = 0, comm2_time = 0;
-	struct perf_mmap *md;
+	struct mmap *md;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c4b22e1b0a40..7354b77e9137 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -750,7 +750,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 {
 	struct evlist *evlist = kvm->evlist;
 	union perf_event *event;
-	struct perf_mmap *md;
+	struct mmap *md;
 	u64 timestamp;
 	s64 n = 0;
 	int err;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1e1f97139f16..1528fb686f96 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -119,7 +119,7 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
-static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
+static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 			 void *bf, size_t size)
 {
 	struct perf_data_file *file = &rec->session->data->file;
@@ -168,7 +168,7 @@ static int record__aio_write(struct aiocb *cblock, int trace_fd,
 	return rc;
 }
 
-static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
+static int record__aio_complete(struct mmap *md, struct aiocb *cblock)
 {
 	void *rem_buf;
 	off_t rem_off;
@@ -214,7 +214,7 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
 	return rc;
 }
 
-static int record__aio_sync(struct perf_mmap *md, bool sync_all)
+static int record__aio_sync(struct mmap *md, bool sync_all)
 {
 	struct aiocb **aiocb = md->aio.aiocb;
 	struct aiocb *cblocks = md->aio.cblocks;
@@ -255,7 +255,7 @@ struct record_aio {
 	size_t		size;
 };
 
-static int record__aio_pushfn(struct perf_mmap *map, void *to, void *buf, size_t size)
+static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size)
 {
 	struct record_aio *aio = to;
 
@@ -300,7 +300,7 @@ static int record__aio_pushfn(struct perf_mmap *map, void *to, void *buf, size_t
 	return size;
 }
 
-static int record__aio_push(struct record *rec, struct perf_mmap *map, off_t *off)
+static int record__aio_push(struct record *rec, struct mmap *map, off_t *off)
 {
 	int ret, idx;
 	int trace_fd = rec->session->data->file.fd;
@@ -351,13 +351,13 @@ static void record__aio_mmap_read_sync(struct record *rec)
 {
 	int i;
 	struct evlist *evlist = rec->evlist;
-	struct perf_mmap *maps = evlist->mmap;
+	struct mmap *maps = evlist->mmap;
 
 	if (!record__aio_enabled(rec))
 		return;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		struct perf_mmap *map = &maps[i];
+		struct mmap *map = &maps[i];
 
 		if (map->base)
 			record__aio_sync(map, true);
@@ -387,7 +387,7 @@ static int record__aio_parse(const struct option *opt,
 #else /* HAVE_AIO_SUPPORT */
 static int nr_cblocks_max = 0;
 
-static int record__aio_push(struct record *rec __maybe_unused, struct perf_mmap *map __maybe_unused,
+static int record__aio_push(struct record *rec __maybe_unused, struct mmap *map __maybe_unused,
 			    off_t *off __maybe_unused)
 {
 	return -1;
@@ -482,7 +482,7 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, NULL, event, event->header.size);
 }
 
-static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size)
+static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
 
@@ -527,7 +527,7 @@ static void record__sig_exit(void)
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 static int record__process_auxtrace(struct perf_tool *tool,
-				    struct perf_mmap *map,
+				    struct mmap *map,
 				    union perf_event *event, void *data1,
 				    size_t len1, void *data2, size_t len2)
 {
@@ -565,7 +565,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 }
 
 static int record__auxtrace_mmap_read(struct record *rec,
-				      struct perf_mmap *map)
+				      struct mmap *map)
 {
 	int ret;
 
@@ -581,7 +581,7 @@ static int record__auxtrace_mmap_read(struct record *rec,
 }
 
 static int record__auxtrace_mmap_read_snapshot(struct record *rec,
-					       struct perf_mmap *map)
+					       struct mmap *map)
 {
 	int ret;
 
@@ -603,7 +603,7 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
 	int rc = 0;
 
 	for (i = 0; i < rec->evlist->nr_mmaps; i++) {
-		struct perf_mmap *map = &rec->evlist->mmap[i];
+		struct mmap *map = &rec->evlist->mmap[i];
 
 		if (!map->auxtrace_mmap.base)
 			continue;
@@ -668,7 +668,7 @@ static int record__auxtrace_init(struct record *rec)
 
 static inline
 int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
-			       struct perf_mmap *map __maybe_unused)
+			       struct mmap *map __maybe_unused)
 {
 	return 0;
 }
@@ -901,7 +901,7 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
-static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
+static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
 	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
@@ -948,7 +948,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	u64 bytes_written = rec->bytes_written;
 	int i;
 	int rc = 0;
-	struct perf_mmap *maps;
+	struct mmap *maps;
 	int trace_fd = rec->data.file.fd;
 	off_t off = 0;
 
@@ -967,7 +967,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		u64 flush = 0;
-		struct perf_mmap *map = &maps[i];
+		struct mmap *map = &maps[i];
 
 		if (map->base) {
 			record__adjust_affinity(rec, map);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8da3c939e6b0..834a927107c4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -863,7 +863,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
 	struct record_opts *opts = &top->record_opts;
 	struct evlist *evlist = top->evlist;
-	struct perf_mmap *md;
+	struct mmap *md;
 	union perf_event *event;
 
 	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a292658b4232..2f853870d68d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3444,7 +3444,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
-		struct perf_mmap *md;
+		struct mmap *md;
 
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index a637a4a90760..0a046096e6f4 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -33,7 +33,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 	int i;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		struct perf_mmap *map = &evlist->overwrite_mmap[i];
+		struct mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
 
 		perf_mmap__read_init(map);
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index fc102e4f403e..cf9776aceb82 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -180,7 +180,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
-		struct perf_mmap *md;
+		struct mmap *md;
 
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index fd02c1f1d976..df96cbb9ffe5 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -419,7 +419,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 			  struct state *state)
 {
 	union perf_event *event;
-	struct perf_mmap *md;
+	struct mmap *md;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index df0fd5a44e04..67a87f507bbd 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -31,7 +31,7 @@
 static int find_comm(struct evlist *evlist, const char *comm)
 {
 	union perf_event *event;
-	struct perf_mmap *md;
+	struct mmap *md;
 	int i, found;
 
 	found = 0;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 042757629e90..accca3d78fa3 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -42,7 +42,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		     expected_nr_events[nsyscalls], i, j;
 	struct evsel *evsels[nsyscalls], *evsel;
 	char sbuf[STRERR_BUFSIZE];
-	struct perf_mmap *md;
+	struct mmap *md;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	if (threads == NULL) {
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index b71167b43dda..e5ef74d4e925 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -88,7 +88,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
-			struct perf_mmap *md;
+			struct mmap *md;
 
 			md = &evlist->mmap[i];
 			if (perf_mmap__read_init(md) < 0)
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index e1b42292cf7f..49d2d4c5956d 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -166,7 +166,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
-			struct perf_mmap *md;
+			struct mmap *md;
 
 			md = &evlist->mmap[i];
 			if (perf_mmap__read_init(md) < 0)
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 97694a040986..7abe0b6aabb7 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -42,7 +42,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	};
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
-	struct perf_mmap *md;
+	struct mmap *md;
 
 	attr.sample_freq = 500;
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 3fb1ff7b8a2f..e7888ddd69a3 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -263,7 +263,7 @@ static int process_events(struct evlist *evlist,
 	unsigned pos, cnt = 0;
 	LIST_HEAD(events);
 	struct event_node *events_array, *node;
-	struct perf_mmap *md;
+	struct mmap *md;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 088c7708b03a..cff99707cc9d 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -51,7 +51,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	char sbuf[STRERR_BUFSIZE];
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
-	struct perf_mmap *md;
+	struct mmap *md;
 
 	signal(SIGCHLD, sig_handler);
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0e8c89cf7cad..1d22ffd972ac 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1228,7 +1228,7 @@ int perf_event__process_auxtrace_error(struct perf_session *session,
 	return 0;
 }
 
-static int __auxtrace_mmap__read(struct perf_mmap *map,
+static int __auxtrace_mmap__read(struct mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 bool snapshot, size_t snapshot_size)
@@ -1339,13 +1339,13 @@ static int __auxtrace_mmap__read(struct perf_mmap *map,
 	return 1;
 }
 
-int auxtrace_mmap__read(struct perf_mmap *map, struct auxtrace_record *itr,
+int auxtrace_mmap__read(struct mmap *map, struct auxtrace_record *itr,
 			struct perf_tool *tool, process_auxtrace_t fn)
 {
 	return __auxtrace_mmap__read(map, itr, tool, fn, false, 0);
 }
 
-int auxtrace_mmap__read_snapshot(struct perf_mmap *map,
+int auxtrace_mmap__read_snapshot(struct mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b110aec1da4d..f201f36bc35f 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -22,7 +22,7 @@ union perf_event;
 struct perf_session;
 struct evlist;
 struct perf_tool;
-struct perf_mmap;
+struct mmap;
 struct perf_sample;
 struct option;
 struct record_opts;
@@ -445,14 +445,14 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   bool per_cpu);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
-				  struct perf_mmap *map,
+				  struct mmap *map,
 				  union perf_event *event, void *data1,
 				  size_t len1, void *data2, size_t len2);
 
-int auxtrace_mmap__read(struct perf_mmap *map, struct auxtrace_record *itr,
+int auxtrace_mmap__read(struct mmap *map, struct auxtrace_record *itr,
 			struct perf_tool *tool, process_auxtrace_t fn);
 
-int auxtrace_mmap__read_snapshot(struct perf_mmap *map,
+int auxtrace_mmap__read_snapshot(struct mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ea9517d506d8..ceab9fb7f7f9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -423,7 +423,7 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 }
 
 static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
-				     struct perf_mmap *map, short revent)
+				     struct mmap *map, short revent)
 {
 	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
 	/*
@@ -447,7 +447,7 @@ int perf_evlist__add_pollfd(struct evlist *evlist, int fd)
 static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 					 void *arg __maybe_unused)
 {
-	struct perf_mmap *map = fda->priv[fd].ptr;
+	struct mmap *map = fda->priv[fd].ptr;
 
 	if (map)
 		perf_mmap__put(map);
@@ -693,16 +693,16 @@ void perf_evlist__munmap(struct evlist *evlist)
 	zfree(&evlist->overwrite_mmap);
 }
 
-static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
+static struct mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
 						 bool overwrite)
 {
 	int i;
-	struct perf_mmap *map;
+	struct mmap *map;
 
 	evlist->nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
 	if (perf_cpu_map__empty(evlist->core.cpus))
 		evlist->nr_mmaps = perf_thread_map__nr(evlist->core.threads);
-	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
+	map = zalloc(evlist->nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
 
@@ -741,7 +741,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 	int evlist_cpu = cpu_map__cpu(evlist->core.cpus, cpu_idx);
 
 	evlist__for_each_entry(evlist, evsel) {
-		struct perf_mmap *maps = evlist->mmap;
+		struct mmap *maps = evlist->mmap;
 		int *output = _output;
 		int fd;
 		int cpu;
@@ -1847,7 +1847,7 @@ static void *perf_evlist__poll_thread(void *arg)
 			perf_evlist__poll(evlist, 1000);
 
 		for (i = 0; i < evlist->nr_mmaps; i++) {
-			struct perf_mmap *map = &evlist->mmap[i];
+			struct mmap *map = &evlist->mmap[i];
 			union perf_event *event;
 
 			if (perf_mmap__read_init(map))
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a55f0f2546e5..129786361572 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -39,8 +39,8 @@ struct evlist {
 		pid_t	pid;
 	} workload;
 	struct fdarray	 pollfd;
-	struct perf_mmap *mmap;
-	struct perf_mmap *overwrite_mmap;
+	struct mmap *mmap;
+	struct mmap *overwrite_mmap;
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 33c5b5495482..f3b7c8b0fa90 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -22,13 +22,13 @@
 #include "../perf.h"
 #include "util.h" /* page_size */
 
-size_t perf_mmap__mmap_len(struct perf_mmap *map)
+size_t perf_mmap__mmap_len(struct mmap *map)
 {
 	return map->mask + 1 + page_size;
 }
 
 /* When check_messup is true, 'end' must points to a good entry */
-static union perf_event *perf_mmap__read(struct perf_mmap *map,
+static union perf_event *perf_mmap__read(struct mmap *map,
 					 u64 *startp, u64 end)
 {
 	unsigned char *data = map->base + page_size;
@@ -82,7 +82,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * }
  * perf_mmap__read_done()
  */
-union perf_event *perf_mmap__read_event(struct perf_mmap *map)
+union perf_event *perf_mmap__read_event(struct mmap *map)
 {
 	union perf_event *event;
 
@@ -104,17 +104,17 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 	return event;
 }
 
-static bool perf_mmap__empty(struct perf_mmap *map)
+static bool perf_mmap__empty(struct mmap *map)
 {
 	return perf_mmap__read_head(map) == map->prev && !map->auxtrace_mmap.base;
 }
 
-void perf_mmap__get(struct perf_mmap *map)
+void perf_mmap__get(struct mmap *map)
 {
 	refcount_inc(&map->refcnt);
 }
 
-void perf_mmap__put(struct perf_mmap *map)
+void perf_mmap__put(struct mmap *map)
 {
 	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
 
@@ -122,7 +122,7 @@ void perf_mmap__put(struct perf_mmap *map)
 		perf_mmap__munmap(map);
 }
 
-void perf_mmap__consume(struct perf_mmap *map)
+void perf_mmap__consume(struct mmap *map)
 {
 	if (!map->overwrite) {
 		u64 old = map->prev;
@@ -161,13 +161,13 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 }
 
 #ifdef HAVE_AIO_SUPPORT
-static int perf_mmap__aio_enabled(struct perf_mmap *map)
+static int perf_mmap__aio_enabled(struct mmap *map)
 {
 	return map->aio.nr_cblocks > 0;
 }
 
 #ifdef HAVE_LIBNUMA_SUPPORT
-static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
+static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
 	map->aio.data[idx] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
@@ -179,7 +179,7 @@ static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
 	return 0;
 }
 
-static void perf_mmap__aio_free(struct perf_mmap *map, int idx)
+static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
 	if (map->aio.data[idx]) {
 		munmap(map->aio.data[idx], perf_mmap__mmap_len(map));
@@ -187,7 +187,7 @@ static void perf_mmap__aio_free(struct perf_mmap *map, int idx)
 	}
 }
 
-static int perf_mmap__aio_bind(struct perf_mmap *map, int idx, int cpu, int affinity)
+static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 {
 	void *data;
 	size_t mmap_len;
@@ -207,7 +207,7 @@ static int perf_mmap__aio_bind(struct perf_mmap *map, int idx, int cpu, int affi
 	return 0;
 }
 #else /* !HAVE_LIBNUMA_SUPPORT */
-static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
+static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
 	map->aio.data[idx] = malloc(perf_mmap__mmap_len(map));
 	if (map->aio.data[idx] == NULL)
@@ -216,19 +216,19 @@ static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
 	return 0;
 }
 
-static void perf_mmap__aio_free(struct perf_mmap *map, int idx)
+static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
 	zfree(&(map->aio.data[idx]));
 }
 
-static int perf_mmap__aio_bind(struct perf_mmap *map __maybe_unused, int idx __maybe_unused,
+static int perf_mmap__aio_bind(struct mmap *map __maybe_unused, int idx __maybe_unused,
 		int cpu __maybe_unused, int affinity __maybe_unused)
 {
 	return 0;
 }
 #endif
 
-static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
+static int perf_mmap__aio_mmap(struct mmap *map, struct mmap_params *mp)
 {
 	int delta_max, i, prio, ret;
 
@@ -282,7 +282,7 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 	return 0;
 }
 
-static void perf_mmap__aio_munmap(struct perf_mmap *map)
+static void perf_mmap__aio_munmap(struct mmap *map)
 {
 	int i;
 
@@ -294,23 +294,23 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	zfree(&map->aio.aiocb);
 }
 #else /* !HAVE_AIO_SUPPORT */
-static int perf_mmap__aio_enabled(struct perf_mmap *map __maybe_unused)
+static int perf_mmap__aio_enabled(struct mmap *map __maybe_unused)
 {
 	return 0;
 }
 
-static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
+static int perf_mmap__aio_mmap(struct mmap *map __maybe_unused,
 			       struct mmap_params *mp __maybe_unused)
 {
 	return 0;
 }
 
-static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
+static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 {
 }
 #endif
 
-void perf_mmap__munmap(struct perf_mmap *map)
+void perf_mmap__munmap(struct mmap *map)
 {
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
@@ -343,7 +343,7 @@ static void build_node_mask(int node, cpu_set_t *mask)
 	}
 }
 
-static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_params *mp)
+static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
 	CPU_ZERO(&map->affinity_mask);
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
@@ -352,7 +352,7 @@ static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_pa
 		CPU_SET(map->cpu, &map->affinity_mask);
 }
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
+int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -440,7 +440,7 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
 /*
  * Report the start and end of the available data in ringbuffer
  */
-static int __perf_mmap__read_init(struct perf_mmap *md)
+static int __perf_mmap__read_init(struct mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
@@ -474,7 +474,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
 	return 0;
 }
 
-int perf_mmap__read_init(struct perf_mmap *map)
+int perf_mmap__read_init(struct mmap *map)
 {
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -485,8 +485,8 @@ int perf_mmap__read_init(struct perf_mmap *map)
 	return __perf_mmap__read_init(map);
 }
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
+int perf_mmap__push(struct mmap *md, void *to,
+		    int push(struct mmap *map, void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
@@ -532,7 +532,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
  * The last perf_mmap__read() will set tail to map->prev.
  * Need to correct the map->prev to head which is the end of next read.
  */
-void perf_mmap__read_done(struct perf_mmap *map)
+void perf_mmap__read_done(struct mmap *map)
 {
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 3857a49e8f96..01524608a984 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,11 +15,11 @@
 
 struct aiocb;
 /**
- * struct perf_mmap - perf's ring buffer mmap details
+ * struct mmap - perf's ring buffer mmap details
  *
  * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
  */
-struct perf_mmap {
+struct mmap {
 	void		 *base;
 	int		 mask;
 	int		 fd;
@@ -78,33 +78,33 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
-void perf_mmap__munmap(struct perf_mmap *map);
+int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
+void perf_mmap__munmap(struct mmap *map);
 
-void perf_mmap__get(struct perf_mmap *map);
-void perf_mmap__put(struct perf_mmap *map);
+void perf_mmap__get(struct mmap *map);
+void perf_mmap__put(struct mmap *map);
 
-void perf_mmap__consume(struct perf_mmap *map);
+void perf_mmap__consume(struct mmap *map);
 
-static inline u64 perf_mmap__read_head(struct perf_mmap *mm)
+static inline u64 perf_mmap__read_head(struct mmap *mm)
 {
 	return ring_buffer_read_head(mm->base);
 }
 
-static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
+static inline void perf_mmap__write_tail(struct mmap *md, u64 tail)
 {
 	ring_buffer_write_tail(md->base, tail);
 }
 
-union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
+union perf_event *perf_mmap__read_forward(struct mmap *map);
 
-union perf_event *perf_mmap__read_event(struct perf_mmap *map);
+union perf_event *perf_mmap__read_event(struct mmap *map);
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
+int perf_mmap__push(struct mmap *md, void *to,
+		    int push(struct mmap *map, void *to, void *buf, size_t size));
 
-size_t perf_mmap__mmap_len(struct perf_mmap *map);
+size_t perf_mmap__mmap_len(struct mmap *map);
 
-int perf_mmap__read_init(struct perf_mmap *md);
-void perf_mmap__read_done(struct perf_mmap *map);
+int perf_mmap__read_init(struct mmap *md);
+void perf_mmap__read_done(struct mmap *map);
 #endif /*__PERF_MMAP_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0ba19dd75510..1e1247cffea8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -984,12 +984,12 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	return Py_BuildValue("i", evlist->core.nr_entries);
 }
 
-static struct perf_mmap *get_md(struct evlist *evlist, int cpu)
+static struct mmap *get_md(struct evlist *evlist, int cpu)
 {
 	int i;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		struct perf_mmap *md = &evlist->mmap[i];
+		struct mmap *md = &evlist->mmap[i];
 
 		if (md->cpu == cpu)
 			return md;
@@ -1005,7 +1005,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	union perf_event *event;
 	int sample_id_all = 1, cpu;
 	static char *kwlist[] = { "cpu", "sample_id_all", NULL };
-	struct perf_mmap *md;
+	struct mmap *md;
 	int err;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist,
-- 
2.21.0

