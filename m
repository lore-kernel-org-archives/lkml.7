Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0CECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E31D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfJOFcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42026 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfJOFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQy-0000Ab-KY; Tue, 15 Oct 2019 07:31:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C3CA1C04D4;
        Tue, 15 Oct 2019 07:31:41 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:41 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__mmap_len() function from
 tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-4-jolsa@kernel.org>
References: <20191007125344.14268-4-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750137.12254.17060612108241104664.tip-bot2@tip-bot2>
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

Commit-ID:     bf59b3053e63783520c2810fc3f676553bc7eedd
Gitweb:        https://git.kernel.org/tip/bf59b3053e63783520c2810fc3f676553bc7eedd
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:11 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 09:41:38 -03:00

libperf: Adopt perf_mmap__mmap_len() function from tools/perf

Move perf_mmap__mmap_len() from tools/perf wto libperf, it will be used
in the following patches. And rename the existing perf's function to
mmap__mmap_len().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c            |  4 ++--
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  |  6 ++++++
 tools/perf/util/mmap.c                 | 20 ++++++++++----------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2333286..f05e8b7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -276,7 +276,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 
 	if (record__comp_enabled(aio->rec)) {
 		size = zstd_compress(aio->rec->session, aio->data + aio->size,
-				     perf_mmap__mmap_len(map) - aio->size,
+				     mmap__mmap_len(map) - aio->size,
 				     buf, size);
 	} else {
 		memcpy(aio->data + aio->size, buf, size);
@@ -488,7 +488,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map->data, perf_mmap__mmap_len(map), bf, size);
+		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
 		bf   = map->data;
 	}
 
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index b26806b..e7a6726 100644
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
index 3da6177..cc4284d 100644
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
index a496ced..a8e81c4 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,9 +23,9 @@
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
 
-size_t perf_mmap__mmap_len(struct mmap *map)
+size_t mmap__mmap_len(struct mmap *map)
 {
-	return map->core.mask + 1 + page_size;
+	return perf_mmap__mmap_len(&map->core);
 }
 
 /* When check_messup is true, 'end' must points to a good entry */
@@ -170,7 +170,7 @@ static int perf_mmap__aio_enabled(struct mmap *map)
 #ifdef HAVE_LIBNUMA_SUPPORT
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
-	map->aio.data[idx] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+	map->aio.data[idx] = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 	if (map->aio.data[idx] == MAP_FAILED) {
 		map->aio.data[idx] = NULL;
@@ -183,7 +183,7 @@ static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
 	if (map->aio.data[idx]) {
-		munmap(map->aio.data[idx], perf_mmap__mmap_len(map));
+		munmap(map->aio.data[idx], mmap__mmap_len(map));
 		map->aio.data[idx] = NULL;
 	}
 }
@@ -196,7 +196,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 
 	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
 		data = map->aio.data[idx];
-		mmap_len = perf_mmap__mmap_len(map);
+		mmap_len = mmap__mmap_len(map);
 		node_mask = 1UL << cpu__get_node(cpu);
 		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
 			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
@@ -210,7 +210,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 #else /* !HAVE_LIBNUMA_SUPPORT */
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
-	map->aio.data[idx] = malloc(perf_mmap__mmap_len(map));
+	map->aio.data[idx] = malloc(mmap__mmap_len(map));
 	if (map->aio.data[idx] == NULL)
 		return -1;
 
@@ -315,11 +315,11 @@ void perf_mmap__munmap(struct mmap *map)
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
@@ -371,7 +371,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	refcount_set(&map->core.refcnt, 2);
 	map->core.prev = 0;
 	map->core.mask = mp->core.mask;
-	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->core.prot,
+	map->core.base = mmap(NULL, mmap__mmap_len(map), mp->core.prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
@@ -389,7 +389,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	map->comp_level = mp->comp_level;
 
 	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
-		map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				 MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (map->data == MAP_FAILED) {
 			pr_debug2("failed to mmap data buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 4ff75d8..2b97dc6 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -67,7 +67,7 @@ union perf_event *perf_mmap__read_event(struct mmap *map);
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size));
 
-size_t perf_mmap__mmap_len(struct mmap *map);
+size_t mmap__mmap_len(struct mmap *map);
 
 int perf_mmap__read_init(struct mmap *md);
 void perf_mmap__read_done(struct mmap *map);
