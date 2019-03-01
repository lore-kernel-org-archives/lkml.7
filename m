Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E402EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfCAPlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:41:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:35443 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfCAPls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:41:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 07:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="121851286"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2019 07:41:48 -0800
Received: from [10.252.14.197] (abudanko-mobl.ccr.corp.intel.com [10.252.14.197])
        by linux.intel.com (Postfix) with ESMTP id 64514580487;
        Fri,  1 Mar 2019 07:41:45 -0800 (PST)
Subject: [PATCH v5 02/10] perf record: implement -f,--mmap-flush=<threshold>
 option
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
Date:   Fri, 1 Mar 2019 18:41:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented -f,--mmap-flush option that specifies minimal size of data
chunk that is extracted from mmaped kernel buffer to store into a trace.

  $ tools/perf/perf record -f 1024 -e cycles -- matrix.gcc
  $ tools/perf/perf record --aio -f 1024 -e cycles -- matrix.gcc

Option can serve two purposes the first one is to increase the compression
ratio of a trace data and the second one is to avoid live-lock-like self 
monitoring in system wide (-a) profiling mode.

The default option value is 1 byte what means that every time trace
writing thread finds some new data in the mmaped buffer the data is
extracted, possibly compressed and written to a trace. Larger data chunks
are compressed more effectively in comparison to smaller chunks so
extraction of larger chunks from the kernel buffer is preferable from
perspective of trace size reduction. So the implemented option allows 
specifying minimal data chunk size that is more than 1 byte to influence 
data compression ratio. Also at some cases executing more write syscalls 
with smaller data size can take longer than executing less write syscalls 
with bigger data size due to syscall overhead so extracting bigger data 
chunks specified by the option value could additionally decrease runtime 
overhead.

Profiling in system wide mode with compression (-a -z) can additionally 
induce data into the kernel buffers along with the data from monitored 
processes. If performance data rate and volume from the monitored processes 
is high then trace streaming and compression activity in the tool is also 
high and it can lead to subtle live-lock effect of endless activity when 
compression of single new byte from some of mmaped kernel buffer leads to 
eneration of the next single byte at some mmaped buffer so perf tool trace 
writing thread never stops on polling event file descriptors.

Implemented sync param is the mean to force data move independently from
the threshold value. Despite the provided flush value from the command
line, the tool needs capability to drain memory buffers, at least in the
end of the collection.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 13 ++++++
 tools/perf/builtin-record.c              | 53 +++++++++++++++++++++---
 tools/perf/perf.h                        |  1 +
 tools/perf/util/evlist.c                 |  6 +--
 tools/perf/util/evlist.h                 |  3 +-
 tools/perf/util/mmap.c                   |  4 +-
 tools/perf/util/mmap.h                   |  3 +-
 7 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8f0c2be34848..9fa33ce9bc00 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -459,6 +459,19 @@ Set affinity mask of trace reading thread according to the policy defined by 'mo
   node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
   cpu  - thread affinity mask is set to cpu of the processed mmap buffer
 
+-f::
+--mmap-flush=n::
+Specify minimal number of bytes that is extracted from mmap data pages and stored
+into a trace. Maximal allowed value is a quarter of the size of mmaped data pages.
+The default option value is 1 what means that every time trace writing thread finds
+some new data in the mmaped buffer the data is extracted, possibly compressed (-z)
+and written to a trace. Larger data chunks are compressed more effectively in
+comparison to smaller chunks so extraction of larger chunks from the mmap data pages
+is preferable from perspective of trace size reduction. Also at some cases
+executing less trace write syscalls with bigger data size can take shorter than
+executing more trace write syscalls with smaller data size thus lowering runtime
+profiling overhead.
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f3f7f3100336..9b02a68e8c23 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -334,6 +334,29 @@ static int record__aio_enabled(struct record *rec)
 	return rec->opts.nr_cblocks > 0;
 }
 
