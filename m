Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32959C2D0CA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1267E206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLNWLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:11:12 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33395 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLNWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:10:29 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 99BF11BF204;
        Sat, 14 Dec 2019 22:10:28 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 06/16] rtc: rv3029: get rid of rv3029_get_sr
Date:   Sat, 14 Dec 2019 23:10:12 +0100
Message-Id: <20191214221022.622482-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
References: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in having 2 indirections before calling regmap_read,
especially since rv3029_get_sr also changes the return value without any
good reason. Call regmap_read directly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3029c2.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 0e0a10cbfd67..f92fbb4db173 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -137,23 +137,13 @@ static int rv3029_write_regs(struct device *dev, u8 reg, u8 const buf[],
 	return regmap_bulk_write(rv3029->regmap, reg, buf, len);
 }
 
-static int rv3029_get_sr(struct device *dev, u8 *buf)
-{
-	int ret = rv3029_read_regs(dev, RV3029_STATUS, buf, 1);
-
-	if (ret < 0)
-		return -EIO;
-	dev_dbg(dev, "status = 0x%.2x (%d)\n", buf[0], buf[0]);
-	return 0;
-}
-
-static int rv3029_eeprom_busywait(struct device *dev)
+static int rv3029_eeprom_busywait(struct rv3029_data *rv3029)
 {
+	unsigned int sr;
 	int i, ret;
-	u8 sr;
 
 	for (i = 100; i > 0; i--) {
-		ret = rv3029_get_sr(dev, &sr);
+		ret = regmap_read(rv3029->regmap, RV3029_STATUS, &sr);
 		if (ret < 0)
 			break;
 		if (!(sr & RV3029_STATUS_EEBUSY))
@@ -161,7 +151,7 @@ static int rv3029_eeprom_busywait(struct device *dev)
 		usleep_range(1000, 10000);
 	}
 	if (i <= 0) {
-		dev_err(dev, "EEPROM busy wait timeout.\n");
+		dev_err(rv3029->dev, "EEPROM busy wait timeout.\n");
 		return -ETIMEDOUT;
 	}
 
@@ -181,11 +171,11 @@ static int rv3029_eeprom_exit(struct device *dev)
 static int rv3029_eeprom_enter(struct device *dev)
 {
 	struct rv3029_data *rv3029 = dev_get_drvdata(dev);
+	unsigned int sr;
 	int ret;
-	u8 sr;
 
 	/* Check whether we are in the allowed voltage range. */
-	ret = rv3029_get_sr(dev, &sr);
+	ret = regmap_read(rv3029->regmap, RV3029_STATUS, &sr);
 	if (ret < 0)
 		return ret;
 	if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
@@ -198,7 +188,7 @@ static int rv3029_eeprom_enter(struct device *dev)
 		if (ret < 0)
 			return ret;
 		usleep_range(1000, 10000);
-		ret = rv3029_get_sr(dev, &sr);
+		ret = regmap_read(rv3029->regmap, RV3029_STATUS, &sr);
 		if (ret < 0)
 			return ret;
 		if (sr & (RV3029_STATUS_VLOW1 | RV3029_STATUS_VLOW2)) {
@@ -215,7 +205,7 @@ static int rv3029_eeprom_enter(struct device *dev)
 		return ret;
 
 	/* Wait for any previous eeprom accesses to finish. */
-	ret = rv3029_eeprom_busywait(dev);
+	ret = rv3029_eeprom_busywait(rv3029);
 	if (ret < 0)
 		rv3029_eeprom_exit(dev);
 
@@ -243,6 +233,7 @@ static int rv3029_eeprom_read(struct device *dev, u8 reg,
 static int rv3029_eeprom_write(struct device *dev, u8 reg,
 			       u8 const buf[], size_t len)
 {
+	struct rv3029_data *rv3029 = dev_get_drvdata(dev);
 	int ret, err;
 	size_t i;
 	u8 tmp;
@@ -260,7 +251,7 @@ static int rv3029_eeprom_write(struct device *dev, u8 reg,
 			if (ret < 0)
 				break;
 		}
-		ret = rv3029_eeprom_busywait(dev);
+		ret = rv3029_eeprom_busywait(rv3029);
 		if (ret < 0)
 			break;
 	}
-- 
2.23.0

