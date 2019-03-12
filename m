Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4758C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748C5214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfCLFgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:36:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:38915 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfCLFgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:36:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 22:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,469,1544515200"; 
   d="scan'208";a="126168059"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2019 22:36:22 -0700
Received: from [10.252.11.175] (abudanko-mobl.ccr.corp.intel.com [10.252.11.175])
        by linux.intel.com (Postfix) with ESMTP id DD77F58046F;
        Mon, 11 Mar 2019 22:36:19 -0700 (PDT)
Subject: [PATCH v7 10/12] perf report: implement record trace decompression
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
Message-ID: <54b3c3c8-2b7e-e7ba-d55e-d15cc5983ced@linux.intel.com>
Date:   Tue, 12 Mar 2019 08:36:18 +0300
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


zstd_init(, comp_level = 0) initializes decompression part of API only
that now consists of zstd_decompress_stream() function.

Trace frames containing PERF_RECORD_COMPRESSED records are decompressed
using zstd_decompress_stream() function into a linked list of mmaped 
memory regions of mmap_comp_len size (struct decomp).

After decompression of one COMPRESSED record its content is iterated and
fetched for usual processing. The mmaped memory regions with decompressed
events are kept in the linked list till the tool process termination.

When dumping raw trace (e.g., perf report -D --header) file offsets of
events from compressed records are printed as zero.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-report.c |   5 +-
 tools/perf/util/compress.h  |   4 ++
 tools/perf/util/session.c   | 124 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/session.h   |  10 +++
 tools/perf/util/tool.h      |   2 +
 tools/perf/util/zstd.c      |  48 ++++++++++++++
 6 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 05c8dd41106c..66aceca49312 100644
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
index e0987616db94..4f6672770ebb 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -20,6 +20,7 @@ bool lzma_is_compressed(const char *input);
 struct zstd_data {
 #ifdef HAVE_ZSTD_SUPPORT
 	ZSTD_CStream	*cstream;
+	ZSTD_DStream	*dstream;
 #endif
 };
 
@@ -30,4 +31,7 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data,
 	void *dst, size_t dst_size, void *src, size_t src_size,	size_t max_record_size,
 	size_t process_header(void *record, size_t increment));
 
+size_t zstd_decompress_stream(struct zstd_data *data,
+	void *src, size_t src_size, void *dst, size_t dst_size);
+
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0ec34227bd60..a2e4f1202fe4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,67 @@
 #include "stat.h"
 #include "arch/common.h"
 
+#ifdef HAVE_ZSTD_SUPPORT
+static int perf_session__process_compressed_event(struct perf_session *session,
+					union perf_event *event, u64 file_offset)
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
+static int perf_session__process_compressed_event(struct perf_session *session __maybe_unused,
+				union perf_event *event __maybe_unused,
+				u64 file_offset __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+#endif
+
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       struct perf_tool *tool,
@@ -198,12 +259,23 @@ static void perf_session__delete_threads(struct perf_session *session)
 
 void perf_session__delete(struct perf_session *session)
 {
+	struct decomp *next, *decomp;
+	size_t decomp_len;
 	if (session == NULL)
 		return;
 	auxtrace__free(session);
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
+	next = session->decomp;
+	decomp_len = session->header.env.comp_mmap_len;
+	do {
+		decomp = next;
+		if (decomp == NULL)
+			break;
+		next = decomp->next;
+		munmap(decomp, decomp_len + sizeof(struct decomp));
+	} while (1);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data)
@@ -429,6 +501,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->time_conv = process_event_op2_stub;
 	if (tool->feature == NULL)
 		tool->feature = process_event_op2_stub;
+	if (tool->compressed == NULL)
+		tool->compressed = perf_session__process_compressed_event;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -1372,7 +1446,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int err;
 
-	dump_event(session->evlist, event, file_offset, &sample);
+	if (event->header.type != PERF_RECORD_COMPRESSED)
+		dump_event(session->evlist, event, file_offset, &sample);
 
 	/* These events are processed right away */
 	switch (event->header.type) {
@@ -1425,6 +1500,11 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return tool->time_conv(session, event);
 	case PERF_RECORD_HEADER_FEATURE:
 		return tool->feature(session, event);
+	case PERF_RECORD_COMPRESSED:
+		err = tool->compressed(session, event, file_offset);
+		if (err)
+			dump_event(session->evlist, event, file_offset, &sample);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1707,6 +1787,8 @@ static int perf_session__flush_thread_stacks(struct perf_session *session)
 
 volatile int session_done;
 
+static int __perf_session__process_decomp_events(struct perf_session *session);
+
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
@@ -1787,6 +1869,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	if (skip > 0)
 		head += skip;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out_err;
+
 	if (!session_done())
 		goto more;
 done:
@@ -1835,6 +1921,38 @@ fetch_mmaped_event(struct perf_session *session,
 	return event;
 }
 
+static int __perf_session__process_decomp_events(struct perf_session *session)
+{
+	s64 skip;
+	u64 size, file_pos = 0;
+	union perf_event *event;
+	struct decomp *decomp = session->decomp_last;
+
+	if (!decomp)
+		return 0;
+
+	while (decomp->head < decomp->size && !session_done()) {
+		event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
+		if (!event)
+			break;
+
+		size = event->header.size;
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
@@ -1942,6 +2060,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 250391672f9f..9096a6e3de59 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -28,6 +28,7 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
 typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
+typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
@@ -72,6 +73,7 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature;
+	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index e5d44d0f6b5d..ca43538b8772 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -11,6 +11,21 @@ int zstd_init(struct zstd_data *data, int level)
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
@@ -28,6 +43,11 @@ int zstd_init(struct zstd_data *data, int level)
 
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
@@ -71,6 +91,27 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data,
 	return compressed;
 }
 
+size_t zstd_decompress_stream(struct zstd_data *data,
+		void *src, size_t src_size, void *dst, size_t dst_size)
+{
+	size_t ret;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output = { dst, dst_size, 0 };
+
+	while (input.pos < input.size) {
+		ret = ZSTD_decompressStream(data->dstream, &output, &input);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to decompress (B): %ld -> %ld : %s\n",
+				src_size, output.size, ZSTD_getErrorName(ret));
+			break;
+		}
+		output.dst  = dst + output.pos;
+		output.size = dst_size - output.pos;
+	}
+
+	return output.pos;
+}
+
 #else /* !HAVE_ZSTD_SUPPORT */
 
 int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
@@ -92,4 +133,11 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
 	return 0;
 }
 
+size_t zstd_decompress_stream(struct zstd_data *data __maybe_unused, void *src __maybe_unused,
+		size_t src_size __maybe_unused, void *dst __maybe_unused,
+		size_t dst_size __maybe_unused)
+{
+	return 0;
+}
+
 #endif
-- 
2.20.1

