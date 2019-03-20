Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A61C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E89213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCTMkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:40:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59057 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfCTMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:40:51 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8A04C1C0009;
        Wed, 20 Mar 2019 12:40:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/6] rtc: at91sam9: drop platform_data support
Date:   Wed, 20 Mar 2019 13:40:37 +0100
Message-Id: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_AT91 is DT only for a while, drop platform data support.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig        |  2 +-
 drivers/rtc/rtc-at91sam9.c | 44 +++++++-------------------------------
 2 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7555fd344ff0..fa5638269b33 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1432,7 +1432,7 @@ config RTC_DRV_AT91RM9200
 config RTC_DRV_AT91SAM9
 	tristate "AT91SAM9 RTT as RTC"
 	depends on ARCH_AT91 || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on OF && HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 1d31c0ae6334..7ec114b59513 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -340,13 +340,6 @@ static const struct rtc_class_ops at91_rtc_ops = {
 	.alarm_irq_enable = at91_rtc_alarm_irq_enable,
 };
 
-static const struct regmap_config gpbr_regmap_config = {
-	.name = "gpbr",
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
-
 /*
  * Initialize and install RTC driver
  */
@@ -357,6 +350,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	int		ret, irq;
 	u32		mr;
 	unsigned int	sclk_rate;
+	struct of_phandle_args args;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -382,34 +376,14 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->rtt))
 		return PTR_ERR(rtc->rtt);
 
-	if (!pdev->dev.of_node) {
-		/*
-		 * TODO: Remove this code chunk when removing non DT board
-		 * support. Remember to remove the gpbr_regmap_config
-		 * variable too.
-		 */
-		void __iomem *gpbr;
-
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		gpbr = devm_ioremap_resource(&pdev->dev, r);
-		if (IS_ERR(gpbr))
-			return PTR_ERR(gpbr);
-
-		rtc->gpbr = regmap_init_mmio(NULL, gpbr,
-					     &gpbr_regmap_config);
-	} else {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
-						"atmel,rtt-rtc-time-reg", 1, 0,
-						&args);
-		if (ret)
-			return ret;
-
-		rtc->gpbr = syscon_node_to_regmap(args.np);
-		rtc->gpbr_offset = args.args[0];
-	}
+	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+					"atmel,rtt-rtc-time-reg", 1, 0,
+					&args);
+	if (ret)
+		return ret;
 
+	rtc->gpbr = syscon_node_to_regmap(args.np);
+	rtc->gpbr_offset = args.args[0];
 	if (IS_ERR(rtc->gpbr)) {
 		dev_err(&pdev->dev, "failed to retrieve gpbr regmap, aborting.\n");
 		return -ENOMEM;
@@ -561,13 +535,11 @@ static int at91_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(at91_rtc_pm_ops, at91_rtc_suspend, at91_rtc_resume);
 
-#ifdef CONFIG_OF
 static const struct of_device_id at91_rtc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-rtt" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
-#endif
 
 static struct platform_driver at91_rtc_driver = {
 	.probe		= at91_rtc_probe,
-- 
2.20.1

