Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4632186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCAEG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:06:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:27130 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfCAEG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:06:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 20:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="303469197"
Received: from rajeev-desktop.iind.intel.com ([10.223.84.39])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2019 20:06:53 -0800
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        gwendal@google.com, jettrink@chromium.org,
        andriy.shevchenko@intel.com
Subject: [PATCH v2] mfd: cros_ec: instantiate properly CrOS ISH MCU device
Date:   Fri,  1 Mar 2019 09:36:11 +0530
Message-Id: <1551413171-27290-1-git-send-email-rushikesh.s.kadam@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrated Sensor Hub (ISH) is also a MCU running EC
having feature bit EC_FEATURE_ISH. Instantiate it as
a special CrOS EC device with device name 'cros_ish'.

Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
---
v2
- Addressed review comments to term the CrOS EC device as a generic
  Integrated Sensor Hub. 
v1
- Initial version.

 drivers/mfd/cros_ec_dev.c            | 13 +++++++++++++
 include/linux/mfd/cros_ec.h          |  1 +
 include/linux/mfd/cros_ec_commands.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 2d0fee4..46963c2 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -415,6 +415,19 @@ static int ec_device_probe(struct platform_device *pdev)
 	cdev_init(&ec->cdev, &fops);
 
 	/*
+	 * Check whether this is actually an Integrated Sensor Hub (ISH)
+	 * rather than an EC.
+	 */
+	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
+		dev_info(dev, "CrOS ISH MCU detected.\n");
+		/*
+		 * Help userspace differentiating ECs from ISH MCU,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
+	}
+
+	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
 	 * in devtmpfs.
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index de8b588..00c5765 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -24,6 +24,7 @@
 
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_ISH_NAME "cros_ish"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082..9276c3c 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -856,6 +856,8 @@ enum ec_feature_code {
 	EC_FEATURE_RTC = 27,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* The MCU is an Intel Integrated Sensor Hub */
+	EC_FEATURE_ISH = 40,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-- 
1.9.1

