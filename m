Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352CAC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1065A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfLLKhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:37:10 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55949 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfLLKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:37:10 -0500
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 8955B1BF218;
        Thu, 12 Dec 2019 10:37:07 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] rtc: hym8563: Read the valid flag directly instead of caching it
Date:   Thu, 12 Dec 2019 11:36:57 +0100
Message-Id: <20191212103658.937528-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC has a valid bit in the seconds register that indicates whether
power was lost since the pevious time set. This bit is currently read
once at probe time, cached and updated with set_time.

Howeever, caching the bit may prevent detecting power loss at runtime
(which can happen if the RTC's supply is distinct from the the platform's).

Writing the seconds register when setting time will clear the bit,
so there should be no downside in reading the bit directly instead of
caching it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/rtc/rtc-hym8563.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 443f6d05ce29..584a7815f246 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -78,7 +78,6 @@
 struct hym8563 {
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
-	bool			valid;
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw		clkout_hw;
 #endif
@@ -95,15 +94,16 @@ static int hym8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	u8 buf[7];
 	int ret;
 
-	if (!hym8563->valid) {
-		dev_warn(&client->dev, "no valid clock/calendar values available\n");
-		return -EPERM;
-	}
-
 	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);
 	if (ret < 0)
 		return ret;
 
+	if (ret & HYM8563_SEC_VL) {
+		dev_warn(&client->dev,
+			 "no valid clock/calendar values available\n");
+		return -EPERM;
+	}
+
 	tm->tm_sec = bcd2bin(buf[0] & HYM8563_SEC_MASK);
 	tm->tm_min = bcd2bin(buf[1] & HYM8563_MIN_MASK);
 	tm->tm_hour = bcd2bin(buf[2] & HYM8563_HOUR_MASK);
@@ -157,8 +157,6 @@ static int hym8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	hym8563->valid = true;
-
 	return 0;
 }
 
@@ -556,9 +554,8 @@ static int hym8563_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	hym8563->valid = !(ret & HYM8563_SEC_VL);
 	dev_dbg(&client->dev, "rtc information is %s\n",
-		hym8563->valid ? "valid" : "invalid");
+		(ret & HYM8563_SEC_VL) ? "invalid" : "valid");
 
 	hym8563->rtc = devm_rtc_device_register(&client->dev, client->name,
 						&hym8563_rtc_ops, THIS_MODULE);
-- 
2.24.0

