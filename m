Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11801C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD91A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OIo0bkHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFVGtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:49:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:49:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6lGEV2009260
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:47:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6lGEV2009260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186037;
        bh=4N0qIimBgRlZkyrF8sbnld3SktgxYNoFlT596cd/75A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OIo0bkHsnxzk+UZcj4JQZz7/pUzbfOv3xuJu+xNGBRbtJRzapfrP/UWYAiGngzwtI
         C1BiNksIVAVMfXwvIEEc4syRNloRhLO9ZRv7VtNpPG3T/sOXpxsDQcW9hdSMiQaqkZ
         mdMh0+cAdzeoGdorGYJpJNUpiOyh60E46ycqWy8wqqlZDWki5OfCddowq//kqlSpaN
         rFbOcCdS68RNWB/TaV12ndBRmfCCRGb6s18ziWdaMZQOqRY/OVGQubEM2HfTTM7QXO
         K8mFyYfnp6RO/kgzaTJ4371aPfW72Fledj4NfFAFfkfnqtNWN8yIobeSY4jGIT0Vgw
         j1CccUZnvrwhA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6lFOe2009238;
        Fri, 21 Jun 2019 23:47:15 -0700
Date:   Fri, 21 Jun 2019 23:47:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-599ee18f0740d7661b8711249096db94c09bc508@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, john.garry@huawei.com,
        ben@decadent.org.uk, will.deacon@arm.com, acme@redhat.com,
        jolsa@redhat.com, brueckner@linux.ibm.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        tmricht@linux.ibm.com, mingo@kernel.org,
        zhangshaokun@hisilicon.com, tglx@linutronix.de, hpa@zytor.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, kan.liang@linux.intel.com
Reply-To: mathieu.poirier@linaro.org, mark.rutland@arm.com,
          brueckner@linux.ibm.com, jolsa@redhat.com, acme@redhat.com,
          will.deacon@arm.com, ben@decadent.org.uk, john.garry@huawei.com,
          alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
          namhyung@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          zhangshaokun@hisilicon.com, mingo@kernel.org,
          tmricht@linux.ibm.com
In-Reply-To: <1560521283-73314-2-git-send-email-john.garry@huawei.com>
References: <1560521283-73314-2-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Fix uncore PMU alias list for ARM64
Git-Commit-ID: 599ee18f0740d7661b8711249096db94c09bc508
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

Commit-ID:  599ee18f0740d7661b8711249096db94c09bc508
Gitweb:     https://git.kernel.org/tip/599ee18f0740d7661b8711249096db94c09bc508
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Fri, 14 Jun 2019 22:07:59 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

perf pmu: Fix uncore PMU alias list for ARM64

In commit 292c34c10249 ("perf pmu: Fix core PMU alias list for X86
platform"), we fixed the issue of CPU events being aliased to uncore
events.

Fix this same issue for ARM64, since the said commit left the (broken)
behaviour untouched for ARM64.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Cc: stable@vger.kernel.org
Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")
Link: http://lkml.kernel.org/r/1560521283-73314-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e0429f4ef335..faa8eb231e1b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -709,9 +709,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
 	int i;
 	struct pmu_events_map *map;
-	struct pmu_event *pe;
 	const char *name = pmu->name;
-	const char *pname;
 
 	map = perf_pmu__find_map(pmu);
 	if (!map)
@@ -722,28 +720,26 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	 */
 	i = 0;
 	while (1) {
+		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
+		struct pmu_event *pe = &map->table[i++];
+		const char *pname = pe->pmu ? pe->pmu : cpu_name;
 
-		pe = &map->table[i++];
 		if (!pe->name) {
 			if (pe->metric_group || pe->metric_name)
 				continue;
 			break;
 		}
 
-		if (!is_arm_pmu_core(name)) {
-			pname = pe->pmu ? pe->pmu : "cpu";
-
-			/*
-			 * uncore alias may be from different PMU
-			 * with common prefix
-			 */
-			if (pmu_is_uncore(name) &&
-			    !strncmp(pname, name, strlen(pname)))
-				goto new_alias;
+		/*
+		 * uncore alias may be from different PMU
+		 * with common prefix
+		 */
+		if (pmu_is_uncore(name) &&
+		    !strncmp(pname, name, strlen(pname)))
+			goto new_alias;
 
-			if (strcmp(pname, name))
-				continue;
-		}
+		if (strcmp(pname, name))
+			continue;
 
 new_alias:
 		/* need type casts to override 'const' */
