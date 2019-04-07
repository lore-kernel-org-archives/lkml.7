Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA75C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C631213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfDGVGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:06:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60187 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDGVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:06:20 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5E72B60006;
        Sun,  7 Apr 2019 21:06:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/8] rtc: ds1672: set range
Date:   Sun,  7 Apr 2019 23:05:34 +0200
Message-Id: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ds1672 is a 32bit seconds counter.

Also remove erroneous comment claiming that epoch is set to 2000, it was
not.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1672.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index b1ebca099b0d..b9860820cc90 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -21,12 +21,10 @@
 
 #define DS1672_REG_CONTROL_EOSC	0x80
 
-static struct i2c_driver ds1672_driver;
-
 /*
  * In the routines that deal directly with the ds1672 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch
- * Epoch is initialized as 2000. Time is set to UTC.
+ * Time is set to UTC.
  */
 static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
@@ -164,8 +162,16 @@ static int ds1672_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	rtc = devm_rtc_device_register(&client->dev, ds1672_driver.driver.name,
-				  &ds1672_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->ops = &ds1672_rtc_ops;
+	rtc->range_max = U32_MAX;
+
+	err = rtc_register_device(rtc);
+	if (err)
+		return err;
 
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
-- 
2.20.1

