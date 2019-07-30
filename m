Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5426C2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455684;
	bh=Pw3CHLw1UkY+PFK9hu7cmOCAtAMKEn/ogD+ZhWDcDSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jev0QvpxQg3B2kZJVgKwfYeR5yQRlyrNFG4yg52CnkmRmg71U+3pnfkz8Mf2WBgK7
	 NWVY2yV+hvjKlovJMY98SWiTx8/A4d5ID1n5JzEHMAEgXUnSRFAtNbzdlBa1YnhVfV
	 LMlavehHIbnT8KmI6GDZywdX0zNUPQTq6QUjCQNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfG3DBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732573AbfG3DBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA86E206DD;
        Tue, 30 Jul 2019 03:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455678;
        bh=Pw3CHLw1UkY+PFK9hu7cmOCAtAMKEn/ogD+ZhWDcDSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdP+KVbKfV1pb8dWSIT40DXPhIQD3FACwHtfU+DPjT6F0hb1fzhMqrezssph+kgjT
         sjDoJvKxznRxl2lmnw2T/V9gHNH6RLJjYwOzJNlZcg1V+eYfMgY8C3pHm4Sl4S6maD
         1WQPZwQndUGEnPdvaCdIO7QykK4i7C1Ab3SAvmhw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 088/107] libperf: Adopt perf_evsel__alloc_fd() function from tools/perf
Date:   Mon, 29 Jul 2019 23:55:51 -0300
Message-Id: <20190730025610.22603-89-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the perf_evsel__alloc_fd() function from perf to libperf.

It's not exported.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-62-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 21 +++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  2 ++
 tools/perf/util/evsel.c                 | 18 +-----------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index ddc3ad447bfb..027f1edb4e8e 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <internal/xyarray.h>
+#include <linux/string.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -25,3 +28,21 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 {
 	free(evsel);
 }
+
+#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
+
+	if (evsel->fd) {
+		int cpu, thread;
+		for (cpu = 0; cpu < ncpus; cpu++) {
+			for (thread = 0; thread < nthreads; thread++) {
+				FD(evsel, cpu, thread) = -1;
+			}
+		}
+	}
+
+	return evsel->fd != NULL ? 0 : -ENOMEM;
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 29eca9576546..3cb9a0f5f32e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -20,4 +20,6 @@ struct perf_evsel {
 	int			 nr_members;
 };
 
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8b9a00598677..d3c8488f7069 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1153,22 +1153,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-static int perf_evsel__alloc_fd(struct evsel *evsel, int ncpus, int nthreads)
-{
-	evsel->core.fd = xyarray__new(ncpus, nthreads, sizeof(int));
-
-	if (evsel->core.fd) {
-		int cpu, thread;
-		for (cpu = 0; cpu < ncpus; cpu++) {
-			for (thread = 0; thread < nthreads; thread++) {
-				FD(evsel, cpu, thread) = -1;
-			}
-		}
-	}
-
-	return evsel->core.fd != NULL ? 0 : -ENOMEM;
-}
-
 static int perf_evsel__run_ioctl(struct evsel *evsel,
 			  int ioc,  void *arg)
 {
@@ -1866,7 +1850,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		nthreads = threads->nr;
 
 	if (evsel->core.fd == NULL &&
-	    perf_evsel__alloc_fd(evsel, cpus->nr, nthreads) < 0)
+	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
 		return -ENOMEM;
 
 	if (evsel->cgrp) {
-- 
2.21.0

