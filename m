Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2043CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B4021925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJSUtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 16:49:47 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41937 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfJSUtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 16:49:46 -0400
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4A687240002;
        Sat, 19 Oct 2019 20:49:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/9] rtc: ds1343: remove dead code
Date:   Sat, 19 Oct 2019 22:49:34 +0200
Message-Id: <20191019204941.6203-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019204941.6203-1-alexandre.belloni@bootlin.com>
References: <20191019204941.6203-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC_SET_CHARGE doesn't exist, the ioctl code is never used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index b45d1b8fd631..9d7d571e722b 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -87,26 +87,6 @@ struct ds1343_priv {
 	int alarm_mday;
 };
 
-static int ds1343_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-#ifdef RTC_SET_CHARGE
-	case RTC_SET_CHARGE:
-	{
-		int val;
-
-		if (copy_from_user(&val, (int __user *)arg, sizeof(int)))
-			return -EFAULT;
-
-		return regmap_write(priv->map, DS1343_TRICKLE_REG, val);
-	}
-	break;
-#endif
-	}
-
-	return -ENOIOCTLCMD;
-}
-
 static ssize_t ds1343_show_glitchfilter(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -452,7 +432,6 @@ static irqreturn_t ds1343_thread(int irq, void *dev_id)
 }
 
 static const struct rtc_class_ops ds1343_rtc_ops = {
-	.ioctl		= ds1343_ioctl,
 	.read_time	= ds1343_read_time,
 	.set_time	= ds1343_set_time,
 	.read_alarm	= ds1343_read_alarm,
-- 
2.21.0

