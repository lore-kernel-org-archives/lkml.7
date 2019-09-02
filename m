Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFDC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0E3217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfIBJxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:53:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46878 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfIBJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:53:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 634B128CB74
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
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 10/10] mfd: cros_ec: Use mfd_add_hotplug_devices() helper
Date:   Mon,  2 Sep 2019 11:53:09 +0200
Message-Id: <20190902095309.18574-11-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902095309.18574-1-enric.balletbo@collabora.com>
References: <20190902095309.18574-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mfd_add_hotplug_devices() helper to register the subdevices. The
helper allows us to reduce the boiler plate and also registers the
subdevices in the same way as used in other functions used in this
files.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v7: None
Changes in v6:
- Improve patch description stating the reason of the change (Lee Jones)

Changes in v5: None
Changes in v4: None
Changes in v3:
- Add a new patch to use mfd_add_hoplug_devices to register subdevices

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 90eb02c56b77..6e6dfd6c1871 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -329,10 +329,8 @@ static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
 	 * Register 2 accelerometers, we will fail in the IIO driver if there
 	 * are no sensors.
 	 */
-	ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-			      cros_ec_accel_legacy_cells,
-			      ARRAY_SIZE(cros_ec_accel_legacy_cells),
-			      NULL, 0, NULL);
+	ret = mfd_add_hotplug_devices(ec->dev, cros_ec_accel_legacy_cells,
+				      ARRAY_SIZE(cros_ec_accel_legacy_cells));
 	if (ret)
 		dev_err(ec_dev->dev, "failed to add EC sensors\n");
 }
@@ -419,10 +417,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
 	 */
-	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-				 cros_ec_platform_cells,
-				 ARRAY_SIZE(cros_ec_platform_cells),
-				 NULL, 0, NULL);
+	retval = mfd_add_hotplug_devices(ec->dev, cros_ec_platform_cells,
+					 ARRAY_SIZE(cros_ec_platform_cells));
 	if (retval)
 		dev_warn(ec->dev,
 			 "failed to add cros-ec platform devices: %d\n",
@@ -431,10 +427,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* Check whether this EC instance has a VBC NVRAM */
 	node = ec->ec_dev->dev->of_node;
 	if (of_property_read_bool(node, "google,has-vbc-nvram")) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_vbc_cells,
-					 ARRAY_SIZE(cros_ec_vbc_cells),
-					 NULL, 0, NULL);
+		retval = mfd_add_hotplug_devices(ec->dev, cros_ec_vbc_cells,
+						ARRAY_SIZE(cros_ec_vbc_cells));
 		if (retval)
 			dev_warn(ec->dev, "failed to add VBC devices: %d\n",
 				 retval);
-- 
2.20.1

