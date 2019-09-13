Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74245C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE50206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381298;
	bh=OqJ6u3FXdL8bvea/eE2VVFa//H4ThVh0MrDcbBhCzdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BHuRmqDamHjwy/0y/1LnWQAtwBK4KwuCYUPY9u3lYFLyAKpz4oC1s9x6+T41uigTv
	 V4piZnZm2bpWrUMyFnmEo9ZIi9YccjtSECmaFittJkiYRJ5KGzVI68cE7xy1eReyua
	 siHJURGNFSHmrpvzlL+cGPUifYTooy/nAe899/Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbfIMNZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390993AbfIMNZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6DB2301A3AC;
        Fri, 13 Sep 2019 13:25:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C7585C219;
        Fri, 13 Sep 2019 13:25:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 31/73] libperf: Add perf_evlist__id_add_fd function
Date:   Fri, 13 Sep 2019 15:23:13 +0200
Message-Id: <20190913132355.21634-32-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 13:25:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__id_add_fd function to libperf
as internal function.

Link: http://lkml.kernel.org/n/tip-ba32sqqoqy925xs4l1bvwg1f@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 44 ++++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  4 +++
 tools/perf/util/evlist.c                 | 43 +----------------------
 tools/perf/util/evlist.h                 |  4 ---
 tools/perf/util/evsel.c                  |  2 +-
 5 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index f4f8e37c6272..35467d99cea5 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -3,11 +3,14 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <linux/hash.h>
+#include <sys/ioctl.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <internal/xyarray.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 
@@ -193,3 +196,44 @@ void perf_evlist__id_add(struct perf_evlist *evlist,
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
 	evsel->id[evsel->ids++] = id;
 }
+
+int perf_evlist__id_add_fd(struct perf_evlist *evlist,
+			   struct perf_evsel *evsel,
+			   int cpu, int thread, int fd)
+{
+	u64 read_data[4] = { 0, };
+	int id_idx = 1; /* The first entry is the counter value */
+	u64 id;
+	int ret;
+
+	ret = ioctl(fd, PERF_EVENT_IOC_ID, &id);
+	if (!ret)
+		goto add;
+
+	if (errno != ENOTTY)
+		return -1;
+
+	/* Legacy way to get event id.. All hail to old kernels! */
+
+	/*
+	 * This way does not work with group format read, so bail
+	 * out in that case.
+	 */
+	if (perf_evlist__read_format(evlist) & PERF_FORMAT_GROUP)
+		return -1;
+
+	if (!(evsel->attr.read_format & PERF_FORMAT_ID) ||
+	    read(fd, &read_data, sizeof(read_data)) == -1)
+		return -1;
+
+	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		++id_idx;
+	if (evsel->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		++id_idx;
+
+	id = read_data[id_idx];
+
+add:
+	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	return 0;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 649406f717bc..7d64185cfabd 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -72,4 +72,8 @@ void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
 			 int cpu, int thread, u64 id);
 
+int perf_evlist__id_add_fd(struct perf_evlist *evlist,
+			   struct perf_evsel *evsel,
+			   int cpu, int thread, int fd);
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dde6c68b9a42..433e9af6e063 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -460,47 +460,6 @@ int perf_evlist__poll(struct evlist *evlist, int timeout)
 	return fdarray__poll(&evlist->core.pollfd, timeout);
 }
 
-int perf_evlist__id_add_fd(struct evlist *evlist,
-			   struct evsel *evsel,
-			   int cpu, int thread, int fd)
-{
-	u64 read_data[4] = { 0, };
-	int id_idx = 1; /* The first entry is the counter value */
-	u64 id;
-	int ret;
-
-	ret = ioctl(fd, PERF_EVENT_IOC_ID, &id);
-	if (!ret)
-		goto add;
-
-	if (errno != ENOTTY)
-		return -1;
-
-	/* Legacy way to get event id.. All hail to old kernels! */
-
-	/*
-	 * This way does not work with group format read, so bail
-	 * out in that case.
-	 */
-	if (perf_evlist__read_format(&evlist->core) & PERF_FORMAT_GROUP)
-		return -1;
-
-	if (!(evsel->core.attr.read_format & PERF_FORMAT_ID) ||
-	    read(fd, &read_data, sizeof(read_data)) == -1)
-		return -1;
-
-	if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		++id_idx;
-	if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		++id_idx;
-
-	id = read_data[id_idx];
-
- add:
-	perf_evlist__id_add(&evlist->core, &evsel->core, cpu, thread, id);
-	return 0;
-}
-
 static void perf_evlist__set_sid_idx(struct evlist *evlist,
 				     struct evsel *evsel, int idx, int cpu,
 				     int thread)
@@ -775,7 +734,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		}
 
 		if (evsel->core.attr.read_format & PERF_FORMAT_ID) {
-			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
+			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core, cpu, thread,
 						   fd) < 0)
 				return -1;
 			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 37f29b67dd61..204315516c32 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -113,10 +113,6 @@ struct evsel *
 perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-int perf_evlist__id_add_fd(struct evlist *evlist,
-			   struct evsel *evsel,
-			   int cpu, int thread, int fd);
-
 int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
 int perf_evlist__alloc_pollfd(struct evlist *evlist);
 int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 904b67d23bde..d69549c57fda 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2936,7 +2936,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 		     thread++) {
 			int fd = FD(evsel, cpu, thread);
 
-			if (perf_evlist__id_add_fd(evlist, evsel,
+			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core,
 						   cpu, thread, fd) < 0)
 				return -1;
 		}
-- 
2.21.0

