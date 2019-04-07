Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC40C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE242087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDGVGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:06:21 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60409 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:06:20 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1F4521C0002;
        Sun,  7 Apr 2019 21:06:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/8] rtc: ds1672: move oscillator handling to .read_time
Date:   Sun,  7 Apr 2019 23:05:35 +0200
Message-Id: <20190407210541.13409-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
References: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EINVAL when trying to read an invalid time instead of just probe
because this is a useful information for userspace.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1672.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index b9860820cc90..71645f009e04 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -29,7 +29,7 @@
 static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
 	unsigned long time;
-	unsigned char addr = DS1672_REG_CNT_BASE;
+	unsigned char addr = DS1672_REG_CONTROL;
 	unsigned char buf[4];
 
 	struct i2c_msg msgs[] = {
@@ -41,11 +41,25 @@ static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		{/* read date */
 			.addr = client->addr,
 			.flags = I2C_M_RD,
-			.len = 4,
+			.len = 1,
 			.buf = buf
 		},
 	};
 
+	/* read control register */
+	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
+		dev_warn(&client->dev, "Unable to read the control register\n");
+		return -EIO;
+	}
+
+	if (buf[0] & DS1672_REG_CONTROL_EOSC) {
+		dev_warn(&client->dev, "Oscillator not enabled. Set time to enable.\n");
+		return -EINVAL;
+	}
+
+	addr = DS1672_REG_CNT_BASE;
+	msgs[1].len = 4;
+
 	/* read date registers */
 	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
 		dev_err(&client->dev, "%s: read error\n", __func__);
@@ -154,7 +168,6 @@ static int ds1672_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	int err = 0;
-	u8 control;
 	struct rtc_device *rtc;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
@@ -178,16 +191,6 @@ static int ds1672_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, rtc);
 
-	/* read control register */
-	err = ds1672_get_control(client, &control);
-	if (err) {
-		dev_warn(&client->dev, "Unable to read the control register\n");
-	}
-
-	if (control & DS1672_REG_CONTROL_EOSC)
-		dev_warn(&client->dev, "Oscillator not enabled. "
-			 "Set time to enable.\n");
-
 	/* Register sysfs hooks */
 	err = device_create_file(&client->dev, &dev_attr_control);
 	if (err)
-- 
2.20.1

