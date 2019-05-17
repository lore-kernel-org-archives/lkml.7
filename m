Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5968C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1821744
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122007;
	bh=lEGa3vLkwFAB0B5UeDAzabpDDSVZGL7EFb7KExn2xOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhbAG1VWH4Wc9FnBwyQGYPIKZJXPyS5ET4GaNBdtktnuVLkWzz+8QJ/ffra3B92jZ
	 r+0nMmTvbDUc1Y49A+J/rR+9HjKYZUxHDd9EmyY4wzg9S9P6ed7D+dbWLOPQDbXjg+
	 MRUV14N4dO8Nrj6irpsDmQhnijRlmysOekMkJ6S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfEQTkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfEQTkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:02 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87EB82087B;
        Fri, 17 May 2019 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122002;
        bh=lEGa3vLkwFAB0B5UeDAzabpDDSVZGL7EFb7KExn2xOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMj54IXSDrsRXybYU7J5UQU2cU2mRZB6MSQnLz3PrMvr8duB5VX7a5F9hrwrDodTw
         6gWnuQZwGCUbpJqGueLb51ZWMVkErFEfp/828TOxZDrCze65aDP/ESDwEhz7iUU4VY
         kyGyLIoWhmkayNqbk6MGuTIBplhyvC8WUHN8E7xQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 50/73] perf mmap: Implement dedicated memory buffer for data compression
Date:   Fri, 17 May 2019 16:35:48 -0300
Message-Id: <20190517193611.4974-51-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Implemented mmap data buffer that is used as the memory to operate
on when compressing data in case of serial trace streaming.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/49b31321-0f70-392b-9a4f-649d3affe090@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  8 +++++++-
 tools/perf/util/evlist.c    |  8 +++++---
 tools/perf/util/evlist.h    |  2 +-
 tools/perf/util/mmap.c      | 30 ++++++++++++++++++++++++++++--
 tools/perf/util/mmap.h      |  4 +++-
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 45a80b3584ad..ca6d7488e34b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -372,6 +372,8 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+static unsigned int comp_level_max = 22;
+
 static int record__comp_enabled(struct record *rec)
 {
 	return rec->opts.comp_level > 0;
@@ -587,7 +589,7 @@ static int record__mmap_evlist(struct record *rec,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
 				 opts->nr_cblocks, opts->affinity,
-				 opts->mmap_flush) < 0) {
+				 opts->mmap_flush, opts->comp_level) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -2298,6 +2300,10 @@ int cmd_record(int argc, const char **argv)
 	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
 	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
 
+	if (rec->opts.comp_level > comp_level_max)
+		rec->opts.comp_level = comp_level_max;
+	pr_debug("comp level: %d\n", rec->opts.comp_level);
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4b6783ff5813..69d0fa8ab16f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1009,7 +1009,8 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush,
+			 int comp_level)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1019,7 +1020,8 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush,
+				  .comp_level = comp_level };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1051,7 +1053,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1, 0);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c9a0f72677fd..49354fe24d5f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -178,7 +178,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite, int nr_cblocks,
-			 int affinity, int flush);
+			 int affinity, int flush, int comp_level);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ef3d79b2c90b..d85e73fc82e2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -157,6 +157,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 }
 
 #ifdef HAVE_AIO_SUPPORT
+static int perf_mmap__aio_enabled(struct perf_mmap *map)
+{
+	return map->aio.nr_cblocks > 0;
+}
 
 #ifdef HAVE_LIBNUMA_SUPPORT
 static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
@@ -198,7 +202,7 @@ static int perf_mmap__aio_bind(struct perf_mmap *map, int idx, int cpu, int affi
 
 	return 0;
 }
-#else
+#else /* !HAVE_LIBNUMA_SUPPORT */
 static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
 {
 	map->aio.data[idx] = malloc(perf_mmap__mmap_len(map));
@@ -359,7 +363,12 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 
 	return rc;
 }
-#else
+#else /* !HAVE_AIO_SUPPORT */
+static int perf_mmap__aio_enabled(struct perf_mmap *map __maybe_unused)
+{
+	return 0;
+}
+
 static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
 			       struct mmap_params *mp __maybe_unused)
 {
@@ -374,6 +383,10 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
 void perf_mmap__munmap(struct perf_mmap *map)
 {
 	perf_mmap__aio_munmap(map);
+	if (map->data != NULL) {
+		munmap(map->data, perf_mmap__mmap_len(map));
+		map->data = NULL;
+	}
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -442,6 +455,19 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 
 	map->flush = mp->flush;
 
+	map->comp_level = mp->comp_level;
+
+	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
+		map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+				 MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+		if (map->data == MAP_FAILED) {
+			pr_debug2("failed to mmap data buffer, error %d\n",
+					errno);
+			map->data = NULL;
+			return -1;
+		}
+	}
+
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index b82f8c2d55c4..4e2f58d95c1f 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -40,6 +40,8 @@ struct perf_mmap {
 #endif
 	cpu_set_t	affinity_mask;
 	u64		flush;
+	void		*data;
+	int		comp_level;
 };
 
 /*
@@ -71,7 +73,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks, affinity, flush;
+	int prot, mask, nr_cblocks, affinity, flush, comp_level;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.20.1

