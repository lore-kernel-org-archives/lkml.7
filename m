Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B322BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FB220578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455680;
	bh=g6aXuM+CiPZJOBpBGAoFsTFDVwL7knX4n7fz+wo9AXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jlR941RAcxPCltD7wQOmqoUM4a0DcLryyfubVwd1o0Djeh5oqDGMAITdL03oTDwf4
	 Jq02ca+LRXHk2JmHPnshB0ULJbts6xpO6v39YlmsKH+mcafGv4R8I/J5SO7Z7VnWRG
	 GWIS5Ir+6MkQaYFJSVkNCPNWp5BQ9xVGueX2maE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfG3DBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbfG3DBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E13F2171F;
        Tue, 30 Jul 2019 03:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455675;
        bh=g6aXuM+CiPZJOBpBGAoFsTFDVwL7knX4n7fz+wo9AXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqdZThQT5j93zdw3bAD6thWS0c+z3Q8GBID7sLKktKXgc3krXYTqvs0hzouO6pnkU
         /okFCVGbSLJoiwU+ikIDbdSKGNGwmafpJBl8fa7txBqOoD8KOP5mYGpvyN0BeFBUMU
         tfrSyP9lbO+qxOD5X3n5kpec1hdqNtD7QlQn5+iw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 087/107] libperf: Adopt the readn()/writen() functions from tools/perf
Date:   Mon, 29 Jul 2019 23:55:50 -0300
Message-Id: <20190730025610.22603-88-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the readn()/writen() functions into libperf.

Keep those non-namespaced names because they will be shared only between
perf and libperf.

Again, these are not exported functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-61-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                  |  1 +
 tools/perf/lib/include/internal/lib.h | 10 ++++++
 tools/perf/lib/lib.c                  | 46 +++++++++++++++++++++++++++
 tools/perf/util/util.c                | 40 -----------------------
 tools/perf/util/util.h                |  4 +--
 5 files changed, 58 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/lib.h
 create mode 100644 tools/perf/lib/lib.c

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 4f78ec0b4e10..c31f1c111f8f 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -5,6 +5,7 @@ libperf-y += evsel.o
 libperf-y += evlist.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
+libperf-y += lib.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
new file mode 100644
index 000000000000..0b56f1201dc9
--- /dev/null
+++ b/tools/perf/lib/include/internal/lib.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_LIB_H
+#define __LIBPERF_INTERNAL_LIB_H
+
+#include <unistd.h>
+
+ssize_t readn(int fd, void *buf, size_t n);
+ssize_t writen(int fd, const void *buf, size_t n);
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
new file mode 100644
index 000000000000..2a81819c3b8c
--- /dev/null
+++ b/tools/perf/lib/lib.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <linux/kernel.h>
+#include <internal/lib.h>
+
+static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
+{
+	void *buf_start = buf;
+	size_t left = n;
+
+	while (left) {
+		/* buf must be treated as const if !is_read. */
+		ssize_t ret = is_read ? read(fd, buf, left) :
+					write(fd, buf, left);
+
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			return ret;
+
+		left -= ret;
+		buf  += ret;
+	}
+
+	BUG_ON((size_t)(buf - buf_start) != n);
+	return n;
+}
+
+/*
+ * Read exactly 'n' bytes or return an error.
+ */
+ssize_t readn(int fd, void *buf, size_t n)
+{
+	return ion(true, fd, buf, n);
+}
+
+/*
+ * Write exactly 'n' bytes or return an error.
+ */
+ssize_t writen(int fd, const void *buf, size_t n)
+{
+	/* ion does not modify buf. */
+	return ion(false, fd, (void *)buf, n);
+}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index a61535cf1bca..9c3c97697387 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -384,46 +384,6 @@ int copyfile(const char *from, const char *to)
 	return copyfile_mode(from, to, 0755);
 }
 
-static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
-{
-	void *buf_start = buf;
-	size_t left = n;
-
-	while (left) {
-		/* buf must be treated as const if !is_read. */
-		ssize_t ret = is_read ? read(fd, buf, left) :
-					write(fd, buf, left);
-
-		if (ret < 0 && errno == EINTR)
-			continue;
-		if (ret <= 0)
-			return ret;
-
-		left -= ret;
-		buf  += ret;
-	}
-
-	BUG_ON((size_t)(buf - buf_start) != n);
-	return n;
-}
-
-/*
- * Read exactly 'n' bytes or return an error.
- */
-ssize_t readn(int fd, void *buf, size_t n)
-{
-	return ion(true, fd, buf, n);
-}
-
-/*
- * Write exactly 'n' bytes or return an error.
- */
-ssize_t writen(int fd, const void *buf, size_t n)
-{
-	/* ion does not modify buf. */
-	return ion(false, fd, (void *)buf, n);
-}
-
 size_t hex_width(u64 v)
 {
 	size_t n = 1;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc7a469921e9..0dab140c6517 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,6 +11,7 @@
 #include <stddef.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
+#include <internal/lib.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -30,9 +31,6 @@ int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
 int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
-ssize_t readn(int fd, void *buf, size_t n);
-ssize_t writen(int fd, const void *buf, size_t n);
-
 size_t hex_width(u64 v);
 
 extern unsigned int page_size;
-- 
2.21.0

