Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF4C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721B22147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708572;
	bh=PHksIxjfoqXE3q+HLOJLFn9AMMyWnevEJrJ7SrM4BWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=npRMkgBBnRW3GUI/1lNkNGOFwn6o8oLB26a3n4gJTz1HShkQC0jRqwiI9HCf8LGpo
	 2MijMLYVmwEMuM71Tn966ThEiehzB2qtouXlDOAg5tCanff0gV6+23hl9h0jm6W2JC
	 QFtpoB/Zt4kKcxb7wXDzIa2PtOdF74o3b0QMwdRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfGUL3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:29:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39EB03082E24;
        Sun, 21 Jul 2019 11:29:30 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 677215D9D3;
        Sun, 21 Jul 2019 11:29:25 +0000 (UTC)
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
Subject: [PATCH 37/79] libperf: Add perf_evsel__init function
Date:   Sun, 21 Jul 2019 13:24:24 +0200
Message-Id: <20190721112506.12306-38-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 21 Jul 2019 11:29:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evsel__init function to initialize
perf_evsel struct.

Link: http://lkml.kernel.org/n/tip-nr0r23hdi4ifk7a487jdths0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evsel.c              | 5 +++++
 tools/perf/lib/include/perf/evsel.h | 4 ++++
 tools/perf/lib/libperf.map          | 1 +
 tools/perf/util/evsel.c             | 3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 12e86de1994b..9a87e867a7ec 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -2,3 +2,8 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
+
+void perf_evsel__init(struct perf_evsel *evsel)
+{
+	INIT_LIST_HEAD(&evsel->node);
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 162bffd43409..b4d074a3684b 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_EVSEL_H
 #define __LIBPERF_EVSEL_H
 
+#include <perf/core.h>
+
 struct perf_evsel;
 
+LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index c4f611010ccc..54f8503c6d82 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__comm;
 		perf_thread_map__get;
 		perf_thread_map__put;
+		perf_evsel__init;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8fed22d889a4..172bcc2e198f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -22,6 +22,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <perf/evsel.h>
 #include "asm/bug.h"
 #include "callchain.h"
 #include "cgroup.h"
@@ -226,6 +227,7 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 void evsel__init(struct evsel *evsel,
 		 struct perf_event_attr *attr, int idx)
 {
+	perf_evsel__init(&evsel->core);
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
 	evsel->attr	   = *attr;
@@ -236,7 +238,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
-	INIT_LIST_HEAD(&evsel->core.node);
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
-- 
2.21.0

