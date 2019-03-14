Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39846C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B7A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCNLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:31:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:6144 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCNLbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:31:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 04:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="307161204"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Mar 2019 04:31:54 -0700
Received: from [10.125.252.108] (abudanko-mobl.ccr.corp.intel.com [10.125.252.108])
        by linux.intel.com (Postfix) with ESMTP id CFC6158046D;
        Thu, 14 Mar 2019 04:31:52 -0700 (PDT)
Subject: [PATCH v8 05/12] perf mmap: implement dedicated memory buffer for
 data compression
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5c893bf7-3fec-d83c-bb85-506175dbe9ba@linux.intel.com>
Date:   Thu, 14 Mar 2019 14:31:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented mmap data buffer that is used as the memory to operate
on when compressing data in case of serial trace streaming.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c |  8 +++++++-
 tools/perf/util/evlist.c    |  8 +++++---
 tools/perf/util/evlist.h    |  2 +-
 tools/perf/util/mmap.c      | 30 ++++++++++++++++++++++++++++--
 tools/perf/util/mmap.h      |  4 +++-
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5bba860d5376..e2d9347c08b3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -369,6 +369,8 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+static unsigned int comp_level_max = 22;
+
 static int record__comp_enabled(struct record *rec)
 {
 	return rec->opts.comp_level > 0;
@@ -584,7 +586,7 @@ static int record__mmap_evlist(struct record *rec,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
 				 opts->nr_cblocks, opts->affinity,
-				 opts->mmap_flush) < 0) {
+				 opts->mmap_flush, opts->comp_level) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -2258,6 +2260,10 @@ int cmd_record(int argc, const char **argv)
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
index 8858d829983b..4d8a25a12430 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1037,7 +1037,8 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush,
+			 int comp_level)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1047,7 +1048,8 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush,
+				  .comp_level = comp_level };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1079,7 +1081,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1, 0);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index edf18811e39f..77c11dac4a63 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -166,7 +166,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
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
index b82f8c2d55c4..a02427d609c0 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -40,6 +40,8 @@ struct perf_mmap {
 #endif
 	cpu_set_t	affinity_mask;
 	u64		flush;
+	void 		*data;
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

