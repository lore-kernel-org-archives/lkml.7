Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFACC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A5D206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381151;
	bh=5tNuxPTdZ12DnAihoVjsD6EP40KV0tCBvu1knyls6nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUGguETBWQ6R8CsKF9vQztzgDnIv7L6zaAoobDJYy3HE1+B8xD9/6qedQeYGs2r2d
	 Xr/ez3gVHUy4W6xjprxLGcPQM8faUyODNOn6eOknyZqqL/B3e0CwGeBs7EjGRJVoQ2
	 wx2P51IAZjz5LU7FS/bkVMr3ge4UFFtj694neia4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391457AbfIMNZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391434AbfIMNZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED4C910DCC8B;
        Fri, 13 Sep 2019 13:25:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D1F5C1D4;
        Fri, 13 Sep 2019 13:25:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 44/73] libperf: Add perf_mmap__unmap function
Date:   Fri, 13 Sep 2019 15:23:26 +0200
Message-Id: <20190913132355.21634-45-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 13 Sep 2019 13:25:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__unmap function under libperf,
to internal header internal/mmap.h. It will be
used in following patches. And rename the existing
perf's function to mmap__munmap.

Link: http://lkml.kernel.org/n/tip-5k8rntfq0sudli9dzw6aqg5a@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/lib/mmap.c                  | 10 ++++++++++
 tools/perf/util/evlist.c               |  4 ++--
 tools/perf/util/mmap.c                 | 11 +++--------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 372521cae06d..5c9ba00e67e1 100644
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
index 0191d3b2eb20..22165862f587 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -576,11 +576,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 
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
index a7e0b4afc176..eb77141dbfca 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -114,7 +114,7 @@ void perf_mmap__put(struct mmap *map)
 	BUG_ON(map->core.base && refcount_read(&map->core.refcnt) == 0);
 
 	if (refcount_dec_and_test(&map->core.refcnt))
-		perf_mmap__munmap(map);
+		mmap__munmap(map);
 }
 
 void perf_mmap__consume(struct mmap *map)
@@ -305,19 +305,14 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
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
index f7ee0252db24..852f1ec20787 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -71,7 +71,7 @@ struct mmap_params {
 };
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
-void perf_mmap__munmap(struct mmap *map);
+void mmap__munmap(struct mmap *map);
 
 void perf_mmap__put(struct mmap *map);
 
-- 
2.21.0

