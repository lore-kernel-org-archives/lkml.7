Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FDDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8122186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfDELww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:52:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDELwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:52:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BqZrR2738680
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:52:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BqYxh2738677;
        Fri, 5 Apr 2019 04:52:34 -0700
Date:   Fri, 5 Apr 2019 04:52:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-470530bbb8fbbf2a09bd1d7150bb92501c5c54e6@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, ak@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com
Reply-To: acme@redhat.com, jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, namhyung@kernel.org
In-Reply-To: <f6600d72-ecfa-2eb7-7e51-f6954547d500@linux.intel.com>
References: <f6600d72-ecfa-2eb7-7e51-f6954547d500@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Implement --mmap-flush=<number> option
Git-Commit-ID: 470530bbb8fbbf2a09bd1d7150bb92501c5c54e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  470530bbb8fbbf2a09bd1d7150bb92501c5c54e6
Gitweb:     https://git.kernel.org/tip/470530bbb8fbbf2a09bd1d7150bb92501c5c54e6
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:40:26 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:10 -0300

perf record: Implement --mmap-flush=<number> option

Implement a --mmap-flush option that specifies minimal number of bytes
that is extracted from mmaped kernel buffer to store into a trace. The
default option value is 1 byte what means every time trace writing
thread finds some new data in the mmaped buffer the data is extracted,
possibly compressed and written to a trace.

  $ tools/perf/perf record --mmap-flush 1024 -e cycles -- matrix.gcc
  $ tools/perf/perf record --aio --mmap-flush 1K -e cycles -- matrix.gcc

The option is independent from -z setting, doesn't vary with compression
level and can serve two purposes.

The first purpose is to increase the compression ratio of a trace data.
Larger data chunks are compressed more effectively so the implemented
option allows specifying data chunk size to compress. Also at some cases
executing more write syscalls with smaller data size can take longer
than executing less write syscalls with bigger data size due to syscall
overhead so extracting bigger data chunks specified by the option value
could additionally decrease runtime overhead.

The second purpose is to avoid self monitoring live-lock issue in system
wide (-a) profiling mode. Profiling in system wide mode with compression
(-a -z) can additionally induce data into the kernel buffers along with
the data from monitored processes. If performance data rate and volume
from the monitored processes is high then trace streaming and
compression activity in the tool is also high. High tool process
activity can lead to subtle live-lock effect when compression of single
new byte from some of mmaped kernel buffer leads to generation of the
next single byte at some mmaped buffer. So perf tool process ends up in
endless self monitoring.

Implemented synch parameter is the mean to force data move independently
from the specified flush threshold value. Despite the provided flush
value the tool needs capability to unconditionally drain memory buffers,
at least in the end of the collection.

Committer testing:

Running with the default value, i.e. as soon as there is something to
read go on consuming, we first write the synthesized events, small
chunks of about 128 bytes:

  # perf trace -m 2048 --call-graph dwarf -e write -- perf record
  <SNIP>
     101.142 ( 0.004 ms): perf/25821 write(fd: 3</root/perf.data>, buf: 0x210db60, count: 120) = 120
                                         __libc_write (/usr/lib64/libpthread-2.28.so)
                                         ion (/home/acme/bin/perf)
                                         record__write (inlined)
                                         process_synthesized_event (/home/acme/bin/perf)
                                         perf_tool__process_synth_event (inlined)
                                         perf_event__synthesize_mmap_events (/home/acme/bin/perf)

Then we move to reading the mmap buffers consuming the events put there
by the kernel perf infrastructure:

     107.561 ( 0.005 ms): perf/25821 write(fd: 3</root/perf.data>, buf: 0x7f1befc02000, count: 336) = 336
                                         __libc_write (/usr/lib64/libpthread-2.28.so)
                                         ion (/home/acme/bin/perf)
                                         record__write (inlined)
                                         record__pushfn (/home/acme/bin/perf)
                                         perf_mmap__push (/home/acme/bin/perf)
                                         record__mmap_read_evlist (inlined)
                                         record__mmap_read_all (inlined)
                                         __cmd_record (inlined)
                                         cmd_record (/home/acme/bin/perf)
     12919.953 ( 0.136 ms): perf/25821 write(fd: 3</root/perf.data>, buf: 0x7f1befc83150, count: 184984) = 184984
  <SNIP same backtrace as in the 107.561 timestamp>
     12920.094 ( 0.155 ms): perf/25821 write(fd: 3</root/perf.data>, buf: 0x7f1befc02150, count: 261816) = 261816
  <SNIP same backtrace as in the 107.561 timestamp>
     12920.253 ( 0.093 ms): perf/25821 write(fd: 3</root/perf.data>, buf: 0x7f1befb81120, count: 170832) = 170832
  <SNIP same backtrace as in the 107.561 timestamp>

