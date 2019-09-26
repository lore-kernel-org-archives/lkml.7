Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3977C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE77D222CA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458146;
	bh=3E6QcXTvI2xA2Efi0bCJdKtaOWE89o+L7sAwgHUvjQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6GeF8sCnnY4cGWE5ffBA6NTsDli5y6/kYxZTAPf8moCoOMzDjoJuSUF3n8C4UflM
	 Pi9cf7JJUmXG+u8CRNkbrTmHcsCTFSM9KhLohHEe4PyV+SfM4D4ByGTZ/0122egfGq
	 nkZdMrSIy998zZ6nK8jTz2R2n9MXUSDDdeYaEakc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbfIZAfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389915AbfIZAfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:42 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58608222C6;
        Thu, 26 Sep 2019 00:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458141;
        bh=3E6QcXTvI2xA2Efi0bCJdKtaOWE89o+L7sAwgHUvjQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ultaIe/Dp5hL52kyja0FAxjpMmTaf0Sm0TVvepmk/HurNijk0zoPeolsTAPrj1yUs
         IIuV4rjQK3ZgxyJpmYinh4nNDfsvgkKhnFFHHIjz+z2WUX4SsLSr4D8jSJLW9Qzvsx
         DFbp3tWRh7zcsn0igRfWNv/haZvaYLZlKcsHOEvU=
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
Subject: [PATCH 45/66] libperf: Add perf_evlist__id_add_fd() function
Date:   Wed, 25 Sep 2019 21:32:23 -0300
Message-Id: <20190926003244.13962-46-acme@kernel.org>
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

Add the perf_evlist__id_add_fd() function to libperf as an internal
function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 44 ++++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  4 +++
 tools/perf/util/evlist.c                 | 43 +----------------------
 tools/perf/util/evlist.h                 |  4 ---
 tools/perf/util/evsel.c                  |  2 +-
 5 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index a29ee8a746d9..3a16dd0c044f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -4,11 +4,14 @@
 #include <linux/bitops.h>
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
 
@@ -194,3 +197,44 @@ void perf_evlist__id_add(struct perf_evlist *evlist,
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
index f2863b4c61d7..a37eccf65eae 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -461,47 +461,6 @@ int perf_evlist__poll(struct evlist *evlist, int timeout)
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
@@ -776,7 +735,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		}
 
 		if (evsel->core.attr.read_format & PERF_FORMAT_ID) {
-			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
+			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core, cpu, thread,
 						   fd) < 0)
 				return -1;
 			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index eb35b4b1d86f..80b3361613e5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -141,10 +141,6 @@ struct evsel *
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
index a4a492f11849..9c284d2adcea 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2662,7 +2662,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 		     thread++) {
 			int fd = FD(evsel, cpu, thread);
 
-			if (perf_evlist__id_add_fd(evlist, evsel,
+			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core,
 						   cpu, thread, fd) < 0)
 				return -1;
 		}
-- 
2.21.0

