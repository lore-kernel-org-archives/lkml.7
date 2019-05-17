Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301BCC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE96217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122032;
	bh=93AnWlAt7LDifH/MAsQDaI9FUPeHoynCq3sQmydy/GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FmOmhKQY2yGzFyMxe2aoui9PkmIOvdyltPhQ10x1eTdVofAa0WSIn6ZyEzIuHBNw6
	 qJP9q5Mk3nwoe0gkJdbnrwAzvXniQoLvAn/URCk2ozBgd23KJq3tv19HmAgIMiKMjb
	 oeiOVkOME9RPcQfm1vnKy5nwMkBiS9QeQOLSQYaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfEQTkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfEQTk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:27 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2D821726;
        Fri, 17 May 2019 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122026;
        bh=93AnWlAt7LDifH/MAsQDaI9FUPeHoynCq3sQmydy/GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4+bses2cXLIIx0MnzDAhugpmp+pM0XkxSTjAA4tX0356PUU5Zu/GWFLcnpS/fdqu
         EaCiHLpPefocWbr37hFAqTLZzrMEKQS0RlsNie/Cn7j90RGSONVDC8ownkFa4tORRn
         FI2obXcCc61jIzEPPeBzi+OVj1W7dTibKslW2pyo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 56/73] perf report: Implement perf.data record decompression
Date:   Fri, 17 May 2019 16:35:54 -0300
Message-Id: <20190517193611.4974-57-acme@kernel.org>
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

zstd_init(, comp_level = 0) initializes decompression part of API only
hat now consists of zstd_decompress_stream() function.

The perf.data PERF_RECORD_COMPRESSED records are decompressed using
zstd_decompress_stream() function into a linked list of mmaped memory
regions of mmap_comp_len size (struct decomp).

After decompression of one COMPRESSED record its content is iterated and
fetched for usual processing. The mmaped memory regions with
decompressed events are kept in the linked list till the tool process
termination.

When dumping raw records (e.g., perf report -D --header) file offsets of
events from compressed records are printed as zero.

Committer notes:

Since now we have support for processing PERF_RECORD_COMPRESSED, we see
none, in raw form, like we saw in the previous patch commiter notes,
they were decompressed into the usual PERF_RECORD_{FORK,MMAP,COMM,etc}
records, we only see the stats for those PERF_RECORD_COMPRESSED events,
and since I used the file generated in the commiter notes for the
previous patch, there they are, 2 compressed records:

  $ perf report --header-only | grep cmdline
  # cmdline : /home/acme/bin/perf record -z2 sleep 1
  $ perf report -D | grep COMPRESS
        COMPRESSED events:          2
        COMPRESSED events:          0
  $ perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 15  of event 'cycles:u'
  # Event count (approx.): 962227
  #
  # Overhead  Command  Shared Object     Symbol
  # ........  .......  ................  ...........................
  #
      46.99%  sleep    libc-2.28.so      [.] _dl_addr
      29.24%  sleep    [unknown]         [k] 0xffffffffaea00a67
      16.45%  sleep    libc-2.28.so      [.] __GI__IO_un_link.part.1
       5.92%  sleep    ld-2.28.so        [.] _dl_setup_hash
       1.40%  sleep    libc-2.28.so      [.] __nanosleep
       0.00%  sleep    [unknown]         [k] 0xffffffffaea00163

  #
  # (Tip: To see callchains in a more compact form: perf report -g folded)
  #
  $

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/304b0a59-942c-3fe1-da02-aa749f87108b@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c |   5 +-
 tools/perf/util/compress.h  |  11 ++++
 tools/perf/util/session.c   | 116 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/session.h   |  10 ++++
 tools/perf/util/zstd.c      |  41 +++++++++++++
 5 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91e27ac297c2..1ca533f06a4c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1258,6 +1258,9 @@ int cmd_report(int argc, const char **argv)
 	if (session == NULL)
 		return -1;
 
+	if (zstd_init(&(session->zstd_data), 0) < 0)
+		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
+
 	if (report.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
 					       report.queue_size);
@@ -1448,7 +1451,7 @@ int cmd_report(int argc, const char **argv)
 error:
 	if (report.ptime_range)
 		zfree(&report.ptime_range);
-
+	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return ret;
 }
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 1041a4fd81e2..0cd3369af2a4 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -20,6 +20,7 @@ bool lzma_is_compressed(const char *input);
 struct zstd_data {
 #ifdef HAVE_ZSTD_SUPPORT
 	ZSTD_CStream	*cstream;
+	ZSTD_DStream	*dstream;
 #endif
 };
 
@@ -31,6 +32,9 @@ int zstd_fini(struct zstd_data *data);
 size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
 				       size_t process_header(void *record, size_t increment));
+
+size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size,
+			      void *dst, size_t dst_size);
 #else /* !HAVE_ZSTD_SUPPORT */
 
 static inline int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
@@ -52,6 +56,13 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
 {
 	return 0;
 }
+
+static inline size_t zstd_decompress_stream(struct zstd_data *data __maybe_unused, void *src __maybe_unused,
+					    size_t src_size __maybe_unused, void *dst __maybe_unused,
+					    size_t dst_size __maybe_unused)
+{
+	return 0;
+}
 #endif
 
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ec1dec86d0e1..2310a1752983 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,61 @@
 #include "stat.h"
 #include "arch/common.h"
 
