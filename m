Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8290C222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458169;
	bh=Sj4A6FIx26R73d05tBu/6Ut0tmCLcx/BJSYVcvNfRZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0tkPutJ3900Ul+4Q0SRC29MN5vVB5nDxdLro/SWLDyJtAnGkAa06Yw87SMSpyGro6
	 OAyl/GYTy16HwJadZ3BEog2JasB5Q+4ouF2LjFkuEljFwXgLwFU8UBogp5UfUx0bKM
	 QpERKa7D8Rrk3C1A15BSGSycMSrDE4aIT2/73t1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbfIZAgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390168AbfIZAgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:00 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1352B217F4;
        Thu, 26 Sep 2019 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458159;
        bh=Sj4A6FIx26R73d05tBu/6Ut0tmCLcx/BJSYVcvNfRZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaLcMT4Ic3H41zJ8rxwDeOqCxbwHK7e0qXKY1lWW0KOF9s/4YSsJJ9XT4v2uzZURt
         Q5XY+8KX0kzg27861igEvTwwIAtf7XYD/e40zrKJKsMtFFxWKtMTep7QPyLBDbSNTf
         sNoZrPQoTLERLdvpJG51tLZI9XNHKYAYLXOJtmkY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 50/66] libperf: Merge libperf_set_print() into libperf_init()
Date:   Wed, 25 Sep 2019 21:32:28 -0300
Message-Id: <20190926003244.13962-51-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The libperf_set_print() function needs to be called in any case so let's
merge it with libperf_init(), so we have just one init function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 724da66776ef..5eb0150ccdc6 100644
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
index c012ceb64ff9..27f94b0bb874 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -430,6 +430,12 @@ void pthread__unblock_sigwinch(void)
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
@@ -440,7 +446,7 @@ int main(int argc, const char **argv)
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
 
-	libperf_init();
+	libperf_init(libperf_print);
 
 	cmd = extract_argv0_path(argv[0]);
 	if (!cmd)
-- 
2.21.0

