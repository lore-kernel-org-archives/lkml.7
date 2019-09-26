Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF694C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88534222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458172;
	bh=5Uj3ZnAyESfWapb3p+sSM85AuFAMxui3oyxF/X3AWwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tq64Qh1oO/wmd8UW9gR/QYX/jKrjxXZLU7ss0/5vVvbXZJIhB1XmNHT+k+tvKmC3z
	 1rHO/aAsbYOhA4GauH1fLH5hZHP8jkO647frHK2FfDJULwVEkYUtQrzG9638zJHOZG
	 s47Ro3Jg71fQbOFx6lwjORdoMFsEctYW8HW8rYHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390339AbfIZAgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfIZAgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:04 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3F6F21D6C;
        Thu, 26 Sep 2019 00:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458162;
        bh=5Uj3ZnAyESfWapb3p+sSM85AuFAMxui3oyxF/X3AWwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfpFsD6+LyA9FhjnI0t85d0qgAgJtXL3IaWT1BMqhwoAOdQsCdmPGEKYe/74tPA66
         uo3nsCgWKvuRBroE79uwQ5y2OzHDhKdu/FIM5waj5gzHyfjtW3gQOhoAVpn8ZQQMFb
         1n1bHAKLmYuGIgj3gtPffpxh9pzEbZySmQHPK5IQ=
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
Subject: [PATCH 51/66] libperf: Add libperf_init() call to the tests
Date:   Wed, 25 Sep 2019 21:32:29 -0300
Message-Id: <20190926003244.13962-52-acme@kernel.org>
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

Add libperf_init() call to the automated tests.

Committer notes:

Added missing stdarg.h and/or stdio.h to places using vfprintf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/test-cpumap.c    | 10 ++++++++++
 tools/perf/lib/tests/test-evlist.c    | 10 ++++++++++
 tools/perf/lib/tests/test-evsel.c     | 10 ++++++++++
 tools/perf/lib/tests/test-threadmap.c | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
index 76a43cfb83a1..aa34c20df07e 100644
--- a/tools/perf/lib/tests/test-cpumap.c
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -1,13 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
 #include <perf/cpumap.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 int main(int argc, char **argv)
 {
 	struct perf_cpu_map *cpus;
 
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	cpus = perf_cpu_map__dummy_new();
 	if (!cpus)
 		return -1;
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index 4e1407f20ffd..e6b2ab2e2bde 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdarg.h>
 #include <linux/perf_event.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
@@ -6,6 +8,12 @@
 #include <perf/evsel.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 static int test_stat_cpu(void)
 {
 	struct perf_cpu_map *cpus;
@@ -177,6 +185,8 @@ int main(int argc, char **argv)
 {
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
index 2c648fe5617e..1b6c4285ac2b 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -1,10 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
 #include <linux/perf_event.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <perf/evsel.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 static int test_stat_cpu(void)
 {
 	struct perf_cpu_map *cpus;
@@ -116,6 +124,8 @@ int main(int argc, char **argv)
 {
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
index 10a4f4cbbdd5..8c5f47247d9e 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -1,13 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
 #include <perf/threadmap.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 int main(int argc, char **argv)
 {
 	struct perf_thread_map *threads;
 
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	threads = perf_thread_map__new_dummy();
 	if (!threads)
 		return -1;
-- 
2.21.0

