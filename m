Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5452133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfDAQJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:09:20 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49583 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfDAQIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:34 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0261A60005;
        Mon,  1 Apr 2019 16:08:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 04/12] rtc: pcf85063: convert to devm_rtc_allocate_device
Date:   Mon,  1 Apr 2019 18:08:08 +0200
Message-Id: <20190401160816.17859-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index c4cc0abe37cb..afd98e863482 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -28,8 +28,6 @@
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
 
-static struct i2c_driver pcf85063_driver;
-
 static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
 {
 	int rc;
@@ -220,11 +218,13 @@ static int pcf85063_probe(struct i2c_client *client)
 		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
 			 err);
 
-	rtc = devm_rtc_device_register(&client->dev,
-				       pcf85063_driver.driver.name,
-				       &pcf85063_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->ops = &pcf85063_rtc_ops;
 
-	return PTR_ERR_OR_ZERO(rtc);
+	return rtc_register_device(rtc);
 }
 
 #ifdef CONFIG_OF
-- 
2.20.1

