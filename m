Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5512C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892E92087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDGVGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:06:23 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43887 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDGVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:06:22 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CC84D60007;
        Sun,  7 Apr 2019 21:06:19 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/8] rtc: ds1672: remove sysfs debug interface
Date:   Sun,  7 Apr 2019 23:05:36 +0200
Message-Id: <20190407210541.13409-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
References: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the control sysfs file as it is not documented, read only and was
only used to provide the oscillator state.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1672.c | 51 ----------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 71645f009e04..4b4757a6644d 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -114,51 +114,6 @@ static int ds1672_rtc_set_mmss(struct device *dev, unsigned long secs)
 	return ds1672_set_mmss(to_i2c_client(dev), secs);
 }
 
-static int ds1672_get_control(struct i2c_client *client, u8 *status)
-{
-	unsigned char addr = DS1672_REG_CONTROL;
-
-	struct i2c_msg msgs[] = {
-		{/* setup read ptr */
-			.addr = client->addr,
-			.len = 1,
-			.buf = &addr
-		},
-		{/* read control */
-			.addr = client->addr,
-			.flags = I2C_M_RD,
-			.len = 1,
-			.buf = status
-		},
-	};
-
-	/* read control register */
-	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
-		dev_err(&client->dev, "%s: read error\n", __func__);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/* following are the sysfs callback functions */
-static ssize_t show_control(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	u8 control;
-	int err;
-
-	err = ds1672_get_control(client, &control);
-	if (err)
-		return err;
-
-	return sprintf(buf, "%s\n", (control & DS1672_REG_CONTROL_EOSC)
-		       ? "disabled" : "enabled");
-}
-
-static DEVICE_ATTR(control, S_IRUGO, show_control, NULL);
-
 static const struct rtc_class_ops ds1672_rtc_ops = {
 	.read_time = ds1672_rtc_read_time,
 	.set_mmss = ds1672_rtc_set_mmss,
@@ -191,12 +146,6 @@ static int ds1672_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, rtc);
 
-	/* Register sysfs hooks */
-	err = device_create_file(&client->dev, &dev_attr_control);
-	if (err)
-		dev_err(&client->dev, "Unable to create sysfs entry: %s\n",
-			dev_attr_control.attr.name);
-
 	return 0;
 }
 
-- 
2.20.1

