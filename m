Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D6BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1F2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKOMnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfKOMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749663"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:27 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] perf auxtrace: Move perf_evsel__find_pmu()
Date:   Fri, 15 Nov 2019 14:42:14 +0200
Message-Id: <20191115124225.5247-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_evsel__find_pmu() so it can be used without forward
declaration.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c555c3ccd79d..263d1d9d8987 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -57,6 +57,18 @@
 #include "symbol/kallsyms.h"
 #include <internal/lib.h>
 
+static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->type == evsel->core.attr.type)
+			break;
+	}
+
+	return pmu;
+}
+
 static bool auxtrace__dont_decode(struct perf_session *session)
 {
 	return !session->itrace_synth_opts ||
@@ -2180,18 +2192,6 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 	return err;
 }
 
-static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		if (pmu->type == evsel->core.attr.type)
-			break;
-	}
-
-	return pmu;
-}
-
 static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
-- 
2.17.1

