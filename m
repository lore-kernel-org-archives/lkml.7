Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D634DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42AA2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfFDPUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:20:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfFDPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:20:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 97B46285378
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org
Subject: [PATCH 09/10] mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
Date:   Tue,  4 Jun 2019 17:20:18 +0200
Message-Id: <20190604152019.16100-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604152019.16100-1-enric.balletbo@collabora.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the increasing use of dedicated CrOS EC MCUs, it takes a fair amount
of boiler plate code to add those devices, add a struct that can be used
to specify a dedicated CrOS EC MCU so we can just add a new item to it to
define a new dedicated MCU.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec_dev.c | 72 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 5663fda3739c..6fcfc8f17e03 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -22,6 +22,36 @@ static struct class cros_class = {
 	.name           = "chromeos",
 };
 
+/**
+ * cros_feature_to_name - CrOS feature id to name/short description.
+ * @id: The feature identifier.
+ * @name: Device name associated with the feature id.
+ * @desc: Short name that will be displayed.
+ */
+struct cros_feature_to_name {
+	unsigned int id;
+	const char *name;
+	const char *desc;
+};
+
+static const struct cros_feature_to_name cros_mcu_devices[] = {
+	{
+		.id	= EC_FEATURE_FINGERPRINT,
+		.name	= CROS_EC_DEV_FP_NAME,
+		.desc	= "Fingerprint",
+	},
+	{
+		.id	= EC_FEATURE_ISH,
+		.name	= CROS_EC_DEV_ISH_NAME,
+		.desc	= "Integrated Sensor Hub",
+	},
+	{
+		.id	= EC_FEATURE_TOUCHPAD,
+		.name	= CROS_EC_DEV_TP_NAME,
+		.desc	= "Touchpad",
+	},
+};
+
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -212,6 +242,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
 	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
+	int i;
 
 	if (!ec)
 		return retval;
@@ -224,37 +255,20 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->features[1] = -1U; /* Not cached yet */
 	device_initialize(&ec->class_dev);
 
-	/* Check whether this is actually a Fingerprint MCU rather than an EC */
-	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
-		dev_info(dev, "CrOS Fingerprint MCU detected.\n");
+	for (i = 0; i < ARRAY_SIZE(cros_mcu_devices); i++) {
 		/*
-		 * Help userspace differentiating ECs from FP MCU,
-		 * regardless of the probing order.
+		 * Check whether this is actually a dedicated MCU rather
+		 * than an standard EC.
 		 */
-		ec_platform->ec_name = CROS_EC_DEV_FP_NAME;
-	}
-
-	/*
-	 * Check whether this is actually an Integrated Sensor Hub (ISH)
-	 * rather than an EC.
-	 */
-	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
-		dev_info(dev, "CrOS ISH MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from ISH MCU,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
-	}
-
-	/* Check whether this is actually a Touchpad MCU rather than an EC */
-	if (cros_ec_check_features(ec, EC_FEATURE_TOUCHPAD)) {
-		dev_info(dev, "CrOS Touchpad MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from TP MCU,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
+		if (cros_ec_check_features(ec, cros_mcu_devices[i].id)) {
+			dev_info(dev, "CrOS %s MCU detected\n",
+				 cros_mcu_devices[i].desc);
+			/*
+			 * Help userspace differentiating ECs from other MCU,
+			 * regardless of the probing order.
+			 */
+			ec_platform->ec_name = cros_mcu_devices[i].name;
+		}
 	}
 
 	/*
-- 
2.20.1

