Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D0A2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCIF4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:56:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:26841 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfCIF4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:56:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 21:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,458,1544515200"; 
   d="scan'208";a="281138790"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2019 21:56:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BE5EB301CE1; Fri,  8 Mar 2019 21:56:41 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 10/15] perf tools: Add utility function to print ns time stamps
Date:   Fri,  8 Mar 2019 21:56:23 -0800
Message-Id: <20190309055628.21617-11-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309055628.21617-1-andi@firstfloor.org>
References: <20190309055628.21617-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a utility function to print nanosecond timestamps.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/time-utils.c | 8 ++++++++
 tools/perf/util/time-utils.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46050a5..a63bdf4cfd1b 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -404,6 +404,14 @@ int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 	return scnprintf(buf, sz, "%"PRIu64".%06"PRIu64, sec, usec);
 }
 
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz)
+{
+	u64  sec = timestamp / NSEC_PER_SEC;
+	u64 nsec = timestamp % NSEC_PER_SEC;
+
+	return scnprintf(buf, sz, "%"PRIu64".%09"PRIu64, sec, nsec);
+}
+
 int fetch_current_timestamp(char *buf, size_t sz)
 {
 	struct timeval tv;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 70b177d2b98c..9266cf4a8e58 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -24,6 +24,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 				   int num, u64 timestamp);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 
-- 
2.20.1

