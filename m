Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA9ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26C7206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824732;
	bh=x3/FP3zTIufSGUOK3eEpVchefxML50Hi16H43V/9RBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uaq1MNqoRsijJPhDWCDnkyuuYDWJXY6kqaLTdY9vRTV/xL8WgdgxqTPSd3dEbB16x
	 PnM9RSlHuAZomYCQN9lp/6Zknu/LENIbs1vfU2fCOEXebAl66kf61B3sSOT9fQ+wxv
	 Khv/LolJeOhNtiUtFXLl2FkH7rDUJf/9HjVJ/7c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfJKUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfJKUKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:34 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C656222D2;
        Fri, 11 Oct 2019 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824632;
        bh=x3/FP3zTIufSGUOK3eEpVchefxML50Hi16H43V/9RBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXaeGYkWkjrERCRpg7D1o8btUp6scSm3viLG97xGVTJmpYWFdC/jNErVIYBnPmWD1
         rEouWhQ5Q7DfO4Op/3/wt9eSJSR67p5oxnd5Hzlf7+np5R2QIAHPVkNopuc+fOo5Mq
         1TO9Isjvg82/zI+i3F+U8ezfCIiMFkTYc1P+euq8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 47/69] libperf: Adopt perf_mmap__unmap() function from tools/perf
Date:   Fri, 11 Oct 2019 17:05:37 -0300
Message-Id: <20191011200559.7156-48-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move perf_mmap__unmap() from tools/perf to libperf, to internal header
internal/mmap.h. It will be used in the following patches. And rename
the existing perf's function to mmap__munmap().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-7-jolsa@kernel.org
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
index dc5b36069d4c..0b877d39a660 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -601,11 +601,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 
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

