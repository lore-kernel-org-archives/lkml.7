Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C5C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDJWQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:16:41 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46677 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:16:41 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5B4F2E0006;
        Wed, 10 Apr 2019 22:16:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Mastro Gippo <gipmad@gmail.com>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: ds1307: properly handle oscillator failure flags
Date:   Thu, 11 Apr 2019 00:16:29 +0200
Message-Id: <20190410221629.18906-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop enabling the oscillator and removing the oscillator failure flags in
probe. Instead, return -EINVAL in .read_time when the oscillaotr is not
start or when it failed at some point. The oscillator gets enabled on the
first .set_time after failure and the failure flags are cleared.

This also removes the possibility of an infinite loop at probe where a
failing RTC will make the goto read_rtc to be taken every time.

Tested on mcp79411.

Reported-by: Mastro Gippo <gipmad@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 129 ++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 71 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 07530fe1da2a..7f8b236c935c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -225,6 +225,45 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 		return -EINVAL;
 	}
 
+	tmp = regs[DS1307_REG_SECS];
+	switch (ds1307->type) {
+	case ds_1307:
+	case m41t0:
+	case m41t00:
+	case m41t11:
+		if (tmp & DS1307_BIT_CH)
+			return -EINVAL;
+		break;
+	case ds_1308:
+	case ds_1338:
+		if (tmp & DS1307_BIT_CH)
+			return -EINVAL;
+
+		ret = regmap_read(ds1307->regmap, DS1307_REG_CONTROL, &tmp);
+		if (ret)
+			return ret;
+		if (tmp & DS1338_BIT_OSF)
+			return -EINVAL;
+		break;
+	case ds_1340:
+		if (tmp & DS1340_BIT_nEOSC)
+			return -EINVAL;
+
+		ret = regmap_read(ds1307->regmap, DS1340_REG_FLAG, &tmp);
+		if (ret)
+			return ret;
+		if (tmp & DS1340_BIT_OSF)
+			return -EINVAL;
+		break;
+	case mcp794xx:
+		if (!(tmp & MCP794XX_BIT_ST))
+			return -EINVAL;
+
+		break;
+	default:
+		break;
+	}
+
 	t->tm_sec = bcd2bin(regs[DS1307_REG_SECS] & 0x7f);
 	t->tm_min = bcd2bin(regs[DS1307_REG_MIN] & 0x7f);
 	tmp = regs[DS1307_REG_HOUR] & 0x3f;
@@ -289,7 +328,17 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	if (t->tm_year > 199 && chip->century_bit)
 		regs[chip->century_reg] |= chip->century_bit;
 
-	if (ds1307->type == mcp794xx) {
+	switch (ds1307->type) {
+	case ds_1308:
+	case ds_1338:
+		regmap_update_bits(ds1307->regmap, DS1307_REG_CONTROL,
+				   DS1338_BIT_OSF, 0);
+		break;
+	case ds_1340:
+		regmap_update_bits(ds1307->regmap, DS1340_REG_FLAG,
+				   DS1340_BIT_OSF, 0);
+		break;
+	case mcp794xx:
 		/*
 		 * these bits were cleared when preparing the date/time
 		 * values and need to be set again before writing the
@@ -297,6 +346,9 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		 */
 		regs[DS1307_REG_SECS] |= MCP794XX_BIT_ST;
 		regs[DS1307_REG_WDAY] |= MCP794XX_BIT_VBATEN;
+		break;
+	default:
+		break;
 	}
 
 	dev_dbg(dev, "%s: %7ph\n", "write", regs);
@@ -1705,7 +1757,6 @@ static int ds1307_probe(struct i2c_client *client,
 		break;
 	}
 
-read_rtc:
 	/* read RTC registers */
 	err = regmap_bulk_read(ds1307->regmap, chip->offset, regs,
 			       sizeof(regs));
@@ -1714,75 +1765,11 @@ static int ds1307_probe(struct i2c_client *client,
 		goto exit;
 	}
 
-	/*
-	 * minimal sanity checking; some chips (like DS1340) don't
-	 * specify the extra bits as must-be-zero, but there are
-	 * still a few values that are clearly out-of-range.
-	 */
-	tmp = regs[DS1307_REG_SECS];
-	switch (ds1307->type) {
-	case ds_1307:
-	case m41t0:
-	case m41t00:
-	case m41t11:
-		/* clock halted?  turn it on, so clock can tick. */
-		if (tmp & DS1307_BIT_CH) {
-			regmap_write(ds1307->regmap, DS1307_REG_SECS, 0);
-			dev_warn(ds1307->dev, "SET TIME!\n");
-			goto read_rtc;
-		}
-		break;
-	case ds_1308:
-	case ds_1338:
-		/* clock halted?  turn it on, so clock can tick. */
-		if (tmp & DS1307_BIT_CH)
-			regmap_write(ds1307->regmap, DS1307_REG_SECS, 0);
-
-		/* oscillator fault?  clear flag, and warn */
-		if (regs[DS1307_REG_CONTROL] & DS1338_BIT_OSF) {
-			regmap_write(ds1307->regmap, DS1307_REG_CONTROL,
-				     regs[DS1307_REG_CONTROL] &
-				     ~DS1338_BIT_OSF);
-			dev_warn(ds1307->dev, "SET TIME!\n");
-			goto read_rtc;
-		}
-		break;
-	case ds_1340:
-		/* clock halted?  turn it on, so clock can tick. */
-		if (tmp & DS1340_BIT_nEOSC)
-			regmap_write(ds1307->regmap, DS1307_REG_SECS, 0);
-
-		err = regmap_read(ds1307->regmap, DS1340_REG_FLAG, &tmp);
-		if (err) {
-			dev_dbg(ds1307->dev, "read error %d\n", err);
-			goto exit;
-		}
-
-		/* oscillator fault?  clear flag, and warn */
-		if (tmp & DS1340_BIT_OSF) {
-			regmap_write(ds1307->regmap, DS1340_REG_FLAG, 0);
-			dev_warn(ds1307->dev, "SET TIME!\n");
-		}
-		break;
-	case mcp794xx:
-		/* make sure that the backup battery is enabled */
-		if (!(regs[DS1307_REG_WDAY] & MCP794XX_BIT_VBATEN)) {
-			regmap_write(ds1307->regmap, DS1307_REG_WDAY,
-				     regs[DS1307_REG_WDAY] |
-				     MCP794XX_BIT_VBATEN);
-		}
-
-		/* clock halted?  turn it on, so clock can tick. */
-		if (!(tmp & MCP794XX_BIT_ST)) {
-			regmap_write(ds1307->regmap, DS1307_REG_SECS,
-				     MCP794XX_BIT_ST);
-			dev_warn(ds1307->dev, "SET TIME!\n");
-			goto read_rtc;
-		}
-
-		break;
-	default:
-		break;
+	if (ds1307->type == mcp794xx &&
+	    !(regs[DS1307_REG_WDAY] & MCP794XX_BIT_VBATEN)) {
+		regmap_write(ds1307->regmap, DS1307_REG_WDAY,
+			     regs[DS1307_REG_WDAY] |
+			     MCP794XX_BIT_VBATEN);
 	}
 
 	tmp = regs[DS1307_REG_HOUR];
-- 
2.20.1

