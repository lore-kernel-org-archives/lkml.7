Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3DCA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC28321A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfJTRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:52:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:24807 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfJTRwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 10:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="371971240"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2019 10:52:30 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 125B630034D; Sun, 20 Oct 2019 10:52:30 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 3/9] perf pmu: Use file system cache to optimize sysfs access
Date:   Sun, 20 Oct 2019 10:51:56 -0700
Message-Id: <20191020175202.32456-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020175202.32456-1-andi@firstfloor.org>
References: <20191020175202.32456-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

pmu.c does a lot of redundant /sys accesses while parsing aliases
and probing for PMUs. On large systems with a lot of PMUs this
can get expensive (>2s):

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 27.25    1.227847           8    160888     16976 openat
 26.42    1.190481           7    164224    164077 stat

Add a cache to remember if specific file names exist or don't
exist, which eliminates most of this overhead.

Also optimize some stat() calls to be slightly cheaper access()

Resulting in:

  0.18    0.004166           2      1851       305 open
  0.08    0.001970           2       829       622 access

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/Build     |  1 +
 tools/perf/util/fncache.c | 52 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/fncache.h |  8 ++++++
 tools/perf/util/pmu.c     | 53 ++++++++++++++++++++++++---------------
 tools/perf/util/srccode.c |  9 +------
 5 files changed, 95 insertions(+), 28 deletions(-)
 create mode 100644 tools/perf/util/fncache.c
 create mode 100644 tools/perf/util/fncache.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 39814b1806a6..2c1504fe924c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -48,6 +48,7 @@ perf-y += header.o
 perf-y += callchain.o
 perf-y += values.o
 perf-y += debug.o
+perf-y += fncache.o
 perf-y += machine.o
 perf-y += map.o
 perf-y += pstack.o
diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
new file mode 100644
index 000000000000..0e6e2370b3af
--- /dev/null
+++ b/tools/perf/util/fncache.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Manage a cache of file names' existence */
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <linux/list.h>
+#include "fncache.h"
+
+struct fncache {
+	struct hlist_node nd;
+	bool res;
+	char name[];
+};
+
+#define FNHSIZE 61
+
+static struct hlist_head fncache_hash[FNHSIZE];
+
+unsigned shash(const unsigned char *s)
+{
+	unsigned h = 0;
+	while (*s)
+		h = 65599 * h + *s++;
+	return h ^ (h >> 16);
+}
+
+bool lookup_fncache(const char *name, bool *res)
+{
+	int h = shash((const unsigned char *)name) % FNHSIZE;
+	struct fncache *n;
+
+	hlist_for_each_entry (n, &fncache_hash[h], nd) {
+		if (!strcmp(n->name, name)) {
+			*res = n->res;
+			return true;
+		}
+	}
+	return false;
+}
+
+/* No LRU, only use when bounded in some other way. */
+void update_fncache(const char *name, bool res)
+{
+	struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
+	int h = shash((const unsigned char *)name) % FNHSIZE;
+
+	if (!n)
+		return;
+	strcpy(n->name, name);
+	n->res = res;
+	hlist_add_head(&n->nd, &fncache_hash[h]);
+}
diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
new file mode 100644
index 000000000000..93ca473f5357
--- /dev/null
+++ b/tools/perf/util/fncache.h
@@ -0,0 +1,8 @@
+#ifndef _FCACHE_H
+#define _FCACHE_H 1
+
+unsigned shash(const unsigned char *s);
+void update_fncache(const char *name, bool res);
+bool lookup_fncache(const char *name, bool *res);
+
+#endif
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5608da82ad23..ae5e6e894e79 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -24,6 +24,7 @@
 #include "pmu-events/pmu-events.h"
 #include "string2.h"
 #include "strbuf.h"
+#include "fncache.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -82,9 +83,9 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
  */
 static int pmu_format(const char *name, struct list_head *format)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
+	bool res = false;
 
 	if (!sysfs)
 		return -1;
