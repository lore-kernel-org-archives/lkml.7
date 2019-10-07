Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E05ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676392064A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452964;
	bh=i9NYvr6zx0jKXPuCOMhiVuM8EBAjrGopT/RS3mD+5fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TuD3y43DjCYQF/cTLIf7vof/bu9Xjk9J9gk4vL+atr72lbgINY+CkQyPZdlsh5+ma
	 Z+mC2Sj252EZSennyxVcBFbCWWaVIzhLoBt6M417QMFBHpQFFqP31KFEL7vh6loQUN
	 GQlmcAnYW6d2m1gO6LsbtXW+beuDgY0d1xWFQeWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfJGMyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbfJGMyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD27D85542;
        Mon,  7 Oct 2019 12:53:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4262D5DA8C;
        Mon,  7 Oct 2019 12:53:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 06/36] libperf: Add perf_mmap__unmap() function
Date:   Mon,  7 Oct 2019 14:53:14 +0200
Message-Id: <20191007125344.14268-7-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 07 Oct 2019 12:54:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__unmap() from tools/perf to libperf, to internal header
internal/mmap.h. It will be used in the following patches. And rename
the existing perf's function to mmap__munmap().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-45-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/lib/mmap.c                  | 10 ++++++++++
 tools/perf/util/evlist.c               |  4 ++--
 tools/perf/util/mmap.c                 | 11 +++--------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 2e68974bffb4..5c2ca9ab12cd 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -39,6 +39,7 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map);
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, int cpu);
+void perf_mmap__munmap(struct perf_mmap *map);
 void perf_mmap__get(struct perf_mmap *map);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index b765e0505bb6..6eb228d89206 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -32,6 +32,16 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 	return 0;
 }
 
+void perf_mmap__munmap(struct perf_mmap *map)
+{
+	if (map && map->base != NULL) {
+		munmap(map->base, perf_mmap__mmap_len(map));
+		map->base = NULL;
+		map->fd = -1;
+		refcount_set(&map->refcnt, 0);
+	}
+}
+
 void perf_mmap__get(struct perf_mmap *map)
 {
 	refcount_inc(&map->refcnt);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a7ba22e18e7b..2e5eaac6325e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -577,11 +577,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 
 	if (evlist->mmap)
 		for (i = 0; i < evlist->core.nr_mmaps; i++)
-			perf_mmap__munmap(&evlist->mmap[i]);
+			mmap__munmap(&evlist->mmap[i]);
 
 	if (evlist->overwrite_mmap)
 		for (i = 0; i < evlist->core.nr_mmaps; i++)
-			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
+			mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
 void evlist__munmap(struct evlist *evlist)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index be691b58d8ab..2c73b5bcf74e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -115,7 +115,7 @@ void perf_mmap__put(struct mmap *map)
 	BUG_ON(map->core.base && refcount_read(&map->core.refcnt) == 0);
 
 	if (refcount_dec_and_test(&map->core.refcnt))
-		perf_mmap__munmap(map);
+		mmap__munmap(map);
 }
 
 void perf_mmap__consume(struct mmap *map)
@@ -306,19 +306,14 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 }
 #endif
 
-void perf_mmap__munmap(struct mmap *map)
+void mmap__munmap(struct mmap *map)
 {
+	perf_mmap__munmap(&map->core);
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
 		map->data = NULL;
 	}
-	if (map->core.base != NULL) {
-		munmap(map->core.base, mmap__mmap_len(map));
-		map->core.base = NULL;
-		map->core.fd = -1;
-		refcount_set(&map->core.refcnt, 0);
-	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a73402ee8fe0..6a18b2990059 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -43,7 +43,7 @@ struct mmap_params {
 };
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
-void perf_mmap__munmap(struct mmap *map);
+void mmap__munmap(struct mmap *map);
 
 void perf_mmap__put(struct mmap *map);
 
-- 
2.21.0

