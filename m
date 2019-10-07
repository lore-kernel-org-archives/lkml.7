Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2ADECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CF2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfJGNrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:47:42 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54479 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJGNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:47:35 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AD66B24000E;
        Mon,  7 Oct 2019 13:47:33 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 08/10] rtc: ds1347: properly handle oscillator failures
Date:   Mon,  7 Oct 2019 15:47:22 +0200
Message-Id: <20191007134724.15505-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
References: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in the probe function stating that it disables oscillator stop
detection and glitch filtering is incorrect as it sets bits 3 and 4 while
it should be setting 5 and 6 to achieve that. Then, it is safe to assume
that the oscillator failure detection is actually enabled.

Properly handle oscillator failures by returning -EINVAL when the time and
date are know to be incorrect and reset the flag when the time is set.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1347.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index 22a75b01f1ac..eeaf43586bce 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -29,6 +29,9 @@
 #define DS1347_STATUS_REG	0x17
 #define DS1347_CLOCK_BURST	0x3F
 
+#define DS1347_NEOSC_BIT	BIT(7)
+#define DS1347_OSF_BIT		BIT(2)
+
 static const struct regmap_range ds1347_ranges[] = {
 	{
 		.range_min = DS1347_SECONDS_REG,
@@ -44,9 +47,17 @@ static const struct regmap_access_table ds1347_access_table = {
 static int ds1347_read_time(struct device *dev, struct rtc_time *dt)
 {
 	struct regmap *map = dev_get_drvdata(dev);
+	unsigned int status;
 	int err;
 	unsigned char buf[8];
 
+	err = regmap_read(map, DS1347_STATUS_REG, &status);
+	if (err)
+		return err;
+
+	if (status & DS1347_OSF_BIT)
+		return -EINVAL;
+
 	err = regmap_bulk_read(map, DS1347_CLOCK_BURST, buf, 8);
 	if (err)
 		return err;
@@ -66,6 +77,12 @@ static int ds1347_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct regmap *map = dev_get_drvdata(dev);
 	unsigned char buf[8];
+	int err;
+
+	err = regmap_update_bits(map, DS1347_STATUS_REG,
+				 DS1347_NEOSC_BIT, DS1347_NEOSC_BIT);
+	if (err)
+		return err;
 
 	buf[0] = bin2bcd(dt->tm_sec);
 	buf[1] = bin2bcd(dt->tm_min);
@@ -82,7 +99,12 @@ static int ds1347_set_time(struct device *dev, struct rtc_time *dt)
 	buf[7] = bin2bcd(0x00);
 
 	/* write the rtc settings */
-	return regmap_bulk_write(map, DS1347_CLOCK_BURST, buf, 8);
+	err = regmap_bulk_write(map, DS1347_CLOCK_BURST, buf, 8);
+	if (err)
+		return err;
+
+	return regmap_update_bits(map, DS1347_STATUS_REG,
+				  DS1347_NEOSC_BIT | DS1347_OSF_BIT, 0);
 }
 
 static const struct rtc_class_ops ds1347_rtc_ops = {
@@ -123,12 +145,6 @@ static int ds1347_probe(struct spi_device *spi)
 	data = data & ~(1<<7);
 	regmap_write(map, DS1347_CONTROL_REG, data);
 
-	/* Enable the oscillator , disable the oscillator stop flag,
-	 and glitch filter to reduce current consumption */
-	regmap_read(map, DS1347_STATUS_REG, &data);
-	data = data & 0x1B;
-	regmap_write(map, DS1347_STATUS_REG, data);
-
 	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
-- 
2.21.0

