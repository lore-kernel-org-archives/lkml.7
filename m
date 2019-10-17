Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ACDECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B850320854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbfJQMvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:51:50 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:58270 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJQMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:51:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id AEC73184A3;
        Thu, 17 Oct 2019 14:51:46 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ORlrqU7P1kMl; Thu, 17 Oct 2019 14:51:45 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id E39721816A;
        Thu, 17 Oct 2019 14:51:43 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C696B1E075;
        Thu, 17 Oct 2019 14:51:43 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B191E1E074;
        Thu, 17 Oct 2019 14:51:43 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 14:51:43 +0200 (CEST)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by thoth.se.axis.com (Postfix) with ESMTP id 97D0F2F9F;
        Thu, 17 Oct 2019 14:51:43 +0200 (CEST)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id 92A7C800E1; Thu, 17 Oct 2019 14:51:43 +0200 (CEST)
Date:   Thu, 17 Oct 2019 14:51:43 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "afaerber@suse.de" <afaerber@suse.de>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "vz@mleia.com" <vz@mleia.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "daniel@zonque.org" <daniel@zonque.org>,
        "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
        "wens@csie.org" <wens@csie.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH -next 27/30] pinctrl: artpec6: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20191017125143.yxhwy6lvzfhle7ey@axis.com>
References: <20191017122640.22976-1-yuehaibing@huawei.com>
 <20191017122640.22976-28-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017122640.22976-28-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:26:37PM +0200, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  drivers/pinctrl/pinctrl-artpec6.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
> index e3239cf..986e04a 100644
> --- a/drivers/pinctrl/pinctrl-artpec6.c
> +++ b/drivers/pinctrl/pinctrl-artpec6.c
> @@ -936,7 +936,6 @@ static void artpec6_pmx_reset(struct artpec6_pmx *pmx)
>  static int artpec6_pmx_probe(struct platform_device *pdev)
>  {
>  	struct artpec6_pmx *pmx;
> -	struct resource *res;
>  
>  	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
>  	if (!pmx)
> @@ -944,8 +943,7 @@ static int artpec6_pmx_probe(struct platform_device *pdev)
>  
>  	pmx->dev = &pdev->dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pmx->base = devm_ioremap_resource(&pdev->dev, res);
> +	pmx->base = devm_platform_ioremap_resource(pdev, 0);
>  
>  	if (IS_ERR(pmx->base))
>  		return PTR_ERR(pmx->base);
> -- 
> 2.7.4
> 
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
