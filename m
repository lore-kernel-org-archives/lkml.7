Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5079C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7506206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLNWKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:10:33 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50053 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:10:29 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CC7451BF207;
        Sat, 14 Dec 2019 22:10:27 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 04/16] rtc: rv3029: remove race condition when update STATUS
Date:   Sat, 14 Dec 2019 23:10:10 +0100
Message-Id: <20191214221022.622482-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
References: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no lock preventing concurrent access to the status register from
bth the rtc subsystem and the hwmon subsystem. Use regmap_update_bits to
ensure updating RV3029_STATUS is properly locked.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3029c2.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 36b4da260caf..4e7514433b79 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -147,19 +147,6 @@ static int rv3029_get_sr(struct device *dev, u8 *buf)
 	return 0;
 }
 
-static int rv3029_set_sr(struct device *dev, u8 val)
-{
-	u8 buf[1];
-	int sr;
-
-	buf[0] = val;
-	sr = rv3029_write_regs(dev, RV3029_STATUS, buf, 1);
-	dev_dbg(dev, "status = 0x%.2x (%d)\n", buf[0], buf[0]);
-	if (sr < 0)
-		return -EIO;
-	return 0;
-}
-
 static int rv3029_eeprom_busywait(struct device *dev)
 {
 	int i, ret;
@@ -205,9 +192,9 @@ static int rv3029_eeprom_enter(struct device *dev)
 		/* We clear the bits and retry once just in case
 		 * we had a brown out in early startup.
 		 */
-		sr &= ~RV3029_STATUS_VLOW1;
-		sr &= ~RV3029_STATUS_VLOW2;
-		ret = rv3029_set_sr(dev, sr);
+		ret = regmap_update_bits(rv3029->regmap, RV3029_STATUS,
+					 RV3029_STATUS_VLOW1 |
+					 RV3029_STATUS_VLOW2, 0);
 		if (ret < 0)
 			return ret;
 		usleep_range(1000, 10000);
@@ -515,6 +502,7 @@ static int rv3029_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static int rv3029_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct rv3029_data *rv3029 = dev_get_drvdata(dev);
 	u8 regs[8];
 	int ret;
 
@@ -539,19 +527,9 @@ static int rv3029_set_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	ret = rv3029_get_sr(dev, regs);
-	if (ret < 0) {
-		dev_err(dev, "%s: reading SR failed\n", __func__);
-		return ret;
-	}
 	/* clear PON bit */
-	ret = rv3029_set_sr(dev, (regs[0] & ~RV3029_STATUS_PON));
-	if (ret < 0) {
-		dev_err(dev, "%s: reading SR failed\n", __func__);
-		return ret;
-	}
-
-	return 0;
+	return regmap_update_bits(rv3029->regmap, RV3029_STATUS,
+				  RV3029_STATUS_PON, 0);
 }
 
 static const struct rv3029_trickle_tab_elem {
-- 
2.23.0

