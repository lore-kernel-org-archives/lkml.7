Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B60ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8622B2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824617;
	bh=ZAPZSJPb02yh+Ie8cOfuqvE5atWjQ3RSj2lu+IaH9eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TXfnRjOqTq7GU4fdBYMCgOt7LNP2nrUY5+GxZE5OpGyCRr4S6soYoXCOm8pt91pnM
	 rwJ6eEYuns6XYNmESqH3AQuLLygvQzdzS0YLEximOHx09WQl0NIyMwp6Eq+TCFMAmy
	 o+txjIo8K0uE5q4rsXoGackICXtauQc+aMNmqYiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfJKUKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbfJKUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:15 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095BD222C5;
        Fri, 11 Oct 2019 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824614;
        bh=ZAPZSJPb02yh+Ie8cOfuqvE5atWjQ3RSj2lu+IaH9eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIGYTMIbuFdy2aGH9hTYP/H1G8ZhsQ3gckI513cQJZJQONmULMGreRFlKoyoW/LMO
         C38y8DdYHxAOB1CCuF5W/ae3H3/dXqwU/r6FISfIGs0CPu+b/J4fl7dEQLdlC6McZC
         TTXcUBNwjWvnilyWR4OUnJOUIb1uDJ0eunKBtdZw=
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
Subject: [PATCH 42/69] libperf: Add perf_mmap__init() function
Date:   Fri, 11 Oct 2019 17:05:32 -0300
Message-Id: <20191011200559.7156-43-acme@kernel.org>
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

Add perf_mmap__init() function to initialize 'struct perf_mmap' objects.

Add it to a new mmap.c source file, that will carry all the mmap related
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                   | 1 +
 tools/perf/lib/include/internal/mmap.h | 2 ++
 tools/perf/lib/mmap.c                  | 9 +++++++++
 tools/perf/util/evlist.c               | 5 ++---
 4 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/lib/mmap.c

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index c31f1c111f8f..2ef9a4ec6d99 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -3,6 +3,7 @@ libperf-y += cpumap.o
 libperf-y += threadmap.o
 libperf-y += evsel.o
 libperf-y += evlist.o
+libperf-y += mmap.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
 libperf-y += lib.o
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index ba1e519c15b9..e25890de6a55 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -29,4 +29,6 @@ struct perf_mmap {
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
+void perf_mmap__init(struct perf_mmap *map, bool overwrite);
+
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
new file mode 100644
index 000000000000..3da6177510e6
--- /dev/null
+++ b/tools/perf/lib/mmap.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <internal/mmap.h>
+
+void perf_mmap__init(struct perf_mmap *map, bool overwrite)
+{
+	map->fd = -1;
+	map->overwrite = overwrite;
+	refcount_set(&map->refcnt, 0);
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e33b46aca5cb..6c8de0865670 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -629,8 +629,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
-		map[i].core.fd = -1;
-		map[i].core.overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -640,8 +638,9 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		refcount_set(&map[i].core.refcnt, 0);
+		perf_mmap__init(&map[i].core, overwrite);
 	}
+
 	return map;
 }
 
-- 
2.21.0

