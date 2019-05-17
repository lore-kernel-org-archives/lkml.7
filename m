Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C940C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F88217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122020;
	bh=KoNPAitENNzIk+9NwQQOg4sJFl1+moWpkembUsEQWqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ei9Cw20GYQEPrOYCvVpCDcjV4EtWfmK5/XqgeknEUgMPepymY4X2RLvL/q4kCfxn6
	 6I4E1j+bUBFKQ3gIow3IDG8CzPLiGV+O1dXRfxv48v5Bg0MVgEBJ97BwsU1zopxuL/
	 NXCaU3o4dtjy4bjicP2NYdBGzd+PX6Z4R6vBPagA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfEQTkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbfEQTkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:15 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB5221744;
        Fri, 17 May 2019 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122013;
        bh=KoNPAitENNzIk+9NwQQOg4sJFl1+moWpkembUsEQWqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfAPe/+0BuVBMS98/BMNhVmQVA9UMipqhcSUmtxWYxMOoGAqSnND03qeS6zooiNRQ
         lb3aT5kJsTbewwUf66v1wZ64ORvLBTj4oFqA/h6Bu26E7CzXARfzQpuobu68KkDwNP
         4+97wyABoVO0qzsFatQeAJiKAs48MHpb0GXSQZ9c=
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
Subject: [PATCH 53/73] perf record: Implement compression for AIO trace streaming
Date:   Fri, 17 May 2019 16:35:51 -0300
Message-Id: <20190517193611.4974-54-acme@kernel.org>
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
with positive return values to signify absence of data ready for
processing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/77db2b2c-5d03-dbb0-aeac-c4dd92129ab9@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 114 ++++++++++++++++++++++++++++--------
 tools/perf/util/mmap.c      |  76 +-----------------------
 tools/perf/util/mmap.h      |  12 ----
 3 files changed, 89 insertions(+), 113 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index de9632c69852..a0bd9104fae6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -133,6 +133,8 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 	return 0;
 }
 
+static int record__aio_enabled(struct record *rec);
+static int record__comp_enabled(struct record *rec);
 static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
 			    void *src, size_t src_size);
 
@@ -186,9 +188,9 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
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
@@ -243,18 +245,89 @@ static int record__aio_sync(struct perf_mmap *md, bool sync_all)
 	} while (1);
 }
 
-static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size, off_t off)
+struct record_aio {
+	struct record	*rec;
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
 
-	ret = record__aio_write(cblock, trace_fd, bf, size, off);
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
+
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
@@ -276,7 +349,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_mmap *maps = evlist->mmap;
 
-	if (!rec->opts.nr_cblocks)
+	if (!record__aio_enabled(rec))
 		return;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
@@ -310,13 +383,8 @@ static int record__aio_parse(const struct option *opt,
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
@@ -825,7 +893,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	int rc = 0;
 	struct perf_mmap *maps;
 	int trace_fd = rec->data.file.fd;
-	off_t off;
+	off_t off = 0;
 
 	if (!evlist)
 		return 0;
@@ -851,20 +919,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				map->flush = 1;
 			}
 			if (!record__aio_enabled(rec)) {
-				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+				if (perf_mmap__push(map, rec, record__pushfn) < 0) {
 					if (synch)
 						map->flush = flush;
 					rc = -1;
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
 					if (synch)
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
index 4e2f58d95c1f..274ce389cd84 100644
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

