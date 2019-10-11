Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D007C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC682190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824634;
	bh=zRJklvcnqvhkqtRIHqJqdCrtPlGtxC4ndWOul/2Hyfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nL9UlCwpZ/73rUZqfXps9UfL6Eb4gaKcimiG6vDEDoxvNGagcjmchY0kxk+7oPFJE
	 JGQPkI2KamYPBJm9K5+Erq8QM36F5hN3UG3oXzC7+7X9RhbNYFR0PvdI1vm6Yhms8C
	 AyvpZEuA7+0yYkamp98cgoWQRqCUPBMNR68KJ+sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfJKUKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfJKUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:30 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC52222474;
        Fri, 11 Oct 2019 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824629;
        bh=zRJklvcnqvhkqtRIHqJqdCrtPlGtxC4ndWOul/2Hyfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC5qKHOy6li6PA7zGY9CCT/VhJYRkdK7XUWNsj0dUfOaoJyjPmHf7EgQg52SEP6/N
         Vfe9rm73CqGdCp9KXZIjcX8sR4htWL3ri8sZkZ6QJF5B7+zBMeLFG62XKBlSsq00sH
         Z/V2cx5t4MvlzcCs594TmyNqPV+NusFdlc7DYjxs=
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
Subject: [PATCH 46/69] libperf: Adopt perf_mmap__get() function from tools/perf
Date:   Fri, 11 Oct 2019 17:05:36 -0300
Message-Id: <20191011200559.7156-47-acme@kernel.org>
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

Move perf_mmap__get() from tools/perf to libperf in the internal header
internal/mmap.h.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-6-jolsa@kernel.org
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
index f9781de0e61e..dc5b36069d4c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -701,7 +701,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
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

