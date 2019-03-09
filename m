Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12A2206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCIUIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:08:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:08:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K7meZ3206055
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:07:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K7m0Y3206052;
        Sat, 9 Mar 2019 12:07:48 -0800
Date:   Sat, 9 Mar 2019 12:07:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-90a86bde97ba050cb3c9ccb215252ee2d2d705fa@git.kernel.org>
Cc:     peterz@infradead.org, jonas.rabenstein@studium.uni-erlangen.de,
        mingo@kernel.org, ravi.bangoria@linux.ibm.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de, nasastry@in.ibm.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          jonas.rabenstein@studium.uni-erlangen.de, ak@linux.intel.com,
          jolsa@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, ravi.bangoria@linux.ibm.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          nasastry@in.ibm.com, acme@redhat.com, mingo@kernel.org
In-Reply-To: <20190305152536.21035-5-jolsa@kernel.org>
References: <20190305152536.21035-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Read and store caps/max_precise in
 perf_pmu
Git-Commit-ID: 90a86bde97ba050cb3c9ccb215252ee2d2d705fa
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

Commit-ID:  90a86bde97ba050cb3c9ccb215252ee2d2d705fa
Gitweb:     https://git.kernel.org/tip/90a86bde97ba050cb3c9ccb215252ee2d2d705fa
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 5 Mar 2019 16:25:32 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:18:17 -0300

perf tools: Read and store caps/max_precise in perf_pmu

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
