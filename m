Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62419C4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5AF222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458096;
	bh=mwN3XCOY2D1HNrC7wu5tUUtmWJ8TELsDdn4pXDDSvgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMSTHIFevxscaKS7bUn/CaZnsXR5ZiA5E7uSNV2+GLnubb9kqIUUPJMVcTlHtDRfF
	 1EnCzlQLQulPojDHF2Se8c/wM0jLtE0TcJH1VIpZgPA61yiN7S7FHb+LZkWCvOBkxZ
	 9oTebB78+pZaSLLEySQ2wbXbsxfAsSOBVp3bfp5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbfIZAez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388885AbfIZAex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:53 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330F8217F4;
        Thu, 26 Sep 2019 00:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458092;
        bh=mwN3XCOY2D1HNrC7wu5tUUtmWJ8TELsDdn4pXDDSvgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZynfO0h+ap8LfW5OuVFoN7XR+rnWFzBbXH7XLWLhqaMbevsZ3zac7jwUiMd/E8U3
         Wqbo3sSiAol3RVn/46vSVQnSSsJDrsd9BWdgJhXJZdmK5kOYmQxuOe9HDlxW9qgb0u
         PMpvjeqbRARVj0mssakbilO1Txj6z+9Gg7dwqtTQ=
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
Subject: [PATCH 31/66] libperf: Add 'flush' to 'struct perf_mmap'
Date:   Wed, 25 Sep 2019 21:32:09 -0300
Message-Id: <20190926003244.13962-32-acme@kernel.org>
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

Move 'flush' from tools/perf's mmap to libperf's perf_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c            | 10 +++++-----
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/util/mmap.c                 |  4 ++--
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2520c0212275..06738efd9820 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -973,13 +973,13 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
@@ -987,13 +987,13 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
index 10653b6e864e..ba1e519c15b9 100644
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
index 75c77fa57121..e567c1c875bd 100644
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