+#define MMAP_FLUSH_DEFAULT 1
+static int record__mmap_flush_parse(const struct option *opt,
+				    const char *str,
+				    int unset)
+{
+	int mmap_len;
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset)
+		return 0;
+
+	if (str)
+		opts->mmap_flush = strtol(str, NULL, 0);
+	if (!opts->mmap_flush)
+		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
+
+	mmap_len = perf_evlist__mmap_size(opts->mmap_pages);
+	if (opts->mmap_flush > mmap_len / 4)
+		opts->mmap_flush = mmap_len / 4;
+
+	return 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -543,7 +566,8 @@ static int record__mmap_evlist(struct record *rec,
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
-				 opts->nr_cblocks, opts->affinity) < 0) {
+				 opts->nr_cblocks, opts->affinity,
+				 opts->mmap_flush) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -733,7 +757,7 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 }
 
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
-				    bool overwrite)
+				    bool overwrite, bool sync)
 {
 	u64 bytes_written = rec->bytes_written;
 	int i;
@@ -756,12 +780,19 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		off = record__aio_get_pos(trace_fd);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		u64 flush = MMAP_FLUSH_DEFAULT;
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
 			record__adjust_affinity(rec, map);
+			if (sync) {
+				flush = map->flush;
+				map->flush = MMAP_FLUSH_DEFAULT;
+			}
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+					if (sync)
+						map->flush = flush;
 					rc = -1;
 					goto out;
 				}
@@ -774,10 +805,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				idx = record__aio_sync(map, false);
 				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
 					record__aio_set_pos(trace_fd, off);
+					if (sync)
+						map->flush = flush;
 					rc = -1;
 					goto out;
 				}
 			}
+			if (sync)
+				map->flush = flush;
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
@@ -803,15 +838,15 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	return rc;
 }
 
-static int record__mmap_read_all(struct record *rec)
+static int record__mmap_read_all(struct record *rec, bool sync)
 {
 	int err;
 
-	err = record__mmap_read_evlist(rec, rec->evlist, false);
+	err = record__mmap_read_evlist(rec, rec->evlist, false, sync);
 	if (err)
 		return err;
 
-	return record__mmap_read_evlist(rec, rec->evlist, true);
+	return record__mmap_read_evlist(rec, rec->evlist, true, sync);
 }
 
 static void record__init_features(struct record *rec)
@@ -1310,7 +1345,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (trigger_is_hit(&switch_output_trigger) || done || draining)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
-		if (record__mmap_read_all(rec) < 0) {
+		if (record__mmap_read_all(rec, false) < 0) {
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1411,6 +1446,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
 	if (forks) {
@@ -1813,6 +1849,7 @@ static struct record record = {
 			.uses_mmap   = true,
 			.default_per_cpu = true,
 		},
+		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1879,6 +1916,9 @@ static struct option __record_options[] = {
 	OPT_CALLBACK('m', "mmap-pages", &record.opts, "pages[,pages]",
 		     "number of mmap data pages and AUX area tracing mmap pages",
 		     record__parse_mmap_pages),
+	OPT_CALLBACK('f', "mmap-flush", &record.opts, "bytes",
+		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
+		     record__mmap_flush_parse),
 	OPT_BOOLEAN(0, "group", &record.opts.group,
 		    "put the counters into a counter group"),
 	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
@@ -2182,6 +2222,7 @@ int cmd_record(int argc, const char **argv)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
 	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
+	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
 
 	err = __cmd_record(&record, argc, argv);
 out:
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index b120e547ddc7..7886cc9771cf 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -85,6 +85,7 @@ struct record_opts {
 	u64          clockid_res_ns;
 	int	     nr_cblocks;
 	int	     affinity;
+	int	     mmap_flush;
 };
 
 enum perf_affinity {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..937039faac59 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1022,7 +1022,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1032,7 +1032,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1064,7 +1064,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 744906dd4887..edf18811e39f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -165,7 +165,8 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity);
+			 bool auxtrace_overwrite, int nr_cblocks,
+			 int affinity, int flush);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index cdc7740fc181..ef3d79b2c90b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -440,6 +440,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 
 	perf_mmap__setup_affinity_mask(map, mp);
 
+	map->flush = mp->flush;
+
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
@@ -492,7 +494,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
 	md->start = md->overwrite ? head : old;
 	md->end = md->overwrite ? old : head;
 
-	if (md->start == md->end)
+	if ((md->end - md->start) < md->flush)
 		return -EAGAIN;
 
 	size = md->end - md->start;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e566c19b242b..b82f8c2d55c4 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -39,6 +39,7 @@ struct perf_mmap {
 	} aio;
 #endif
 	cpu_set_t	affinity_mask;
+	u64		flush;
 };
 
 /*
@@ -70,7 +71,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks, affinity;
+	int			    prot, mask, nr_cblocks, affinity, flush;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.20.1

