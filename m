Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D46C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDCE20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbfCAP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:58:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:1380 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbfCAP6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:58:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 07:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="324530783"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2019 07:58:37 -0800
Received: from [10.252.14.197] (abudanko-mobl.ccr.corp.intel.com [10.252.14.197])
        by linux.intel.com (Postfix) with ESMTP id 92754580487;
        Fri,  1 Mar 2019 07:58:34 -0800 (PST)
Subject: [PATCH v5 07/10] perf record: implement -z,--compression_level=n
 option and compression
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
Message-ID: <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
Date:   Fri, 1 Mar 2019 18:58:32 +0300
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


Implemented -z,--compression_level=n option that enables compression
of mmaped kernel data buffers content in runtime during perf record
sampling collection.

Compression is implemented using the functions from zstd.c. As the
memory to operate on the compression employs mmap->data buffer in case
of serial trace writing and mmap AIO buffers in case of AIO trace
writing. If Zstd streaming compression API fails for some reason the
data to be compressed are just copied into the memory buffers using
memcpy().

Compressed trace frame consists of an array of PERF_RECORD_COMPRESSED
records. Each element of the array is not longer that 64KiB because of
u16 size limitation and comprised of perf_event_header followed by the
compressed chunk that is decompressed on the loading stage. --mmap-flush
option value can be used to avoid compression of every single byte of
data and possibly increase compression ratio.

Compression overhead has been measured for serial and AIO trace writing
when profiling matrix multiplication workload:

    -------------------------------------------------------------
    | SERIAL			  | AIO-1                       |
-----------------------------------------------------------------
|-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
|----------------------------------------------------------------
| 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
| 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
| 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
| 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
| 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
| 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
-----------------------------------------------------------------

OVH = (Execution time with -z N) / (Execution time with -z 0)

ratio - compression ratio
size  - number of bytes that was compressed

	size ~= trace size x ratio

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  5 ++
 tools/perf/builtin-record.c              | 85 ++++++++++++++++++++----
 tools/perf/util/mmap.c                   | 31 ++++++---
 tools/perf/util/mmap.h                   | 13 ++--
 tools/perf/util/session.h                |  2 +
 5 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 9fa33ce9bc00..872c20917df7 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -472,6 +472,11 @@ executing less trace write syscalls with bigger data sets can take shorter than
 executing more trace write syscalls with smaller data sets thus lowering runtime
 profiling overhead.
 
+-z::
+--compression-level=n::
+Produce compressed trace using specified compression level n (no compression: 0 - default,
+fastest compression: 1, smallest trace: 22)
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 954141c491b0..26f07b880a0a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -237,7 +237,7 @@ static int record__aio_sync(struct perf_mmap *md, bool sync_all)
 	} while (1);
 }
 
-static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size, off_t off)
+static int record__aio_pushfn(void *to, void *bf, size_t size, off_t off, struct aiocb *cblock)
 {
 	struct record *rec = to;
 	int ret, trace_fd = rec->session->data->file.fd;
@@ -264,13 +264,15 @@ static void record__aio_set_pos(int trace_fd, off_t pos)
 	lseek(trace_fd, pos, SEEK_SET);
 }
 
+static int record__aio_enabled(struct record *rec);
+
 static void record__aio_mmap_read_sync(struct record *rec)
 {
 	int i;
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_mmap *maps = evlist->mmap;
 
-	if (!rec->opts.nr_cblocks)
+	if (!record__aio_enabled(rec))
 		return;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
@@ -292,13 +294,17 @@ static int record__aio_parse(const struct option *opt,
 
 	if (unset) {
 		opts->nr_cblocks = 0;
-	} else {
-		if (str)
-			opts->nr_cblocks = strtol(str, NULL, 0);
-		if (!opts->nr_cblocks)
-			opts->nr_cblocks = nr_cblocks_default;
+		return 0;
 	}
 
+	if (str)
+		opts->nr_cblocks = strtol(str, NULL, 0);
+	if (!opts->nr_cblocks)
+		opts->nr_cblocks = nr_cblocks_default;
+
+	if (opts->nr_cblocks > nr_cblocks_max)
+		opts->nr_cblocks = nr_cblocks_max;
+
 	return 0;
 }
 #else /* HAVE_AIO_SUPPORT */
@@ -309,8 +315,9 @@ static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all _
 	return -1;
 }
 
