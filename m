Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A48C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AAA21537
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfFDNCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbfFDNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:13 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] perf time-utils: Prevent percentage time range overlap
Date:   Tue,  4 Jun 2019 16:00:12 +0300
Message-Id: <20190604130017.31207-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent percentage time range overlap. This is only a 1 nanosecond change
but makes the results more logical e.g. a sample cannot be in both the
first 10% and the second 20%.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/time-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 69441faab3d0..3e87c21c293c 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -148,6 +148,9 @@ static int set_percent_time(struct perf_time_interval *ptime, double start_pcnt,
 	ptime->start = start + round(start_pcnt * total);
 	ptime->end = start + round(end_pcnt * total);
 
+	if (ptime->end > ptime->start && ptime->end != end)
+		ptime->end -= 1;
+
 	return 0;
 }
 
-- 
2.17.1

