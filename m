Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247D8C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BB1217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381145;
	bh=H5KbKxWXq7SZcsYJoh9Y61IMCEPOzwxDOwM8flRJt8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aE5Zf5jXLiE2TMUwaqTQ6APBP0r0u5Hz6VFDLxyhrk7nWCDoA8khcUymJ5oqtJ4NG
	 5o1kv0+nRbw/IADn+xKa8RiSJyga3cdmisaWpRblmfDgsnSCdqkeWxzqPKoOurJCDu
	 MS/kXVlziUN7FwW5wwCFgX74Vy8KGu8wZduGHomM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbfIMNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391402AbfIMNZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20834C053B26;
        Fri, 13 Sep 2019 13:25:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A76A5C1D4;
        Fri, 13 Sep 2019 13:25:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 41/73] libperf: Add perf_mmap__mmap_len function
Date:   Fri, 13 Sep 2019 15:23:23 +0200
Message-Id: <20190913132355.21634-42-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 13 Sep 2019 13:25:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__mmap_len function under libperf,
it will be used in following patches. And rename
the existing perf's function to mmap__mmap_len.

Link: http://lkml.kernel.org/n/tip-bl2yh297jg6tbsxo94px5fdm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c            |  4 ++--
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  |  6 ++++++
 tools/perf/util/mmap.c                 | 20 ++++++++++----------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7b12877de27c..40780434b23e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -273,7 +273,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 
 	if (record__comp_enabled(aio->rec)) {
 		size = zstd_compress(aio->rec->session, aio->data + aio->size,
-				     perf_mmap__mmap_len(map) - aio->size,
+				     mmap__mmap_len(map) - aio->size,
 				     buf, size);
 	} else {
 		memcpy(aio->data + aio->size, buf, size);
@@ -485,7 +485,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map->data, perf_mmap__mmap_len(map), bf, size);
+		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
 		bf   = map->data;
 	}
 
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 8e06eb840c47..45ab791aa392 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -34,6 +34,8 @@ struct perf_mmap_param {
 	int	mask;
 };
 
+size_t perf_mmap__mmap_len(struct perf_mmap *map);
+
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 3da6177510e6..cc4284da4d99 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <internal/mmap.h>
+#include <internal/lib.h>
 
 void perf_mmap__init(struct perf_mmap *map, bool overwrite)
 {
@@ -7,3 +8,8 @@ void perf_mmap__init(struct perf_mmap *map, bool overwrite)
 	map->overwrite = overwrite;
 	refcount_set(&map->refcnt, 0);
 }
+
+size_t perf_mmap__mmap_len(struct perf_mmap *map)
+{
+	return map->mask + 1 + page_size;
+}
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2f34a93a72f4..4e2ef633d425 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -22,9 +22,9 @@
 #include "../perf.h"
 #include "util.h" /* page_size */
 
-size_t perf_mmap__mmap_len(struct mmap *map)
+size_t mmap__mmap_len(struct mmap *map)
 {
-	return map->core.mask + 1 + page_size;
+	return perf_mmap__mmap_len(&map->core);
 }
 
 /* When check_messup is true, 'end' must points to a good entry */
@@ -169,7 +169,7 @@ static int perf_mmap__aio_enabled(struct mmap *map)
 #ifdef HAVE_LIBNUMA_SUPPORT
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
-	map->aio.data[idx] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+	map->aio.data[idx] = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 	if (map->aio.data[idx] == MAP_FAILED) {
 		map->aio.data[idx] = NULL;
@@ -182,7 +182,7 @@ static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
 	if (map->aio.data[idx]) {
-		munmap(map->aio.data[idx], perf_mmap__mmap_len(map));
+		munmap(map->aio.data[idx], mmap__mmap_len(map));
 		map->aio.data[idx] = NULL;
 	}
 }
@@ -195,7 +195,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 
 	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
 		data = map->aio.data[idx];
-		mmap_len = perf_mmap__mmap_len(map);
+		mmap_len = mmap__mmap_len(map);
 		node_mask = 1UL << cpu__get_node(cpu);
 		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
 			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
@@ -209,7 +209,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 #else /* !HAVE_LIBNUMA_SUPPORT */
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
-	map->aio.data[idx] = malloc(perf_mmap__mmap_len(map));
+	map->aio.data[idx] = malloc(mmap__mmap_len(map));
 	if (map->aio.data[idx] == NULL)
 		return -1;
 
@@ -314,11 +314,11 @@ void perf_mmap__munmap(struct mmap *map)
 {
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
-		munmap(map->data, perf_mmap__mmap_len(map));
+		munmap(map->data, mmap__mmap_len(map));
 		map->data = NULL;
 	}
 	if (map->core.base != NULL) {
-		munmap(map->core.base, perf_mmap__mmap_len(map));
+		munmap(map->core.base, mmap__mmap_len(map));
 		map->core.base = NULL;
 		map->core.fd = -1;
 		refcount_set(&map->core.refcnt, 0);
@@ -370,7 +370,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	refcount_set(&map->core.refcnt, 2);
 	map->core.prev = 0;
 	map->core.mask = mp->core.mask;
-	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->core.prot,
+	map->core.base = mmap(NULL, mmap__mmap_len(map), mp->core.prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
@@ -388,7 +388,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	map->comp_level = mp->comp_level;
 
 	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
-		map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				 MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (map->data == MAP_FAILED) {
 			pr_debug2("failed to mmap data buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 965acb46df81..308492a59ea1 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -95,7 +95,7 @@ union perf_event *perf_mmap__read_event(struct mmap *map);
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size));
 
-size_t perf_mmap__mmap_len(struct mmap *map);
+size_t mmap__mmap_len(struct mmap *map);
 
 int perf_mmap__read_init(struct mmap *md);
 void perf_mmap__read_done(struct mmap *map);
-- 
2.21.0