+#ifdef HAVE_ZSTD_SUPPORT
+static int perf_session__process_compressed_event(struct perf_session *session,
+						  union perf_event *event, u64 file_offset)
+{
+	void *src;
+	size_t decomp_size, src_size;
+	u64 decomp_last_rem = 0;
+	size_t decomp_len = session->header.env.comp_mmap_len;
+	struct decomp *decomp, *decomp_last = session->decomp_last;
+
+	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
+		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (decomp == MAP_FAILED) {
+		pr_err("Couldn't allocate memory for decompression\n");
+		return -1;
+	}
+
+	decomp->file_pos = file_offset;
+	decomp->head = 0;
+
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
+		decomp->size = decomp_last_rem;
+	}
+
+	src = (void *)event + sizeof(struct compressed_event);
+	src_size = event->pack.header.size - sizeof(struct compressed_event);
+
+	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
+				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
+	if (!decomp_size) {
+		munmap(decomp, sizeof(struct decomp) + decomp_len);
+		pr_err("Couldn't decompress data\n");
+		return -1;
+	}
+
+	decomp->size += decomp_size;
+
+	if (session->decomp == NULL) {
+		session->decomp = decomp;
+		session->decomp_last = decomp;
+	} else {
+		session->decomp_last->next = decomp;
+		session->decomp_last = decomp;
+	}
+
+	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
+
+	return 0;
+}
+#else /* !HAVE_ZSTD_SUPPORT */
+#define perf_session__process_compressed_event perf_session__process_compressed_event_stub
+#endif
+
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       struct perf_tool *tool,
@@ -197,6 +252,21 @@ static void perf_session__delete_threads(struct perf_session *session)
 	machine__delete_threads(&session->machines.host);
 }
 
+static void perf_session__release_decomp_events(struct perf_session *session)
+{
+	struct decomp *next, *decomp;
+	size_t decomp_len;
+	next = session->decomp;
+	decomp_len = session->header.env.comp_mmap_len;
+	do {
+		decomp = next;
+		if (decomp == NULL)
+			break;
+		next = decomp->next;
+		munmap(decomp, decomp_len + sizeof(struct decomp));
+	} while (1);
+}
+
 void perf_session__delete(struct perf_session *session)
 {
 	if (session == NULL)
@@ -205,6 +275,7 @@ void perf_session__delete(struct perf_session *session)
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
+	perf_session__release_decomp_events(session);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data)
@@ -439,7 +510,7 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 	if (tool->feature == NULL)
 		tool->feature = process_event_op2_stub;
 	if (tool->compressed == NULL)
-		tool->compressed = perf_session__process_compressed_event_stub;
+		tool->compressed = perf_session__process_compressed_event;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -1725,6 +1796,8 @@ static int perf_session__flush_thread_stacks(struct perf_session *session)
 
 volatile int session_done;
 
+static int __perf_session__process_decomp_events(struct perf_session *session);
+
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
@@ -1805,6 +1878,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	if (skip > 0)
 		head += skip;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out_err;
+
 	if (!session_done())
 		goto more;
 done:
@@ -1853,6 +1930,39 @@ fetch_mmaped_event(struct perf_session *session,
 	return event;
 }
 
+static int __perf_session__process_decomp_events(struct perf_session *session)
+{
+	s64 skip;
+	u64 size, file_pos = 0;
+	struct decomp *decomp = session->decomp_last;
+
+	if (!decomp)
+		return 0;
+
+	while (decomp->head < decomp->size && !session_done()) {
+		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
+
+		if (!event)
+			break;
+
+		size = event->header.size;
+
+		if (size < sizeof(struct perf_event_header) ||
+		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+				decomp->file_pos + decomp->head, event->header.size, event->header.type);
+			return -EINVAL;
+		}
+
+		if (skip)
+			size += skip;
+
+		decomp->head += size;
+	}
+
+	return 0;
+}
+
 /*
  * On 64bit we can mmap the data file in one go. No need for tiny mmap
  * slices. On 32bit we use 32MB.
@@ -1962,6 +2072,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	head += size;
 	file_pos += size;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out;
+
 	ui_progress__update(prog, size);
 
 	if (session_done())
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 6c984c895924..dd8920b745bc 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -39,6 +39,16 @@ struct perf_session {
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;
+	struct decomp		*decomp;
+	struct decomp		*decomp_last;
+};
+
+struct decomp {
+	struct decomp *next;
+	u64 file_pos;
+	u64 head;
+	size_t size;
+	char data[];
 };
 
 struct perf_tool;
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 359ec9a9d306..23bdb9884576 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -9,6 +9,21 @@ int zstd_init(struct zstd_data *data, int level)
 {
 	size_t ret;
 
+	data->dstream = ZSTD_createDStream();
+	if (data->dstream == NULL) {
+		pr_err("Couldn't create decompression stream.\n");
+		return -1;
+	}
+
+	ret = ZSTD_initDStream(data->dstream);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	if (!level)
+		return 0;
+
 	data->cstream = ZSTD_createCStream();
 	if (data->cstream == NULL) {
 		pr_err("Couldn't create compression stream.\n");
@@ -26,6 +41,11 @@ int zstd_init(struct zstd_data *data, int level)
 
 int zstd_fini(struct zstd_data *data)
 {
+	if (data->dstream) {
+		ZSTD_freeDStream(data->dstream);
+		data->dstream = NULL;
+	}
+
 	if (data->cstream) {
 		ZSTD_freeCStream(data->cstream);
 		data->cstream = NULL;
@@ -68,3 +88,24 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t
 
 	return compressed;
 }
+
+size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size,
+			      void *dst, size_t dst_size)
+{
+	size_t ret;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output = { dst, dst_size, 0 };
+
+	while (input.pos < input.size) {
+		ret = ZSTD_decompressStream(data->dstream, &output, &input);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to decompress (B): %ld -> %ld : %s\n",
+			       src_size, output.size, ZSTD_getErrorName(ret));
+			break;
+		}
+		output.dst  = dst + output.pos;
+		output.size = dst_size - output.pos;
+	}
+
+	return output.pos;
+}
-- 
2.20.1

