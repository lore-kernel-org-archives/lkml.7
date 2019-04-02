Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C5C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F58E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEJLt3ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfDBTCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:02:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34155 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfDBTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:02:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so7033878pgq.1;
        Tue, 02 Apr 2019 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=iqq8ncZ5ErnSYdXfiX5I/XJ0LgfGRBFZZ7vcHkNk8TU=;
        b=JEJLt3ETRjznPRoC70wiBzMIFKUEutHHTbAAWTisj00w2J4dzaJ4aDiGoCQOUVxcDg
         6iACcM6Itv7wBfd6CVjk5LK6fnyGmYOtMxSDAoQDtGuHobZBr4X0l5vY0lcJeWHb2nYB
         WbTpZvxoXP3ZP6fsIZLwCDfKaF/yL/GUGESL/durel9yp5BHeCUoSQdYRA7SW6FyZmTR
         QOy+kBRVNAllZ0lXjlM8s609BatDyJIWc2ZnWlCsulB5tTWA1o+jzMgniOOEw3JeHXpO
         3owdQiCfQMTcsYAh5gmLZMIONrSIL3FUND3pFchVrOfwhIuIFHNH+6eN9SvsiVdpiKhL
         4/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=iqq8ncZ5ErnSYdXfiX5I/XJ0LgfGRBFZZ7vcHkNk8TU=;
        b=pnEjfdl38T+9TfN4Zg/Nv2DMeunrqil4mNaKSA2VAsPYYupHZZJde2f29wbNMIvFiS
         oYkGJodhhz98cC50oeuaMFWHpTkBkRlTKiD83nZMV8w4ssjGyJa6YkRgVWkWLvPm+qlS
         QiM8h03Rjvd0iSnbr6blalRCglZpDgER/svDkQM/GI14DYXGZ+IxNic8K3tL5dVGNBZC
         uwjKTPWzHu95cUs7uPjsX280A7XE5rN2wRU6YyMe2v/QCDahPXNlT2b8UODLWx/NHxE/
         xmHWrPZ92kNrN+mmsRHJWmyWgjh1+GHewKg0VTvQDXTBgGqa6hcIJpY83GtwfdSgn+kC
         Hz8Q==
X-Gm-Message-State: APjAAAX4TaVs+CFO8WMzKNewqv+9Z5vjXZSJAbvAsfGJ7AXO3TNrDS9J
        he1JXGcy4HMrND4M3gdH5S2entxw
X-Google-Smtp-Source: APXvYqxAsBJjzvCDy/25ZxrzL+1wV+FLyJaG8jEUaEvxEzgm4VUWr3cmSepzY98aO/7Q0EHh3TMNaA==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr13218857pff.203.1554231718970;
        Tue, 02 Apr 2019 12:01:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3sm23948176pfn.167.2019.04.02.12.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:01:57 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
Date:   Tue,  2 Apr 2019 12:01:53 -0700
Message-Id: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource to reduce source code size,
improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patch.

@r@
identifier res, pdev;
expression a;
expression index;
expression e;
@@

<+...
- res = platform_get_resource(pdev, IORESOURCE_MEM, index);
- a = devm_ioremap_resource(e, res);
+ a = devm_platform_ioremap_resource(pdev, index);
...+>

@depends on r@
identifier r.res;
@@
- struct resource *res;
  ... when != res

@@
identifier res, pdev;
expression index;
expression a;
@@
- struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, index);
- a = devm_ioremap_resource(&pdev->dev, res);
+ a = devm_platform_ioremap_resource(pdev, index);

