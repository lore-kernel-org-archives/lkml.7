Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197321726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455491;
	bh=dMObh+RlWlzyqT4LnneM73Rjn+tfXumTAKFnVKzwrtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fpZxSMc8Y3tKi0pS2yNRJ5c/OU5pc7QiXfoy8ya+UmmnU7337IFHF8AazuLde8hU9
	 KE2b5UDRbHYi7HviOaOx1lJ0oTvkLIGFS0OV62MmECHoneun8RM7IdtieKNuAjBan4
	 gliPbp+adoAADR0PI0+Gamd+tUKP0Ng3tQYHUfMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfG3C6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbfG3C6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB14206DD;
        Tue, 30 Jul 2019 02:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455487;
        bh=dMObh+RlWlzyqT4LnneM73Rjn+tfXumTAKFnVKzwrtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CmLhS7BPdsbBlezM3bVOhua5psdTim4Os3IoyizpUOagcyoS24NDsY9KGVaEZIqC
         /aFPx1Vl6iJ1/cYH81+pF3Dhv0IpT9Af8AwKz1xg5ZwZ/SNhqAJJBKEs+b3hTNPi7c
         OjsQRkLJsxog7jn55D2Nd1kwOHqcL6wFWH4y90ic=
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
Subject: [PATCH 034/107] perf evlist: Rename perf_evlist__init() to evlist__init()
Date:   Mon, 29 Jul 2019 23:54:57 -0300
Message-Id: <20190730025610.22603-35-acme@kernel.org>
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

Rename perf_evlist__init() to evlist__init(), so we don't have a name
clash when we add perf_evlist__init() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 6 +++---
 tools/perf/util/evlist.h | 4 ++--
 tools/perf/util/python.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c234fa4ba92a..4fcd55c8a8d5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -41,8 +41,8 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-void perf_evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
-		       struct perf_thread_map *threads)
+void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
+		  struct perf_thread_map *threads)
 {
 	int i;
 
@@ -60,7 +60,7 @@ struct evlist *perf_evlist__new(void)
 	struct evlist *evlist = zalloc(sizeof(*evlist));
 
 	if (evlist != NULL)
-		perf_evlist__init(evlist, NULL, NULL);
+		evlist__init(evlist, NULL, NULL);
 
 	return evlist;
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 54f1c3e2b721..d6a3fa461566 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -68,8 +68,8 @@ struct evsel_str_handler {
 struct evlist *perf_evlist__new(void);
 struct evlist *perf_evlist__new_default(void);
 struct evlist *perf_evlist__new_dummy(void);
-void perf_evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
-		       struct perf_thread_map *threads);
+void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
+		  struct perf_thread_map *threads);
 void perf_evlist__exit(struct evlist *evlist);
 void perf_evlist__delete(struct evlist *evlist);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f6fe3c90828f..ade4e85c6d81 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -873,7 +873,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 
 	threads = ((struct pyrf_thread_map *)pthreads)->threads;
 	cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
-	perf_evlist__init(&pevlist->evlist, cpus, threads);
+	evlist__init(&pevlist->evlist, cpus, threads);
 	return 0;
 }
 
-- 
2.21.0

