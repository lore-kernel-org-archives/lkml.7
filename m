Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F539C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0192F21924
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452833;
	bh=pWP0ro7ZLl0zM+hCS0IV3XRvwgyPIdzyLtfyo9aVMLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UxK584omVM54CsycLWlKNFSXM2bgMxnDrCBJepgWv/MlMgLTiMadU29bEEumy6EBi
	 JweewMtnzAGpS/hYidzA01jSw4WbWWph0aAYklScSaZGtBFaZgV+hsCaLmOFQlj6zx
	 67X8vBvlycIlfiEL6PQAWew6CmOVC8ZbHI/G+HFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJGMxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:53:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:53:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CECD18C4272;
        Mon,  7 Oct 2019 12:53:50 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF975D9CD;
        Mon,  7 Oct 2019 12:53:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 01/36] libperf: Add perf_mmap__init() function
Date:   Mon,  7 Oct 2019 14:53:09 +0200
Message-Id: <20191007125344.14268-2-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Mon, 07 Oct 2019 12:53:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_mmap__init() function to initialize 'struct perf_mmap' object.

Add it to a new mmap.c object, that will carry all the mmap related
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-40-jolsa@kernel.org
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
index d277a98e62df..633a407b1294 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -605,8 +605,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
-		map[i].core.fd = -1;
-		map[i].core.overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -616,8 +614,9 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
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

