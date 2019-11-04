Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCB1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1A222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfKDLDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:03:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:13206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKDLDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021237"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:09 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 07/10] tools/power/x86/intel-speed-select: Use Frequency weight for CLOS
Date:   Mon,  4 Nov 2019 03:02:43 -0800
Message-Id: <20191104110246.70465-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use different frequency weights for CLOS 0 and and CLOS1-3, to define
relative priority for power budgeting. This will be used for --auto
mode to enable base-freq and turbo-freq feature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index a8ada9a4f020..2d7ed27af7e0 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1260,15 +1260,15 @@ static int set_core_priority_and_min(int cpu, int mask_size,
 	if (ret)
 		return ret;
 
-	ret = set_clos_param(cpu, 1, 15, 0, min_low, 0xff);
+	ret = set_clos_param(cpu, 1, 15, 15, min_low, 0xff);
 	if (ret)
 		return ret;
 
-	ret = set_clos_param(cpu, 2, 15, 0, min_low, 0xff);
+	ret = set_clos_param(cpu, 2, 15, 15, min_low, 0xff);
 	if (ret)
 		return ret;
 
-	ret = set_clos_param(cpu, 3, 15, 0, min_low, 0xff);
+	ret = set_clos_param(cpu, 3, 15, 15, min_low, 0xff);
 	if (ret)
 		return ret;
 
@@ -1589,15 +1589,15 @@ static void set_fact_enable(int arg)
 			if (ret)
 				goto error_disp;
 
-			ret = set_clos_param(i, 1, 15, 0, 0, 0xff);
+			ret = set_clos_param(i, 1, 15, 15, 0, 0xff);
 			if (ret)
 				goto error_disp;
 
-			ret = set_clos_param(i, 2, 15, 0, 0, 0xff);
+			ret = set_clos_param(i, 2, 15, 15, 0, 0xff);
 			if (ret)
 				goto error_disp;
 
-			ret = set_clos_param(i, 3, 15, 0, 0, 0xff);
+			ret = set_clos_param(i, 3, 15, 15, 0, 0xff);
 			if (ret)
 				goto error_disp;
 
-- 
2.17.2

