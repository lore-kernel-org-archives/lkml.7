Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE9ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71321835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJOFgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:36:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfJOFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQx-00009f-Bc; Tue, 15 Oct 2019 07:31:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0C43A1C0450;
        Tue, 15 Oct 2019 07:31:41 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:40 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__get() function from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-6-jolsa@kernel.org>
References: <20191007125344.14268-6-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750098.12254.6375534524352964789.tip-bot2@tip-bot2>
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

Commit-ID:     e75710f063e29ae7715c57b45eb27c2d504b32ca
Gitweb:        https://git.kernel.org/tip/e75710f063e29ae7715c57b45eb27c2d504b32ca
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:13 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 09:53:27 -03:00

libperf: Adopt perf_mmap__get() function from tools/perf

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
index f05e8b7..025a12b 100644
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
index 7067b70..2e68974 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -39,5 +39,6 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map);
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, int cpu);
+void perf_mmap__get(struct perf_mmap *map);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index b216a7d..b765e05 100644
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
index f9781de..dc5b360 100644
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
index acef6e3..be691b5 100644
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
index a60e6ea..a73402e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,7 +45,6 @@ struct mmap_params {
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct mmap *map);
 
-void perf_mmap__get(struct mmap *map);
 void perf_mmap__put(struct mmap *map);
 
 void perf_mmap__consume(struct mmap *map);
