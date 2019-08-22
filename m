Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858ABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0E522CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566472314;
	bh=eHBgGn80yeTDfIe7ALPF3FsB8wuDr5w7m3zNN/EQz0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GIznhaeR/AZ4qZnijwQgZnzb6gyzVr4xbQAY62HGQHTu2panTl09+4f5TT+bSJ2W2
	 zuMLKTv/g4CcVG4gYqZGgqOb2ekRiFhSTIhABL0zzxEwxbmOKcx7ElgX7hcKMgEbGo
	 rCmGsqQLGKFeMbXMJHgUgadzRVIZFMvca0Ziw/08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfHVLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:11:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388127AbfHVLLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:11:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 928E4300C72A;
        Thu, 22 Aug 2019 11:11:51 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE5541001B17;
        Thu, 22 Aug 2019 11:11:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 4/5] libperf: Move cpu_map__idx to perf_cpu_map__idx
Date:   Thu, 22 Aug 2019 13:11:40 +0200
Message-Id: <20190822111141.25823-5-jolsa@kernel.org>
In-Reply-To: <20190822111141.25823-1-jolsa@kernel.org>
References: <20190822111141.25823-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 11:11:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an internal function that will be used by both
perf and libperf, but is not exported at this point.

Link: http://lkml.kernel.org/n/tip-wa4bngnci9395p6xk0nfmj9h@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/cpumap.c                  | 12 ++++++++++++
 tools/perf/lib/include/internal/cpumap.h |  2 ++
 tools/perf/util/cpumap.c                 | 14 +-------------
 tools/perf/util/cpumap.h                 |  1 -
 tools/perf/util/evlist.c                 |  2 +-
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 63f7df7e47ff..2834753576b2 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -242,3 +242,15 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
 	return map ? map->map[0] == -1 : true;
 }
+
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
+{
+	int i;
+
+	for (i = 0; i < cpus->nr; ++i) {
+		if (cpus->map[i] == cpu)
+			return i;
+	}
+
+	return -1;
+}
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
index 3306319f7df8..840d4032587b 100644
--- a/tools/perf/lib/include/internal/cpumap.h
+++ b/tools/perf/lib/include/internal/cpumap.h
@@ -14,4 +14,6 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
+
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 4402e67445a4..8e6c2cbffedc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -458,19 +458,7 @@ int cpu__setup_cpunode_map(void)
 
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
 {
-	return cpu_map__idx(cpus, cpu) != -1;
-}
-
-int cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
-{
-	int i;
-
-	for (i = 0; i < cpus->nr; ++i) {
-		if (cpus->map[i] == cpu)
-			return i;
-	}
-
-	return -1;
+	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 3e068090612f..8dbedda7af45 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -62,5 +62,4 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
-int cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ba49b5ecffd0..8582560b59af 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -758,7 +758,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (evsel->system_wide && thread)
 			continue;
 
-		cpu = cpu_map__idx(evsel->core.cpus, evlist_cpu);
+		cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
 		if (cpu == -1)
 			continue;
 
-- 
2.21.0

