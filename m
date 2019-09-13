Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB2C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72CD20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381293;
	bh=86BMGjweWwnZhIRJzScChpFhXYlUScemP/fGYB6du+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/Mkw6zQsRa2U8bpw6v8cicpmitqQgq1fTaFevVT/AKbD+2YeYYBBSnqMo6Gzpx2X
	 uyrLVk9hjPGLG71taBG9Z6V/D8PNbXFvFC+QCC/a+mtQ1kIPOu+6gyrFa3afnwBqPp
	 S9MfmqXrH+xMf8X4QrPTCe16h8hR8+3/q4kAXctQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391371AbfIMNZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391356AbfIMNZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1493308A9E2;
        Fri, 13 Sep 2019 13:25:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCD615C1D4;
        Fri, 13 Sep 2019 13:25:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 34/73] libperf: Add libperf_init call to tests
Date:   Fri, 13 Sep 2019 15:23:16 +0200
Message-Id: <20190913132355.21634-35-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 13:25:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding libperf_init call to automated tests.

Link: http://lkml.kernel.org/n/tip-xxpguwr7u2jryhsn7wjybexz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/tests/test-cpumap.c    |  8 ++++++++
 tools/perf/lib/tests/test-evlist.c    | 10 ++++++++++
 tools/perf/lib/tests/test-evsel.c     |  8 ++++++++
 tools/perf/lib/tests/test-threadmap.c |  8 ++++++++
 4 files changed, 34 insertions(+)

diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
index 76a43cfb83a1..4224d6f213f8 100644
--- a/tools/perf/lib/tests/test-cpumap.c
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -2,12 +2,20 @@
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
index 2c648fe5617e..64d2257a93cb 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -5,6 +5,12 @@
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
@@ -116,6 +122,8 @@ int main(int argc, char **argv)
 {
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
index 10a4f4cbbdd5..9b72c43c8c59 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -2,12 +2,20 @@
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

