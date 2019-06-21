Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F481C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF502084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFUM4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:56:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:36380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfFUM4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:56:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 05:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,400,1557212400"; 
   d="scan'208";a="311980790"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2019 05:56:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 500DE159; Fri, 21 Jun 2019 15:56:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: release ida resources
Date:   Fri, 21 Jun 2019 15:56:31 +0300
Message-Id: <20190621125631.36872-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida instances allocate some internal memory for ->free_bitmap
in addition to the base 'struct ida'. Use ida_destroy() to release
that memory at module_exit().

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index cb3c4caf06c5..160c80f6c912 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -547,6 +547,7 @@ module_init(intel_lpss_init);
 
 static void __exit intel_lpss_exit(void)
 {
+	ida_destroy(&intel_lpss_devid_ida);
 	debugfs_remove(intel_lpss_debugfs);
 }
 module_exit(intel_lpss_exit);
-- 
2.20.1

