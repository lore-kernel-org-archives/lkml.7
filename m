Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17641ECE596
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3220867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfJGNsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:48:03 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47637 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:47:32 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 86F0E1BF213;
        Mon,  7 Oct 2019 13:47:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 03/10] rtc: ds1347: remove useless read
Date:   Mon,  7 Oct 2019 15:47:17 +0200
Message-Id: <20191007134724.15505-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
References: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS1347_SECONDS_REG is read at probe time but the value is simply discarded.
Remove that useless read.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1347.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index ab5533c7f99d..013c5df13765 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -102,7 +102,6 @@ static int ds1347_probe(struct spi_device *spi)
 	struct regmap_config config;
 	struct regmap *map;
 	unsigned int data;
-	int res;
 
 	memset(&config, 0, sizeof(config));
 	config.reg_bits = 8;
@@ -125,11 +124,6 @@ static int ds1347_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, map);
 
-	/* RTC Settings */
-	res = regmap_read(map, DS1347_SECONDS_REG, &data);
-	if (res)
-		return res;
-
 	/* Disable the write protect of rtc */
 	regmap_read(map, DS1347_CONTROL_REG, &data);
 	data = data & ~(1<<7);
-- 
2.21.0

