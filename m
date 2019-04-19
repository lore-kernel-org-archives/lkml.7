Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAACC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfDSTJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:09:54 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41976 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfDSTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:09:52 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 3C8883A976D;
        Fri, 19 Apr 2019 08:25:13 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 71078FF810;
        Fri, 19 Apr 2019 08:25:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/6] rtc: ds2404: simplify .probe and remove .remove
Date:   Fri, 19 Apr 2019 10:25:01 +0200
Message-Id: <20190419082501.17549-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
References: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset to simplify .probe and remove .remove

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds2404.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index c6b73dcf9d62..1e9f429ada64 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -72,7 +72,7 @@ static int ds2404_gpio_map(struct ds2404 *chip, struct platform_device *pdev,
 	return err;
 }
 
-static void ds2404_gpio_unmap(struct ds2404 *chip)
+static void ds2404_gpio_unmap(void *data)
 {
 	int i;
 
@@ -218,7 +218,11 @@ static int rtc_probe(struct platform_device *pdev)
 
 	retval = ds2404_gpio_map(chip, pdev, pdata);
 	if (retval)
-		goto err_chip;
+		return retval;
+
+	retval = devm_add_action_or_reset(&pdev->dev, ds2404_gpio_unmap, chip);
+	if (retval)
+		return retval;
 
 	dev_info(&pdev->dev, "using GPIOs RST:%d, CLK:%d, DQ:%d\n",
 		 chip->gpio[DS2404_RST].gpio, chip->gpio[DS2404_CLK].gpio,
@@ -231,29 +235,14 @@ static int rtc_probe(struct platform_device *pdev)
 
 	retval = rtc_register_device(chip->rtc);
 	if (retval)
-		goto err_io;
+		return retval;
 
 	ds2404_enable_osc(&pdev->dev);
 	return 0;
-
-err_io:
-	ds2404_gpio_unmap(chip);
-err_chip:
-	return retval;
-}
-
-static int rtc_remove(struct platform_device *dev)
-{
-	struct ds2404 *chip = platform_get_drvdata(dev);
-
-	ds2404_gpio_unmap(chip);
-
-	return 0;
 }
 
 static struct platform_driver rtc_device_driver = {
 	.probe	= rtc_probe,
-	.remove = rtc_remove,
 	.driver = {
 		.name	= "ds2404",
 	},
-- 
2.20.1