If we limit it to write only when more than 16MB are available for
reading, it throttles that to a quarter of the --mmap-pages set for
'perf record', which by default get to 528384 bytes, found out using
'record -v':

  mmap flush: 132096
  mmap size 528384B

With that in place all the writes coming from
record__mmap_read_evlist(), i.e. from the mmap buffers setup by the
kernel perf infrastructure were at least 132096 bytes long.

Trying with a bigger mmap size:

   perf trace -e write perf record -v -m 2048 --mmap-flush 16M
   74982.928 ( 2.471 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff94a6cc000, count: 3580888) = 3580888
   74985.406 ( 2.353 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff949ecb000, count: 3453256) = 3453256
   74987.764 ( 2.629 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff9496ca000, count: 3859232) = 3859232
   74990.399 ( 2.341 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff948ec9000, count: 3769032) = 3769032
   74992.744 ( 2.064 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff9486c8000, count: 3310520) = 3310520
   74994.814 ( 2.619 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff947ec7000, count: 4194688) = 4194688
   74997.439 ( 2.787 ms): perf/26500 write(fd: 3</root/perf.data>, buf: 0x7ff9476c6000, count: 4029760) = 4029760

Was again limited to a quarter of the mmap size:

  mmap flush: 2098176
  mmap size 8392704B

A warning about that would be good to have but can be added later,
something like:

  "max flush is a quarter of the mmap size, if wanting to bump the mmap
   flush further, bump the mmap size as well using -m/--mmap-pages"

Also rename the 'sync' parameters to 'synch' to keep tools/perf building
with older glibcs:

  cc1: warnings being treated as errors
  builtin-record.c: In function 'record__mmap_read_evlist':
  builtin-record.c:775: warning: declaration of 'sync' shadows a global declaration
  /usr/include/unistd.h:933: warning: shadowed declaration is here
  builtin-record.c: In function 'record__mmap_read_all':
  builtin-record.c:856: warning: declaration of 'sync' shadows a global declaration
  /usr/include/unistd.h:933: warning: shadowed declaration is here

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/f6600d72-ecfa-2eb7-7e51-f6954547d500@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 19 ++++++++++
 tools/perf/builtin-record.c              | 65 +++++++++++++++++++++++++++++---
 tools/perf/perf.h                        |  1 +
 tools/perf/util/evlist.c                 |  6 +--
 tools/perf/util/evlist.h                 |  3 +-
 tools/perf/util/mmap.c                   |  4 +-
 tools/perf/util/mmap.h                   |  3 +-
 7 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8fe4dffcadd0..58986f4cc190 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -459,6 +459,25 @@ Set affinity mask of trace reading thread according to the policy defined by 'mo
   node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
   cpu  - thread affinity mask is set to cpu of the processed mmap buffer
 
+--mmap-flush=number::
+
+Specify minimal number of bytes that is extracted from mmap data pages and
+processed for output. One can specify the number using B/K/M/G suffixes.
+
+The maximal allowed value is a quarter of the size of mmaped data pages.
+
+The default option value is 1 byte which means that every time that the output
+writing thread finds some new data in the mmaped buffer the data is extracted,
+possibly compressed (-z) and written to the output, perf.data or pipe.
+
+Larger data chunks are compressed more effectively in comparison to smaller
+chunks so extraction of larger chunks from the mmap data pages is preferable
+from the perspective of output size reduction.
+
+Also at some cases executing less output write syscalls with bigger data size
+can take less time than executing more output write syscalls with smaller data
+size thus lowering runtime profiling overhead.
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4e2d953d4bc5..c5e10552776a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -337,6 +337,41 @@ static int record__aio_enabled(struct record *rec)
 	return rec->opts.nr_cblocks > 0;
 }
 
