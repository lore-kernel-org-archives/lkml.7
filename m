Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44882173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452843;
	bh=LcPIK0uaAlbmJeG2hoCxqNLdE4OBjvQasPx3mQ0/oL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvFqJumWyiLDpMAeSV5pjVVhkSRn/zOcMzCjX/MN+tsFlYzAl0n1ESsZ88YBF+b9f
	 mLBmATXLIu9mL1MK32GbcjlUoJD/kEyYhWMzCDAghu6f/1S21fw37tvAMcqs3g9IoW
	 qBjayzjmLLcH0vqUIHKQxJKJ9dvFDK762KtRLU84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJGMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:53:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB6303C918;
        Mon,  7 Oct 2019 12:53:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 547105D9CC;
        Mon,  7 Oct 2019 12:53:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 05/36] libperf: Add perf_mmap__get() function
Date:   Mon,  7 Oct 2019 14:53:13 +0200
Message-Id: <20191007125344.14268-6-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 07 Oct 2019 12:53:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__get() from tools/perf to libperf in the internal header
internal/mmap.h.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-44-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c            | 2 +-
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/lib/mmap.c                  | 5 +++++
 tools/perf/util/evlist.c               | 2 +-
 tools/perf/util/mmap.c                 | 5 -----
 tools/perf/util/mmap.h                 | 1 -
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f05e8b7955e4..025a12b57325 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -293,7 +293,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 		 * after started aio request completion or at record__aio_push()
 		 * if the request failed to start.
 		 */
-		perf_mmap__get(map);
+		perf_mmap__get(&map->core);
 	}
 
 	aio->size += size;
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 7067b70c6f61..2e68974bffb4 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -39,5 +39,6 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map);
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, int cpu);
+void perf_mmap__get(struct perf_mmap *map);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index b216a7db857f..b765e0505bb6 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -31,3 +31,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 	map->cpu = cpu;
 	return 0;
 }
+
+void perf_mmap__get(struct perf_mmap *map)
+{
+	refcount_inc(&map->refcnt);
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 055f625dc630..a7ba22e18e7b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -677,7 +677,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
 
-			perf_mmap__get(&maps[idx]);
+			perf_mmap__get(&maps[idx].core);
 		}
 
 		revent = perf_evlist__should_poll(evlist, evsel) ? POLLIN : 0;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index acef6e3f6b80..be691b58d8ab 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -110,11 +110,6 @@ static bool perf_mmap__empty(struct mmap *map)
 	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
 }
 
-void perf_mmap__get(struct mmap *map)
-{
-	refcount_inc(&map->core.refcnt);
-}
-
 void perf_mmap__put(struct mmap *map)
 {
 	BUG_ON(map->core.base && refcount_read(&map->core.refcnt) == 0);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a60e6ead7255..a73402ee8fe0 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,7 +45,6 @@ struct mmap_params {
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct mmap *map);
 
-void perf_mmap__get(struct mmap *map);
 void perf_mmap__put(struct mmap *map);
 
 void perf_mmap__consume(struct mmap *map);
-- 
2.21.0

