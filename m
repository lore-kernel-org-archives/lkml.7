Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668B220640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381200;
	bh=kH2bClfne0TETe0u06mr9FRCy/TRjPNph1ivJZuAu88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tDngYEhhKYiFc56INLFHkMthvZrN+ikYqTPsaSKEODOJjVlmXxqKs8VxQIWGg/FKM
	 0foMk+SWARcrKlFuW49EPPI/WbwQgEDoUqm/PLdPYDod6vMwpPqdxnI9mf5rcPKiuv
	 hmw/sQiRALjY5sRvOxkDSSA2ynExqeVMB5L4lU1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbfIMN0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389841AbfIMN0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6050A2DA980;
        Fri, 13 Sep 2019 13:26:37 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA23C5C1D4;
        Fri, 13 Sep 2019 13:26:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 66/73] libperf: Add perf_evlist__for_each_mmap function
Date:   Fri, 13 Sep 2019 15:23:48 +0200
Message-Id: <20190913132355.21634-67-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 13 Sep 2019 13:26:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__for_each_mmap function and exporting
it in perf/evlist.h header, so user can iterate through
'struct perf_mmap' objects.

Adding internal perf_mmap__link function to do the actual
linking.

Link: http://lkml.kernel.org/n/tip-5h62ytvpxgozhqix2y41cvex@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                | 13 +++++++++++++
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/include/perf/evlist.h   |  7 +++++++
 tools/perf/lib/libperf.map             |  1 +
 tools/perf/lib/mmap.c                  |  6 ++++++
 tools/perf/util/evlist.c               |  1 +
 6 files changed, 30 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index ee1d364460e6..ca98aac80ce1 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -382,6 +382,7 @@ perf_evlist__mmap_cb_new(struct perf_evlist *evlist, bool overwrite, int idx)
 
 	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
 	maps[idx] = map;
+	perf_mmap__link(idx ? maps[idx - 1] : NULL, map);
 	return map;
 }
 
@@ -584,3 +585,15 @@ void perf_evlist__munmap(struct perf_evlist *evlist)
 	zfree(&evlist->mmap);
 	zfree(&evlist->mmap_ovw);
 }
+
+struct perf_mmap*
+perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map)
+{
+	if (map)
+		return map->next;
+
+	if (!evlist->mmap)
+		return NULL;
+
+	return evlist->mmap[0];
+}
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 98e31f8ab461..f0fdf9b5a1d5 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -33,6 +33,7 @@ struct perf_mmap {
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
 	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	struct perf_mmap	*next;
 };
 
 struct perf_mmap_param {
@@ -54,4 +55,5 @@ void perf_mmap__put(struct perf_mmap *map);
 
 u64 perf_mmap__read_head(struct perf_mmap *map);
 
+void perf_mmap__link(struct perf_mmap *prev, struct perf_mmap *map);
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 16f526e74d13..9c3f341dc261 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -38,4 +38,11 @@ LIBPERF_API int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
 LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
 LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
 
+LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
+						     struct perf_mmap *map);
+#define perf_evlist__for_each_mmap(evlist, pos)			\
+	for ((pos) = perf_evlist__next_mmap((evlist), NULL);	\
+	     (pos) != NULL;					\
+	     (pos) = perf_evlist__next_mmap((evlist), (pos)))
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 90aee2a635b2..265188126b08 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__mmap;
 		perf_evlist__munmap;
 		perf_evlist__filter_pollfd;
+		perf_evlist__next_mmap;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index f8816c7bee87..453c8a57a895 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -281,3 +281,9 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 
 	return event;
 }
+
+void perf_mmap__link(struct perf_mmap *prev, struct perf_mmap *map)
+{
+	if (prev)
+		prev->next = map;
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9edb0855f711..1e703eb11500 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -591,6 +591,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * thus does perf_mmap__get() on it.
 		 */
 		perf_mmap__init(&map[i].core, overwrite, perf_mmap__unmap_cb);
+		perf_mmap__link(i ? &map[i - 1].core : NULL, &map[i].core);
 	}
 
 	return map;
-- 
2.21.0

