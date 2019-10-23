Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01093CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9412086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ACQWP5bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfJWRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:47:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38610 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbfJWRra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1571852842; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw3H1n/jwcizL4RpISfM0SdzIvSyZlZQ0uvl9RUxxmY=;
        b=ACQWP5bswURj4+7m8A/P2HKfDw8ZLi66nwwPGX5eqAO8moTK84ZJyHaKTdUO1wC1thnmso
        s9hXu1fcvi1b8cbRyTfs35Aedvlnnxr4hPwydj1KX8cWkijGzCJwTQU0aweDLcu29HD4sv
        4glwlia1Hh4LFTMFRdRqsSJ4Q+NvGbM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/3] watchdog: jz4740: Use regmap provided by TCU driver
Date:   Wed, 23 Oct 2019 19:47:13 +0200
Message-Id: <20191023174714.14362-2-paul@crapouillou.net>
In-Reply-To: <20191023174714.14362-1-paul@crapouillou.net>
References: <20191023174714.14362-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we broke the ABI by changing the clock, the driver was also
updated to use the regmap provided by the TCU driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
    v2: Rebase on top of 5.4-rc4

 drivers/watchdog/Kconfig      |  1 +
 drivers/watchdog/jz4740_wdt.c | 35 ++++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6421187769cf..dbef995856bf 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1644,6 +1644,7 @@ config JZ4740_WDT
 	depends on MACH_JZ4740 || MACH_JZ4780
 	depends on COMMON_CLK
 	select WATCHDOG_CORE
+	select MFD_SYSCON
 	help
 	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
 
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 72920f09f4a7..bdf9564efa29 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/mfd/ingenic-tcu.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -17,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #define DEFAULT_HEARTBEAT 5
 #define MAX_HEARTBEAT     2048
@@ -36,7 +38,7 @@ MODULE_PARM_DESC(heartbeat,
 
 struct jz4740_wdt_drvdata {
 	struct watchdog_device wdt;
-	void __iomem *base;
+	struct regmap *map;
 	struct clk *clk;
 	unsigned long clk_rate;
 };
@@ -45,7 +47,8 @@ static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writew(0x0, drvdata->base + TCU_REG_WDT_TCNT);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
+
 	return 0;
 }
 
@@ -54,16 +57,16 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
-	u8 tcer;
+	unsigned int tcer;
 
-	tcer = readb(drvdata->base + TCU_REG_WDT_TCER);
-	writeb(0x0, drvdata->base + TCU_REG_WDT_TCER);
+	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
-	writew((u16)timeout_value, drvdata->base + TCU_REG_WDT_TDR);
-	writew(0x0, drvdata->base + TCU_REG_WDT_TCNT);
+	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
 	if (tcer & TCU_WDT_TCER_TCEN)
-		writeb(TCU_WDT_TCER_TCEN, drvdata->base + TCU_REG_WDT_TCER);
+		regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	wdt_dev->timeout = new_timeout;
 	return 0;
@@ -72,20 +75,20 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+	unsigned int tcer;
 	int ret;
-	u8 tcer;
 
 	ret = clk_prepare_enable(drvdata->clk);
 	if (ret)
 		return ret;
 
-	tcer = readb(drvdata->base + TCU_REG_WDT_TCER);
+	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
 
 	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
 
 	/* Start watchdog if it wasn't started already */
 	if (!(tcer & TCU_WDT_TCER_TCEN))
-		writeb(TCU_WDT_TCER_TCEN, drvdata->base + TCU_REG_WDT_TCER);
+		regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	return 0;
 }
@@ -94,7 +97,7 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writeb(0x0, drvdata->base + TCU_REG_WDT_TCER);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 	clk_disable_unprepare(drvdata->clk);
 
 	return 0;
@@ -172,9 +175,11 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
-	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(drvdata->base))
-		return PTR_ERR(drvdata->base);
+	drvdata->map = device_node_to_regmap(dev->parent->of_node);
+	if (!drvdata->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
 
 	return devm_watchdog_register_device(dev, &drvdata->wdt);
 }
-- 
2.23.0

