Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C32206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j3PTc/Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfGaIkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:40:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35098 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfGaIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:40:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6V8eFfc078983;
        Wed, 31 Jul 2019 03:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564562415;
        bh=f8OILjK+4xrFtumGGFPWPDxRCqrguz9p6urLvVz00sU=;
        h=From:To:CC:Subject:Date;
        b=j3PTc/Xcx9hTMnjgCer63vG17POH5udTLqEDNcL7ONFZFvIXCJVJLP5kzIGg7FLEA
         KndqyFc5myT8luPQYO/k/kOH7Ns6nR9mK5Lksp60mHMOnjL7uweKXLnrUSotuSJKLP
         8Fe8+VB6nfgo2URujZLmogYjukgy+uNa9s64fEH0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6V8eFnW016389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Jul 2019 03:40:15 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 31
 Jul 2019 03:40:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 31 Jul 2019 03:40:14 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6V8eCSn048437;
        Wed, 31 Jul 2019 03:40:13 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <lee.jones@linaro.org>, <jingoohan1@gmail.com>,
        <daniel.thompson@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3] backlight: gpio-backlight: Correct initial power state handling
Date:   Wed, 31 Jul 2019 11:40:18 +0300
Message-ID: <20190731084018.5318-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default-on property - or the def_value via legacy pdata) should be
handled as:
if it is 1, the backlight must be enabled (kept enabled)
if it is 0, the backlight must be disabled (kept disabled)

This only works for the case when default-on is set. If it is not set then
the brightness of the backlight is set to 0. Now if the backlight is
enabled by external driver (graphics) the backlight will stay disabled since
the brightness is configured as 0. The backlight will not turn on.

In order to minimize screen flickering during device boot:

The initial brightness should be set to 1.

If booted in non DT mode or no phandle link to the backlight node:
follow the def_value/default-on to select UNBLANK or POWERDOWN

If in DT boot we have phandle link then leave the GPIO in a state which the
bootloader left it and let the user of the backlight to configure it
further.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

sorry for the delay, but got distracted a bit with the resend of this...
Let's try again ;)

Changes since v2 (https://lore.kernel.org/patchwork/patch/1002359/):
- Rebased on drm-next

Changes since v1:
- Implement similiar initial power state handling as pwm backlight have

Regards,
Peter

 drivers/video/backlight/gpio_backlight.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e84f3087e29f..18e053e4716c 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -59,13 +59,11 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 				   struct gpio_backlight *gbl)
 {
 	struct device *dev = &pdev->dev;
-	enum gpiod_flags flags;
 	int ret;
 
 	gbl->def_value = device_property_read_bool(dev, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
-	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
+	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
 	if (IS_ERR(gbl->gpiod)) {
 		ret = PTR_ERR(gbl->gpiod);
 
@@ -79,6 +77,22 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
+{
+	struct device_node *node = gbl->dev->of_node;
+
+	/* Not booted with device tree or no phandle link to the node */
+	if (!node || !node->phandle)
+		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+
+	/* if the enable GPIO is disabled, do not enable the backlight */
+	if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
+		return FB_BLANK_POWERDOWN;
+
+	return FB_BLANK_UNBLANK;
+}
+
+
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct gpio_backlight_platform_data *pdata =
@@ -136,7 +150,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.power = gpio_backlight_initial_power_state(gbl);
+	bl->props.brightness = 1;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

