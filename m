Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D904EC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D1F2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfDER74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:59:56 -0400
Received: from mleia.com ([178.79.152.223]:44228 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfDER74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:59:56 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 2A04F45F08A;
        Fri,  5 Apr 2019 18:59:53 +0100 (BST)
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
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
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <112ed5c1-1761-2d04-fd9c-49fc9ef3d8f7@mleia.com>
Date:   Fri, 5 Apr 2019 20:59:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190405_185953_209427_E116B2E0 
X-CRM114-Status: GOOD (  23.59  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2019 10:01 PM, Guenter Roeck wrote:
> Use devm_platform_ioremap_resource to reduce source code size,
> improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patch.
> 
> @r@
> identifier res, pdev;
> expression a;
> expression index;
> expression e;
> @@
> 
> <+...
> - res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> - a = devm_ioremap_resource(e, res);
> + a = devm_platform_ioremap_resource(pdev, index);
> ...+>
> 
> @depends on r@
> identifier r.res;
> @@
> - struct resource *res;
>   ... when != res
> 
> @@
> identifier res, pdev;
> expression index;
> expression a;
> @@
> - struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> - a = devm_ioremap_resource(&pdev->dev, res);
> + a = devm_platform_ioremap_resource(pdev, index);
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/asm9260_wdt.c    | 4 +---
>  drivers/watchdog/aspeed_wdt.c     | 4 +---
>  drivers/watchdog/at91sam9_wdt.c   | 4 +---
>  drivers/watchdog/ath79_wdt.c      | 4 +---
>  drivers/watchdog/atlas7_wdt.c     | 4 +---
>  drivers/watchdog/bcm7038_wdt.c    | 4 +---
>  drivers/watchdog/bcm_kona_wdt.c   | 4 +---
>  drivers/watchdog/cadence_wdt.c    | 4 +---
>  drivers/watchdog/coh901327_wdt.c  | 4 +---
>  drivers/watchdog/davinci_wdt.c    | 4 +---
>  drivers/watchdog/digicolor_wdt.c  | 4 +---
>  drivers/watchdog/dw_wdt.c         | 4 +---
>  drivers/watchdog/ep93xx_wdt.c     | 4 +---
>  drivers/watchdog/ftwdt010_wdt.c   | 4 +---
>  drivers/watchdog/imgpdc_wdt.c     | 4 +---
>  drivers/watchdog/jz4740_wdt.c     | 4 +---
>  drivers/watchdog/lantiq_wdt.c     | 4 +---
>  drivers/watchdog/loongson1_wdt.c  | 4 +---
>  drivers/watchdog/lpc18xx_wdt.c    | 4 +---
>  drivers/watchdog/max63xx_wdt.c    | 4 +---
>  drivers/watchdog/meson_gxbb_wdt.c | 4 +---
>  drivers/watchdog/meson_wdt.c      | 4 +---
>  drivers/watchdog/moxart_wdt.c     | 4 +---
>  drivers/watchdog/mpc8xxx_wdt.c    | 3 +--
>  drivers/watchdog/mt7621_wdt.c     | 5 +----
>  drivers/watchdog/mtk_wdt.c        | 4 +---
>  drivers/watchdog/npcm_wdt.c       | 4 +---
>  drivers/watchdog/nuc900_wdt.c     | 4 +---
>  drivers/watchdog/of_xilinx_wdt.c  | 4 +---
>  drivers/watchdog/omap_wdt.c       | 4 +---
>  drivers/watchdog/orion_wdt.c      | 6 ++----
>  drivers/watchdog/pic32-dmt.c      | 4 +---
>  drivers/watchdog/pic32-wdt.c      | 4 +---
>  drivers/watchdog/pnx4008_wdt.c    | 4 +---
>  drivers/watchdog/renesas_wdt.c    | 4 +---
>  drivers/watchdog/rt2880_wdt.c     | 4 +---
>  drivers/watchdog/rtd119x_wdt.c    | 4 +---
>  drivers/watchdog/rza_wdt.c        | 4 +---
>  drivers/watchdog/s3c2410_wdt.c    | 4 +---
>  drivers/watchdog/sama5d4_wdt.c    | 4 +---
>  drivers/watchdog/sbsa_gwdt.c      | 7 ++-----
>  drivers/watchdog/shwdt.c          | 4 +---
>  drivers/watchdog/sirfsoc_wdt.c    | 4 +---
>  drivers/watchdog/sprd_wdt.c       | 4 +---
>  drivers/watchdog/st_lpc_wdt.c     | 4 +---
>  drivers/watchdog/stm32_iwdg.c     | 4 +---
>  drivers/watchdog/sunxi_wdt.c      | 4 +---
>  drivers/watchdog/tangox_wdt.c     | 4 +---
>  drivers/watchdog/tegra_wdt.c      | 4 +---
>  drivers/watchdog/ts72xx_wdt.c     | 7 ++-----
>  drivers/watchdog/txx9wdt.c        | 4 +---
>  drivers/watchdog/zx2967_wdt.c     | 4 +---
>  52 files changed, 55 insertions(+), 161 deletions(-)

[snip]

> diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
> index 331cadb459ac..f6f66634cedf 100644
> --- a/drivers/watchdog/lpc18xx_wdt.c
> +++ b/drivers/watchdog/lpc18xx_wdt.c
> @@ -204,15 +204,13 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
>  {
>  	struct lpc18xx_wdt_dev *lpc18xx_wdt;
>  	struct device *dev = &pdev->dev;
> -	struct resource *res;
>  	int ret;
>  
>  	lpc18xx_wdt = devm_kzalloc(dev, sizeof(*lpc18xx_wdt), GFP_KERNEL);
>  	if (!lpc18xx_wdt)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	lpc18xx_wdt->base = devm_ioremap_resource(dev, res);
> +	lpc18xx_wdt->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(lpc18xx_wdt->base))
>  		return PTR_ERR(lpc18xx_wdt->base);
>  

[snip]

> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 8e261799c84e..24c266a9e1dc 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -185,13 +185,11 @@ static struct watchdog_device pnx4008_wdd = {
>  
>  static int pnx4008_wdt_probe(struct platform_device *pdev)
>  {
> -	struct resource *r;
>  	int ret = 0;
>  
>  	watchdog_init_timeout(&pnx4008_wdd, heartbeat, &pdev->dev);
>  
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	wdt_base = devm_ioremap_resource(&pdev->dev, r);
> +	wdt_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(wdt_base))
>  		return PTR_ERR(wdt_base);
>  

For lpc18xx_wdt.c and pnx4008_wdt.c:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
