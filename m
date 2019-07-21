Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D0C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1152147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708512;
	bh=YL0d7FA/eGRjG/IeLPWD/Ng8fJ7y938JOXwNk3C7Sog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuBWd4ErxVgMjDN5GaUEBI8pH7N+6Qx4c/XpbZrybs6/kSrLB/ycC/Q3uwwXnLHe3
	 2ArJfh2LvqavWhf6YkMGZ9UZHUJJV01M7drL9VsztXTQgyLDIg88asBaAARwga+B8q
	 lIZh0QrPMYmU9ZFHXBeZduXTGD3yVu5cIR5hc1EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGUL2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfGUL2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 726553083363;
        Sun, 21 Jul 2019 11:28:30 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB5A55D9D3;
        Sun, 21 Jul 2019 11:28:25 +0000 (UTC)
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
Subject: [PATCH 27/79] libperf: Add debug output support
Date:   Sun, 21 Jul 2019 13:24:14 +0200
Message-Id: <20190721112506.12306-28-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 21 Jul 2019 11:28:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_set_print function allowing to set output function
for warn/info/debug messages.

Link: http://lkml.kernel.org/n/tip-2tf4pywtnzctbcgkgdhf0y19@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/core.c              | 34 ++++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/core.h | 13 ++++++++++++
 tools/perf/lib/internal.h          | 18 ++++++++++++++++
 tools/perf/lib/libperf.map         |  2 ++
 4 files changed, 67 insertions(+)
 create mode 100644 tools/perf/lib/internal.h

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
-- 
2.21.0

