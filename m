Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01ACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DDF214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCLFZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:25:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:15477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfCLFZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:25:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 22:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,469,1544515200"; 
   d="scan'208";a="206860672"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2019 22:25:25 -0700
Received: from [10.252.11.175] (abudanko-mobl.ccr.corp.intel.com [10.252.11.175])
        by linux.intel.com (Postfix) with ESMTP id 38F2C58046F;
        Mon, 11 Mar 2019 22:25:22 -0700 (PDT)
Subject: [PATCH v7 07/12] perf record: implement compression for serial trace
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
Message-ID: <ab5980ca-be72-c423-6c2e-f48e23797364@linux.intel.com>
Date:   Tue, 12 Mar 2019 08:25:21 +0300
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
to operate on the compression uses mmap->data buffer. If Zstd streaming
compression API fails for some reason the data to be compressed are just
copied into the memory buffers using plain memcpy().

Compressed trace frame consists of an array of PERF_RECORD_COMPRESSED
records. Each element of the array is not longer that PERF_SAMPLE_MAX_SIZE
and consists of perf_event_header followed by the compressed chunk
that is decompressed on the loading stage.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 52 +++++++++++++++++++++++++++++++++++--
 tools/perf/util/session.h   |  2 ++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c4ce5a9c9e3f..d13c0dd87592 100644
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
@@ -387,6 +390,12 @@ static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size
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
@@ -773,6 +782,37 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
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
+	} else {
+		event->header.type = PERF_RECORD_COMPRESSED;
+		event->header.size = size;
+		return size;
+	}
+}
+
+static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
+			    void *src, size_t src_size)
+{
+	size_t compressed;
+	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct compressed_event);
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
@@ -1202,6 +1242,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -1535,6 +1583,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return status;
 }
@@ -2252,8 +2301,7 @@ int cmd_record(int argc, const char **argv)
 
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