Cc: Joel Stanley <joel@jms.id.au>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/asm9260_wdt.c    | 4 +---
 drivers/watchdog/aspeed_wdt.c     | 4 +---
 drivers/watchdog/at91sam9_wdt.c   | 4 +---
 drivers/watchdog/ath79_wdt.c      | 4 +---
 drivers/watchdog/atlas7_wdt.c     | 4 +---
 drivers/watchdog/bcm7038_wdt.c    | 4 +---
 drivers/watchdog/bcm_kona_wdt.c   | 4 +---
 drivers/watchdog/cadence_wdt.c    | 4 +---
 drivers/watchdog/coh901327_wdt.c  | 4 +---
 drivers/watchdog/davinci_wdt.c    | 4 +---
 drivers/watchdog/digicolor_wdt.c  | 4 +---
 drivers/watchdog/dw_wdt.c         | 4 +---
 drivers/watchdog/ep93xx_wdt.c     | 4 +---
 drivers/watchdog/ftwdt010_wdt.c   | 4 +---
 drivers/watchdog/imgpdc_wdt.c     | 4 +---
 drivers/watchdog/jz4740_wdt.c     | 4 +---
 drivers/watchdog/lantiq_wdt.c     | 4 +---
 drivers/watchdog/loongson1_wdt.c  | 4 +---
 drivers/watchdog/lpc18xx_wdt.c    | 4 +---
 drivers/watchdog/max63xx_wdt.c    | 4 +---
 drivers/watchdog/meson_gxbb_wdt.c | 4 +---
 drivers/watchdog/meson_wdt.c      | 4 +---
 drivers/watchdog/moxart_wdt.c     | 4 +---
 drivers/watchdog/mpc8xxx_wdt.c    | 3 +--
 drivers/watchdog/mt7621_wdt.c     | 5 +----
 drivers/watchdog/mtk_wdt.c        | 4 +---
 drivers/watchdog/npcm_wdt.c       | 4 +---
 drivers/watchdog/nuc900_wdt.c     | 4 +---
 drivers/watchdog/of_xilinx_wdt.c  | 4 +---
 drivers/watchdog/omap_wdt.c       | 4 +---
 drivers/watchdog/orion_wdt.c      | 6 ++----
 drivers/watchdog/pic32-dmt.c      | 4 +---
 drivers/watchdog/pic32-wdt.c      | 4 +---
 drivers/watchdog/pnx4008_wdt.c    | 4 +---
 drivers/watchdog/renesas_wdt.c    | 4 +---
 drivers/watchdog/rt2880_wdt.c     | 4 +---
 drivers/watchdog/rtd119x_wdt.c    | 4 +---
 drivers/watchdog/rza_wdt.c        | 4 +---
 drivers/watchdog/s3c2410_wdt.c    | 4 +---
 drivers/watchdog/sama5d4_wdt.c    | 4 +---
 drivers/watchdog/sbsa_gwdt.c      | 7 ++-----
 drivers/watchdog/shwdt.c          | 4 +---
 drivers/watchdog/sirfsoc_wdt.c    | 4 +---
 drivers/watchdog/sprd_wdt.c       | 4 +---
 drivers/watchdog/st_lpc_wdt.c     | 4 +---
 drivers/watchdog/stm32_iwdg.c     | 4 +---
 drivers/watchdog/sunxi_wdt.c      | 4 +---
 drivers/watchdog/tangox_wdt.c     | 4 +---
 drivers/watchdog/tegra_wdt.c      | 4 +---
 drivers/watchdog/ts72xx_wdt.c     | 7 ++-----
 drivers/watchdog/txx9wdt.c        | 4 +---
 drivers/watchdog/zx2967_wdt.c     | 4 +---
 52 files changed, 55 insertions(+), 161 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 9768e44ffeb8..1de272bb2070 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -276,7 +276,6 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 {
 	struct asm9260_wdt_priv *priv;
 	struct watchdog_device *wdd;
-	struct resource *res;
 	int ret;
 	static const char * const mode_name[] = { "hw", "sw", "debug", };
 
@@ -287,8 +286,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->iobase = devm_ioremap_resource(&pdev->dev, res);
+	priv->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1abe4d021fd2..f09333fd54b4 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -190,7 +190,6 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const struct aspeed_wdt_config *config;
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
-	struct resource *res;
 	struct device_node *np;
 	const char *reset_type;
 	u32 duration;
@@ -201,8 +200,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index f4050a229eb5..292b5a1ca831 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -327,7 +327,6 @@ static inline int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
 
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
-	struct resource	*r;
 	int err;
 	struct at91wdt *wdt;
 
@@ -346,8 +345,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0xFFFF;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(&pdev->dev, r);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e2209bf5fa8a..5d66c8ec9a7d 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -250,15 +250,13 @@ static struct miscdevice ath79_wdt_miscdev = {
 
 static int ath79_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	u32 ctrl;
 	int err;
 
 	if (wdt_base)
 		return -EBUSY;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
index 4abdcabd8219..e170933aa0a8 100644
--- a/drivers/watchdog/atlas7_wdt.c
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -129,15 +129,13 @@ static int atlas7_wdt_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct atlas7_wdog *wdt;
-	struct resource *res;
 	struct clk *clk;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index ce3f646e8077..71fca45eab5d 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -111,7 +111,6 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm7038_watchdog *wdt;
-	struct resource *res;
 	int err;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -120,8 +119,7 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(dev, res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 4249b47902bd..d52334ab0805 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -280,7 +280,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm_kona_wdt *wdt;
-	struct resource *res;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -289,8 +288,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(dev, res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return -ENODEV;
 
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index c3924356d173..5986f18f97e2 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -285,7 +285,6 @@ static const struct watchdog_ops cdns_wdt_ops = {
  */
 static int cdns_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret, irq;
 	unsigned long clock_f;
 	struct cdns_wdt *wdt;
@@ -302,8 +301,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	cdns_wdt_device->min_timeout = CDNS_WDT_MIN_TIMEOUT;
 	cdns_wdt_device->max_timeout = CDNS_WDT_MAX_TIMEOUT;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->regs = devm_ioremap_resource(&pdev->dev, res);
+	wdt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->regs))
 		return PTR_ERR(wdt->regs);
 
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index f29d1edc5bad..3c4eaa0d1178 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -258,12 +258,10 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 	u16 val;
-	struct resource *res;
 
 	parent = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virtbase = devm_ioremap_resource(dev, res);
+	virtbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(virtbase))
 		return PTR_ERR(virtbase);
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index ebb85d60b6d5..7daa15df74a5 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -195,7 +195,6 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct device *dev = &pdev->dev;
-	struct resource  *wdt_mem;
 	struct watchdog_device *wdd;
 	struct davinci_wdt_device *davinci_wdt;
 
@@ -235,8 +234,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdd, 1);
 	watchdog_set_restart_priority(wdd, 128);
 
-	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	davinci_wdt->base = devm_ioremap_resource(dev, wdt_mem);
+	davinci_wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(davinci_wdt->base)) {
 		ret = PTR_ERR(davinci_wdt->base);
 		goto err_clk_disable;
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index a9e11df155b8..8af6e9a67d0d 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -116,7 +116,6 @@ static struct watchdog_device dc_wdt_wdd = {
 
 static int dc_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct dc_wdt *wdt;
 	int ret;
@@ -125,8 +124,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(dev, res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index aa95f57cc1c3..39e43750ab08 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -238,15 +238,13 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct dw_wdt *dw_wdt;
-	struct resource *mem;
 	int ret;
 
 	dw_wdt = devm_kzalloc(dev, sizeof(*dw_wdt), GFP_KERNEL);
 	if (!dw_wdt)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dw_wdt->regs = devm_ioremap_resource(dev, mem);
+	dw_wdt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dw_wdt->regs))
 		return PTR_ERR(dw_wdt->regs);
 
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index f9b14e6efd9a..1e721c2f9eac 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -91,7 +91,6 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 {
 	struct ep93xx_wdt_priv *priv;
 	struct watchdog_device *wdd;
-	struct resource *res;
 	unsigned long val;
 	int ret;
 
@@ -99,8 +98,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->mmio = devm_ioremap_resource(&pdev->dev, res);
+	priv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->mmio))
 		return PTR_ERR(priv->mmio);
 
diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index a9c2912ee280..ecb32c42e839 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -124,7 +124,6 @@ static const struct watchdog_info ftwdt010_wdt_info = {
 static int ftwdt010_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct ftwdt010_wdt *gwdt;
 	unsigned int reg;
 	int irq;
@@ -134,8 +133,7 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
 	if (!gwdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gwdt->base = devm_ioremap_resource(dev, res);
+	gwdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gwdt->base))
 		return PTR_ERR(gwdt->base);
 
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index a3134ffa59f8..84c9fb905072 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -183,15 +183,13 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	u64 div;
 	int ret, val;
 	unsigned long clk_rate;
-	struct resource *res;
 	struct pdc_wdt_dev *pdc_wdt;
 
 	pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
 	if (!pdc_wdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	pdc_wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdc_wdt->base))
 		return PTR_ERR(pdc_wdt->base);
 
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index ec4d99a830ba..aa9d3523addd 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -165,7 +165,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata;
 	struct watchdog_device *jz4740_wdt;
-	struct resource	*res;
 	int ret;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
@@ -186,8 +185,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 83da84d6074b..4caf02ba5d49 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -203,7 +203,6 @@ static int ltq_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ltq_wdt_priv *priv;
 	struct watchdog_device *wdt;
-	struct resource *res;
 	struct clk *clk;
 	const struct ltq_wdt_hw *ltq_wdt_hw;
 	int ret;
