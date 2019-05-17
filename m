Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D221734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122012;
	bh=PsOht2GsQjF/Ujb6+nhh+Sjg6LUp9rrh9zuEGkQIrKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8WU1BenhPyFVYlR+7Faoo/KA8tKq6zcm0tjeU+7iYTLSlz5y+COYqXON9Emfl8tS
	 CpIA6crXS76PwSdClXPuexT6NVmFTTX/5jGuhyjyJjq6M92wpkYzm9oSe0ORPhSE99
	 KNjPap15TA5PTNBkFhECiiuMH02x4poUCrins9Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfEQTkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbfEQTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:07 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905FC216FD;
        Fri, 17 May 2019 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122006;
        bh=PsOht2GsQjF/Ujb6+nhh+Sjg6LUp9rrh9zuEGkQIrKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZR+DQSg6kZiy2mE+xcPf9/85l7rhAZN4C0h0GPSb5BtLnpuatSO47MCcuIJGAANpF
         WgSSo/3x7cEO2PmdgxiZwY/wB+TGBEhvrEZbvWMVPhVoohsQivE/gb0VOOBU6Ppkpv
         09VSZv7DbfLcpSZnDVoKuGZ+K6X2h/q2IGKIAimA=
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
Subject: [PATCH 51/73] perf tools: Introduce Zstd streaming based compression API
Date:   Fri, 17 May 2019 16:35:49 -0300
Message-Id: <20190517193611.4974-52-acme@kernel.org>
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
 tools/perf/util/compress.h | 42 +++++++++++++++++++++++
 tools/perf/util/zstd.c     | 70 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 tools/perf/util/zstd.c

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
-- 
2.20.1

