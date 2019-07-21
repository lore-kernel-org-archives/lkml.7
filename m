Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4DC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3A02085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708709;
	bh=sifyvYENEg9p+O2JjTnWRyNGLKPsRj6hdIl4SzXQZ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrI5TOuXELrVoNpwD9yA1Rl1SmbbZq1IiPqntTtyvJIKQojAmEykYMkMpn2zfodD0
	 sunBdUA09dPXNvuwYLZ9beDyoXzwicCbw7ZnynoTvbGZlq0vSy683NBYazio+9kgDH
	 EG4zxJwkQjcFta11GPtwVsvreNaq8IAHt6fppD0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGULbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ED2885542;
        Sun, 21 Jul 2019 11:31:46 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04A8913AD1;
        Sun, 21 Jul 2019 11:31:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 61/79] libperf: Add perf_evsel__alloc_fd function
Date:   Sun, 21 Jul 2019 13:24:48 +0200
Message-Id: <20190721112506.12306-62-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 21 Jul 2019 11:31:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving perf_evsel__alloc_fd function into libperf.
It's not exported.

Link: http://lkml.kernel.org/n/tip-wwik9ermjsd3kr9d107inzwo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

