Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45146C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184BF23404
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507694;
	bh=uNT3VdhTaNqAYKUXZis/XSlNwNtmzv0Wjjb6Lax/jmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=odR1POAlbELUmnWtElUqPTyB/qnqGo/uw7lGYuPYKe2rM/WlbjAlzbs9joaGnSzix
	 /3ygxtZuD9e7zJ/WzJfvZS8NduZ8RwRFBBFEh5P+BXa8EWnX/9WjV1tH31NelGd3aH
	 SQMKZXYFu6vr6QEZg6RurC3lkqsLwOj0Danw5AUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404667AbfHVVBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404579AbfHVVB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:29 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3FD7233FC;
        Thu, 22 Aug 2019 21:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507688;
        bh=uNT3VdhTaNqAYKUXZis/XSlNwNtmzv0Wjjb6Lax/jmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WE/bEJq3ONI7bpjP1ZqDlB9stsdS6vEBurl/kXMC6trOKj0MO+qXY4X+25ApHVw0W
         xghX5EHGLCOSjf7smi8O7UfGxTbGgKA3eonrPJCaulzL9LO9iUT4kG8KRiT7K6Q84u
         aAVGP6eF9/ZjwvDGvtXjLe0FDkMrkwnbRX0xhdY0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/25] libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()
Date:   Thu, 22 Aug 2019 18:00:39 -0300
Message-Id: <20190822210100.3461-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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

