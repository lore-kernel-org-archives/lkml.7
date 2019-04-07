Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C200C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2A521738
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDGVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:06:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53607 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:06:22 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 811741C0003;
        Sun,  7 Apr 2019 21:06:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/8] rtc: ds1672: remove useless indirection
Date:   Sun,  7 Apr 2019 23:05:37 +0200
Message-Id: <20190407210541.13409-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
References: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ds1672_get_datetime and ds1672_set_mmss are only used after casting dev
to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1672.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 4b4757a6644d..81f1aaeb8964 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -26,8 +26,9 @@
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch
  * Time is set to UTC.
  */
-static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int ds1672_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long time;
 	unsigned char addr = DS1672_REG_CONTROL;
 	unsigned char buf[4];
@@ -83,8 +84,9 @@ static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int ds1672_set_mmss(struct i2c_client *client, unsigned long secs)
+static int ds1672_set_mmss(struct device *dev, unsigned long secs)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int xfer;
 	unsigned char buf[6];
 
@@ -104,19 +106,9 @@ static int ds1672_set_mmss(struct i2c_client *client, unsigned long secs)
 	return 0;
 }
 
-static int ds1672_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return ds1672_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int ds1672_rtc_set_mmss(struct device *dev, unsigned long secs)
-{
-	return ds1672_set_mmss(to_i2c_client(dev), secs);
-}
-
 static const struct rtc_class_ops ds1672_rtc_ops = {
-	.read_time = ds1672_rtc_read_time,
-	.set_mmss = ds1672_rtc_set_mmss,
+	.read_time = ds1672_read_time,
+	.set_mmss = ds1672_set_mmss,
 };
 
 static int ds1672_probe(struct i2c_client *client,
-- 
2.20.1

