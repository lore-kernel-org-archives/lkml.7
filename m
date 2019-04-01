Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4901D213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDAJPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:15:23 -0400
Received: from mx.socionext.com ([202.248.49.38]:27857 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDAJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:15:22 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 01 Apr 2019 18:15:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A3EBE611D6;
        Mon,  1 Apr 2019 18:15:20 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 1 Apr 2019 18:15:20 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5D5D740F06;
        Mon,  1 Apr 2019 18:15:20 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3406C120499;
        Mon,  1 Apr 2019 18:15:20 +0900 (JST)
Date:   Mon, 01 Apr 2019 18:15:19 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH 3/4] phy: socionext: get optional clock by devm_clk_get_optional()
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
In-Reply-To: <f3370a0619d40c40676ed029cc04a3ed1c12b991.1553914418.git.chunfeng.yun@mediatek.com>
References: <a8539bcf66065380069676fbea99a51254309803.1553914418.git.chunfeng.yun@mediatek.com> <f3370a0619d40c40676ed029cc04a3ed1c12b991.1553914418.git.chunfeng.yun@mediatek.com>
Message-Id: <20190401181519.2595.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This looks good to me.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thanks,

On Sat, 30 Mar 2019 17:11:37 +0800
Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> Use devm_clk_get_optional() to get optional clock
> 
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 10 +++-------
>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 10 +++-------
>  2 files changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> index b1b048be6166..50f379fc4e06 100644
> --- a/drivers/phy/socionext/phy-uniphier-usb3hs.c
> +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> @@ -335,13 +335,9 @@ static int uniphier_u3hsphy_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->clk_parent))
>  		return PTR_ERR(priv->clk_parent);
>  
> -	priv->clk_ext = devm_clk_get(dev, "phy-ext");
> -	if (IS_ERR(priv->clk_ext)) {
> -		if (PTR_ERR(priv->clk_ext) == -ENOENT)
> -			priv->clk_ext = NULL;
> -		else
> -			return PTR_ERR(priv->clk_ext);
> -	}
> +	priv->clk_ext = devm_clk_get_optional(dev, "phy-ext");
> +	if (IS_ERR(priv->clk_ext))
> +		return PTR_ERR(priv->clk_ext);
>  
>  	priv->rst = devm_reset_control_get_shared(dev, "phy");
>  	if (IS_ERR(priv->rst))
> diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
> index 4be95679c7d8..ec231e40ef2a 100644
> --- a/drivers/phy/socionext/phy-uniphier-usb3ss.c
> +++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
> @@ -238,13 +238,9 @@ static int uniphier_u3ssphy_probe(struct platform_device *pdev)
>  		if (IS_ERR(priv->clk))
>  			return PTR_ERR(priv->clk);
>  
> -		priv->clk_ext = devm_clk_get(dev, "phy-ext");
> -		if (IS_ERR(priv->clk_ext)) {
> -			if (PTR_ERR(priv->clk_ext) == -ENOENT)
> -				priv->clk_ext = NULL;
> -			else
> -				return PTR_ERR(priv->clk_ext);
> -		}
> +		priv->clk_ext = devm_clk_get_optional(dev, "phy-ext");
> +		if (IS_ERR(priv->clk_ext))
> +			return PTR_ERR(priv->clk_ext);
>  
>  		priv->rst = devm_reset_control_get_shared(dev, "phy");
>  		if (IS_ERR(priv->rst))
> -- 
> 2.20.1

---
Best Regards,
Kunihiko Hayashi


