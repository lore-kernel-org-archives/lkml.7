Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C28C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB41520679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d9D9YYVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbfG3SyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:54:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbfG3SyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:54:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIrxHT3336269
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:53:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIrxHT3336269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512840;
        bh=Xf5fl1XyHMY7q0Rm8VIKmCn4hmMOVHb8R7uqteZAf/s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=d9D9YYVr7OcLJ7NAWEzE/QlWde0uvh3UM8tEm4B+MmWKT1FsvvkwS3LM67J58X7C2
         DmyTFILluadQ/ttoWCoGfEKfywAQzXw5PyUoMNghbmMKxQUqWhlDYGrnzQFAsIwnik
         B/HO76fiP7KLLjdiMvZT+C4R8pXVskKK7l8j8K1xgvqzBles5mkipYYurvSRIddPqa
         UvbcC2HsJ3C+TX/ZNXfTnHzBjOsgPpkCmbcRx2z4yjI5l9okAaZn0cq/k4nLrYFXLg
         lKJY9Ep+E5PZeet+tdZUwUCGJq5Cm9k3ttsCRkGZxwPIUy/EQdGm6JfVzoj6WOtstN
         zbkudGKWgd8HQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIrweD3336266;
        Tue, 30 Jul 2019 11:53:58 -0700
Date:   Tue, 30 Jul 2019 11:53:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-50a4e6fa450c4e5b688814a7ec8236d0de6e38bf@git.kernel.org>
Cc:     ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        mpetlan@redhat.com, alexey.budankov@linux.intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, alexey.budankov@linux.intel.com,
          mpetlan@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          ak@linux.intel.com, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          acme@redhat.com
In-Reply-To: <20190721112506.12306-63-jolsa@kernel.org>
References: <20190721112506.12306-63-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt simplified perf_evsel__open()
 function from tools/perf
Git-Commit-ID: 50a4e6fa450c4e5b688814a7ec8236d0de6e38bf
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

Commit-ID:  50a4e6fa450c4e5b688814a7ec8236d0de6e38bf
Gitweb:     https://git.kernel.org/tip/50a4e6fa450c4e5b688814a7ec8236d0de6e38bf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:49 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt simplified perf_evsel__open() function from tools/perf

Add a perf_evsel__open() function to libperf.

It's a simplified version of evsel__open() without the fallback
mechanism.

We can try to merge it in the future to libperf, but it has many
details, lets start simple, requiring the latest kernel, perf should
continue using its evsel__open() version, continuing to support running
on older kernels when possible.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-63-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 65 +++++++++++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/evsel.h |  4 +++
 tools/perf/lib/libperf.map          |  1 +
 3 files changed, 70 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 027f1edb4e8e..7027dacb50f6 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -1,11 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <unistd.h>
+#include <sys/syscall.h>
 #include <perf/evsel.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <internal/xyarray.h>
+#include <internal/cpumap.h>
+#include <internal/threadmap.h>
 #include <linux/string.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
@@ -46,3 +52,62 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 
 	return evsel->fd != NULL ? 0 : -ENOMEM;
 }
+
+static int
+sys_perf_event_open(struct perf_event_attr *attr,
+		    pid_t pid, int cpu, int group_fd,
+		    unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+		     struct perf_thread_map *threads)
+{
+	int cpu, thread, err = 0;
+
+	if (cpus == NULL) {
+		static struct perf_cpu_map *empty_cpu_map;
+
+		if (empty_cpu_map == NULL) {
+			empty_cpu_map = perf_cpu_map__dummy_new();
+			if (empty_cpu_map == NULL)
+				return -ENOMEM;
+		}
+
+		cpus = empty_cpu_map;
+	}
+
+	if (threads == NULL) {
+		static struct perf_thread_map *empty_thread_map;
+
+		if (empty_thread_map == NULL) {
+			empty_thread_map = perf_thread_map__new_dummy();
+			if (empty_thread_map == NULL)
+				return -ENOMEM;
+		}
+
+		threads = empty_thread_map;
+	}
+
+	if (evsel->fd == NULL &&
+	    perf_evsel__alloc_fd(evsel, cpus->nr, threads->nr) < 0)
+		return -ENOMEM;
+
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		for (thread = 0; thread < threads->nr; thread++) {
+			int fd;
+
+			fd = sys_perf_event_open(&evsel->attr,
+						 threads->map[thread].pid,
+						 cpus->map[cpu], -1, 0);
+
+			if (fd < 0)
+				return -errno;
+
+			FD(evsel, cpu, thread) = fd;
+		}
+	}
+
+	return err;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index a57efc0f5c8b..e9fbaa8fb51a 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -6,10 +6,14 @@
 
 struct perf_evsel;
 struct perf_event_attr;
+struct perf_cpu_map;
+struct perf_thread_map;
 
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+				 struct perf_thread_map *threads);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 9b6e8f165014..7594d3d89c5f 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -14,6 +14,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__new;
 		perf_evsel__delete;
 		perf_evsel__init;
+		perf_evsel__open;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
