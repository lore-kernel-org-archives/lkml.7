Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB13C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2009D21537
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFDNCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfFDNCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:12 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] perf time-utils: Factor out set_percent_time()
Date:   Tue,  4 Jun 2019 16:00:11 +0300
Message-Id: <20190604130017.31207-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out set_percent_time() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/time-utils.c | 39 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 1d67cf1216c7..69441faab3d0 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -135,12 +135,27 @@ static int parse_percent(double *pcnt, char *str)
 	return 0;
 }
 
+static int set_percent_time(struct perf_time_interval *ptime, double start_pcnt,
+			    double end_pcnt, u64 start, u64 end)
+{
+	u64 total = end - start;
+
+	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
+	    end_pcnt < 0.0 || end_pcnt > 1.0) {
+		return -1;
+	}
+
+	ptime->start = start + round(start_pcnt * total);
+	ptime->end = start + round(end_pcnt * total);
+
+	return 0;
+}
+
 static int percent_slash_split(char *str, struct perf_time_interval *ptime,
 			       u64 start, u64 end)
 {
 	char *p, *end_str;
 	double pcnt, start_pcnt, end_pcnt;
-	u64 total = end - start;
 	int i;
 
 	/*
@@ -168,15 +183,7 @@ static int percent_slash_split(char *str, struct perf_time_interval *ptime,
 	start_pcnt = pcnt * (i - 1);
 	end_pcnt = pcnt * i;
 
-	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
-	    end_pcnt < 0.0 || end_pcnt > 1.0) {
-		return -1;
-	}
-
-	ptime->start = start + round(start_pcnt * total);
-	ptime->end = start + round(end_pcnt * total);
-
-	return 0;
+	return set_percent_time(ptime, start_pcnt, end_pcnt, start, end);
 }
 
 static int percent_dash_split(char *str, struct perf_time_interval *ptime,
@@ -184,7 +191,6 @@ static int percent_dash_split(char *str, struct perf_time_interval *ptime,
 {
 	char *start_str = NULL, *end_str;
 	double start_pcnt, end_pcnt;
-	u64 total = end - start;
 	int ret;
 
 	/*
@@ -203,16 +209,7 @@ static int percent_dash_split(char *str, struct perf_time_interval *ptime,
 
 	free(start_str);
 
-	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
-	    end_pcnt < 0.0 || end_pcnt > 1.0 ||
-	    start_pcnt > end_pcnt) {
-		return -1;
-	}
-
-	ptime->start = start + round(start_pcnt * total);
-	ptime->end = start + round(end_pcnt * total);
-
-	return 0;
+	return set_percent_time(ptime, start_pcnt, end_pcnt, start, end);
 }
 
 typedef int (*time_pecent_split)(char *, struct perf_time_interval *,
-- 
2.17.1

