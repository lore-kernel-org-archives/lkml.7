Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5462FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8321911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfGVNdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:33:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36524 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfGVNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:33:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F0F7728B079
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 09/11] mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC subdevices
Date:   Mon, 22 Jul 2019 15:32:55 +0200
Message-Id: <20190722133257.9336-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722133257.9336-1-enric.balletbo@collabora.com>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
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
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- Use mfd_add_hotplug_devices helper (Gwendal)

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 131 +++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 58 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index e0e18c0eb9f5..38627f6b78af 100644
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
@@ -57,6 +69,48 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
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
@@ -282,30 +336,6 @@ static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
 		dev_err(ec_dev->dev, "failed to add EC sensors\n");
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
@@ -366,42 +396,27 @@ static int ec_device_probe(struct platform_device *pdev)
 		/* Workaroud for older EC firmware */
 		cros_ec_accel_legacy_register(ec);
 
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
+			retval = mfd_add_hotplug_devices(ec->dev,
+						cros_subdevices[i].mfd_cells,
+						cros_subdevices[i].num_cells);
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

