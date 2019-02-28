Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73357C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FFA20643
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfB1Hke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:40:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfB1Hke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:40:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7dKOa2947490
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:39:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7dK9v2947486;
        Wed, 27 Feb 2019 23:39:20 -0800
Date:   Wed, 27 Feb 2019 23:39:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-48e6c5acd36873ff022cd97de866bfd0a36a3b99@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, acme@redhat.com, namhyung@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, jolsa@kernel.org
In-Reply-To: <20190219095815.15931-4-jolsa@kernel.org>
References: <20190219095815.15931-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add numa_topology object
Git-Commit-ID: 48e6c5acd36873ff022cd97de866bfd0a36a3b99
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

Commit-ID:  48e6c5acd36873ff022cd97de866bfd0a36a3b99
Gitweb:     https://git.kernel.org/tip/48e6c5acd36873ff022cd97de866bfd0a36a3b99
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 19 Feb 2019 10:58:14 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 12:21:06 -0300

perf tools: Add numa_topology object

Add the numa_topology object to return the list of numa nodes together
with their cpus. It will replace the numa code in header.c and will be
used from 'perf record' in the following patches.

Add the following interface functions to load numa details:

  struct numa_topology *numa_topology__new(void);
  void numa_topology__delete(struct numa_topology *tp);

And replace the current (copied) local interface, with no functional
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190219095815.15931-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cputopo.c | 118 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  16 +++++++
 tools/perf/util/header.c  | 119 ++++++++++------------------------------------
 3 files changed, 160 insertions(+), 93 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 84470ed4e707..83ffca2ea9ee 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
+#include <inttypes.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
 #include "util.h"
+#include "env.h"
 
 
 #define CORE_SIB_FMT \
@@ -142,3 +144,119 @@ out_free:
 	}
 	return tp;
 }
+
+static int load_numa_node(struct numa_topology_node *node, int nr)
+{
+	char str[MAXPATHLEN];
+	char field[32];
+	char *buf = NULL, *p;
+	size_t len = 0;
+	int ret = -1;
+	FILE *fp;
+	u64 mem;
+
+	node->node = (u32) nr;
+
+	sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
+	fp = fopen(str, "r");
+	if (!fp)
+		return -1;
+
+	while (getline(&buf, &len, fp) > 0) {
+		/* skip over invalid lines */
+		if (!strchr(buf, ':'))
+			continue;
+		if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
+			goto err;
+		if (!strcmp(field, "MemTotal:"))
+			node->mem_total = mem;
+		if (!strcmp(field, "MemFree:"))
+			node->mem_free = mem;
+		if (node->mem_total && node->mem_free)
+			break;
+	}
+
+	fclose(fp);
+	fp = NULL;
+
+	sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
+
+	fp = fopen(str, "r");
+	if (!fp)
+		return -1;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto err;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	node->cpus = buf;
+	fclose(fp);
+	return 0;
+
+err:
+	free(buf);
+	if (fp)
+		fclose(fp);
+	return ret;
+}
+
+struct numa_topology *numa_topology__new(void)
+{
+	struct cpu_map *node_map = NULL;
+	struct numa_topology *tp = NULL;
+	char *buf = NULL;
+	size_t len = 0;
+	u32 nr, i;
+	FILE *fp;
+	char *c;
+
+	fp = fopen("/sys/devices/system/node/online", "r");
+	if (!fp)
+		return NULL;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto out;
+
+	c = strchr(buf, '\n');
+	if (c)
+		*c = '\0';
+
+	node_map = cpu_map__new(buf);
+	if (!node_map)
+		goto out;
+
+	nr = (u32) node_map->nr;
+
+	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0])*nr);
+	if (!tp)
+		goto out;
+
+	tp->nr = nr;
+
+	for (i = 0; i < nr; i++) {
+		if (load_numa_node(&tp->nodes[i], node_map->map[i])) {
+			numa_topology__delete(tp);
+			tp = NULL;
+			break;
+		}
+	}
+
+out:
+	free(buf);
+	fclose(fp);
+	cpu_map__put(node_map);
+	return tp;
+}
+
+void numa_topology__delete(struct numa_topology *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->nr; i++)
+		free(tp->nodes[i].cpus);
+
+	free(tp);
+}
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 4b5f4112b6f8..47a97e71acdf 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -3,6 +3,7 @@
 #define __PERF_CPUTOPO_H
 
 #include <linux/types.h>
