Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF98BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46B420643
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfB1HkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:40:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfB1HkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:40:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7dxwn2947536
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:39:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7dwIq2947533;
        Wed, 27 Feb 2019 23:39:58 -0800
Date:   Wed, 27 Feb 2019 23:39:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e19a01c1438e123d169fd09376a221d844797174@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, namhyung@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          namhyung@kernel.org, peterz@infradead.org
In-Reply-To: <20190219095815.15931-5-jolsa@kernel.org>
References: <20190219095815.15931-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use sysfs__mountpoint() when reading
 cpu topology
Git-Commit-ID: e19a01c1438e123d169fd09376a221d844797174
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

Commit-ID:  e19a01c1438e123d169fd09376a221d844797174
Gitweb:     https://git.kernel.org/tip/e19a01c1438e123d169fd09376a221d844797174
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 19 Feb 2019 10:58:15 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 12:21:10 -0300

perf tools: Use sysfs__mountpoint() when reading cpu topology

Use sysfs__mountpoint() when reading sysfs files to obtain cpu/numa
topologies.

Also use scnprintf instead of sprintf as suggested by Namhyung.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190219095815.15931-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cputopo.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 83ffca2ea9ee..ece0710249d4 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
 #include <inttypes.h>
+#include <api/fs/fs.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
@@ -9,9 +10,15 @@
 
 
 #define CORE_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
+	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define THRD_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+#define NODE_ONLINE_FMT \
+	"%s/devices/system/node/online"
+#define NODE_MEMINFO_FMT \
+	"%s/devices/system/node/node%d/meminfo"
+#define NODE_CPULIST_FMT \
+	"%s/devices/system/node/node%d/cpulist"
 
 static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 {
@@ -23,7 +30,8 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	u32 i = 0;
 	int ret = -1;
 
-	sprintf(filename, CORE_SIB_FMT, cpu);
+	scnprintf(filename, MAXPATHLEN, CORE_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto try_threads;
@@ -50,7 +58,8 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	sprintf(filename, THRD_SIB_FMT, cpu);
+	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto done;
@@ -157,7 +166,8 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 
 	node->node = (u32) nr;
 
-	sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
+	scnprintf(str, MAXPATHLEN, NODE_MEMINFO_FMT,
+		  sysfs__mountpoint(), nr);
 	fp = fopen(str, "r");
 	if (!fp)
 		return -1;
@@ -179,7 +189,8 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 	fclose(fp);
 	fp = NULL;
 
-	sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
+	scnprintf(str, MAXPATHLEN, NODE_CPULIST_FMT,
+		  sysfs__mountpoint(), nr);
 
 	fp = fopen(str, "r");
 	if (!fp)
@@ -207,13 +218,17 @@ struct numa_topology *numa_topology__new(void)
 {
 	struct cpu_map *node_map = NULL;
 	struct numa_topology *tp = NULL;
+	char path[MAXPATHLEN];
 	char *buf = NULL;
 	size_t len = 0;
 	u32 nr, i;
 	FILE *fp;
 	char *c;
 
-	fp = fopen("/sys/devices/system/node/online", "r");
+	scnprintf(path, MAXPATHLEN, NODE_ONLINE_FMT,
+		  sysfs__mountpoint());
+
+	fp = fopen(path, "r");
 	if (!fp)
 		return NULL;
 
