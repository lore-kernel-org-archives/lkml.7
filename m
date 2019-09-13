Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC09C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3481214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381142;
	bh=+aeV9ASaLWzzuBN6CCwlcZDOFlUgjVDtKB5tgexwOms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o5/ClmWRN+kfnfRkPc6ZQfmrDtE7CkquouMyssVvdd8vyqvdu7wxMz4zHeV3SIoD3
	 8Ui5QF3XYjRkytOXFnf7ZGy4HApKG/FIgLY+55Hxg7UqeAxu6E4Ujs5/zUFRQft/rm
	 sjygtT2tBbdxZo6tlqpQZS1xXFXonEtT9QjM+IWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbfIMNZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391402AbfIMNZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37F5C50F4D;
        Fri, 13 Sep 2019 13:25:37 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92D145C1D4;
        Fri, 13 Sep 2019 13:25:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 39/73] libperf: Add perf_mmap__init function
Date:   Fri, 13 Sep 2019 15:23:21 +0200
Message-Id: <20190913132355.21634-40-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 13 Sep 2019 13:25:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_mmap__init function to initialize
'struct perf_mmap' object. Adding it to new
mmap.c object, that will carry all the mmap
related functions.

Link: http://lkml.kernel.org/n/tip-hvilw6n69knpyhdndrslgtdu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index a147b25c4b88..e95fc51e5bd0 100644
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
index dcc4accd3180..0d1ae00d22f3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -604,8 +604,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
-		map[i].core.fd = -1;
-		map[i].core.overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -615,8 +613,9 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
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

