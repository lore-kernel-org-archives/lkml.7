Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E5C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210832087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JEbaAlFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfERJWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:22:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:21:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9LlCW1739064
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:21:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9LlCW1739064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171307;
        bh=JN5L4QzSYCIpcc1mz6cgi4dRfmSNKY+8/f2TPOR+w/w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JEbaAlFPAqRP2RPfc6krklgljjxXN7RE/lzm6aXM4TUObjKepHrzRA5YmXWqQAuMp
         PbaTt2fhgtwC4J/h7R5LC9rhDx3R8OBlPPN6MXEetxnndEk8yv0MW2m/p7q7AtmKaE
         lTaaVYmoY/glvHexYIilThWG/ol+9tz55eeORUnDLCMOn3i7wEia0FBHK/ZtGMcgWD
         Y55n2hz1YwhzbL9B7asHZWU1EQ20tngwLGz9B8Gqxg34oqORbyMqyLX+yJp66QpZcJ
         6kmYlLS7mG+vJCK8diGo1Y8y2aL/l4kU0lgUBwGx6NUjZS4nrOPkBDMeRfvsWVpbQ7
         X2Tm2vP+2EYWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9LkC01739061;
        Sat, 18 May 2019 02:21:46 -0700
Date:   Sat, 18 May 2019 02:21:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-f24c1d7523e6db26ec2115a308750c875927741b@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, alexey.budankov@linux.intel.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@kernel.org,
        ak@linux.intel.com
Reply-To: ak@linux.intel.com, mingo@kernel.org,
          alexey.budankov@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com, namhyung@kernel.org,
          acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <18bf36f3-b85a-1fe2-dd83-10e0c6069568@linux.intel.com>
References: <18bf36f3-b85a-1fe2-dd83-10e0c6069568@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Introduce Zstd streaming based
 compression API
Git-Commit-ID: f24c1d7523e6db26ec2115a308750c875927741b
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

Commit-ID:  f24c1d7523e6db26ec2115a308750c875927741b
Gitweb:     https://git.kernel.org/tip/f24c1d7523e6db26ec2115a308750c875927741b
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:42:55 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf tools: Introduce Zstd streaming based compression API

Implemented functions are based on Zstd streaming compression API.

The functions are used in runtime to compress data that come from mmaped
kernel buffer. zstd_init(), zstd_fini() are used for initialization and
finalization to allocate and deallocate internal zstd objects.
zstd_compress_stream_to_records() is used to convert parts of mmaped
kernel buffer into an array of PERF_RECORD_COMPRESSED records.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/18bf36f3-b85a-1fe2-dd83-10e0c6069568@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build      |  2 ++
 tools/perf/util/compress.h | 42 ++++++++++++++++++++++++++++
 tools/perf/util/zstd.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dd3102301ea..6d5bbc8b589b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -145,6 +145,8 @@ perf-y += scripting-engines/
 
 perf-$(CONFIG_ZLIB) += zlib.o
 perf-$(CONFIG_LZMA) += lzma.o
+perf-$(CONFIG_ZSTD) += zstd.o
+
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
 
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 892e92e7e7fc..1041a4fd81e2 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -2,6 +2,11 @@
 #ifndef PERF_COMPRESS_H
 #define PERF_COMPRESS_H
 
+#include <stdbool.h>
+#ifdef HAVE_ZSTD_SUPPORT
+#include <zstd.h>
+#endif
+
 #ifdef HAVE_ZLIB_SUPPORT
 int gzip_decompress_to_file(const char *input, int output_fd);
 bool gzip_is_compressed(const char *input);
@@ -12,4 +17,41 @@ int lzma_decompress_to_file(const char *input, int output_fd);
 bool lzma_is_compressed(const char *input);
 #endif
 
+struct zstd_data {
+#ifdef HAVE_ZSTD_SUPPORT
+	ZSTD_CStream	*cstream;
+#endif
+};
+
+#ifdef HAVE_ZSTD_SUPPORT
+
+int zstd_init(struct zstd_data *data, int level);
+int zstd_fini(struct zstd_data *data);
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
+				       void *src, size_t src_size, size_t max_record_size,
+				       size_t process_header(void *record, size_t increment));
+#else /* !HAVE_ZSTD_SUPPORT */
+
+static inline int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
+{
+	return 0;
+}
+
+static inline int zstd_fini(struct zstd_data *data __maybe_unused)
+{
+	return 0;
+}
+
+static inline
+size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
+				       void *dst __maybe_unused, size_t dst_size __maybe_unused,
+				       void *src __maybe_unused, size_t src_size __maybe_unused,
+				       size_t max_record_size __maybe_unused,
+				       size_t process_header(void *record, size_t increment) __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
new file mode 100644
index 000000000000..359ec9a9d306
--- /dev/null
+++ b/tools/perf/util/zstd.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+
+#include "util/compress.h"
+#include "util/debug.h"
+
+int zstd_init(struct zstd_data *data, int level)
+{
+	size_t ret;
+
+	data->cstream = ZSTD_createCStream();
+	if (data->cstream == NULL) {
+		pr_err("Couldn't create compression stream.\n");
+		return -1;
+	}
+
+	ret = ZSTD_initCStream(data->cstream, level);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+int zstd_fini(struct zstd_data *data)
+{
+	if (data->cstream) {
+		ZSTD_freeCStream(data->cstream);
+		data->cstream = NULL;
+	}
+
+	return 0;
+}
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
+				       void *src, size_t src_size, size_t max_record_size,
+				       size_t process_header(void *record, size_t increment))
+{
+	size_t ret, size, compressed = 0;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output;
+	void *record;
+
+	while (input.pos < input.size) {
+		record = dst;
+		size = process_header(record, 0);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+		output = (ZSTD_outBuffer){ dst, (dst_size > max_record_size) ?
+						max_record_size : dst_size, 0 };
+		ret = ZSTD_compressStream(data->cstream, &output, &input);
+		ZSTD_flushStream(data->cstream, &output);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to compress %ld bytes: %s\n",
+				(long)src_size, ZSTD_getErrorName(ret));
+			memcpy(dst, src, src_size);
+			return src_size;
+		}
+		size = output.pos;
+		size = process_header(record, size);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+	}
+
+	return compressed;
+}