-static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
-		void *bf __maybe_unused, size_t size __maybe_unused, off_t off __maybe_unused)
+static int record__aio_pushfn(void *to __maybe_unused, void *bf __maybe_unused,
+		size_t size __maybe_unused, off_t off __maybe_unused,
+		struct aiocb *cblock __maybe_unused)
 {
 	return -1;
 }
@@ -761,6 +768,40 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 	}
 }
 
+static size_t record__process_comp_header(void *record, size_t increment)
+{
+	struct compressed_event *event = record;
+	size_t size = sizeof(struct compressed_event);
+
+	if (increment) {
+		event->header.size += increment;
+		return increment;
+	} else {
+		event->header.type = PERF_RECORD_COMPRESSED;
+		event->header.size = size;
+		return size;
+	}
+}
+
+static size_t record__zstd_compress(void *data, void *dst, size_t dst_size,
+		void *src, size_t src_size)
+{
+	size_t compressed;
+	struct perf_session *session = data;
+	/* maximum size of record data size (2^16 - 1 - header) */
+	const size_t max_record_size = (1 << 8 * sizeof(u16)) -
+					1 - sizeof(struct compressed_event);
+
+	compressed = zstd_compress_stream_to_records(&(session->zstd_data),
+				dst, dst_size, src, src_size, max_record_size,
+				record__process_comp_header);
+
+	session->bytes_transferred += src_size;
+	session->bytes_compressed  += compressed;
+
+	return compressed;
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite, bool sync)
 {
@@ -770,6 +811,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	struct perf_mmap *maps;
 	int trace_fd = rec->data.file.fd;
 	off_t off;
+	struct perf_session *session = rec->session;
+	perf_mmap__compress_fn_t compress_fn;
 
 	if (!evlist)
 		return 0;
@@ -781,6 +824,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
 		return 0;
 
+	compress_fn = record__comp_enabled(rec) ? record__zstd_compress : NULL;
+
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
@@ -795,7 +840,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				map->flush = MMAP_FLUSH_DEFAULT;
 			}
 			if (!record__aio_enabled(rec)) {
-				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+				if (perf_mmap__push(map, rec, record__pushfn,
+						    compress_fn, session) != 0) {
 					if (sync)
 						map->flush = flush;
 					rc = -1;
@@ -808,7 +854,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				 * becomes available after previous aio write request.
 				 */
 				idx = record__aio_sync(map, false);
-				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
+				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off,
+							compress_fn, session) != 0) {
 					record__aio_set_pos(trace_fd, off);
 					if (sync)
 						map->flush = flush;
@@ -1189,6 +1236,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
+	if (zstd_init(&(session->zstd_data), rec->opts.comp_level) < 0) {
+		pr_err("Compression initialization failed.\n");
+		return -1;
+	}
+
+	session->header.env.comp_type  = PERF_COMP_ZSTD;
+	session->header.env.comp_level = rec->opts.comp_level;
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
@@ -1518,6 +1573,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return status;
 }
@@ -2038,6 +2094,10 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+#ifdef HAVE_ZSTD_SUPPORT
+	OPT_UINTEGER('z', "compression-level", &record.opts.comp_level,
+		     "Produce compressed trace (default: 0, fastest: 1, smallest: 22)"),
+#endif
 	OPT_END()
 };
 
@@ -2235,8 +2295,7 @@ int cmd_record(int argc, const char **argv)
 
 	if (rec->opts.nr_cblocks > nr_cblocks_max)
 		rec->opts.nr_cblocks = nr_cblocks_max;
