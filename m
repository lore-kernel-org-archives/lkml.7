Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35193C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FFA2147A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799556;
	bh=hnOJ68a2Sq1uqWQaPID2Z8gz6Zi2WR6MfqJ7COyojCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MW/CujiN3FwCSsa/JQ7cGwYIehRnnP/Sq2kzv6aKq5GIu0Zm9hy8ymKltEYYxOVi9
	 rURvfbPKMict8PP7atQo0Zxw4M6vq3LW5O9LNpC+6Y2qrYhwdgvlJObVl1SsNkQHaW
	 sHnSkv5Emu4R3M2n4L0BOlP+00BVGPzC9oy5i67o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfCEPZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfCEPZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79F5F3092656;
        Tue,  5 Mar 2019 15:25:52 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB311001DF0;
        Tue,  5 Mar 2019 15:25:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 5/8] perf tools: Get precise_ip from the pmu config
Date:   Tue,  5 Mar 2019 16:25:33 +0100
Message-Id: <20190305152536.21035-6-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 05 Mar 2019 15:25:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting precise_ip field from the perf_pmu::max_precise
config read from sysfs. If it's not available falling
back to current detection function.

This fixes perf c2c usage of 'P' modifier on memory events,
where the standard detection fails, because of way too many
new perf_event_attr features added recently.

Use PYTHON_MOD to distinguish python perf module build
to exclude pmu.o object call being compiled in. There's
the flex/bison (and other) object dependencies, that
we'd need to teach setup.py about.

Link: http://lkml.kernel.org/n/tip-zyegnaq8xlkhh4sgfl4tnvui@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c  | 28 +++++++++++++++++++++++++++-
 tools/perf/util/setup.py |  2 +-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dfe2958e6287..eec542bab815 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -870,6 +870,32 @@ static bool is_dummy_event(struct perf_evsel *evsel)
 	       (evsel->attr.config == PERF_COUNT_SW_DUMMY);
 }
 
+#ifndef PYTHON_MOD
+static int pmu_get_precise(const char *pmu_name)
+{
+	struct perf_pmu *pmu = pmu_name ? perf_pmu__find(pmu_name) : NULL;
+
+	/* If unsupported pmu->max_precise is -1. */
+	return pmu ? pmu->max_precise : -1;
+}
+#else
+static int pmu_get_precise(const char *pmu_name __maybe_unused)
+{
+	return 0;
+}
+#endif
+
+static void perf_evsel__set_max_precise_ip(struct perf_evsel *evsel)
+{
+	int max_precise = pmu_get_precise(evsel->pmu_name);
+	struct perf_event_attr *attr = &evsel->attr;
+
+	if (max_precise >= 0)
+		attr->precise_ip = max_precise;
+	else
+		perf_event_attr__set_max_precise_ip(attr);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1091,7 +1117,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	}
 
 	if (evsel->precise_max)
-		perf_event_attr__set_max_precise_ip(attr);
+		perf_evsel__set_max_precise_ip(evsel);
 
 	if (opts->all_user) {
 		attr->exclude_kernel = 1;
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 5b5a167b43ce..9eee3467ac5d 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -37,7 +37,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_MOD' ]
 if cc != "clang":
     cflags += ['-Wno-cast-function-type' ]
 
-- 
2.17.2

