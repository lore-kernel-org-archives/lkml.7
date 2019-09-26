Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E299EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA63C222CD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458077;
	bh=ZEaYgrvsoOAhPDYvs77hPGVQfAuIBkn8z+CGLgw4d64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTxjE8FD7esHyp6Ok4jrD4fW2qaz58xGCQxaJXD0NNC8/ay3sDqdpUtwdFQN+8R50
	 lISHjrNRjV9D5IYD8rKMjl/+0yLAG4g1V0Edd9pV7eLJP3F6PDBPFbBQ2GUxNL8vzv
	 9G99sJ5pt2F/PMqNZZ58opJ93nzp/tWrstypRmvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfIZAeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388657AbfIZAed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:33 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C79222C1;
        Thu, 26 Sep 2019 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458072;
        bh=ZEaYgrvsoOAhPDYvs77hPGVQfAuIBkn8z+CGLgw4d64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFVRAerOx2n5C5Spv+JRlE1YAFm/B4H4pbPHdX+Mso8Gwr07Qi4f++E6BadFmMVu4
         2nn9e0pBhjWYGtBFyapqFcoIxRTge9t407o+xvDEJ9t2y1/SV3boCOchh5ASR+sjll
         XiLb2xAFAPmX0i5d0zGgzJuLmQLy0Kl8uW5ftRtE=
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
Subject: [PATCH 25/66] libperf: Add 'fd' to struct perf_mmap
Date:   Wed, 25 Sep 2019 21:32:03 -0300
Message-Id: <20190926003244.13962-26-acme@kernel.org>
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

Move 'fd' from tools/perf's mmap to libperf's perf_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/util/evlist.c               | 4 ++--
 tools/perf/util/mmap.c                 | 4 ++--
 tools/perf/util/mmap.h                 | 1 -
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 1caa1e8ee5c6..892cbd401d8d 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -10,6 +10,7 @@
 struct perf_mmap {
 	void		*base;
 	int		 mask;
+	int		 fd;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f700dbe043b7..a4e1c19c969f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -652,7 +652,7 @@ static int perf_evlist__set_paused(struct evlist *evlist, bool value)
 		return 0;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		int fd = evlist->overwrite_mmap[i].fd;
+		int fd = evlist->overwrite_mmap[i].core.fd;
 		int err;
 
 		if (fd < 0)
@@ -708,7 +708,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		map[i].fd = -1;
+		map[i].core.fd = -1;
 		map[i].overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 702e8e0b90ea..40bf124cb658 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -320,7 +320,7 @@ void perf_mmap__munmap(struct mmap *map)
 	if (map->core.base != NULL) {
 		munmap(map->core.base, perf_mmap__mmap_len(map));
 		map->core.base = NULL;
-		map->fd = -1;
+		map->core.fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
@@ -378,7 +378,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		map->core.base = NULL;
 		return -1;
 	}
-	map->fd = fd;
+	map->core.fd = fd;
 	map->cpu = cpu;
 
 	perf_mmap__setup_affinity_mask(map, mp);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 370138e395fc..de991194af8d 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	int		 fd;
 	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
-- 
2.21.0

