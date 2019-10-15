Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCEB21A49
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfJOFcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfJOFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQw-000092-Q6; Tue, 15 Oct 2019 07:31:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CD7071C04D1;
        Tue, 15 Oct 2019 07:31:40 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:40 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__unmap() function from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-7-jolsa@kernel.org>
References: <20191007125344.14268-7-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750072.12254.5147371764550354694.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59d7ea620b58fa7d107834a81528e3098f1c27b0
Gitweb:        https://git.kernel.org/tip/59d7ea620b58fa7d107834a81528e3098f1c27b0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:14 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 10:05:57 -03:00

libperf: Adopt perf_mmap__unmap() function from tools/perf

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
index 2e68974..5c2ca9a 100644
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
index b765e05..6eb228d 100644
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
index dc5b360..0b877d3 100644
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
index be691b5..2c73b5b 100644
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
index a73402e..6a18b29 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -43,7 +43,7 @@ struct mmap_params {
 };
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
-void perf_mmap__munmap(struct mmap *map);
+void mmap__munmap(struct mmap *map);
 
 void perf_mmap__put(struct mmap *map);
 
