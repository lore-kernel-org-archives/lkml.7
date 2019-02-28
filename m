Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB98C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278FD20643
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfB1Hix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:38:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfB1Hiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:38:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7ce4r2947198
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:38:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7cdVf2947195;
        Wed, 27 Feb 2019 23:38:39 -0800
Date:   Wed, 27 Feb 2019 23:38:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5135d5efcbb439c2acb20d6197dd57af3a456e76@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190219095815.15931-3-jolsa@kernel.org>
References: <20190219095815.15931-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add cpu_topology object
Git-Commit-ID: 5135d5efcbb439c2acb20d6197dd57af3a456e76
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5135d5efcbb439c2acb20d6197dd57af3a456e76
Gitweb:     https://git.kernel.org/tip/5135d5efcbb439c2acb20d6197dd57af3a456e76
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 19 Feb 2019 10:58:13 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 12:21:01 -0300

perf tools: Add cpu_topology object

Make struct cpu_topo global and rename it to 'struct cpu_topology', so
that it can be used from the 'perf record' command in the following
patches.

Add the following interface functions to load/free cpu topology details:

  struct cpu_topology *cpu_topology__new(void);
  void cpu_topology__delete(struct cpu_topology *tp);

Move it to a separate source file cputopo.c together with numa related
object in the following patches.

No functional change, the new interface will be used in upcoming changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190219095815.15931-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/cputopo.c | 144 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  17 ++++++
 tools/perf/util/header.c  | 150 ++--------------------------------------------
 4 files changed, 166 insertions(+), 146 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ca0741c91903..3008d49fa587 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -69,6 +69,7 @@ perf-y += hist.o
 perf-y += util.o
 perf-y += xyarray.o
 perf-y += cpumap.o
+perf-y += cputopo.o
 perf-y += cgroup.o
 perf-y += target.o
 perf-y += rblist.o
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
new file mode 100644
index 000000000000..84470ed4e707
--- /dev/null
+++ b/tools/perf/util/cputopo.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/param.h>
+
+#include "cputopo.h"
+#include "cpumap.h"
+#include "util.h"
+
+
+#define CORE_SIB_FMT \
+	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
+#define THRD_SIB_FMT \
+	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+
+static int build_cpu_topology(struct cpu_topology *tp, int cpu)
+{
+	FILE *fp;
+	char filename[MAXPATHLEN];
+	char *buf = NULL, *p;
+	size_t len = 0;
+	ssize_t sret;
+	u32 i = 0;
+	int ret = -1;
+
+	sprintf(filename, CORE_SIB_FMT, cpu);
+	fp = fopen(filename, "r");
+	if (!fp)
+		goto try_threads;
+
+	sret = getline(&buf, &len, fp);
+	fclose(fp);
+	if (sret <= 0)
+		goto try_threads;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	for (i = 0; i < tp->core_sib; i++) {
+		if (!strcmp(buf, tp->core_siblings[i]))
+			break;
+	}
+	if (i == tp->core_sib) {
+		tp->core_siblings[i] = buf;
+		tp->core_sib++;
+		buf = NULL;
+		len = 0;
+	}
+	ret = 0;
+
+try_threads:
+	sprintf(filename, THRD_SIB_FMT, cpu);
+	fp = fopen(filename, "r");
+	if (!fp)
+		goto done;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto done;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	for (i = 0; i < tp->thread_sib; i++) {
+		if (!strcmp(buf, tp->thread_siblings[i]))
+			break;
+	}
+	if (i == tp->thread_sib) {
+		tp->thread_siblings[i] = buf;
+		tp->thread_sib++;
+		buf = NULL;
+	}
+	ret = 0;
+done:
+	if (fp)
+		fclose(fp);
+	free(buf);
+	return ret;
+}
+
+void cpu_topology__delete(struct cpu_topology *tp)
+{
+	u32 i;
+
+	if (!tp)
+		return;
+
+	for (i = 0 ; i < tp->core_sib; i++)
+		zfree(&tp->core_siblings[i]);
+
+	for (i = 0 ; i < tp->thread_sib; i++)
+		zfree(&tp->thread_siblings[i]);
+
+	free(tp);
+}
+
+struct cpu_topology *cpu_topology__new(void)
+{
+	struct cpu_topology *tp = NULL;
+	void *addr;
+	u32 nr, i;
+	size_t sz;
+	long ncpus;
+	int ret = -1;
+	struct cpu_map *map;
+
+	ncpus = cpu__max_present_cpu();
+
+	/* build online CPU map */
+	map = cpu_map__new(NULL);
+	if (map == NULL) {
+		pr_debug("failed to get system cpumap\n");
+		return NULL;
+	}
+
+	nr = (u32)(ncpus & UINT_MAX);
+
+	sz = nr * sizeof(char *);
+	addr = calloc(1, sizeof(*tp) + 2 * sz);
+	if (!addr)
+		goto out_free;
+
+	tp = addr;
+	addr += sizeof(*tp);
+	tp->core_siblings = addr;
+	addr += sz;
+	tp->thread_siblings = addr;
+
+	for (i = 0; i < nr; i++) {
+		if (!cpu_map__has(map, i))
+			continue;
+
+		ret = build_cpu_topology(tp, i);
+		if (ret < 0)
+			break;
+	}
+
+out_free:
+	cpu_map__put(map);
+	if (ret) {
+		cpu_topology__delete(tp);
+		tp = NULL;
+	}
+	return tp;
+}
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
new file mode 100644
index 000000000000..4b5f4112b6f8
--- /dev/null
+++ b/tools/perf/util/cputopo.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_CPUTOPO_H
+#define __PERF_CPUTOPO_H
+
+#include <linux/types.h>
+
+struct cpu_topology {
+	u32	  core_sib;
+	u32	  thread_sib;
+	char	**core_siblings;
+	char	**thread_siblings;
+};
+
+struct cpu_topology *cpu_topology__new(void);
+void cpu_topology__delete(struct cpu_topology *tp);
+
+#endif /* __PERF_CPUTOPO_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c66f26ec557a..80ac57e6d38f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -39,6 +39,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
+#include "cputopo.h"
 
 #include "sane_ctype.h"
 
