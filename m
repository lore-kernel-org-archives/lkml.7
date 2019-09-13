Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA0C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3A206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381128;
	bh=ij5P3bcv8gyDN884zlPHIushpEpNd37yZ8A9qQ9uMCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPF6mTO5QbSjlYdrHnbzk33YL5TXc3ShKWlEkQV8CFWUGJQaFsiH9wYuCh1mpq90v
	 Ctd1GD06q3PIETDQnDgcwcdz/85FFk5twvhFbfQ8Wg7FE4ztWRxcWpxqTjGLLvY/tw
	 /Qwo7U5pZOOIlz4VhQt7g5gUcNNJ/5a1m1onHmCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbfIMNZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390988AbfIMNZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FE4C1DA4;
        Fri, 13 Sep 2019 13:25:24 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C275C1D4;
        Fri, 13 Sep 2019 13:25:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 33/73] libperf: Merge libperf_set_print in libperf_init
Date:   Fri, 13 Sep 2019 15:23:15 +0200
Message-Id: <20190913132355.21634-34-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 13 Sep 2019 13:25:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libperf_set_print needs to be called in any
case so let's merge it with libperf_init, so
we have just one init function.

Link: http://lkml.kernel.org/n/tip-ak1oqlj43qsbioo7q9m5fg9t@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/core.c              | 8 ++------
 tools/perf/lib/include/perf/core.h | 3 +--
 tools/perf/lib/libperf.map         | 1 -
 tools/perf/perf.c                  | 8 +++++++-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
index 6689d593c2d1..d0b9ae422b9f 100644
--- a/tools/perf/lib/core.c
+++ b/tools/perf/lib/core.c
@@ -17,11 +17,6 @@ static int __base_pr(enum libperf_print_level level, const char *format,
 
 static libperf_print_fn_t __libperf_pr = __base_pr;
 
-void libperf_set_print(libperf_print_fn_t fn)
-{
-	__libperf_pr = fn;
-}
-
 __printf(2, 3)
 void libperf_print(enum libperf_print_level level, const char *format, ...)
 {
@@ -35,7 +30,8 @@ void libperf_print(enum libperf_print_level level, const char *format, ...)
 	va_end(args);
 }
 
-void libperf_init(void)
+void libperf_init(libperf_print_fn_t fn)
 {
 	page_size = sysconf(_SC_PAGE_SIZE);
+	__libperf_pr = fn;
 }
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index ba2f4e76a3e2..cfd70e720c1c 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -17,7 +17,6 @@ enum libperf_print_level {
 typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
 				  const char *, va_list ap);
 
-LIBPERF_API void libperf_set_print(libperf_print_fn_t fn);
-LIBPERF_API void libperf_init(void);
+LIBPERF_API void libperf_init(libperf_print_fn_t fn);
 
 #endif /* __LIBPERF_CORE_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 3fbf050b5add..507b4cc4784c 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,7 +1,6 @@
 LIBPERF_0.0.1 {
 	global:
 		libperf_init;
-		libperf_set_print;
 		perf_cpu_map__dummy_new;
 		perf_cpu_map__get;
 		perf_cpu_map__put;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index ead18b712d6c..d13a9b1ce65d 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -429,6 +429,12 @@ void pthread__unblock_sigwinch(void)
 	pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 }
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return eprintf(level, verbose, fmt, ap);
+}
+
 int main(int argc, const char **argv)
 {
 	int err;
@@ -439,7 +445,7 @@ int main(int argc, const char **argv)
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
 
-	libperf_init();
+	libperf_init(libperf_print);
 
 	cmd = extract_argv0_path(argv[0]);
 	if (!cmd)
-- 
2.21.0