+#define MMAP_FLUSH_DEFAULT 1
+static int record__mmap_flush_parse(const struct option *opt,
+				    const char *str,
+				    int unset)
+{
+	int flush_max;
+	struct record_opts *opts = (struct record_opts *)opt->value;
+	static struct parse_tag tags[] = {
+			{ .tag  = 'B', .mult = 1       },
+			{ .tag  = 'K', .mult = 1 << 10 },
+			{ .tag  = 'M', .mult = 1 << 20 },
+			{ .tag  = 'G', .mult = 1 << 30 },
+			{ .tag  = 0 },
+	};
+
+	if (unset)
+		return 0;
+
+	if (str) {
+		opts->mmap_flush = parse_tag_value(str, tags);
+		if (opts->mmap_flush == (int)-1)
+			opts->mmap_flush = strtol(str, NULL, 0);
+	}
+
+	if (!opts->mmap_flush)
+		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
+
+	flush_max = perf_evlist__mmap_size(opts->mmap_pages);
+	flush_max /= 4;
+	if (opts->mmap_flush > flush_max)
+		opts->mmap_flush = flush_max;
+
+	return 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -546,7 +581,8 @@ static int record__mmap_evlist(struct record *rec,
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
-				 opts->nr_cblocks, opts->affinity) < 0) {
+				 opts->nr_cblocks, opts->affinity,
+				 opts->mmap_flush) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -736,7 +772,7 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 }
 
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
-				    bool overwrite)
+				    bool overwrite, bool synch)
 {
 	u64 bytes_written = rec->bytes_written;
 	int i;
@@ -759,12 +795,19 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		off = record__aio_get_pos(trace_fd);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		u64 flush = 0;
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
 			record__adjust_affinity(rec, map);
+			if (synch) {
+				flush = map->flush;
+				map->flush = 1;
+			}
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+					if (synch)
+						map->flush = flush;
 					rc = -1;
 					goto out;
 				}
@@ -777,10 +820,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				idx = record__aio_sync(map, false);
 				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
 					record__aio_set_pos(trace_fd, off);
+					if (synch)
+						map->flush = flush;
 					rc = -1;
 					goto out;
 				}
 			}
+			if (synch)
+				map->flush = flush;
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
@@ -806,15 +853,15 @@ out:
 	return rc;
 }
 
-static int record__mmap_read_all(struct record *rec)
+static int record__mmap_read_all(struct record *rec, bool synch)
 {
 	int err;
 
-	err = record__mmap_read_evlist(rec, rec->evlist, false);
+	err = record__mmap_read_evlist(rec, rec->evlist, false, synch);
 	if (err)
 		return err;
 
-	return record__mmap_read_evlist(rec, rec->evlist, true);
+	return record__mmap_read_evlist(rec, rec->evlist, true, synch);
 }
 
 static void record__init_features(struct record *rec)
@@ -1340,7 +1387,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (trigger_is_hit(&switch_output_trigger) || done || draining)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
-		if (record__mmap_read_all(rec) < 0) {
+		if (record__mmap_read_all(rec, false) < 0) {
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1441,6 +1488,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
 	if (forks) {
@@ -1846,6 +1894,7 @@ static struct record record = {
 			.uses_mmap   = true,
 			.default_per_cpu = true,
 		},
+		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1912,6 +1961,9 @@ static struct option __record_options[] = {
 	OPT_CALLBACK('m', "mmap-pages", &record.opts, "pages[,pages]",
 		     "number of mmap data pages and AUX area tracing mmap pages",
 		     record__parse_mmap_pages),
+	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
+		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
+		     record__mmap_flush_parse),
 	OPT_BOOLEAN(0, "group", &record.opts.group,
 		    "put the counters into a counter group"),
 	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
@@ -2224,6 +2276,7 @@ int cmd_record(int argc, const char **argv)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
 	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
+	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
 
 	err = __cmd_record(&record, argc, argv);
 out:
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index c59743def8d3..369eae61068d 100644
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
index 6689378ee577..f2bbae38278d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1009,7 +1009,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1019,7 +1019,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1051,7 +1051,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 6a94785b9100..c9a0f72677fd 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -177,7 +177,8 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
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
 
