Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD8CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF4420665
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFTSel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:34:41 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38353 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfFTSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:34:40 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id F044B100002;
        Thu, 20 Jun 2019 18:34:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Dylan Howey <Dylan.Howey@tennantco.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: pcf2123: convert to devm_rtc_allocate_device
Date:   Thu, 20 Jun 2019 20:34:30 +0200
Message-Id: <20190620183433.30779-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2123.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index e8100af789ef..29e09ff57f89 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -411,14 +411,9 @@ static int pcf2123_probe(struct spi_device *spi)
 			(spi->max_speed_hz + 500) / 1000);
 
 	/* Finalize the initialization */
-	rtc = devm_rtc_device_register(&spi->dev, pcf2123_driver.driver.name,
-			&pcf2123_rtc_ops, THIS_MODULE);
-
-	if (IS_ERR(rtc)) {
-		dev_err(&spi->dev, "failed to register.\n");
-		ret = PTR_ERR(rtc);
-		goto kfree_exit;
-	}
+	rtc = devm_rtc_allocate_device(&spi->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
 	pdata->rtc = rtc;
 
@@ -438,7 +433,18 @@ static int pcf2123_probe(struct spi_device *spi)
 	 * support to this driver to generate interrupts more than once
 	 * per minute.
 	 */
-	pdata->rtc->uie_unsupported = 1;
+	rtc->uie_unsupported = 1;
+	rtc->ops = &pcf2123_rtc_ops;
+
+	ret = rtc_register_device(rtc);
+	if (ret)
+		return ret;
+
+	if (IS_ERR(rtc)) {
+		dev_err(&spi->dev, "failed to register.\n");
+		ret = PTR_ERR(rtc);
+		goto kfree_exit;
+	}
 
 	return 0;
 
-- 
2.21.0