@@ -213,8 +212,7 @@ static int ltq_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->membase = devm_ioremap_resource(dev, res);
+	priv->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->membase))
 		return PTR_ERR(priv->membase);
 
diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 3aee50c64a36..1119634b5c87 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -88,15 +88,13 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	struct ls1x_wdt_drvdata *drvdata;
 	struct watchdog_device *ls1x_wdt;
 	unsigned long clk_rate;
-	struct resource *res;
 	int err;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 331cadb459ac..f6f66634cedf 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -204,15 +204,13 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
 	lpc18xx_wdt = devm_kzalloc(dev, sizeof(*lpc18xx_wdt), GFP_KERNEL);
 	if (!lpc18xx_wdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	lpc18xx_wdt->base = devm_ioremap_resource(dev, res);
+	lpc18xx_wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_wdt->base))
 		return PTR_ERR(lpc18xx_wdt->base);
 
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index bf6a068245ba..5aaf13e5115a 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -187,9 +187,7 @@ static void max63xx_mmap_set(struct max63xx_wdt *wdt, u8 set)
 
 static int max63xx_mmap_init(struct platform_device *p, struct max63xx_wdt *wdt)
 {
-	struct resource *mem = platform_get_resource(p, IORESOURCE_MEM, 0);
-
-	wdt->base = devm_ioremap_resource(&p->dev, mem);
+	wdt->base = devm_platform_ioremap_resource(p, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 69adeab3fde7..a8ed75cc9a6e 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -139,15 +139,13 @@ MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
 static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 {
 	struct meson_gxbb_wdt *data;
-	struct resource *res;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	data->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->reg_base))
 		return PTR_ERR(data->reg_base);
 
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index cd0275a6cdac..7fc6acb33c7f 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -164,7 +164,6 @@ MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
 
 static int meson_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct meson_wdt_dev *meson_wdt;
 	const struct of_device_id *of_id;
 	int err;
@@ -173,8 +172,7 @@ static int meson_wdt_probe(struct platform_device *pdev)
 	if (!meson_wdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	meson_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	meson_wdt->wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson_wdt->wdt_base))
 		return PTR_ERR(meson_wdt->wdt_base);
 
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 430c3ab84c07..740215a247fc 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -92,7 +92,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	struct moxart_wdt_dev *moxart_wdt;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	struct clk *clk;
 	int err;
 	unsigned int max_timeout;
@@ -104,8 +103,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, moxart_wdt);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	moxart_wdt->base = devm_ioremap_resource(dev, res);
+	moxart_wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(moxart_wdt->base))
 		return PTR_ERR(moxart_wdt->base);
 
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 069072e6747d..3b5b446b690c 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -149,8 +149,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	if (!ddata)
 		return -ENOMEM;
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	ddata->base = devm_ioremap_resource(dev, res);
+	ddata->base = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(ddata->base))
 		return PTR_ERR(ddata->base);
 
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 81208cd3f4ec..9c943f1d57ec 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -133,10 +133,7 @@ static struct watchdog_device mt7621_wdt_dev = {
 
 static int mt7621_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mt7621_wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	mt7621_wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mt7621_wdt_base))
 		return PTR_ERR(mt7621_wdt_base);
 
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 4baf64f21aa1..113a48d54058 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -154,7 +154,6 @@ static const struct watchdog_ops mtk_wdt_ops = {
 static int mtk_wdt_probe(struct platform_device *pdev)
 {
 	struct mtk_wdt_dev *mtk_wdt;
-	struct resource *res;
 	int err;
 
 	mtk_wdt = devm_kzalloc(&pdev->dev, sizeof(*mtk_wdt), GFP_KERNEL);
@@ -163,8 +162,7 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mtk_wdt);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mtk_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	mtk_wdt->wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mtk_wdt->wdt_base))
 		return PTR_ERR(mtk_wdt->wdt_base);
 
diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 0d4213652ecc..4fce10c145c2 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -181,7 +181,6 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct npcm_wdt *wdt;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -189,8 +188,7 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->reg = devm_ioremap_resource(dev, res);
+	wdt->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->reg))
 		return PTR_ERR(wdt->reg);
 
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index 830bd04ff911..74e99eac90b9 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -242,7 +242,6 @@ static struct miscdevice nuc900wdt_miscdev = {
 
 static int nuc900wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret = 0;
 
 	nuc900_wdt = devm_kzalloc(&pdev->dev, sizeof(*nuc900_wdt),
@@ -254,8 +253,7 @@ static int nuc900wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&nuc900_wdt->wdt_lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nuc900_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	nuc900_wdt->wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(nuc900_wdt->wdt_base))
 		return PTR_ERR(nuc900_wdt->wdt_base);
 
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index d3f7eb046678..5c977164b3e5 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -155,7 +155,6 @@ static int xwdt_probe(struct platform_device *pdev)
 {
 	int rc;
 	u32 pfreq = 0, enable_once = 0;
-	struct resource *res;
 	struct xwdt_device *xdev;
 	struct watchdog_device *xilinx_wdt_wdd;
 
@@ -168,8 +167,7 @@ static int xwdt_probe(struct platform_device *pdev)
 	xilinx_wdt_wdd->ops = &xilinx_wdt_ops;
 	xilinx_wdt_wdd->parent = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xdev->base = devm_ioremap_resource(&pdev->dev, res);
+	xdev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xdev->base))
 		return PTR_ERR(xdev->base);
 
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index cbd752f9ac56..d49688d93f6a 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -231,7 +231,6 @@ static const struct watchdog_ops omap_wdt_ops = {
 static int omap_wdt_probe(struct platform_device *pdev)
 {
 	struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *res;
 	struct omap_wdt_dev *wdev;
 	int ret;
 
@@ -245,8 +244,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	mutex_init(&wdev->lock);
 
 	/* reserve static register mappings */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdev->base = devm_ioremap_resource(&pdev->dev, res);
+	wdev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdev->base))
 		return PTR_ERR(wdev->base);
 
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 8b259c712c52..cdb0d174c5e2 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -494,8 +494,7 @@ static int orion_wdt_get_regs(struct platform_device *pdev,
 		   of_device_is_compatible(node, "marvell,armada-xp-wdt")) {
 
 		/* Dedicated RSTOUT register, can be requested. */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		dev->rstout = devm_ioremap_resource(&pdev->dev, res);
+		dev->rstout = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(dev->rstout))
 			return PTR_ERR(dev->rstout);
 
@@ -503,8 +502,7 @@ static int orion_wdt_get_regs(struct platform_device *pdev,
 		   of_device_is_compatible(node, "marvell,armada-380-wdt")) {
 
 		/* Dedicated RSTOUT register, can be requested. */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		dev->rstout = devm_ioremap_resource(&pdev->dev, res);
+		dev->rstout = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(dev->rstout))
 			return PTR_ERR(dev->rstout);
 
diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index c797305f8338..052751c224fd 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -172,15 +172,13 @@ static int pic32_dmt_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct pic32_dmt *dmt;
-	struct resource *mem;
 	struct watchdog_device *wdd = &pic32_dmt_wdd;
 
 	dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
 	if (!dmt)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmt->regs = devm_ioremap_resource(&pdev->dev, mem);
+	dmt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmt->regs))
 		return PTR_ERR(dmt->regs);
 
diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index e2761068dc6f..455ec38363a6 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -171,14 +171,12 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 	int ret;
 	struct watchdog_device *wdd = &pic32_wdd;
 	struct pic32_wdt *wdt;
-	struct resource *mem;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->regs = devm_ioremap_resource(&pdev->dev, mem);
+	wdt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->regs))
 		return PTR_ERR(wdt->regs);
 
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 8e261799c84e..24c266a9e1dc 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -185,13 +185,11 @@ static struct watchdog_device pnx4008_wdd = {
 
 static int pnx4008_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *r;
 	int ret = 0;
 
 	watchdog_init_timeout(&pnx4008_wdd, heartbeat, &pdev->dev);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt_base = devm_ioremap_resource(&pdev->dev, r);
+	wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 622ede529912..5b3186492087 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -177,7 +177,6 @@ static inline bool rwdt_blacklisted(struct device *dev) { return false; }
 static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
-	struct resource *res;
 	struct clk *clk;
 	unsigned long clks_per_sec;
 	int ret, i;
@@ -189,8 +188,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index db7c57d82cfd..4adf5f39fdd9 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -141,11 +141,9 @@ static struct watchdog_device rt288x_wdt_dev = {
 
 static int rt288x_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rt288x_wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	rt288x_wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rt288x_wdt_base))
 		return PTR_ERR(rt288x_wdt_base);
 
diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index d001c17ddfde..d823c9def36f 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -98,15 +98,13 @@ static const struct of_device_id rtd119x_wdt_dt_ids[] = {
 static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
 	struct rtd119x_watchdog_device *data;
-	struct resource *res;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index 781bb572e6af..b854f0aeb3ef 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -167,7 +167,6 @@ static const struct watchdog_ops rza_wdt_ops = {
 static int rza_wdt_probe(struct platform_device *pdev)
 {
 	struct rza_wdt *priv;
-	struct resource *res;
 	unsigned long rate;
 	int ret;
 
@@ -175,8 +174,7 @@ static int rza_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index adaa43543f0a..4267b9e8734b 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -522,7 +522,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct s3c2410_wdt *wdt;
-	struct resource *wdt_mem;
 	struct resource *wdt_irq;
 	unsigned int wtcon;
 	int started = 0;
@@ -554,8 +553,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	}
 
 	/* get the memory region for the watchdog timer */
-	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->reg_base = devm_ioremap_resource(dev, wdt_mem);
+	wdt->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->reg_base)) {
 		ret = PTR_ERR(wdt->reg_base);
 		goto err;
diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 1e93c1b0e3cf..ea72fa0aa3ec 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -201,7 +201,6 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 {
 	struct watchdog_device *wdd;
 	struct sama5d4_wdt *wdt;
-	struct resource *res;
 	void __iomem *regs;
 	u32 irq = 0;
 	u32 timeout;
@@ -221,8 +220,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, wdt);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e8bd9887c566..68aff828bf7e 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -231,7 +231,6 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct sbsa_gwdt *gwdt;
-	struct resource *res;
 	int ret, irq;
 	u32 status;
 
@@ -240,13 +239,11 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, gwdt);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cf_base = devm_ioremap_resource(dev, res);
+	cf_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cf_base))
 		return PTR_ERR(cf_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	rf_base = devm_ioremap_resource(dev, res);
+	rf_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(rf_base))
 		return PTR_ERR(rf_base);
 
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index a7d6425db807..e7617b7df70b 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -220,7 +220,6 @@ static struct watchdog_device sh_wdt_dev = {
 static int sh_wdt_probe(struct platform_device *pdev)
 {
 	struct sh_wdt *wdt;
-	struct resource *res;
 	int rc;
 
 	/*
@@ -245,8 +244,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 		wdt->clk = NULL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(wdt->dev, res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index ac0c9d2c4aee..2559062d35da 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -146,12 +146,10 @@ static struct watchdog_device sirfsoc_wdd = {
 
 static int sirfsoc_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret;
 	void __iomem *base;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index ff9397d9638a..a63163a93777 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -269,7 +269,6 @@ static const struct watchdog_info sprd_wdt_info = {
 
 static int sprd_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *wdt_res;
 	struct sprd_wdt *wdt;
 	int ret;
 
@@ -277,8 +276,7 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(&pdev->dev, wdt_res);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 177829b379da..196fb4b72c5d 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -148,7 +148,6 @@ static int st_wdog_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct st_wdog *st_wdog;
 	struct regmap *regmap;
-	struct resource *res;
 	struct clk *clk;
 	void __iomem *base;
 	uint32_t mode;
@@ -175,8 +174,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 	}
 	st_wdog->syscfg	= (struct st_wdog_syscfg *)match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index e00e3b3526c6..309563e002b8 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -202,7 +202,6 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	struct watchdog_device *wdd;
 	const struct of_device_id *match;
 	struct stm32_iwdg *wdt;
-	struct resource *res;
 	int ret;
 
 	match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
@@ -216,8 +215,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdt->has_pclk = match->data;
 
 	/* This is the timer base. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->regs = devm_ioremap_resource(&pdev->dev, res);
+	wdt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->regs)) {
 		dev_err(&pdev->dev, "Could not get resource\n");
 		return PTR_ERR(wdt->regs);
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index c6c73656997e..f0e7ef40b1e4 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
 static int sunxi_wdt_probe(struct platform_device *pdev)
 {
 	struct sunxi_wdt_dev *sunxi_wdt;
-	struct resource *res;
 	int err;
 
 	sunxi_wdt = devm_kzalloc(&pdev->dev, sizeof(*sunxi_wdt), GFP_KERNEL);
@@ -245,8 +244,7 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	if (!sunxi_wdt->wdt_regs)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sunxi_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	sunxi_wdt->wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sunxi_wdt->wdt_base))
 		return PTR_ERR(sunxi_wdt->wdt_base);
 
diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index d0b53f3c0d17..16611fe0d9d1 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -111,7 +111,6 @@ static const struct watchdog_ops tangox_wdt_ops = {
 static int tangox_wdt_probe(struct platform_device *pdev)
 {
 	struct tangox_wdt_device *dev;
-	struct resource *res;
 	u32 config;
 	int err;
 
@@ -119,8 +118,7 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dev->base = devm_ioremap_resource(&pdev->dev, res);
+	dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dev->base))
 		return PTR_ERR(dev->base);
 
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 877dd39bd41f..fc3cf5edf6c7 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -183,13 +183,11 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 {
 	struct watchdog_device *wdd;
 	struct tegra_wdt *wdt;
-	struct resource *res;
 	void __iomem *regs;
 	int ret;
 
 	/* This is the timer base. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 811e43c39ec4..3aa11c84dea9 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -124,20 +124,17 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 {
 	struct ts72xx_wdt_priv *priv;
 	struct watchdog_device *wdd;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->control_reg = devm_ioremap_resource(&pdev->dev, res);
+	priv->control_reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->control_reg))
 		return PTR_ERR(priv->control_reg);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->feed_reg = devm_ioremap_resource(&pdev->dev, res);
+	priv->feed_reg = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->feed_reg))
 		return PTR_ERR(priv->feed_reg);
 
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 6f7a9deb27d0..fcb4da5b1f4c 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -103,7 +103,6 @@ static struct watchdog_device txx9wdt = {
 
 static int __init txx9wdt_probe(struct platform_device *dev)
 {
-	struct resource *res;
 	int ret;
 
 	txx9_imclk = clk_get(NULL, "imbus_clk");
@@ -119,8 +118,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 		goto exit;
 	}
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	txx9wdt_reg = devm_ioremap_resource(&dev->dev, res);
+	txx9wdt_reg = devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(txx9wdt_reg)) {
 		ret = PTR_ERR(txx9wdt_reg);
 		goto exit;
diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index 9261f7c77f6d..9ccc83f526f3 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -192,7 +192,6 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct zx2967_wdt *wdt;
-	struct resource *base;
 	int ret;
 	struct reset_control *rstc;
 
@@ -209,8 +208,7 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 	wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
 	wdt->wdt_device.parent = &pdev->dev;
 
-	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->reg_base = devm_ioremap_resource(dev, base);
+	wdt->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->reg_base))
 		return PTR_ERR(wdt->reg_base);
 
-- 
2.7.4

