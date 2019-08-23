Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 21:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D621848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404763AbfHWVDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 17:03:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:36059 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfHWVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 17:03:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 14:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="191058781"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2019 14:03:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 73E23301C0B; Fri, 23 Aug 2019 14:03:43 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf report: Use timestamp__scnprintf_nsec for time sort key
Date:   Fri, 23 Aug 2019 14:03:37 -0700
Message-Id: <20190823210338.12360-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Use timestamp__scnprintf_nsec to print nanoseconds for the time
sort key, instead of open coding.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/sort.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f9a38a1dd4d1..0985e9072db0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -668,17 +668,11 @@ sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
 static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
-	unsigned long secs;
-	unsigned long long nsecs;
 	char he_time[32];
 
-	nsecs = he->time;
-	secs = nsecs / NSEC_PER_SEC;
-	nsecs -= secs * NSEC_PER_SEC;
-
 	if (symbol_conf.nanosecs)
-		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
-			 secs, nsecs);
+		timestamp__scnprintf_nsec(he->time, he_time,
+					  sizeof(he_time));
 	else
 		timestamp__scnprintf_usec(he->time, he_time,
 					  sizeof(he_time));
-- 
2.20.1

