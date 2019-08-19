Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CC1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E61C22CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfHSS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:27:06 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36443 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfHSS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:27:02 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D5771200003;
        Mon, 19 Aug 2019 18:27:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 7/9] rtc: pcf2123: convert to devm_rtc_allocate_device
Date:   Mon, 19 Aug 2019 20:26:54 +0200
Message-Id: <20190819182656.29744-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182656.29744-1-alexandre.belloni@bootlin.com>
References: <20190819182656.29744-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver. Also remove the unecessary
error string as the core will already display error messages.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2123.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index aef02193dbcc..fd326fd2932e 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -408,17 +408,12 @@ static int pcf2123_probe(struct spi_device *spi)
 			(spi->max_speed_hz + 500) / 1000);
 
 	/* Finalize the initialization */
-	rtc = devm_rtc_device_register(&spi->dev, pcf2123_driver.driver.name,
-			&pcf2123_rtc_ops, THIS_MODULE);
-
-	if (IS_ERR(rtc)) {
-		dev_err(&spi->dev, "failed to register.\n");
+	rtc = devm_rtc_allocate_device(&spi->dev);
+	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
-	}
 
 	pcf2123->rtc = rtc;
 
-
 	/* Register alarm irq */
 	if (spi->irq > 0) {
 		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
@@ -435,7 +430,12 @@ static int pcf2123_probe(struct spi_device *spi)
 	 * support to this driver to generate interrupts more than once
 	 * per minute.
 	 */
-	pcf2123->rtc->uie_unsupported = 1;
+	rtc->uie_unsupported = 1;
+	rtc->ops = &pcf2123_rtc_ops;
+
+	ret = rtc_register_device(rtc);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.21.0