-	if (verbose > 0)
-		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
 	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
 	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index d85e73fc82e2..724237a253b4 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -291,14 +291,15 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 }
 
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
-			off_t *off)
+			int push(void *to, void *buf, size_t size, off_t off, struct aiocb *cblock),
+			off_t *off, perf_mmap__compress_fn_t compress, void *comp_data)
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
 	unsigned long size, size0 = 0;
 	void *buf;
 	int rc = 0;
+	size_t mmap_len = perf_mmap__mmap_len(md);
 
 	rc = perf_mmap__read_init(md);
 	if (rc < 0)
@@ -327,14 +328,20 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 		buf = &data[md->start & md->mask];
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
-		memcpy(md->aio.data[idx], buf, size);
 		size0 = size;
+		if (!compress)
+			memcpy(md->aio.data[idx], buf, size);
+		else
+			size0 = compress(comp_data, md->aio.data[idx], mmap_len, buf, size);
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
-	memcpy(md->aio.data[idx] + size0, buf, size);
+	if (!compress)
+		memcpy(md->aio.data[idx] + size0, buf, size);
+	else
+		size = compress(comp_data, md->aio.data[idx] + size0, mmap_len - size0, buf, size);
 
 	/*
 	 * Increment md->refcount to guard md->data[idx] buffer
@@ -350,7 +357,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 	md->prev = head;
 	perf_mmap__consume(md);
 
-	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
+	rc = push(to, md->aio.data[idx], size0 + size, *off, &md->aio.cblocks[idx]);
 	if (!rc) {
 		*off += size0 + size;
 	} else {
@@ -556,13 +563,15 @@ int perf_mmap__read_init(struct perf_mmap *map)
 }
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
+		    int push(struct perf_mmap *map, void *to, void *buf, size_t size),
+		    perf_mmap__compress_fn_t compress, void *comp_data)
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
 	void *buf;
 	int rc = 0;
+	size_t mmap_len = perf_mmap__mmap_len(md);
 
 	rc = perf_mmap__read_init(md);
 	if (rc < 0)
@@ -574,7 +583,10 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		buf = &data[md->start & md->mask];
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
-
+		if (compress) {
+			size = compress(comp_data, md->data, mmap_len, buf, size);
+			buf = md->data;
+		}
 		if (push(md, to, buf, size) < 0) {
 			rc = -1;
 			goto out;
@@ -584,7 +596,10 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
-
+	if (compress) {
+		size = compress(comp_data, md->data, mmap_len, buf, size);
+		buf = md->data;
+	}
 	if (push(md, to, buf, size) < 0) {
 		rc = -1;
 		goto out;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a02427d609c0..2df3882c4b83 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -99,16 +99,19 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
+typedef size_t (*perf_mmap__compress_fn_t)(void *data, void *dst, size_t dst_size,
+		void *src, size_t src_size);
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
+		    int push(struct perf_mmap *map, void *to, void *buf, size_t size),
+		    perf_mmap__compress_fn_t compress, void *compress_data);
 #ifdef HAVE_AIO_SUPPORT
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
-			off_t *off);
+			int push(void *to, void *buf, size_t size, off_t off, struct aiocb *cblock),
+			off_t *off, perf_mmap__compress_fn_t compress, void *compress_data);
 #else
 static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused, int idx __maybe_unused,
-	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
-	off_t *off __maybe_unused)
+	int push(void *to, void *buf, size_t size, off_t off, struct aiocb *cblock) __maybe_unused,
+	off_t *off __maybe_unused, perf_mmap__compress_fn_t compress __maybe_unused, void *compress_data __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 0e14884f28b2..6c984c895924 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -8,6 +8,7 @@
 #include "machine.h"
 #include "data.h"
 #include "ordered-events.h"
+#include "util/compress.h"
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
 #include <linux/perf_event.h>
@@ -37,6 +38,7 @@ struct perf_session {
 	struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
+	struct zstd_data	zstd_data;
 };
 
 struct perf_tool;
-- 
2.20.1

