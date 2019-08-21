Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6151C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F85D22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfHUIhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:37:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:28841 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfHUIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:37:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207657589"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 01:37:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35E21FC; Wed, 21 Aug 2019 11:37:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Use MODULE_SOFTDEP() instead of implicit request
Date:   Wed, 21 Aug 2019 11:37:12 +0300
Message-Id: <20190821083712.4635-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to handle optional module request in the driver
when user space tools has that feature for ages.

Replace custom code by MODULE_SOFTDEP() macro to let user space know
that we would like to have the DMA driver loaded first, if any.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 277f48f1cc1c..cb39ecf5a9f1 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -128,17 +128,6 @@ static const struct mfd_cell intel_lpss_spi_cell = {
 static DEFINE_IDA(intel_lpss_devid_ida);
 static struct dentry *intel_lpss_debugfs;
 
-static int intel_lpss_request_dma_module(const char *name)
-{
-	static bool intel_lpss_dma_requested;
-
-	if (intel_lpss_dma_requested)
-		return 0;
-
-	intel_lpss_dma_requested = true;
-	return request_module("%s", name);
-}
-
 static void intel_lpss_cache_ltr(struct intel_lpss *lpss)
 {
 	lpss->active_ltr = readl(lpss->priv + LPSS_PRIV_ACTIVELTR);
@@ -429,16 +418,6 @@ int intel_lpss_probe(struct device *dev,
 		dev_warn(dev, "Failed to create debugfs entries\n");
 
 	if (intel_lpss_has_idma(lpss)) {
-		/*
-		 * Ensure the DMA driver is loaded before the host
-		 * controller device appears, so that the host controller
-		 * driver can request its DMA channels as early as
-		 * possible.
-		 *
-		 * If the DMA module is not there that's OK as well.
-		 */
-		intel_lpss_request_dma_module(LPSS_IDMA64_DRIVER_NAME);
-
 		ret = mfd_add_devices(dev, lpss->devid, &intel_lpss_idma64_cell,
 				      1, info->mem, info->irq, NULL);
 		if (ret)
@@ -554,3 +533,11 @@ MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
 MODULE_DESCRIPTION("Intel LPSS core driver");
 MODULE_LICENSE("GPL v2");
+/*
+ * Ensure the DMA driver is loaded before the host controller device appears,
+ * so that the host controller driver can request its DMA channels as early
+ * as possible.
+ *
+ * If the DMA module is not there that's OK as well.
+ */
+MODULE_SOFTDEP("pre: platform:" LPSS_IDMA64_DRIVER_NAME);
-- 
2.23.0.rc1

