Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B8421848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394530AbfHWMWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:22:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35199 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394466AbfHWMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18ZX-0001gZ-LG; Fri, 23 Aug 2019 14:21:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4AA671C08B0;
        Fri, 23 Aug 2019 14:21:39 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:39 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822111141.25823-5-jolsa@kernel.org>
References: <20190822111141.25823-5-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156656289921.31546.5483240567773794836.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b4df75de3b3930703415aa053a269ae07c78d9b2
Gitweb:        https://git.kernel.org/tip/b4df75de3b3930703415aa053a269ae07c78d9b2
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 22 Aug 2019 13:11:40 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 11:18:45 -03:00

libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()

As an internal function that will be used by both perf and libperf, but
is not exported at this point.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190822111141.25823-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c                  | 12 ++++++++++++
 tools/perf/lib/include/internal/cpumap.h |  2 ++
 tools/perf/util/cpumap.c                 | 14 +-------------
 tools/perf/util/cpumap.h                 |  1 -
 tools/perf/util/evlist.c                 |  2 +-
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 63f7df7..2834753 100644
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
index 3306319..840d403 100644
--- a/tools/perf/lib/include/internal/cpumap.h
+++ b/tools/perf/lib/include/internal/cpumap.h
@@ -14,4 +14,6 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
+
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 4402e67..8e6c2cb 100644
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
index 3e06809..8dbedda 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -62,5 +62,4 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
-int cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ba49b5e..8582560 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -758,7 +758,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (evsel->system_wide && thread)
 			continue;
 
-		cpu = cpu_map__idx(evsel->core.cpus, evlist_cpu);
+		cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
 		if (cpu == -1)
 			continue;
 
