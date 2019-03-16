Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13361C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C3421900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCPOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:14:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:65203 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfCPOOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:14:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 07:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,486,1544515200"; 
   d="scan'208";a="123224212"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2019 07:14:36 -0700
Received: from [10.252.10.233] (abudanko-mobl.ccr.corp.intel.com [10.252.10.233])
        by linux.intel.com (Postfix) with ESMTP id 1BE7958028E;
        Sat, 16 Mar 2019 07:14:33 -0700 (PDT)
Subject: [PATCH v9 07/12] perf record: implement compression for serial trace
 streaming
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
Organization: Intel Corp.
Message-ID: <68a8175b-577f-97a4-932e-8b0e4df4d4ad@linux.intel.com>
Date:   Sat, 16 Mar 2019 17:14:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Compression is implemented using the functions from zstd.c. As the memory
to operate on the compression uses mmap->data buffer. If Zstd streaming
compression API fails for some reason the data to be compressed are just
copied into the memory buffers using plain memcpy().

Compressed trace frame consists of an array of PERF_RECORD_COMPRESSED
records. Each element of the array is not longer that PERF_SAMPLE_MAX_SIZE
and consists of perf_event_header followed by the compressed chunk
that is decompressed on the loading stage.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 53 +++++++++++++++++++++++++++++++++++--
 tools/perf/util/session.h   |  2 ++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 948489cb6ff0..c22e65f6b8e6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -130,6 +130,9 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 	return 0;
 }
 
+static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
+			    void *src, size_t src_size);
+
 #ifdef HAVE_AIO_SUPPORT
 static int record__aio_write(struct aiocb *cblock, int trace_fd,
 		void *buf, size_t size, off_t off)
@@ -389,6 +392,12 @@ static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size
 {
 	struct record *rec = to;
 
+	if (record__comp_enabled(rec)) {
+		size = zstd_compress(rec->session, map->data,
+				     perf_mmap__mmap_len(map), bf, size);
+		bf = map->data;
+	}
+
 	rec->samples++;
 	return record__write(rec, map, bf, size);
 }
@@ -775,6 +784,38 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 	}
 }
 
+static size_t process_comp_header(void *record, size_t increment)
+{
+	struct compressed_event *event = record;
+	size_t size = sizeof(struct compressed_event);
+
+	if (increment) {
+		event->header.size += increment;
+		return increment;
+	}
+
+	event->header.type = PERF_RECORD_COMPRESSED;
+	event->header.size = size;
+
+	return size;
+}
+
+static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
+			    void *src, size_t src_size)
+{
+	size_t compressed;
+	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct compressed_event) - 1;
+
+	compressed = zstd_compress_stream_to_records(&(session->zstd_data),
+				dst, dst_size, src, src_size, max_record_size,
+				process_comp_header);
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
@@ -1205,6 +1246,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -1537,6 +1586,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return status;
 }
@@ -2254,8 +2304,7 @@ int cmd_record(int argc, const char **argv)
 
 	if (rec->opts.nr_cblocks > nr_cblocks_max)
 		rec->opts.nr_cblocks = nr_cblocks_max;
-	if (verbose > 0)
-		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
 	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
 	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
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