@@ -92,8 +93,12 @@ static int pmu_format(const char *name, struct list_head *format)
 	snprintf(path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/format", sysfs, name);
 
-	if (stat(path, &st) < 0)
+	if (lookup_fncache(path, &res) && !res)
+		return 0;
+
+	if (!res && access(path, R_OK) < 0)
 		return 0;	/* no error if format does not exist */
+	update_fncache(path, true);
 
 	if (perf_pmu__format_parse(path, format))
 		return -1;
@@ -470,9 +475,9 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
  */
 static int pmu_aliases(const char *name, struct list_head *head)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
+	bool res = false;
 
 	if (!sysfs)
 		return -1;
@@ -480,8 +485,11 @@ static int pmu_aliases(const char *name, struct list_head *head)
 	snprintf(path, PATH_MAX,
 		 "%s/bus/event_source/devices/%s/events", sysfs, name);
 
-	if (stat(path, &st) < 0)
-		return 0;	 /* no error if 'events' does not exist */
+	if (lookup_fncache(path, &res) && !res)
+		return 0;
+	if (!res && access(path, R_OK) < 0)
+		return 0;
+	update_fncache(path, true);
 
 	if (pmu_aliases_parse(path, head))
 		return -1;
@@ -520,7 +528,6 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
  */
 static int pmu_type(const char *name, __u32 *type)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	FILE *file;
 	int ret = 0;
@@ -532,7 +539,7 @@ static int pmu_type(const char *name, __u32 *type)
 	snprintf(path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/type", sysfs, name);
 
-	if (stat(path, &st) < 0)
+	if (access(path, R_OK) < 0)
 		return -1;
 
 	file = fopen(path, "r");
@@ -623,14 +630,16 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 static bool pmu_is_uncore(const char *name)
 {
 	char path[PATH_MAX];
-	struct perf_cpu_map *cpus;
-	const char *sysfs = sysfs__mountpoint();
+	const char *sysfs;
+	bool res;
 
+	sysfs = sysfs__mountpoint();
 	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
-	cpus = __pmu_cpumask(path);
-	perf_cpu_map__put(cpus);
-
-	return !!cpus;
+	if (lookup_fncache(path, &res))
+		return res;
+	res = access(path, R_OK) == 0;
+	update_fncache(path, res);
+	return res;
 }
 
 /*
@@ -640,9 +649,9 @@ static bool pmu_is_uncore(const char *name)
  */
 static int is_arm_pmu_core(const char *name)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
+	bool res;
 
 	if (!sysfs)
 		return 0;
@@ -650,10 +659,11 @@ static int is_arm_pmu_core(const char *name)
 	/* Look for cpu sysfs (specific to arm) */
 	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
 				sysfs, name);
-	if (stat(path, &st) == 0)
-		return 1;
-
-	return 0;
+	if (lookup_fncache(path, &res))
+		return res;
+	res = access(path, R_OK) == 0;
+	update_fncache(path, res);
+	return res;
 }
 
 static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
@@ -1519,9 +1529,9 @@ bool pmu_have_event(const char *pname, const char *name)
 
 static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs;
+	bool res = false;
 
 	sysfs = sysfs__mountpoint();
 	if (!sysfs)
@@ -1530,8 +1540,11 @@ static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 	snprintf(path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, name);
 
-	if (stat(path, &st) < 0)
+	if (lookup_fncache(path, &res) && !res)
+		return NULL;
+	if (!res && access(path, R_OK) < 0)
 		return NULL;
+	update_fncache(path, true);
 
 	return fopen(path, "r");
 }
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index d84ed8b6caaa..c29edaaca863 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -16,6 +16,7 @@
 #include "srccode.h"
 #include "debug.h"
 #include <internal/lib.h> // page_size
+#include "fncache.h"
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
@@ -36,14 +37,6 @@ static LIST_HEAD(srcfile_list);
 static long map_total_sz;
 static int num_srcfiles;
 
-static unsigned shash(unsigned char *s)
-{
-	unsigned h = 0;
-	while (*s)
-		h = 65599 * h + *s++;
-	return h ^ (h >> 16);
-}
-
 static int countlines(char *map, int maplen)
 {
 	int numl;
-- 
2.21.0

