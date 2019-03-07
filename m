Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3A120851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980827;
	bh=XBy9Kh1FnVmYIqagOHCAsxqmA1K1nRgkbyLQ+9pP9eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xaln1kPWhFY6Nd7eVigWwQcj9KWsUWrOeMbLrigB/Zb/6hwHRVAr7AzOLthtM8M5h
	 x+0xF9hqWLlk9MEntsEwvUp0dAfy/fDZT1piEoE3dJ4+OSigKq8nxNT8dJSO9Tu01m
	 xCrmvO3MVyTHXtvprijD1VHebjYSEkKRdl/e6LqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfCGRrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfCGRrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:47:04 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF994213A2;
        Thu,  7 Mar 2019 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980824;
        bh=XBy9Kh1FnVmYIqagOHCAsxqmA1K1nRgkbyLQ+9pP9eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1K00btUBhoeykDDvibr9/90gM7sOdOuXcvaCmCuEiPaQVdP039TvHWqE+1d+PIWO
         1WJu289L3DyZaXp/2bwkZMeyH6av/odnHWavyGZiuS0VeNFjIu6BpODq9tyKxiJD2r
         VSOPHOeEF9qgkVXljD2gO/PVi79BDZtRTZd8EShY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/35] perf tools: Read and store caps/max_precise in perf_pmu
Date:   Thu,  7 Mar 2019 14:44:30 -0300
Message-Id: <20190307174433.28819-33-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Read the caps/max_precise value and store it in struct perf_pmu to be
used when setting the maximum precise_ip field in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 14 ++++++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 51d437f55d18..6199a3174ab9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -752,6 +752,19 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+static int pmu_max_precise(const char *name)
+{
+	char path[PATH_MAX];
+	int max_precise = -1;
+
+	scnprintf(path, PATH_MAX,
+		 "bus/event_source/devices/%s/caps/max_precise",
+		 name);
+
+	sysfs__read_int(path, &max_precise);
+	return max_precise;
+}
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -784,6 +797,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 47253c3daf55..bd9ec2704a57 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -26,6 +26,7 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
+	int max_precise;
 	struct perf_event_attr *default_config;
 	struct cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-- 
2.20.1

