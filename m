Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD59218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfJGNr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:47:59 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42345 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfJGNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:47:32 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 28E1A24000E;
        Mon,  7 Oct 2019 13:47:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 04/10] rtc: ds1347: simplify getting .driver_data
Date:   Mon,  7 Oct 2019 15:47:18 +0200
Message-Id: <20191007134724.15505-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
References: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get 'driver_data' from 'struct device' directly. Going via spi_device is an
unnecessary step.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1347.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index 013c5df13765..06abf0b47e16 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -43,13 +43,10 @@ static const struct regmap_access_table ds1347_access_table = {
 
 static int ds1347_read_time(struct device *dev, struct rtc_time *dt)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct regmap *map;
+	struct regmap *map = dev_get_drvdata(dev);
 	int err;
 	unsigned char buf[8];
 
-	map = spi_get_drvdata(spi);
-
 	err = regmap_bulk_read(map, DS1347_CLOCK_BURST, buf, 8);
 	if (err)
 		return err;
@@ -67,12 +64,9 @@ static int ds1347_read_time(struct device *dev, struct rtc_time *dt)
 
 static int ds1347_set_time(struct device *dev, struct rtc_time *dt)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct regmap *map;
+	struct regmap *map = dev_get_drvdata(dev);
 	unsigned char buf[8];
 
-	map = spi_get_drvdata(spi);
-
 	buf[0] = bin2bcd(dt->tm_sec);
 	buf[1] = bin2bcd(dt->tm_min);
 	buf[2] = (bin2bcd(dt->tm_hour) & 0x3F);
-- 
2.21.0

