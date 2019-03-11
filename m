Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5AFC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A34F214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfCKUY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:24:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:37489 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbfCKUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306300716"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E5883301E34; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 10/10] perf, tools, stat: Improve scaling
Date:   Mon, 11 Mar 2019 13:24:46 -0700
Message-Id: <20190311202446.10210-11-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The multiplexing scaling in perf stat mysteriously adds 0.5 to the
value. This dates back to the original perf tool. Other scaling
code doesn't use that strange convention. Remove the extra 0.5.

Before:

$ perf stat -e 'cycles,cycles,cycles,cycles,cycles,cycles' grep -rq foo

 Performance counter stats for 'grep -rq foo':

         6,403,580      cycles                                                        (81.62%)
         6,404,341      cycles                                                        (81.64%)
         6,402,983      cycles                                                        (81.62%)
         6,399,941      cycles                                                        (81.63%)
         6,399,451      cycles                                                        (81.62%)
         6,436,105      cycles                                                        (91.87%)

       0.005843799 seconds time elapsed

       0.002905000 seconds user
       0.002902000 seconds sys

After:

$ ./perf stat -e 'cycles,cycles,cycles,cycles,cycles,cycles' grep -rq foo

 Performance counter stats for 'grep -rq foo':

         6,422,704      cycles                                                        (81.68%)
         6,401,842      cycles                                                        (81.68%)
         6,398,432      cycles                                                        (81.68%)
         6,397,098      cycles                                                        (81.68%)
         6,396,074      cycles                                                        (81.67%)
         6,434,980      cycles                                                        (91.62%)

       0.005884437 seconds time elapsed

       0.003580000 seconds user
       0.002356000 seconds sys

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 60450087f198..e425f342fe81 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1342,7 +1342,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 			count->val = 0;
 		} else if (count->run < count->ena) {
 			scaled = 1;
-			count->val = (u64)((double) count->val * count->ena / count->run + 0.5);
+			count->val = (u64)((double) count->val * count->ena / count->run);
 		}
 	}
 
-- 
2.20.1

