Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF201C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CF42064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SoCtjKj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfG3S2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:28:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfG3S2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:28:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIRBmu3330078
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:27:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIRBmu3330078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511232;
        bh=5JjSI86tMyMtPM92TP2hKjaf/Gt7FRV4OORBkc5f/e0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SoCtjKj5VrweDKnLrZukgsm/cLmdd56eMtvirWpvswM4xhAecJ/2lzoxAQpmWWHuO
         sfZT6XGSFt/km5dlkt13T79q9MRDUjBIIR536VVgIy4xGvlcg8cpDeeP57k/BzFDG2
         evbZTPJhapzyA1xsYUczsb03P9n9je8EsxtTM8mW17Qg5AX6tgya7GJKixy2XrlIlQ
         bLwM+TezzckQnhlBl1OGwm5SPfj2wWEIIbdhcZloh0prRvoOVEYZlYwbYyoG6IWQt2
         ao8sf/Ra4BPnYsvs0c3L+yQfHRWTO46F99UwrckeaenaOKno1PA78mgm7U+irBtpP4
         42Lz6rZ6qaXXA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIRB7G3330074;
        Tue, 30 Jul 2019 11:27:11 -0700
Date:   Tue, 30 Jul 2019 11:27:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a1556f8479ed58b8d5a33aef54578bad0165c7e7@git.kernel.org>
Cc:     hpa@zytor.com, mpetlan@redhat.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        ak@linux.intel.com, namhyung@kernel.org,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org,
          alexey.budankov@linux.intel.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          jolsa@kernel.org, mpetlan@redhat.com, hpa@zytor.com
In-Reply-To: <20190721112506.12306-28-jolsa@kernel.org>
References: <20190721112506.12306-28-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add debug output support
Git-Commit-ID: a1556f8479ed58b8d5a33aef54578bad0165c7e7
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

Commit-ID:  a1556f8479ed58b8d5a33aef54578bad0165c7e7
Gitweb:     https://git.kernel.org/tip/a1556f8479ed58b8d5a33aef54578bad0165c7e7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:14 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add debug output support

Add the perf_set_print() function to allow setting an output function
for warn/info/debug messages.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-28-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/core.c              | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/core.h | 13 +++++++++++++
 tools/perf/lib/internal.h          | 18 ++++++++++++++++++
 tools/perf/lib/libperf.map         |  2 ++
 4 files changed, 67 insertions(+)

diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
index e69de29bb2d1..29d5e3348718 100644
--- a/tools/perf/lib/core.c
+++ b/tools/perf/lib/core.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define __printf(a, b)  __attribute__((format(printf, a, b)))
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <perf/core.h>
+#include "internal.h"
+
+static int __base_pr(enum libperf_print_level level, const char *format,
+		     va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+static libperf_print_fn_t __libperf_pr = __base_pr;
+
+void libperf_set_print(libperf_print_fn_t fn)
+{
+	__libperf_pr = fn;
+}
+
+__printf(2, 3)
+void libperf_print(enum libperf_print_level level, const char *format, ...)
+{
+	va_list args;
+
+	if (!__libperf_pr)
+		return;
+
+	va_start(args, format);
+	__libperf_pr(level, format, args);
+	va_end(args);
+}
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index e2e4b43c9131..c341a7b2c874 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -2,8 +2,21 @@
 #ifndef __LIBPERF_CORE_H
 #define __LIBPERF_CORE_H
 
+#include <stdarg.h>
+
 #ifndef LIBPERF_API
 #define LIBPERF_API __attribute__((visibility("default")))
 #endif
 
+enum libperf_print_level {
+	LIBPERF_WARN,
+	LIBPERF_INFO,
+	LIBPERF_DEBUG,
+};
+
+typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
+				  const char *, va_list ap);
+
+LIBPERF_API void libperf_set_print(libperf_print_fn_t fn);
+
 #endif /* __LIBPERF_CORE_H */
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
new file mode 100644
index 000000000000..dc92f241732e
--- /dev/null
+++ b/tools/perf/lib/internal.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_H
+#define __LIBPERF_INTERNAL_H
+
+void libperf_print(enum libperf_print_level level,
+		   const char *format, ...)
+	__attribute__((format(printf, 2, 3)));
+
+#define __pr(level, fmt, ...)   \
+do {                            \
+	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
+} while (0)
+
+#define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
+#define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
+#define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
+
+#endif /* __LIBPERF_INTERNAL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index a8e913988edf..3536242c545c 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,4 +1,6 @@
 LIBPERF_0.0.1 {
+	global:
+		libperf_set_print;
 	local:
 		*;
 };
