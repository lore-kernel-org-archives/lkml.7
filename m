Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059F42083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfHNPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:10:14 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48095 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfHNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:10:12 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DC7F624000A;
        Wed, 14 Aug 2019 15:10:09 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 3/9] rtc: pcf2123: remove useless error path goto
Date:   Wed, 14 Aug 2019 17:09:56 +0200
Message-Id: <20190814151002.7324-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814151002.7324-1-alexandre.belloni@bootlin.com>
References: <20190814151002.7324-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_exit only returns ret, remove it. This also fixes the
devm_regmap_init_spi error case where the probe wouldn't actually fail
because ret is initialized to 0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2123.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 106d5a4cf9b8..2e2a14134346 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -389,10 +389,9 @@ static int pcf2123_probe(struct spi_device *spi)
 	dev_set_drvdata(&spi->dev, pcf2123);
 
 	pcf2123->map = devm_regmap_init_spi(spi, &pcf2123_regmap_config);
-
 	if (IS_ERR(pcf2123->map)) {
 		dev_err(&spi->dev, "regmap init failed.\n");
-		goto kfree_exit;
+		return PTR_ERR(pcf2123->map);
 	}
 
 	ret = pcf2123_rtc_read_time(&spi->dev, &tm);
@@ -400,7 +399,7 @@ static int pcf2123_probe(struct spi_device *spi)
 		ret = pcf2123_reset(&spi->dev);
 		if (ret < 0) {
 			dev_err(&spi->dev, "chip not found\n");
-			goto kfree_exit;
+			return ret;
 		}
 	}
 
@@ -413,8 +412,7 @@ static int pcf2123_probe(struct spi_device *spi)
 
 	if (IS_ERR(rtc)) {
 		dev_err(&spi->dev, "failed to register.\n");
-		ret = PTR_ERR(rtc);
-		goto kfree_exit;
+		return PTR_ERR(rtc);
 	}
 
 	pcf2123->rtc = rtc;
@@ -439,9 +437,6 @@ static int pcf2123_probe(struct spi_device *spi)
 	pcf2123->rtc->uie_unsupported = 1;
 
 	return 0;
-
-kfree_exit:
-	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.21.0

