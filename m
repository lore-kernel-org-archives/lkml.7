Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD34C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B1B20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDHJl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:41:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfDHJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:41:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 684B327F023
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/4] mfd: cros_ec: instantiate properly CrOS ISH MCU device
Date:   Mon,  8 Apr 2019 11:41:39 +0200
Message-Id: <20190408094141.27858-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408094141.27858-1-enric.balletbo@collabora.com>
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>

Integrated Sensor Hub (ISH) is also a MCU running EC
having feature bit EC_FEATURE_ISH. Instantiate it as
a special CrOS EC device with device name 'cros_ish'.

Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Fix Andy Shevchenko email.

Changes in v2:
- Add a patch to instantiate the CrOS ISH device to the series.

 drivers/mfd/cros_ec_dev.c   | 13 +++++++++++++
 include/linux/mfd/cros_ec.h |  5 +++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 99cfdb5b71ef..1daccd4e05a3 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -636,6 +636,19 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	/*
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
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index b6442201f77f..ce50628aa5e7 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -22,8 +22,9 @@
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/mutex.h>
 
-#define CROS_EC_DEV_NAME "cros_ec"
-#define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_NAME	"cros_ec"
+#define CROS_EC_DEV_ISH_NAME	"cros_ish"
+#define CROS_EC_DEV_PD_NAME	"cros_pd"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
-- 
2.20.1

