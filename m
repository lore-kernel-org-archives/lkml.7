Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FECC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0AD20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VQp0R1Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfERJWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:22:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:22:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9MVVP1739127
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:22:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9MVVP1739127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171351;
        bh=sdZAATLzm52Z0/jInaQGYxsiymrbEglKbG6HDEpCeHw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VQp0R1LyeBUyViKKsRuYv1AWBbCG77POv69y1A8Livc5n5svv++bib9/nfEC1sTV/
         ck/ik+Km27N4DNKZNw5J+f8mhMglj2r8Jb0jUlT2yCAj7kH1JQptMjm/+jbqR3tZw3
         /RKZZboPYdAjsVfonU+8RFwn7v5j8NTqMYCN3/2b271igDRLPGPpAGZxOj37SPyjF/
         P7+1ygKZnwlY/Khc5wQdH/VY9BLKfuj2VFnK+7sJuqAfsbqhnOB0m1X9eYZEA+zdLh
         YxO8hMn+MXLsudmYZYRc20aWFY1vrcg2vzLE7LZY2BPdn0zG/N9K+it4zeuZyMSeap
         cI8ELkpD9srKA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9MUNa1739124;
        Sat, 18 May 2019 02:22:30 -0700
Date:   Sat, 18 May 2019 02:22:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-5d7f41164930ecc1797702b7f9728ac702609ef3@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexey.budankov@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, peterz@infradead.org, ak@linux.intel.com,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <744df43f-3932-2594-ddef-1e99a3cad03a@linux.intel.com>
References: <744df43f-3932-2594-ddef-1e99a3cad03a@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Implement compression for serial trace
 streaming
Git-Commit-ID: 5d7f41164930ecc1797702b7f9728ac702609ef3
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

Commit-ID:  5d7f41164930ecc1797702b7f9728ac702609ef3
Gitweb:     https://git.kernel.org/tip/5d7f41164930ecc1797702b7f9728ac702609ef3
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:43:35 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf record: Implement compression for serial trace streaming

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
 tools/perf/builtin-record.c | 51 +++++++++++++++++++++++++++++++++++++++++++--
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
@@ -1565,6 +1612,7 @@ out_child:
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
