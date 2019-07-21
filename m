Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B93C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1852085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708713;
	bh=n88YUrDvV4XerqDwXNbVi8TQHM1z2+ZHBnkZ4qh1DPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qkx3a0S/qKpjuv+GEA9T/DuiYzBVZtiupMgJAhKVqcdL31OLva+9tt4OF42LqXkrV
	 nEO0+16II61DVeiVKyVI9uQoYhsk0XhEYfmzl/BWucawgM5BiIuDwSgkWO8WWhyjaH
	 j1np2p8zBWGBcErBsOD8dC/IU5J+BqLr9ZZDw8eE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfGULbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EDDBC034E71;
        Sun, 21 Jul 2019 11:31:51 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E726B5D9D3;
        Sun, 21 Jul 2019 11:31:46 +0000 (UTC)
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
Subject: [PATCH 62/79] libperf: Add perf_evsel__open function
Date:   Sun, 21 Jul 2019 13:24:49 +0200
Message-Id: <20190721112506.12306-63-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 21 Jul 2019 11:31:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evsel__open function into libperf.

It's a simplified version of evsel__open without fallback
stuff. We can try to merge it in the future to libperf,
but it has many glitches.

Link: http://lkml.kernel.org/n/tip-l21dawds9vj61pbtqhcnacqc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evsel.c              | 65 +++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/evsel.h |  4 ++
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
index c01de0752e4d..adda02f00369 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -6,10 +6,14 @@
 #include <perf/core.h>
 
 struct perf_evsel;
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
-- 
2.21.0

