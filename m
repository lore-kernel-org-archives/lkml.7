Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F22341A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfFDNCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbfFDNCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:17 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
Date:   Tue,  4 Jun 2019 16:00:14 +0300
Message-Id: <20190604130017.31207-17-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify perf_time__parse_for_ranges() error paths slightly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/time-utils.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 3e87c21c293c..9a463752dba8 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -403,7 +403,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				int *range_size, int *range_num)
 {
 	struct perf_time_interval *ptime_range;
-	int size, num, ret;
+	int size, num, ret = -EINVAL;
 
 	ptime_range = perf_time__range_alloc(time_str, &size);
 	if (!ptime_range)
@@ -415,7 +415,6 @@ int perf_time__parse_for_ranges(const char *time_str,
 			pr_err("HINT: no first/last sample time found in perf data.\n"
 			       "Please use latest perf binary to execute 'perf record'\n"
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
 			goto error;
 		}
 
@@ -425,11 +424,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 				session->evlist->first_sample_time,
 				session->evlist->last_sample_time);
 
-		if (num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
-			goto error;
-		}
+		if (num < 0)
+			goto error_invalid;
 	} else {
 		num = 1;
 	}
@@ -439,6 +435,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 	*ranges = ptime_range;
 	return 0;
 
+error_invalid:
+	pr_err("Invalid time string\n");
 error:
 	free(ptime_range);
 	return ret;
-- 
2.17.1

