Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3E214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLFaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:30:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:7295 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfCLFaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:30:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 22:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,469,1544515200"; 
   d="scan'208";a="124685337"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2019 22:30:17 -0700
Received: from [10.252.11.175] (abudanko-mobl.ccr.corp.intel.com [10.252.11.175])
        by linux.intel.com (Postfix) with ESMTP id 7B86158046F;
        Mon, 11 Mar 2019 22:30:14 -0700 (PDT)
Subject: [PATCH v7 08/12] perf record: implement compression for AIO trace
 streaming
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
Organization: Intel Corp.
Message-ID: <618f7b8b-015b-d67e-9ef4-dc7aa0d2cd62@linux.intel.com>
Date:   Tue, 12 Mar 2019 08:30:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Compression is implemented using the functions from zstd.c. As the memory
to operate on the compression uses mmap->aio.data[] buffers. If Zstd
streaming compression API fails for some reason the data to be compressed
are just copied into the memory buffers using plain memcpy().

Compressed trace frame consists of an array of PERF_RECORD_COMPRESSED
records. Each element of the array is not longer that PERF_SAMPLE_MAX_SIZE
and consists of perf_event_header followed by the compressed chunk
that is decompressed on the loading stage.

perf_mmap__aio_push() is replaced by perf_mmap__push() which is now used
in the both serial and AIO streaming cases. perf_mmap__push() is extended 
with positive return values to signify absence of data ready for processing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 110 ++++++++++++++++++++++++++++--------
 tools/perf/util/mmap.c      |  76 +------------------------
 tools/perf/util/mmap.h      |  12 ----
 3 files changed, 87 insertions(+), 111 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d13c0dd87592..47e0abe22192 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -130,6 +130,8 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 	return 0;
 }
 
+static int record__aio_enabled(struct record *rec);
+static int record__comp_enabled(struct record *rec);
 static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
 			    void *src, size_t src_size);
 
@@ -183,9 +185,9 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
 	if (rem_size == 0) {
 		cblock->aio_fildes = -1;
 		/*
-		 * md->refcount is incremented in perf_mmap__push() for
-		 * every enqueued aio write request so decrement it because
-		 * the request is now complete.
+		 * md->refcount is incremented in record__aio_pushfn() for
+		 * every aio write request started in record__aio_push() so
+		 * decrement it because the request is now complete.
 		 */
 		perf_mmap__put(md);
 		rc = 1;
@@ -240,18 +242,89 @@ static int record__aio_sync(struct perf_mmap *md, bool sync_all)
 	} while (1);
 }
 
-static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size, off_t off)
+struct record_aio {
+	struct record 	*rec;
+	void		*data;
+	size_t		size;
+};
+
+static int record__aio_pushfn(struct perf_mmap *map, void *to, void *buf, size_t size)
 {
-	struct record *rec = to;
-	int ret, trace_fd = rec->session->data->file.fd;
+	struct record_aio *aio = to;
 
-	rec->samples++;
+	/*
+	 * map->base data pointed by buf is copied into free map->aio.data[] buffer
+	 * to release space in the kernel buffer as fast as possible, calling
+	 * perf_mmap__consume() from perf_mmap__push() function.
+	 *
+	 * That lets the kernel to proceed with storing more profiling data into
+	 * the kernel buffer earlier than other per-cpu kernel buffers are handled.
+	 *
+	 * Coping can be done in two steps in case the chunk of profiling data
+	 * crosses the upper bound of the kernel buffer. In this case we first move
+	 * part of data from map->start till the upper bound and then the reminder
+	 * from the beginning of the kernel buffer till the end of the data chunk.
+	 */
+
+	if (record__comp_enabled(aio->rec)) {
+		size = zstd_compress(aio->rec->session, aio->data + aio->size,
+				     perf_mmap__mmap_len(map) - aio->size,
+				     buf, size);
+	} else {
+		memcpy(aio->data + aio->size, buf, size);
+	}
+
+	if (!aio->size) {
+		/*
+		 * Increment map->refcount to guard map->aio.data[] buffer
+		 * from premature deallocation because map object can be
+		 * released earlier than aio write request started on
+		 * map->aio.data[] buffer is complete.
+		 *
+		 * perf_mmap__put() is done at record__aio_complete()
+		 * after started aio request completion or at record__aio_push()
+		 * if the request failed to start.
+		 */
+		perf_mmap__get(map);
+	}
+
+	aio->size += size;
+
+	return size;
+}
+
+static int record__aio_push(struct record *rec, struct perf_mmap *map, off_t *off)
+{
+	int ret, idx;
+	int trace_fd = rec->session->data->file.fd;
+	struct record_aio aio = { .rec = rec, .size = 0 };
 
-	ret = record__aio_write(cblock, trace_fd, bf, size, off);
+	/*
+	 * Call record__aio_sync() to wait till map->aio.data[] buffer
+	 * becomes available after previous aio write operation.
+	 */
+
+	idx = record__aio_sync(map, false);
+	aio.data = map->aio.data[idx];
+	ret = perf_mmap__push(map, &aio, record__aio_pushfn);
+	if (ret != 0) /* ret > 0 - no data, ret < 0 - error */
+		return ret;
+
+	rec->samples++;
+	ret = record__aio_write(&(map->aio.cblocks[idx]), trace_fd, aio.data, aio.size, *off);
 	if (!ret) {
-		rec->bytes_written += size;
+		*off += aio.size;
+		rec->bytes_written += aio.size;
 		if (switch_output_size(rec))
 			trigger_hit(&switch_output_trigger);
+	} else {
+		/*
+		 * Decrement map->refcount incremented in record__aio_pushfn()
+		 * back if record__aio_write() operation failed to start, otherwise
+		 * map->refcount is decremented in record__aio_complete() after
+		 * aio write operation finishes successfully.
+		 */
+		perf_mmap__put(map);
 	}
 
 	return ret;
@@ -307,13 +380,8 @@ static int record__aio_parse(const struct option *opt,
 #else /* HAVE_AIO_SUPPORT */
 static int nr_cblocks_max = 0;
 
-static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all __maybe_unused)
-{
-	return -1;
-}
-
-static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
-		void *bf __maybe_unused, size_t size __maybe_unused, off_t off __maybe_unused)
+static int record__aio_push(struct record *rec __maybe_unused, struct perf_mmap *map __maybe_unused,
+			    off_t *off __maybe_unused)
 {
 	return -1;
 }
