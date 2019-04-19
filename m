Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69FC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DA121855
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfDSUFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:05:21 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:55348 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfDSUFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:05:20 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B010C3A5E42;
        Fri, 19 Apr 2019 08:25:11 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 13E8FFF812;
        Fri, 19 Apr 2019 08:25:10 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/6] rtc: ds2404: remove ds2404_chip_ops
Date:   Fri, 19 Apr 2019 10:25:00 +0200
Message-Id: <20190419082501.17549-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
References: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one ds2404_chip_ops struct that is implemented, remove the
unnecessary indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds2404.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 89402ac11cfa..c6b73dcf9d62 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -23,14 +23,6 @@
 #define DS2404_COPY_SCRATCHPAD_CMD 0x55
 #define DS2404_READ_MEMORY_CMD 0xf0
 
-struct ds2404;
-
-struct ds2404_chip_ops {
-	int (*map_io)(struct ds2404 *chip, struct platform_device *pdev,
-		      struct ds2404_platform_data *pdata);
-	void (*unmap_io)(struct ds2404 *chip);
-};
-
 #define DS2404_RST	0
 #define DS2404_CLK	1
 #define DS2404_DQ	2
@@ -42,7 +34,6 @@ struct ds2404_gpio {
 
 struct ds2404 {
 	struct ds2404_gpio *gpio;
-	const struct ds2404_chip_ops *ops;
 	struct rtc_device *rtc;
 };
 
@@ -89,11 +80,6 @@ static void ds2404_gpio_unmap(struct ds2404 *chip)
 		gpio_free(ds2404_gpio[i].gpio);
 }
 
-static const struct ds2404_chip_ops ds2404_gpio_ops = {
-	.map_io		= ds2404_gpio_map,
-	.unmap_io	= ds2404_gpio_unmap,
-};
-
 static void ds2404_reset(struct device *dev)
 {
 	gpio_set_value(ds2404_gpio[DS2404_RST].gpio, 0);
@@ -226,13 +212,11 @@ static int rtc_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	chip->ops = &ds2404_gpio_ops;
-
 	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(chip->rtc))
 		return PTR_ERR(chip->rtc);
 
-	retval = chip->ops->map_io(chip, pdev, pdata);
+	retval = ds2404_gpio_map(chip, pdev, pdata);
 	if (retval)
 		goto err_chip;
 
@@ -253,7 +237,7 @@ static int rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err_io:
-	chip->ops->unmap_io(chip);
+	ds2404_gpio_unmap(chip);
 err_chip:
 	return retval;
 }
@@ -262,7 +246,7 @@ static int rtc_remove(struct platform_device *dev)
 {
 	struct ds2404 *chip = platform_get_drvdata(dev);
 
-	chip->ops->unmap_io(chip);
+	ds2404_gpio_unmap(chip);
 
 	return 0;
 }
-- 
2.20.1

