Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FB1206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFDNCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfFDNCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:19 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] perf time-utils: Make perf_time__parse_for_ranges() more logical
Date:   Tue,  4 Jun 2019 16:00:15 +0300
Message-Id: <20190604130017.31207-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit time ranges never contain a percent sign whereas percentage ranges
always do, so it is possible to call the correct parser.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/time-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 9a463752dba8..d942840356e3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -402,6 +402,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				struct perf_time_interval **ranges,
 				int *range_size, int *range_num)
 {
+	bool has_percent = strchr(time_str, '%');
 	struct perf_time_interval *ptime_range;
 	int size, num, ret = -EINVAL;
 
@@ -409,7 +410,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (!ptime_range)
 		return -ENOMEM;
 
-	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+	if (has_percent) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
@@ -427,6 +428,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 		if (num < 0)
 			goto error_invalid;
 	} else {
+		if (perf_time__parse_str(ptime_range, time_str))
+			goto error_invalid;
 		num = 1;
 	}
 
-- 
2.17.1

