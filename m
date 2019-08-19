Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D27C3A5A3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079EC22CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfHSS1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:27:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38507 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfHSS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:27:01 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 65A6B240004;
        Mon, 19 Aug 2019 18:27:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 6/9] rtc: pcf2123: remove useless error path goto
Date:   Mon, 19 Aug 2019 20:26:53 +0200
Message-Id: <20190819182656.29744-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182656.29744-1-alexandre.belloni@bootlin.com>
References: <20190819182656.29744-1-alexandre.belloni@bootlin.com>
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
index df20dd229140..aef02193dbcc 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -390,10 +390,9 @@ static int pcf2123_probe(struct spi_device *spi)
 	dev_set_drvdata(&spi->dev, pcf2123);
 
 	pcf2123->map = devm_regmap_init_spi(spi, &pcf2123_regmap_config);
-
 	if (IS_ERR(pcf2123->map)) {
 		dev_err(&spi->dev, "regmap init failed.\n");
-		goto kfree_exit;
+		return PTR_ERR(pcf2123->map);
 	}
 
 	ret = pcf2123_rtc_read_time(&spi->dev, &tm);
@@ -401,7 +400,7 @@ static int pcf2123_probe(struct spi_device *spi)
 		ret = pcf2123_reset(&spi->dev);
 		if (ret < 0) {
 			dev_err(&spi->dev, "chip not found\n");
-			goto kfree_exit;
+			return ret;
 		}
 	}
 
@@ -414,8 +413,7 @@ static int pcf2123_probe(struct spi_device *spi)
 
 	if (IS_ERR(rtc)) {
 		dev_err(&spi->dev, "failed to register.\n");
-		ret = PTR_ERR(rtc);
-		goto kfree_exit;
+		return PTR_ERR(rtc);
 	}
 
 	pcf2123->rtc = rtc;
@@ -440,9 +438,6 @@ static int pcf2123_probe(struct spi_device *spi)
 	pcf2123->rtc->uie_unsupported = 1;
 
 	return 0;
-
-kfree_exit:
-	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.21.0

