Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE4C50729
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917CB24735
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfLMN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:58:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbfLMN6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:58:08 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28D915C864E049F2EFC2;
        Fri, 13 Dec 2019 21:58:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Dec 2019 21:57:50 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] perf tools: Add arm64 version of get_cpuid()
Date:   Fri, 13 Dec 2019 21:54:15 +0800
Message-ID: <1576245255-210926-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an arm64 version of get_cpuid(), which is used for various annotation
and headers - for example, I now get the CPUID in "perf report --header",
as shown in this snippet:

# hostname : ubuntu
# os release : 5.5.0-rc1-dirty
# perf version : 5.5.rc1.gbf8a13dc9851
# arch : aarch64
# nrcpus online : 96
# nrcpus avail : 96
# cpuid : 0x00000000480fd010

Since much of the code to read the MIDR is already in get_cpuid_str(),
factor out this code.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index a32e4b72a98f..d730666ab95d 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,8 +1,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
+#include <util/cpumap.h>
 #include <internal/cpumap.h>
 #include <api/fs/fs.h>
+#include <errno.h>
 #include "debug.h"
 #include "header.h"
 
@@ -12,26 +14,21 @@
 #define MIDR_VARIANT_SHIFT      20
 #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
 
-char *get_cpuid_str(struct perf_pmu *pmu)
+static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 {
-	char *buf = NULL;
-	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
-	int cpu;
 	u64 midr = 0;
-	struct perf_cpu_map *cpus;
-	FILE *file;
+	int cpu;
 
-	if (!sysfs || !pmu || !pmu->cpus)
-		return NULL;
+	if (!sysfs || sz < MIDR_SIZE)
+		return EINVAL;
 
-	buf = malloc(MIDR_SIZE);
-	if (!buf)
-		return NULL;
+	cpus = perf_cpu_map__get(cpus);
 
-	/* read midr from list of cpus mapped to this pmu */
-	cpus = perf_cpu_map__get(pmu->cpus);
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
+		char path[PATH_MAX];
+		FILE *file;
+
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
 				sysfs, cpus->map[cpu]);
 
@@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		break;
 	}
 
-	if (!midr) {
+	perf_cpu_map__put(cpus);
+
+	if (!midr)
+		return EINVAL;
+
+	return 0;
+}
+
+int get_cpuid(char *buf, size_t sz)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
+	int ret;
+
+	if (!cpus)
+		return EINVAL;
+
+	ret = _get_cpuid(buf, sz, cpus);
+
+	perf_cpu_map__put(cpus);
+
+	return ret;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	int res;
+
+	if (!pmu || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
+	if (res) {
 		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
 		free(buf);
 		buf = NULL;
 	}
 
-	perf_cpu_map__put(cpus);
 	return buf;
 }
-- 
2.17.1

