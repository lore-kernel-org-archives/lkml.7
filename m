Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF105C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E1F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfCZWSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:18:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:55268 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbfCZWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:18:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 15:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="145482960"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2019 15:18:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BAB2E301C15; Tue, 26 Mar 2019 15:18:28 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/4] perf, tools: Support name for duration_time
Date:   Tue, 26 Mar 2019 15:18:22 -0700
Message-Id: <20190326221823.11518-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326221823.11518-1-andi@firstfloor.org>
References: <20190326221823.11518-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement printing the correct name for duration_time

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7835e05f0c0a..6872394b6f55 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -579,6 +579,12 @@ static int perf_evsel__raw_name(struct perf_evsel *evsel, char *bf, size_t size)
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
+static int perf_evsel__tool_name(char *bf, size_t size)
+{
+	int ret = scnprintf(bf, size, "duration_time");
+	return ret;
+}
+
 const char *perf_evsel__name(struct perf_evsel *evsel)
 {
 	char bf[128];
@@ -600,7 +606,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 		break;
 
 	case PERF_TYPE_SOFTWARE:
-		perf_evsel__sw_name(evsel, bf, sizeof(bf));
+		if (evsel->tool_event)
+			perf_evsel__tool_name(bf, sizeof(bf));
+		else
+			perf_evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-- 
2.20.1

