Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364E521726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455562;
	bh=vW3Hi27+Qj34IfkC1RfQW6W55sHVhgxzQPBAbe/sX0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sI70Kpiu2EhwlujuDJbW+IuUiF3SByOzTmJKveVDQ/uUZ6XBt4irsSzf2OYOVLE2K
	 5k2iol0vVkIxwQcr/akI9gHvgyVmSExOyS9Dncc+l9sk4fkrE5debdxCfSOW8AzavE
	 5xV1GhkXgDfu/Xkqsm5eSycJH204V4qxMorUswz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfG3C7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbfG3C7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0172C217D6;
        Tue, 30 Jul 2019 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455558;
        bh=vW3Hi27+Qj34IfkC1RfQW6W55sHVhgxzQPBAbe/sX0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlxJM4dC18HSE7gY3/28cigoW2DTQjWjevjKYQrpNioOT41F3BpBJpnkxX7zniXfd
         nah0XxDTdMSRnze6WZx3WFrp0wC6PzvBSAO/TIBj/HvWNCTi/tRn7kRxXVgg8siyZ3
         otebaOtEUqadvGbEIOVIn9o3Hp8/inFVNMC/VVko=
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
Subject: [PATCH 054/107] libperf: Add debug output support
Date:   Mon, 29 Jul 2019 23:55:17 -0300
Message-Id: <20190730025610.22603-55-acme@kernel.org>
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

