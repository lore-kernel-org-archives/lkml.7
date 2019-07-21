Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2FC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07CA2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708704;
	bh=w36KDlf9zweHwqWo6Wc2Mqvhp7TRLtI/v0NN3qH/8X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D44iWBhC+PKAAEQjI9pEFswU7gvAvfGwso18zI3Gn3tfdlpMYeEyfEpUlvjPVQPBw
	 Bdv0HqK4K7p11RumMYb2ta4womChY10HAHTF63Z4cMWX7lKsI7mztB0zk9cntE5P0I
	 PXxX6KkpvOit6BETrtQEUVeWCSnXQhhoM+UHkJQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGULbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 715ED83F3F;
        Sun, 21 Jul 2019 11:31:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9F25D9D3;
        Sun, 21 Jul 2019 11:31:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 60/79] libperf: Add readn/writen function
Date:   Sun, 21 Jul 2019 13:24:47 +0200
Message-Id: <20190721112506.12306-61-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 21 Jul 2019 11:31:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving readn/writen functions into libperf. Keeping the name
because they will be shared only between perf and libperf.

These are not exported functions.

Link: http://lkml.kernel.org/n/tip-my4n8qzlt98b0xjxbljscl7r@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

