Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6932A2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfJUP6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:58:12 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49289 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:58:10 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5258A100010;
        Mon, 21 Oct 2019 15:58:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: lpc32xx: remove .remove
Date:   Mon, 21 Oct 2019 17:58:04 +0200
Message-Id: <20191021155806.3625-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021155806.3625-1-alexandre.belloni@bootlin.com>
References: <20191021155806.3625-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpm_sysfs_remove() and device_pm_remove() are already called by
device_del() on device removal so there is no need to call
device_init_wakeup(dev, false) from the driver and it allows to remove the
.remove callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lpc32xx.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index b6a0d4a182bf..15d8abda81fe 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -264,16 +264,6 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lpc32xx_rtc_remove(struct platform_device *pdev)
-{
-	struct lpc32xx_rtc *rtc = platform_get_drvdata(pdev);
-
-	if (rtc->irq >= 0)
-		device_init_wakeup(&pdev->dev, 0);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int lpc32xx_rtc_suspend(struct device *dev)
 {
@@ -355,7 +345,6 @@ MODULE_DEVICE_TABLE(of, lpc32xx_rtc_match);
 
 static struct platform_driver lpc32xx_rtc_driver = {
 	.probe		= lpc32xx_rtc_probe,
-	.remove		= lpc32xx_rtc_remove,
 	.driver = {
 		.name	= "rtc-lpc32xx",
 		.pm	= LPC32XX_RTC_PM_OPS,
-- 
2.21.0

