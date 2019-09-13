Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4554C206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381120;
	bh=3ZJ7J0lGIxvbhKiBy6saH7KwjreJUcCJbkgRUbxtzgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PxJh3buCIR3ieZDAtoacWubj9qzh6CPj+P2s6pwUexFRnGxpvrDChSEz1bR0i+ipu
	 A9EMMKOoKeo8cQwwm9Q3Oms80LIZUIlVUufKBpWJ60C+Cd3y2k5I2Xc7fDtArlfFD3
	 nuYarIVA/R60Ul0VcCQ2vbva8sLcAfltCEqhpVNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbfIMNZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391311AbfIMNZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C46A63023080;
        Fri, 13 Sep 2019 13:25:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F19565C219;
        Fri, 13 Sep 2019 13:25:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 30/73] libperf: Add perf_evlist__id_add function
Date:   Fri, 13 Sep 2019 15:23:12 +0200
Message-Id: <20190913132355.21634-31-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 13:25:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__id_add function to libperf
as internal function. We already have the heads
member in 'struct perf_evlist'.

Link: http://lkml.kernel.org/n/tip-950pzhjg5ureque9bd0mq0lc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 25 ++++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 tools/perf/tests/event_update.c          |  2 +-
 tools/perf/util/evlist.c                 | 22 +--------------------
 tools/perf/util/evlist.h                 |  2 --
 tools/perf/util/header.c                 |  4 ++--
 6 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index ae861bf38976..f4f8e37c6272 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -2,8 +2,10 @@
 #include <perf/evlist.h>
 #include <perf/evsel.h>
 #include <linux/list.h>
+#include <linux/hash.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
+#include <internal/xyarray.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
@@ -168,3 +170,26 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
 	return first->attr.read_format;
 }
+
+#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+
+static void perf_evlist__id_hash(struct perf_evlist *evlist,
+				 struct perf_evsel *evsel,
+				 int cpu, int thread, u64 id)
+{
+	int hash;
+	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+
+	sid->id = id;
+	sid->evsel = evsel;
+	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
+	hlist_add_head(&sid->node, &evlist->heads[hash]);
+}
+
+void perf_evlist__id_add(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel,
+			 int cpu, int thread, u64 id)
+{
+	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	evsel->id[evsel->ids++] = id;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 63516fe14f4c..649406f717bc 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -68,4 +68,8 @@ static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
 
 u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
+void perf_evlist__id_add(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel,
+			 int cpu, int thread, u64 id);
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 0c982550799c..89c8f047676a 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -95,7 +95,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to allos ids",
 			!perf_evsel__alloc_id(&evsel->core, 1, 1));
 
-	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
+	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
 
 	evsel->unit = strdup("KRAVA");
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index de1dc73d1fe4..dde6c68b9a42 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -460,26 +460,6 @@ int perf_evlist__poll(struct evlist *evlist, int timeout)
 	return fdarray__poll(&evlist->core.pollfd, timeout);
 }
 
-static void perf_evlist__id_hash(struct evlist *evlist,
-				 struct evsel *evsel,
-				 int cpu, int thread, u64 id)
-{
-	int hash;
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
-
-	sid->id = id;
-	sid->evsel = &evsel->core;
-	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
-	hlist_add_head(&sid->node, &evlist->core.heads[hash]);
-}
-
-void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
-			 int cpu, int thread, u64 id)
-{
-	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->core.id[evsel->core.ids++] = id;
-}
-
 int perf_evlist__id_add_fd(struct evlist *evlist,
 			   struct evsel *evsel,
 			   int cpu, int thread, int fd)
@@ -517,7 +497,7 @@ int perf_evlist__id_add_fd(struct evlist *evlist,
 	id = read_data[id_idx];
 
  add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(&evlist->core, &evsel->core, cpu, thread, id);
 	return 0;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f0212738bed6..37f29b67dd61 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -113,8 +113,6 @@ struct evsel *
 perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
-			 int cpu, int thread, u64 id);
 int perf_evlist__id_add_fd(struct evlist *evlist,
 			   struct evsel *evsel,
 			   int cpu, int thread, int fd);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 65b6e387e3ae..20f6c8eda8ff 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3633,7 +3633,7 @@ int perf_session__read_header(struct perf_session *session)
 			if (perf_header__getbuffer64(header, fd, &f_id, sizeof(f_id)))
 				goto out_errno;
 
-			perf_evlist__id_add(session->evlist, evsel, 0, j, f_id);
+			perf_evlist__id_add(&session->evlist->core, &evsel->core, 0, j, f_id);
 		}
 
 		lseek(fd, tmp, SEEK_SET);
@@ -4062,7 +4062,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 		return -ENOMEM;
 
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(evlist, evsel, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
 	}
 
 	return 0;
-- 
2.21.0

