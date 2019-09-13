Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DCFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE026206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381095;
	bh=8Ayn712BnbbyP5PsiiWB8TPZ8WCWN6clTcV3WlGco98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v3+L7pafjVrgSUde8Kqz+TDbwP3edcBXr2smhvl09SvNBK5xHuIZSExlrzBlojWFg
	 tVgtmGVIk/kP2JToJ5lM33Hak1/fYCYRyB8tmtuiEVbYD6v2vAK9j4UABdkOzhs2BT
	 KlFj58pL3De9g76Fa07aJhmiO2pU1/Gw/9/d5BF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391254AbfIMNYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391219AbfIMNYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10E307BDA1;
        Fri, 13 Sep 2019 13:24:49 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF575C1D4;
        Fri, 13 Sep 2019 13:24:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 20/73] libperf: Move nr_mmaps from struct evlist to struct perf_evlist
Date:   Fri, 13 Sep 2019 15:23:02 +0200
Message-Id: <20190913132355.21634-21-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 13 Sep 2019 13:24:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving nr_mmaps from struct evlist to struct perf_evlist,
it will be used in following patches.

Link: http://lkml.kernel.org/n/tip-g6auuaej31nsusuevuhcgxli@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c            |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c         |  2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  2 +-
 tools/perf/arch/x86/util/intel-pt.c          |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-record.c                  |  6 +++---
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/internal/evlist.h     |  1 +
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  2 +-
 tools/perf/tests/code-reading.c              |  2 +-
 tools/perf/tests/keep-tracking.c             |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/switch-tracking.c           |  2 +-
 tools/perf/util/evlist.c                     | 16 ++++++++--------
 tools/perf/util/evlist.h                     |  1 -
 tools/perf/util/python.c                     |  2 +-
 20 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c32db09baf0d..6407edf72edd 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -648,7 +648,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	if (priv_size != cs_etm_info_priv_size(itr, session->evlist))
 		return -EINVAL;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	/* If the cpu_map is empty all online CPUs are involved */
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4b364692da67..2fcabddd87b5 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -51,7 +51,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 42725e6882e9..185bdbf8cb9d 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -115,7 +115,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	evlist__disable(evlist);
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index aa13df948049..5dd42e6d22f9 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -74,7 +74,7 @@ static int intel_bts_info_fill(struct auxtrace_record *itr,
 	if (priv_size != INTEL_BTS_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	pc = session->evlist->mmap[0].core.base;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1ae050c4045b..42f111323c31 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -351,7 +351,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	filter = intel_pt_find_filter(session->evlist, ptr->intel_pt_pmu);
 	filter_str_len = filter ? strlen(filter) : 0;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	pc = session->evlist->mmap[0].core.base;
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index da16349f2808..2b8e71d0a722 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -799,7 +799,7 @@ static int perf_kvm__mmap_read(struct perf_kvm_stat *kvm)
 	s64 n, ntotal = 0;
 	u64 flush_time = ULLONG_MAX, mmap_time;
 
-	for (i = 0; i < kvm->evlist->nr_mmaps; i++) {
+	for (i = 0; i < kvm->evlist->core.nr_mmaps; i++) {
 		n = perf_kvm__mmap_read_idx(kvm, i, &mmap_time);
 		if (n < 0)
 			return -1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 400ce2f3fa99..6e9f5619f062 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -354,7 +354,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	if (!record__aio_enabled(rec))
 		return;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *map = &maps[i];
 
 		if (map->core.base)
@@ -600,7 +600,7 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
 	int i;
 	int rc = 0;
 
-	for (i = 0; i < rec->evlist->nr_mmaps; i++) {
+	for (i = 0; i < rec->evlist->core.nr_mmaps; i++) {
 		struct mmap *map = &rec->evlist->mmap[i];
 
 		if (!map->auxtrace_mmap.base)
@@ -952,7 +952,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		u64 flush = 0;
 		struct mmap *map = &maps[i];
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9adc91d06e16..5698234cef88 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -901,7 +901,7 @@ static void perf_top__mmap_read(struct perf_top *top)
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
-	for (i = 0; i < top->evlist->nr_mmaps; i++)
+	for (i = 0; i < top->evlist->core.nr_mmaps; i++)
 		perf_top__mmap_read_idx(top, i);
 
 	if (overwrite) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c2e842a6467b..6e9797d85d54 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3441,7 +3441,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 again:
 	before = trace->nr_events;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		union perf_event *event;
 		struct mmap *md;
 
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 448891f06e3e..035c1e1cc324 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -13,6 +13,7 @@ struct perf_evlist {
 	bool			 has_user_cpus;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map	*threads;
+	int			 nr_mmaps;
 };
 
 /**
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 3073a68d17b9..3297d2eb67fc 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -32,7 +32,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 {
 	int i;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 964731915498..20cacf1e980b 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -178,7 +178,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	(*func)();
 	evlist__disable(evlist);
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		union perf_event *event;
 		struct mmap *md;
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 2c2400d93813..72ae94be686e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -422,7 +422,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 	struct mmap *md;
 	int i, ret;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index ba77eaa215b3..ac44d72e39c3 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -36,7 +36,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
 	int i, found;
 
 	found = 0;
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 5c2576174ae9..abf4d4f5e429 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -86,7 +86,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 	while (1) {
 		int before = nr_events;
 
-		for (i = 0; i < evlist->nr_mmaps; i++) {
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			union perf_event *event;
 			struct mmap *md;
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 669fd88e7f30..dbecc66712af 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -164,7 +164,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	while (1) {
 		int before = total_events;
 
-		for (i = 0; i < evlist->nr_mmaps; i++) {
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			union perf_event *event;
 			struct mmap *md;
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 01bfb087ce22..115eae0f45f1 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -267,7 +267,7 @@ static int process_events(struct evlist *evlist,
 	struct mmap *md;
 	int i, ret;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0ffa1e9b6243..891052570e73 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -650,7 +650,7 @@ static int perf_evlist__set_paused(struct evlist *evlist, bool value)
 	if (!evlist->overwrite_mmap)
 		return 0;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		int fd = evlist->overwrite_mmap[i].core.fd;
 		int err;
 
@@ -678,11 +678,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 	int i;
 
 	if (evlist->mmap)
-		for (i = 0; i < evlist->nr_mmaps; i++)
+		for (i = 0; i < evlist->core.nr_mmaps; i++)
 			perf_mmap__munmap(&evlist->mmap[i]);
 
 	if (evlist->overwrite_mmap)
-		for (i = 0; i < evlist->nr_mmaps; i++)
+		for (i = 0; i < evlist->core.nr_mmaps; i++)
 			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
@@ -699,14 +699,14 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct mmap *map;
 
-	evlist->nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
+	evlist->core.nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
 	if (perf_cpu_map__empty(evlist->core.cpus))
-		evlist->nr_mmaps = perf_thread_map__nr(evlist->core.threads);
-	map = zalloc(evlist->nr_mmaps * sizeof(struct mmap));
+		evlist->core.nr_mmaps = perf_thread_map__nr(evlist->core.threads);
+	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		map[i].core.fd = -1;
 		map[i].core.overwrite = overwrite;
 		/*
@@ -1846,7 +1846,7 @@ static void *perf_evlist__poll_thread(void *arg)
 		if (!draining)
 			perf_evlist__poll(evlist, 1000);
 
-		for (i = 0; i < evlist->nr_mmaps; i++) {
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			struct mmap *map = &evlist->mmap[i];
 			union perf_event *event;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b33c5d67410a..4c465b4aced8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -27,7 +27,6 @@ struct evlist {
 	struct perf_evlist core;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
-	int		 nr_mmaps;
 	bool		 enabled;
 	size_t		 mmap_len;
 	int		 id_pos;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 96100ed73dbe..b71b899407df 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -988,7 +988,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 {
 	int i;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
 		if (md->core.cpu == cpu)
-- 
2.21.0

