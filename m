Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB645C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87319208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405235AbfITQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52876 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404983AbfITQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLei-0004Br-MM; Fri, 20 Sep 2019 18:21:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 22EEA1C0E39;
        Fri, 20 Sep 2019 18:21:02 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:01 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] libperf: Adopt perf_cpu_map__max() function
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190902121255.536-2-jolsa@kernel.org>
References: <20190902121255.536-2-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156899646195.24167.8623127758746231981.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4256d434935e9c85a731823be562785494ca364b
Gitweb:        https://git.kernel.org/tip/4256d434935e9c85a731823be562785494ca364b
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 02 Sep 2019 14:12:53 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Sep 2019 14:33:32 +01:00

libperf: Adopt perf_cpu_map__max() function

>From 'perf stat', so that it can be used from multiple places.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190902121255.536-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c            | 14 +-------------
 tools/perf/lib/cpumap.c              | 12 ++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  1 +
 tools/perf/lib/libperf.map           |  1 +
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7e17bf9..5bc0c57 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -822,18 +822,6 @@ static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 	return cpu_map__get_core(map, cpu, NULL);
 }
 
-static int cpu_map__get_max(struct perf_cpu_map *map)
-{
-	int i, max = -1;
-
-	for (i = 0; i < map->nr; i++) {
-		if (map->map[i] > max)
-			max = map->map[i];
-	}
-
-	return max;
-}
-
 static int perf_stat__get_aggr(struct perf_stat_config *config,
 			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
 {
@@ -928,7 +916,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = cpu_map__get_max(evsel_list->core.cpus);
+	nr = perf_cpu_map__max(evsel_list->core.cpus);
 	stat_config.cpus_aggr_map = perf_cpu_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 1f0e6f3..2ca1faf 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -260,3 +260,15 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 
 	return -1;
 }
+
+int perf_cpu_map__max(struct perf_cpu_map *map)
+{
+	int i, max = -1;
+
+	for (i = 0; i < map->nr; i++) {
+		if (map->map[i] > max)
+			max = map->map[i];
+	}
+
+	return max;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 8aa995c..ac9aa49 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -16,6 +16,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index dc4d663..cd0d17b 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__empty;
+		perf_cpu_map__max;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
