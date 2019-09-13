Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9CDC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F543206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381276;
	bh=mUvpUky/qPKuieY/daNYYCAgq6GGwoVzyTHbwGp6g7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpVs/JCKxuYOG5V+2I8fAVdx9SUKvYmswYVpImNmY5ehFDzlGjc3Zt/iSIXCInzqP
	 AYy1K+lWJSZp9G5OQNBfmRMcF3FrRwVEIA+NZSIAtXuRnywyCbzS2BUm8sEUu3M8xT
	 SnfwkQLtVbAPJcMVnUS8scrKdxouazTpjah+zFrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391449AbfIMNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390591AbfIMNZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0673118C4275;
        Fri, 13 Sep 2019 13:25:45 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62EEA5C1D4;
        Fri, 13 Sep 2019 13:25:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 43/73] libperf: Add perf_mmap__get function
Date:   Fri, 13 Sep 2019 15:23:25 +0200
Message-Id: <20190913132355.21634-44-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 13 Sep 2019 13:25:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__get function under libperf
to internal header internal/mmap.h.

Link: http://lkml.kernel.org/n/tip-iq4yp3dsr2a4yzdkukholo8o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c            | 2 +-
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/lib/mmap.c                  | 5 +++++
 tools/perf/util/evlist.c               | 2 +-
 tools/perf/util/mmap.c                 | 5 -----
 tools/perf/util/mmap.h                 | 1 -
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40780434b23e..82f6bd6b1adc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -290,7 +290,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 		 * after started aio request completion or at record__aio_push()
 		 * if the request failed to start.
 		 */
-		perf_mmap__get(map);
+		perf_mmap__get(&map->core);
 	}
 
 	aio->size += size;
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 5452ed7dabfe..372521cae06d 100644
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
index 8da573307734..0191d3b2eb20 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -676,7 +676,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
 
-			perf_mmap__get(&maps[idx]);
+			perf_mmap__get(&maps[idx].core);
 		}
 
 		revent = perf_evlist__should_poll(evlist, evsel) ? POLLIN : 0;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 7096e9b130cd..a7e0b4afc176 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -109,11 +109,6 @@ static bool perf_mmap__empty(struct mmap *map)
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
index aeb94d128354..f7ee0252db24 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -73,7 +73,6 @@ struct mmap_params {
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct mmap *map);
 
-void perf_mmap__get(struct mmap *map);
 void perf_mmap__put(struct mmap *map);
 
 void perf_mmap__consume(struct mmap *map);
-- 
2.21.0

