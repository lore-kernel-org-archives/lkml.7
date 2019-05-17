Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418EA2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122017;
	bh=NZje17G8lDpjFMwYMuinqIiNSt4M9jodSTQpBBpfRAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zbaqiVZSuNCUfHpBGmES3NUJ5mDJ3uAHNqt5iHz1I+Nm5hpNzwC+JVF5ZcslLqBR2
	 w9eL0V0GsEea26SPQm3o0HD96U/7VNY3E2rtNW7kptfoanybUtTkNi4Jy8PUApa3Z0
	 /y51e28Osl/YoxFuYQDf6+5XugGAGioUKrR4JZb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfEQTkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbfEQTkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:11 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C6F2173C;
        Fri, 17 May 2019 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122010;
        bh=NZje17G8lDpjFMwYMuinqIiNSt4M9jodSTQpBBpfRAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDkgmfbEC/P5/qObe7IX7Xd/5EyLInFz/dKGpluGO/6uu5cnHBQcVRJ64BJKfY2/h
         aQ++kIdoYc2Wf6fG5zPUx5jwLI5+cZ6FnXjFg1FsNohmkzAQZeawbK47YYYHri5sXg
         GjyRUJJbrHUyUp5JtD6Fo6YId1RxI8Olrk/nyREA=
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
Subject: [PATCH 52/73] perf record: Implement compression for serial trace streaming
Date:   Fri, 17 May 2019 16:35:50 -0300
Message-Id: <20190517193611.4974-53-acme@kernel.org>
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

Compression is implemented using the functions from zstd.c. As the
memory to operate on the compression uses mmap->data buffer.

If Zstd streaming compression API fails for some reason the data to be
compressed are just copied into the memory buffers using plain memcpy().

Compressed trace frame consists of an array of PERF_RECORD_COMPRESSED
records. Each element of the array is not longer that
PERF_SAMPLE_MAX_SIZE and consists of perf_event_header followed by the
compressed chunk that is decompressed on the loading stage.

Comitter notes:

Undo some unnecessary line breaks, remove some unnecessary () around
zstd_data to then just get its address, and fix conflicts with
BPF_PROG_INFO/BPF_BTF patchkits.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/744df43f-3932-2594-ddef-1e99a3cad03a@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 51 +++++++++++++++++++++++++++++++++++--
 tools/perf/util/session.h   |  2 ++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ca6d7488e34b..de9632c69852 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -133,6 +133,9 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 	return 0;
 }
 
+static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
+			    void *src, size_t src_size);
+
 #ifdef HAVE_AIO_SUPPORT
 static int record__aio_write(struct aiocb *cblock, int trace_fd,
 		void *buf, size_t size, off_t off)
@@ -392,6 +395,11 @@ static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size
 {
 	struct record *rec = to;
 
+	if (record__comp_enabled(rec)) {
+		size = zstd_compress(rec->session, map->data, perf_mmap__mmap_len(map), bf, size);
+		bf   = map->data;
+	}
+
 	rec->samples++;
 	return record__write(rec, map, bf, size);
 }
@@ -778,6 +786,37 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 	}
 }
 
+static size_t process_comp_header(void *record, size_t increment)
+{
+	struct compressed_event *event = record;
+	size_t size = sizeof(*event);
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
+	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
+						     max_record_size, process_comp_header);
+
+	session->bytes_transferred += src_size;
+	session->bytes_compressed  += compressed;
+
+	return compressed;
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite, bool synch)
 {
@@ -1225,6 +1264,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
+	if (zstd_init(&session->zstd_data, rec->opts.comp_level) < 0) {
+		pr_err("Compression initialization failed.\n");
+		return -1;
+	}
+
+	session->header.env.comp_type  = PERF_COMP_ZSTD;
+	session->header.env.comp_level = rec->opts.comp_level;
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
@@ -1565,6 +1612,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	zstd_fini(&session->zstd_data);
 	perf_session__delete(session);
 
 	if (!opts->no_bpf_event)
@@ -2294,8 +2342,7 @@ int cmd_record(int argc, const char **argv)
 
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

