Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38825C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101F720843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfFDPU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:20:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfFDPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:20:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5E08D28536B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org
Subject: [PATCH 10/10] mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC subdevices
Date:   Tue,  4 Jun 2019 17:20:19 +0200
Message-Id: <20190604152019.16100-11-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604152019.16100-1-enric.balletbo@collabora.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CrOS EC is gaining lots of subdevices that are autodetectable by
sending the EC_FEATURE_GET_CMD, it takes fair amount of boiler plate
code to add those devices. So, add a struct that can be used to quickly
add new subdevices without having to duplicate code.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec_dev.c | 132 +++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 58 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6fcfc8f17e03..49e4ab7ebb71 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -34,6 +34,18 @@ struct cros_feature_to_name {
 	const char *desc;
 };
 
+/**
+ * cros_feature_to_cells - CrOS feature id to mfd cells association.
+ * @id: The feature identifier.
+ * @mfd_cells: Pointer to the array of mfd cells that needs to be added.
+ * @num_cells: Number of mfd cells into the array.
+ */
+struct cros_feature_to_cells {
+	unsigned int id;
+	const struct mfd_cell *mfd_cells;
+	unsigned int num_cells;
+};
+
 static const struct cros_feature_to_name cros_mcu_devices[] = {
 	{
 		.id	= EC_FEATURE_FINGERPRINT,
@@ -52,6 +64,48 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
 	},
 };
 
+static const struct mfd_cell cros_ec_cec_cells[] = {
+	{ .name = "cros-ec-cec", },
+};
+
+static const struct mfd_cell cros_ec_rtc_cells[] = {
+	{ .name = "cros-ec-rtc", },
+};
+
+static const struct mfd_cell cros_usbpd_charger_cells[] = {
+	{ .name = "cros-usbpd-charger", },
+	{ .name = "cros-usbpd-logger", },
+};
+
+static const struct cros_feature_to_cells cros_subdevices[] = {
+	{
+		.id		= EC_FEATURE_CEC,
+		.mfd_cells	= cros_ec_cec_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_cec_cells),
+	},
+	{
+		.id		= EC_FEATURE_RTC,
+		.mfd_cells	= cros_ec_rtc_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_rtc_cells),
+	},
+	{
+		.id		= EC_FEATURE_USB_PD,
+		.mfd_cells	= cros_usbpd_charger_cells,
+		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
+	},
+};
+
+static const struct mfd_cell cros_ec_platform_cells[] = {
+	{ .name = "cros-ec-chardev", },
+	{ .name = "cros-ec-debugfs", },
+	{ .name = "cros-ec-lightbar", },
+	{ .name = "cros-ec-sysfs", },
+};
+
+static const struct mfd_cell cros_ec_vbc_cells[] = {
+	{ .name = "cros-ec-vbc", }
+};
+
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -211,30 +265,6 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
-static const struct mfd_cell cros_ec_cec_cells[] = {
-	{ .name = "cros-ec-cec" }
-};
-
-static const struct mfd_cell cros_ec_rtc_cells[] = {
-	{ .name = "cros-ec-rtc" }
-};
-
-static const struct mfd_cell cros_usbpd_charger_cells[] = {
-	{ .name = "cros-usbpd-charger" },
-	{ .name = "cros-usbpd-logger" },
-};
-
-static const struct mfd_cell cros_ec_platform_cells[] = {
-	{ .name = "cros-ec-chardev" },
-	{ .name = "cros-ec-debugfs" },
-	{ .name = "cros-ec-lightbar" },
-	{ .name = "cros-ec-sysfs" },
-};
-
-static const struct mfd_cell cros_ec_vbc_cells[] = {
-	{ .name = "cros-ec-vbc" }
-};
-
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -292,42 +322,28 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
-	/* Check whether this EC instance has CEC host command support */
-	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_cec_cells,
-					 ARRAY_SIZE(cros_ec_cec_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-ec-cec device: %d\n",
-				retval);
-	}
-
-	/* Check whether this EC instance has RTC host command support */
-	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_rtc_cells,
-					 ARRAY_SIZE(cros_ec_rtc_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-ec-rtc device: %d\n",
-				retval);
-	}
-
-	/* Check whether this EC instance has the PD charge manager */
-	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_usbpd_charger_cells,
-					 ARRAY_SIZE(cros_usbpd_charger_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-usbpd-charger device: %d\n",
-				retval);
+	/*
+	 * The following subdevices can be detected by sending the
+	 * EC_FEATURE_GET_CMD Embedded Controller device.
+	 */
+	for (i = 0; i < ARRAY_SIZE(cros_subdevices); i++) {
+		if (cros_ec_check_features(ec, cros_subdevices[i].id)) {
+			retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+						 cros_subdevices[i].mfd_cells,
+						 cros_subdevices[i].num_cells,
+						 NULL, 0, NULL);
+			if (retval)
+				dev_err(ec->dev,
+					"failed to add %s subdevice: %d\n",
+					cros_subdevices[i].mfd_cells->name,
+					retval);
+		}
 	}
 
+	/*
+	 * The following subdevices cannot be detected by sending the
+	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
+	 */
 	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 				 cros_ec_platform_cells,
 				 ARRAY_SIZE(cros_ec_platform_cells),
-- 
2.20.1