@@ -821,7 +889,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	int rc = 0;
 	struct perf_mmap *maps;
 	int trace_fd = rec->data.file.fd;
-	off_t off;
+	off_t off = 0;
 
 	if (!evlist)
 		return 0;
@@ -854,13 +922,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 					goto out;
 				}
 			} else {
-				int idx;
-				/*
-				 * Call record__aio_sync() to wait till map->data buffer
-				 * becomes available after previous aio write request.
-				 */
-				idx = record__aio_sync(map, false);
-				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
+				if (record__aio_push(rec, map, &off) < 0) {
 					record__aio_set_pos(trace_fd, off);
 					if (sync)
 						map->flush = flush;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index d85e73fc82e2..868c0b0e909c 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -289,80 +289,6 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	zfree(&map->aio.cblocks);
 	zfree(&map->aio.aiocb);
 }
-
-int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
-			off_t *off)
-{
-	u64 head = perf_mmap__read_head(md);
-	unsigned char *data = md->base + page_size;
-	unsigned long size, size0 = 0;
-	void *buf;
-	int rc = 0;
-
-	rc = perf_mmap__read_init(md);
-	if (rc < 0)
-		return (rc == -EAGAIN) ? 0 : -1;
-
-	/*
-	 * md->base data is copied into md->data[idx] buffer to
-	 * release space in the kernel buffer as fast as possible,
-	 * thru perf_mmap__consume() below.
-	 *
-	 * That lets the kernel to proceed with storing more
-	 * profiling data into the kernel buffer earlier than other
-	 * per-cpu kernel buffers are handled.
-	 *
-	 * Coping can be done in two steps in case the chunk of
-	 * profiling data crosses the upper bound of the kernel buffer.
-	 * In this case we first move part of data from md->start
-	 * till the upper bound and then the reminder from the
-	 * beginning of the kernel buffer till the end of
-	 * the data chunk.
-	 */
-
-	size = md->end - md->start;
-
-	if ((md->start & md->mask) + size != (md->end & md->mask)) {
-		buf = &data[md->start & md->mask];
-		size = md->mask + 1 - (md->start & md->mask);
-		md->start += size;
-		memcpy(md->aio.data[idx], buf, size);
-		size0 = size;
-	}
-
-	buf = &data[md->start & md->mask];
-	size = md->end - md->start;
-	md->start += size;
-	memcpy(md->aio.data[idx] + size0, buf, size);
-
-	/*
-	 * Increment md->refcount to guard md->data[idx] buffer
-	 * from premature deallocation because md object can be
-	 * released earlier than aio write request started
-	 * on mmap->data[idx] is complete.
-	 *
-	 * perf_mmap__put() is done at record__aio_complete()
-	 * after started request completion.
-	 */
-	perf_mmap__get(md);
-
-	md->prev = head;
-	perf_mmap__consume(md);
-
-	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
-	if (!rc) {
-		*off += size0 + size;
-	} else {
-		/*
-		 * Decrement md->refcount back if aio write
-		 * operation failed to start.
-		 */
-		perf_mmap__put(md);
-	}
-
-	return rc;
-}
 #else /* !HAVE_AIO_SUPPORT */
 static int perf_mmap__aio_enabled(struct perf_mmap *map __maybe_unused)
 {
@@ -566,7 +492,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 
 	rc = perf_mmap__read_init(md);
 	if (rc < 0)
-		return (rc == -EAGAIN) ? 0 : -1;
+		return (rc == -EAGAIN) ? 1 : -1;
 
 	size = md->end - md->start;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a02427d609c0..e8a34e0bb10e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -101,18 +101,6 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
-#ifdef HAVE_AIO_SUPPORT
-int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
-			off_t *off);
-#else
-static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused, int idx __maybe_unused,
-	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
-	off_t *off __maybe_unused)
-{
-	return 0;
-}
-#endif
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-- 
2.20.1

