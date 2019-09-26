Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892C8C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DEE222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458083;
	bh=KRTcLHfFuL9Kmpap2S6g+G+uFhu3X4hImda6F1cQ7v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qOw0MpHF3sajvKOysGWUvDZb6snoK6qcBKppkfmGQU/BJV/N0L4M5uVP7tIqXUrTe
	 PNHYyRM2WiwjT476/znJxb5d+ul19G1JFuxZ3Eq2pnHzsTs/uHRaQV/TIqbit0H8k+
	 anjFgyKo2ngfTdUezV8iggt473le5rFhkbyLuNXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfIZAem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388755AbfIZAej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:39 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A85D217F4;
        Thu, 26 Sep 2019 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458078;
        bh=KRTcLHfFuL9Kmpap2S6g+G+uFhu3X4hImda6F1cQ7v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdPJU/hMcJoC5D/ceuIw17MZAHMPTivMlOYf9cbcphorYcSxwZMdMRCD0Qjp6VE8L
         E23MpRST1MH+G0abzL06nbTQQjixzNTKQWpn9Yirbm4QxlLWYnEWvB70jmv58MA0x6
         7GpuqSR3HIwtaDVErbo3JsCsqPy2dIkExUViWqdU=
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
Subject: [PATCH 27/66] libperf: Add 'refcnt' to struct perf_mmap
Date:   Wed, 25 Sep 2019 21:32:05 -0300
Message-Id: <20190926003244.13962-28-acme@kernel.org>
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

Move 'refcnt' from tools/perf's mmap to libperf's perf_mmap struct.

Committer notes:

Add the refcount.h include directive here, now it is needed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  3 +++
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 18 +++++++++---------
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index f7d1809fa34c..e6fb850ba47a 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -2,6 +2,8 @@
 #ifndef __LIBPERF_INTERNAL_MMAP_H
 #define __LIBPERF_INTERNAL_MMAP_H
 
+#include <linux/refcount.h>
+
 /**
  * struct perf_mmap - perf's ring buffer mmap details
  *
@@ -12,6 +14,7 @@ struct perf_mmap {
 	int		 mask;
 	int		 fd;
 	int		 cpu;
+	refcount_t	 refcnt;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a4e1c19c969f..d987e0e5d62b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -719,7 +719,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		refcount_set(&map[i].refcnt, 0);
+		refcount_set(&map[i].core.refcnt, 0);
 	}
 	return map;
 }
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index dc8320891344..d6406d216cfe 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -89,7 +89,7 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!refcount_read(&map->refcnt))
+	if (!refcount_read(&map->core.refcnt))
 		return NULL;
 
 	/* non-overwirte doesn't pause the ringbuffer */
@@ -111,14 +111,14 @@ static bool perf_mmap__empty(struct mmap *map)
 
 void perf_mmap__get(struct mmap *map)
 {
-	refcount_inc(&map->refcnt);
+	refcount_inc(&map->core.refcnt);
 }
 
 void perf_mmap__put(struct mmap *map)
 {
-	BUG_ON(map->core.base && refcount_read(&map->refcnt) == 0);
+	BUG_ON(map->core.base && refcount_read(&map->core.refcnt) == 0);
 
-	if (refcount_dec_and_test(&map->refcnt))
+	if (refcount_dec_and_test(&map->core.refcnt))
 		perf_mmap__munmap(map);
 }
 
@@ -130,7 +130,7 @@ void perf_mmap__consume(struct mmap *map)
 		perf_mmap__write_tail(map, old);
 	}
 
-	if (refcount_read(&map->refcnt) == 1 && perf_mmap__empty(map))
+	if (refcount_read(&map->core.refcnt) == 1 && perf_mmap__empty(map))
 		perf_mmap__put(map);
 }
 
@@ -321,7 +321,7 @@ void perf_mmap__munmap(struct mmap *map)
 		munmap(map->core.base, perf_mmap__mmap_len(map));
 		map->core.base = NULL;
 		map->core.fd = -1;
-		refcount_set(&map->refcnt, 0);
+		refcount_set(&map->core.refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
@@ -367,7 +367,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 * evlist layer can't just drop it when filtering events in
 	 * perf_evlist__filter_pollfd().
 	 */
-	refcount_set(&map->refcnt, 2);
+	refcount_set(&map->core.refcnt, 2);
 	map->prev = 0;
 	map->core.mask = mp->mask;
 	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
@@ -479,7 +479,7 @@ int perf_mmap__read_init(struct mmap *map)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!refcount_read(&map->refcnt))
+	if (!refcount_read(&map->core.refcnt))
 		return -ENOENT;
 
 	return __perf_mmap__read_init(map);
@@ -537,7 +537,7 @@ void perf_mmap__read_done(struct mmap *map)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!refcount_read(&map->refcnt))
+	if (!refcount_read(&map->core.refcnt))
 		return;
 
 	map->prev = perf_mmap__read_head(map);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 8ab779c98f4d..5febd22fbe2e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
 	u64		 end;
-- 
2.21.0

