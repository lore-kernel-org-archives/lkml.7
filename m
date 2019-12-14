Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB287C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73A52073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLNWDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:03:48 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48691 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLNWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:03:06 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DD1901C0005;
        Sat, 14 Dec 2019 22:03:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 08/17] rtc: pcf8563: stop caching voltage_low
Date:   Sat, 14 Dec 2019 23:02:50 +0100
Message-Id: <20191214220259.621996-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
References: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

voltage_low is only updated when reading the time, this means that using
RTC_VL_READ will miss the VL flag if the time has not been read before
using the ioctl. Always read the status from the hardware.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8563.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 026192fc0c2a..7fc43950cf6c 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -76,7 +76,6 @@ struct pcf8563 {
 	 * 1970...2069.
 	 */
 	int c_polarity;	/* 0: MO_C=1 means 19xx, otherwise MO_C=1 means 20xx */
-	int voltage_low; /* incicates if a low_voltage was detected */
 
 	struct i2c_client *client;
 #ifdef CONFIG_COMMON_CLK
@@ -208,7 +207,6 @@ static int pcf8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return err;
 
 	if (buf[PCF8563_REG_SC] & PCF8563_SC_LV) {
-		pcf8563->voltage_low = 1;
 		dev_err(&client->dev,
 			"low voltage detected, date/time is not reliable.\n");
 		return -EINVAL;
@@ -278,15 +276,19 @@ static int pcf8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
-	struct pcf8563 *pcf8563 = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+	int vl, ret;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-		if (pcf8563->voltage_low)
-			dev_info(dev, "low voltage detected, date/time is not reliable.\n");
 
-		if (copy_to_user((void __user *)arg, &pcf8563->voltage_low,
-					sizeof(int)))
+		ret = i2c_smbus_read_byte_data(client, PCF8563_REG_SC);
+		if (ret < 0)
+			return ret;
+
+		vl = ret & PCF8563_SC_LV ? 1 : 0;
+
+		if (copy_to_user((void __user *)arg, &vl, sizeof(int)))
 			return -EFAULT;
 		return 0;
 	default:
-- 
2.23.0

