Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B555BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCE2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfHPRdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:33:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:18559 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHPRdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:33:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 10:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="261171825"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2019 10:33:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C74DAF1; Fri, 16 Aug 2019 20:33:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: intel-lpss: Consistently use GENMASK()
Date:   Fri, 16 Aug 2019 20:33:42 +0300
Message-Id: <20190816173342.21912-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already are using BIT() macro, use GENMASK() as well for sake of
consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: drop extra shift, move line closer to other bit definitions
 drivers/mfd/intel-lpss.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 277f48f1cc1c..3e16a1765142 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -47,10 +47,10 @@
 #define LPSS_PRIV_IDLELTR		0x14
 
 #define LPSS_PRIV_LTR_REQ		BIT(15)
-#define LPSS_PRIV_LTR_SCALE_MASK	0xc00
-#define LPSS_PRIV_LTR_SCALE_1US		0x800
-#define LPSS_PRIV_LTR_SCALE_32US	0xc00
-#define LPSS_PRIV_LTR_VALUE_MASK	0x3ff
+#define LPSS_PRIV_LTR_SCALE_MASK	GENMASK(11, 10)
+#define LPSS_PRIV_LTR_SCALE_1US		(2 << 10)
+#define LPSS_PRIV_LTR_SCALE_32US	(3 << 10)
+#define LPSS_PRIV_LTR_VALUE_MASK	GENMASK(9, 0)
 
 #define LPSS_PRIV_SSP_REG		0x20
 #define LPSS_PRIV_SSP_REG_DIS_DMA_FIN	BIT(0)
@@ -59,8 +59,8 @@
 
 #define LPSS_PRIV_CAPS			0xfc
 #define LPSS_PRIV_CAPS_NO_IDMA		BIT(8)
+#define LPSS_PRIV_CAPS_TYPE_MASK	GENMASK(7, 4)
 #define LPSS_PRIV_CAPS_TYPE_SHIFT	4
-#define LPSS_PRIV_CAPS_TYPE_MASK	(0xf << LPSS_PRIV_CAPS_TYPE_SHIFT)
 
 /* This matches the type field in CAPS register */
 enum intel_lpss_dev_type {
-- 
2.23.0.rc1

