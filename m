Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA772C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3920833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDIPCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:02:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:59868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfDIPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:02:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 08:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="162750400"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2019 08:02:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CFD6BFA; Tue,  9 Apr 2019 18:02:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: idma64: Move driver name to the header
Date:   Tue,  9 Apr 2019 18:02:19 +0300
Message-Id: <20190409150219.15094-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two drivers that are relying on the iDMA 64-bit driver name
to match. Instead of duplicating string in both of them, dedicate
a header file and share it between users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/idma64.c       |  9 ++++-----
 drivers/mfd/intel-lpss.c   |  4 ++--
 include/linux/dma/idma64.h | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/dma/idma64.h

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 0baf9797cc09..4180cf197823 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -19,10 +19,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "idma64.h"
+#include <linux/dma/idma64.h>
 
-/* Platform driver name */
-#define DRV_NAME		"idma64"
+#include "idma64.h"
 
 /* For now we support only two channels */
 #define IDMA64_NR_CHAN		2
@@ -697,7 +696,7 @@ static struct platform_driver idma64_platform_driver = {
 	.probe		= idma64_platform_probe,
 	.remove		= idma64_platform_remove,
 	.driver = {
-		.name	= DRV_NAME,
+		.name	= LPSS_IDMA64_DRIVER_NAME,
 		.pm	= &idma64_dev_pm_ops,
 	},
 };
@@ -707,4 +706,4 @@ module_platform_driver(idma64_platform_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("iDMA64 core driver");
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:" LPSS_IDMA64_DRIVER_NAME);
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 50bffc3382d7..45221e092ecf 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -28,6 +28,8 @@
 #include <linux/seq_file.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
+#include <linux/dma/idma64.h>
+
 #include "intel-lpss.h"
 
 #define LPSS_DEV_OFFSET		0x000
@@ -96,8 +98,6 @@ static const struct resource intel_lpss_idma64_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-#define LPSS_IDMA64_DRIVER_NAME		"idma64"
-
 /*
  * Cells needs to be ordered so that the iDMA is created first. This is
  * because we need to be sure the DMA is available when the host controller
diff --git a/include/linux/dma/idma64.h b/include/linux/dma/idma64.h
new file mode 100644
index 000000000000..621cfae60554
--- /dev/null
+++ b/include/linux/dma/idma64.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Definitions for the Intel integrated DMA 64-bit
+ *
+ * Copyright (C) 2019 Intel Corporation
+ */
+
+#ifndef __LINUX_DMA_IDMA64_H__
+#define __LINUX_DMA_IDMA64_H__
+
+/* Platform driver name */
+#define LPSS_IDMA64_DRIVER_NAME		"idma64"
+
+#endif /* __LINUX_DMA_IDMA64_H__ */
-- 
2.20.1

