Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA928C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9699206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381124;
	bh=3WIjhYQQEPXwsAakI6nGKfO2xDfMv/9pILscU/sx6JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SgrAs1n8SBqE/NDvvj5UnSLogaBTBQTDPrBQ3a+3PGBktHs59c9Vee8u/VdBoDOAi
	 b1s5zi24RkBD7i6I1T9+LskyA9xKzX6b0/+0I8U+jh6LBWQc5x9cfPdpZcvdeQiz+q
	 ABAsDJJFXmv2ooy4zkAxcF/dp6td64QS1kd5ViHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbfIMNZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390988AbfIMNZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABE8C7F746;
        Fri, 13 Sep 2019 13:25:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE3F5C219;
        Fri, 13 Sep 2019 13:25:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 32/73] libperf: Move page_size into libperf
Date:   Fri, 13 Sep 2019 15:23:14 +0200
Message-Id: <20190913132355.21634-33-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 13 Sep 2019 13:25:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need page_size in libperf, so moving it in there.
Adding libperf_init as a global libperf init functon.

Link: http://lkml.kernel.org/n/tip-g6auuaej31nsusuevuhcgxli@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/core.c                 | 7 +++++++
 tools/perf/lib/include/internal/lib.h | 2 ++
 tools/perf/lib/include/perf/core.h    | 1 +
 tools/perf/lib/lib.c                  | 2 ++
 tools/perf/lib/libperf.map            | 1 +
 tools/perf/perf.c                     | 4 ++--
 tools/perf/util/util.h                | 2 --
 7 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
index 29d5e3348718..6689d593c2d1 100644
--- a/tools/perf/lib/core.c
+++ b/tools/perf/lib/core.c
@@ -4,7 +4,9 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#include <unistd.h>
 #include <perf/core.h>
+#include <internal/lib.h>
 #include "internal.h"
 
 static int __base_pr(enum libperf_print_level level, const char *format,
@@ -32,3 +34,8 @@ void libperf_print(enum libperf_print_level level, const char *format, ...)
 	__libperf_pr(level, format, args);
 	va_end(args);
 }
+
+void libperf_init(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+}
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
index 0b56f1201dc9..9168b7d2a7e1 100644
--- a/tools/perf/lib/include/internal/lib.h
+++ b/tools/perf/lib/include/internal/lib.h
@@ -4,6 +4,8 @@
 
 #include <unistd.h>
 
+extern unsigned int page_size;
+
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index c341a7b2c874..ba2f4e76a3e2 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -18,5 +18,6 @@ typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
 				  const char *, va_list ap);
 
 LIBPERF_API void libperf_set_print(libperf_print_fn_t fn);
+LIBPERF_API void libperf_init(void);
 
 #endif /* __LIBPERF_CORE_H */
diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
index 2a81819c3b8c..18658931fc71 100644
--- a/tools/perf/lib/lib.c
+++ b/tools/perf/lib/lib.c
@@ -5,6 +5,8 @@
 #include <linux/kernel.h>
 #include <internal/lib.h>
 
+unsigned int page_size;
+
 static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
 {
 	void *buf_start = buf;
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index dc4d66363bc4..3fbf050b5add 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,5 +1,6 @@
 LIBPERF_0.0.1 {
 	global:
+		libperf_init;
 		libperf_set_print;
 		perf_cpu_map__dummy_new;
 		perf_cpu_map__get;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1193b923e801..ead18b712d6c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -25,6 +25,7 @@
 #include "perf-sys.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
+#include <internal/lib.h>
 #include <errno.h>
 #include <pthread.h>
 #include <signal.h>
@@ -438,8 +439,7 @@ int main(int argc, const char **argv)
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
 
-	/* The page_size is placed in util object. */
-	page_size = sysconf(_SC_PAGE_SIZE);
+	libperf_init();
 
 	cmd = extract_argv0_path(argv[0]);
 	if (!cmd)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 45a5c6f20197..d6ae394e67c4 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -33,8 +33,6 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
 size_t hex_width(u64 v);
 
-extern unsigned int page_size;
-
 int sysctl__max_stack(void);
 
 int fetch_kernel_version(unsigned int *puint,
-- 
2.21.0

