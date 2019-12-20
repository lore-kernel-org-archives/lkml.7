Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9659CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731E72467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTLFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:05:46 -0500
Received: from foss.arm.com ([217.140.110.172]:49542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLTLFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:05:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2525130E;
        Fri, 20 Dec 2019 03:05:45 -0800 (PST)
Received: from e112479-lin.warwick.arm.com (e112479-lin.warwick.arm.com [10.32.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286BD3F719;
        Fri, 20 Dec 2019 03:05:41 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Date:   Fri, 20 Dec 2019 11:05:25 +0000
Message-Id: <20191220110525.30131-1-james.clark@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue when non Arm SPE events are specified after an
Arm SPE event. In that case, perf will exit with an error code and not
produce a record file. This is because a loop index is used to store the
location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
index will be overwritten. Fix this issue by saving the PMU into a
variable instead of using the index, and also add an error message.

Before the fix:
    ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
    237

After the fix:
    ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
    ...
    0

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/arch/arm/util/auxtrace.c  | 10 +++++-----
 tools/perf/arch/arm64/util/arm-spe.c |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 0a6e75b8777a..230f03b622e1 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -54,9 +54,9 @@ struct auxtrace_record
 *auxtrace_record__init(struct evlist *evlist, int *err)
 {
 	struct perf_pmu	*cs_etm_pmu;
+	struct perf_pmu *arm_spe_pmu = NULL;
 	struct evsel *evsel;
 	bool found_etm = false;
-	bool found_spe = false;
 	static struct perf_pmu **arm_spe_pmus = NULL;
 	static int nr_spes = 0;
 	int i = 0;
@@ -79,13 +79,13 @@ struct auxtrace_record
 
 		for (i = 0; i < nr_spes; i++) {
 			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
-				found_spe = true;
+				arm_spe_pmu = arm_spe_pmus[i];
 				break;
 			}
 		}
 	}
 
-	if (found_etm && found_spe) {
+	if (found_etm && arm_spe_pmu) {
 		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
 		*err = -EOPNOTSUPP;
 		return NULL;
@@ -95,8 +95,8 @@ struct auxtrace_record
 		return cs_etm_record_init(err);
 
 #if defined(__aarch64__)
-	if (found_spe)
-		return arm_spe_recording_init(err, arm_spe_pmus[i]);
+	if (arm_spe_pmu)
+		return arm_spe_recording_init(err, arm_spe_pmu);
 #endif
 
 	/*
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..b7d17d8724df 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -178,6 +178,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	struct arm_spe_recording *sper;
 
 	if (!arm_spe_pmu) {
+		pr_err("Attempted to initialise null SPE PMU\n");
 		*err = -ENODEV;
 		return NULL;
 	}
-- 
2.24.0

