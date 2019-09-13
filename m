Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E035C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E62206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381088;
	bh=B78E5M+ObAR7j4lJRHytO9mMainUVpQW2jWF4FeqPp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbkcBdb/cmdskbtne3C/ZIw77TzxWTW2lmIWPskVIwgFVVqdBhsNeIFGS2IfvvwdV
	 9C9rl6SWmkcZS7rkIlh/9e3mA3iNcvNyIzzZCFgNtpveJrRKfLqi8bIFd6IHcl0n6f
	 e1fW9m8MERQvC2wS+cTc6LS+0JFxMT9sAX2qJoHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbfIMNYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbfIMNYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5699B30860C8;
        Fri, 13 Sep 2019 13:24:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B18305C1D4;
        Fri, 13 Sep 2019 13:24:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 18/73] libperf: Add flush to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:23:00 +0200
Message-Id: <20190913132355.21634-19-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 13 Sep 2019 13:24:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move flush from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-yvdiy0gkiubey7hut8q3klfu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c            | 10 +++++-----
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/util/mmap.c                 |  4 ++--
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6c0349dcb20c..400ce2f3fa99 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -959,13 +959,13 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		if (map->core.base) {
 			record__adjust_affinity(rec, map);
 			if (synch) {
-				flush = map->flush;
-				map->flush = 1;
+				flush = map->core.flush;
+				map->core.flush = 1;
 			}
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) < 0) {
 					if (synch)
-						map->flush = flush;
+						map->core.flush = flush;
 					rc = -1;
 					goto out;
 				}
@@ -973,13 +973,13 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 				if (record__aio_push(rec, map, &off) < 0) {
 					record__aio_set_pos(trace_fd, off);
 					if (synch)
-						map->flush = flush;
+						map->core.flush = flush;
 					rc = -1;
 					goto out;
 				}
 			}
 			if (synch)
-				map->flush = flush;
+				map->core.flush = flush;
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 3a404ec06214..a147b25c4b88 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -25,6 +25,7 @@ struct perf_mmap {
 	u64		 start;
 	u64		 end;
 	bool		 overwrite;
+	u64		 flush;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4b8ec8dd79c5..4cc3b54b2f73 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -383,7 +383,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 
 	perf_mmap__setup_affinity_mask(map, mp);
 
-	map->flush = mp->flush;
+	map->core.flush = mp->flush;
 
 	map->comp_level = mp->comp_level;
 
@@ -450,7 +450,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 	md->core.start = md->core.overwrite ? head : old;
 	md->core.end = md->core.overwrite ? old : head;
 
-	if ((md->core.end - md->core.start) < md->flush)
+	if ((md->core.end - md->core.start) < md->core.flush)
 		return -EAGAIN;
 
 	size = md->core.end - md->core.start;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bdbbf48ee906..e335c341d073 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -32,7 +32,6 @@ struct mmap {
 	} aio;
 #endif
 	cpu_set_t	affinity_mask;
-	u64		flush;
 	void		*data;
 	int		comp_level;
 };
-- 
2.21.0