@@ -557,158 +558,15 @@ static int write_cmdline(struct feat_fd *ff,
 	return 0;
 }
 
-#define CORE_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
-#define THRD_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
-
-struct cpu_topo {
-	u32 core_sib;
-	u32 thread_sib;
-	char **core_siblings;
-	char **thread_siblings;
-};
-
-static int build_cpu_topo(struct cpu_topo *tp, int cpu)
-{
-	FILE *fp;
-	char filename[MAXPATHLEN];
-	char *buf = NULL, *p;
-	size_t len = 0;
-	ssize_t sret;
-	u32 i = 0;
-	int ret = -1;
-
-	sprintf(filename, CORE_SIB_FMT, cpu);
-	fp = fopen(filename, "r");
-	if (!fp)
-		goto try_threads;
-
-	sret = getline(&buf, &len, fp);
-	fclose(fp);
-	if (sret <= 0)
-		goto try_threads;
-
-	p = strchr(buf, '\n');
-	if (p)
-		*p = '\0';
-
-	for (i = 0; i < tp->core_sib; i++) {
-		if (!strcmp(buf, tp->core_siblings[i]))
-			break;
-	}
-	if (i == tp->core_sib) {
-		tp->core_siblings[i] = buf;
-		tp->core_sib++;
-		buf = NULL;
-		len = 0;
-	}
-	ret = 0;
-
-try_threads:
-	sprintf(filename, THRD_SIB_FMT, cpu);
-	fp = fopen(filename, "r");
-	if (!fp)
-		goto done;
-
-	if (getline(&buf, &len, fp) <= 0)
-		goto done;
-
-	p = strchr(buf, '\n');
-	if (p)
-		*p = '\0';
-
-	for (i = 0; i < tp->thread_sib; i++) {
-		if (!strcmp(buf, tp->thread_siblings[i]))
-			break;
-	}
-	if (i == tp->thread_sib) {
-		tp->thread_siblings[i] = buf;
-		tp->thread_sib++;
-		buf = NULL;
-	}
-	ret = 0;
-done:
-	if(fp)
-		fclose(fp);
-	free(buf);
-	return ret;
-}
-
-static void free_cpu_topo(struct cpu_topo *tp)
-{
-	u32 i;
-
-	if (!tp)
-		return;
-
-	for (i = 0 ; i < tp->core_sib; i++)
-		zfree(&tp->core_siblings[i]);
-
-	for (i = 0 ; i < tp->thread_sib; i++)
-		zfree(&tp->thread_siblings[i]);
-
-	free(tp);
-}
-
-static struct cpu_topo *build_cpu_topology(void)
-{
-	struct cpu_topo *tp = NULL;
-	void *addr;
-	u32 nr, i;
-	size_t sz;
-	long ncpus;
-	int ret = -1;
-	struct cpu_map *map;
-
-	ncpus = cpu__max_present_cpu();
-
-	/* build online CPU map */
-	map = cpu_map__new(NULL);
-	if (map == NULL) {
-		pr_debug("failed to get system cpumap\n");
-		return NULL;
-	}
-
-	nr = (u32)(ncpus & UINT_MAX);
-
-	sz = nr * sizeof(char *);
-	addr = calloc(1, sizeof(*tp) + 2 * sz);
-	if (!addr)
-		goto out_free;
-
-	tp = addr;
-	addr += sizeof(*tp);
-	tp->core_siblings = addr;
-	addr += sz;
-	tp->thread_siblings = addr;
-
-	for (i = 0; i < nr; i++) {
-		if (!cpu_map__has(map, i))
-			continue;
-
-		ret = build_cpu_topo(tp, i);
-		if (ret < 0)
-			break;
-	}
-
-out_free:
-	cpu_map__put(map);
-	if (ret) {
-		free_cpu_topo(tp);
-		tp = NULL;
-	}
-	return tp;
-}
 
 static int write_cpu_topology(struct feat_fd *ff,
 			      struct perf_evlist *evlist __maybe_unused)
 {
-	struct cpu_topo *tp;
+	struct cpu_topology *tp;
 	u32 i;
 	int ret, j;
 
-	tp = build_cpu_topology();
+	tp = cpu_topology__new();
 	if (!tp)
 		return -1;
 
@@ -746,7 +604,7 @@ static int write_cpu_topology(struct feat_fd *ff,
 			return ret;
 	}
 done:
-	free_cpu_topo(tp);
+	cpu_topology__delete(tp);
 	return ret;
 }
 
