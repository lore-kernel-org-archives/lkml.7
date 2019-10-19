Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C8CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D91721925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfJSUtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 16:49:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48895 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfJSUtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 16:49:46 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B727F240008;
        Sat, 19 Oct 2019 20:49:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/9] rtc: ds1343: use burst write to set time
Date:   Sat, 19 Oct 2019 22:49:35 +0200
Message-Id: <20191019204941.6203-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019204941.6203-1-alexandre.belloni@bootlin.com>
References: <20191019204941.6203-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid possible race condition, use regmap_bulk_write to write all the
date/time registers at once instead of sequentially.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 52 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 9d7d571e722b..8a4f1fbb57fd 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -236,46 +236,18 @@ static int ds1343_read_time(struct device *dev, struct rtc_time *dt)
 static int ds1343_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct ds1343_priv *priv = dev_get_drvdata(dev);
-	int res;
-
-	res = regmap_write(priv->map, DS1343_SECONDS_REG,
-				bin2bcd(dt->tm_sec));
-	if (res)
-		return res;
-
-	res = regmap_write(priv->map, DS1343_MINUTES_REG,
-				bin2bcd(dt->tm_min));
-	if (res)
-		return res;
-
-	res = regmap_write(priv->map, DS1343_HOURS_REG,
-				bin2bcd(dt->tm_hour) & 0x3F);
-	if (res)
-		return res;
-
-	res = regmap_write(priv->map, DS1343_DAY_REG,
-				bin2bcd(dt->tm_wday + 1));
-	if (res)
-		return res;
-
-	res = regmap_write(priv->map, DS1343_DATE_REG,
-				bin2bcd(dt->tm_mday));
-	if (res)
-		return res;
-
-	res = regmap_write(priv->map, DS1343_MONTH_REG,
-				bin2bcd(dt->tm_mon + 1));
-	if (res)
-		return res;
-
-	dt->tm_year %= 100;
-
-	res = regmap_write(priv->map, DS1343_YEAR_REG,
-				bin2bcd(dt->tm_year));
-	if (res)
-		return res;
-
-	return 0;
+	u8 buf[7];
+
+	buf[0] = bin2bcd(dt->tm_sec);
+	buf[1] = bin2bcd(dt->tm_min);
+	buf[2] = bin2bcd(dt->tm_hour) & 0x3F;
+	buf[3] = bin2bcd(dt->tm_wday + 1);
+	buf[4] = bin2bcd(dt->tm_mday);
+	buf[5] = bin2bcd(dt->tm_mon + 1);
+	buf[6] = bin2bcd(dt->tm_year - 100);
+
+	return regmap_bulk_write(priv->map, DS1343_SECONDS_REG,
+				 buf, sizeof(buf));
 }
 
 static int ds1343_update_alarm(struct device *dev)
-- 
2.21.0