+#include "env.h"
 
 struct cpu_topology {
 	u32	  core_sib;
@@ -11,7 +12,22 @@ struct cpu_topology {
 	char	**thread_siblings;
 };
 
+struct numa_topology_node {
+	char		*cpus;
+	u32		 node;
+	u64		 mem_total;
+	u64		 mem_free;
+};
+
+struct numa_topology {
+	u32				nr;
+	struct numa_topology_node	nodes[0];
+};
+
 struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
 
+struct numa_topology *numa_topology__new(void);
+void numa_topology__delete(struct numa_topology *tp);
+
 #endif /* __PERF_CPUTOPO_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 80ac57e6d38f..a2323d777dae 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -639,112 +639,45 @@ static int write_total_mem(struct feat_fd *ff,
 	return ret;
 }
 
-static int write_topo_node(struct feat_fd *ff, int node)
-{
-	char str[MAXPATHLEN];
-	char field[32];
-	char *buf = NULL, *p;
-	size_t len = 0;
-	FILE *fp;
-	u64 mem_total, mem_free, mem;
-	int ret = -1;
-
-	sprintf(str, "/sys/devices/system/node/node%d/meminfo", node);
-	fp = fopen(str, "r");
-	if (!fp)
-		return -1;
-
-	while (getline(&buf, &len, fp) > 0) {
-		/* skip over invalid lines */
-		if (!strchr(buf, ':'))
-			continue;
-		if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
-			goto done;
-		if (!strcmp(field, "MemTotal:"))
-			mem_total = mem;
-		if (!strcmp(field, "MemFree:"))
-			mem_free = mem;
-	}
-
-	fclose(fp);
-	fp = NULL;
-
-	ret = do_write(ff, &mem_total, sizeof(u64));
-	if (ret)
-		goto done;
-
-	ret = do_write(ff, &mem_free, sizeof(u64));
-	if (ret)
-		goto done;
-
-	ret = -1;
-	sprintf(str, "/sys/devices/system/node/node%d/cpulist", node);
-
-	fp = fopen(str, "r");
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
-	ret = do_write_string(ff, buf);
-done:
-	free(buf);
-	if (fp)
-		fclose(fp);
-	return ret;
-}
-
 static int write_numa_topology(struct feat_fd *ff,
 			       struct perf_evlist *evlist __maybe_unused)
 {
-	char *buf = NULL;
-	size_t len = 0;
-	FILE *fp;
-	struct cpu_map *node_map = NULL;
-	char *c;
-	u32 nr, i, j;
+	struct numa_topology *tp;
 	int ret = -1;
+	u32 i;
 
-	fp = fopen("/sys/devices/system/node/online", "r");
-	if (!fp)
-		return -1;
+	tp = numa_topology__new();
+	if (!tp)
+		return -ENOMEM;
 
-	if (getline(&buf, &len, fp) <= 0)
-		goto done;
+	ret = do_write(ff, &tp->nr, sizeof(u32));
+	if (ret < 0)
+		goto err;
 
-	c = strchr(buf, '\n');
-	if (c)
-		*c = '\0';
+	for (i = 0; i < tp->nr; i++) {
+		struct numa_topology_node *n = &tp->nodes[i];
 
-	node_map = cpu_map__new(buf);
-	if (!node_map)
-		goto done;
-
-	nr = (u32)node_map->nr;
+		ret = do_write(ff, &n->node, sizeof(u32));
+		if (ret < 0)
+			goto err;
 
-	ret = do_write(ff, &nr, sizeof(nr));
-	if (ret < 0)
-		goto done;
+		ret = do_write(ff, &n->mem_total, sizeof(u64));
+		if (ret)
+			goto err;
 
-	for (i = 0; i < nr; i++) {
-		j = (u32)node_map->map[i];
-		ret = do_write(ff, &j, sizeof(j));
-		if (ret < 0)
-			break;
+		ret = do_write(ff, &n->mem_free, sizeof(u64));
+		if (ret)
+			goto err;
 
-		ret = write_topo_node(ff, j);
+		ret = do_write_string(ff, n->cpus);
 		if (ret < 0)
-			break;
+			goto err;
 	}
-done:
-	free(buf);
-	fclose(fp);
-	cpu_map__put(node_map);
+
+	ret = 0;
+
+err:
+	numa_topology__delete(tp);
 	return ret;
 }
 
