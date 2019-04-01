Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44594C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1AC2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfDAJNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:13:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13498 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbfDAJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:13:20 -0400
X-UUID: 39533b50163a48c6a38ed60fed34659f-20190401
X-UUID: 39533b50163a48c6a38ed60fed34659f-20190401
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 841172811; Mon, 01 Apr 2019 17:13:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 17:13:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 17:13:11 +0800
Message-ID: <1554109991.2011.2.camel@mtksdaap41>
Subject: Re: [PATCH V7 1/6] drm/mediatek: recalculate hdmi phy clock of
 MT2701 by querying hardware
From:   CK Hu <ck.hu@mediatek.com>
To:     wangyan wang <wangyan.wang@mediatek.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Date:   Mon, 1 Apr 2019 17:13:11 +0800
In-Reply-To: <20190327091929.73162-2-wangyan.wang@mediatek.com>
References: <20190327091929.73162-1-wangyan.wang@mediatek.com>
         <20190327091929.73162-2-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 17:19 +0800, wangyan wang wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> Recalculate the rate of this clock, by querying hardware.

You just describe _WHAT_ do you do here, I would like you to describe
_WHT_ do you do here. I think this patch is to make implementation of
recalc_rate() to match the definition.

> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  7 ++----
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 +--
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 33 ++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  8 +++++++
>  4 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 4ef9c57ffd44..13c5e65b9ead 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -29,12 +29,9 @@ long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return rate;
>  }
>  
> -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> -				       unsigned long parent_rate)
> +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
>  {
> -	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> -
> -	return hdmi_phy->pll_rate;
> +	return readl(hdmi_phy->regs + offset);
>  }

This function is useless, so remove it.

Regards,
CK

>  
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index f39b1fc66612..fdad8b17a915 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -41,6 +41,7 @@ struct mtk_hdmi_phy {
>  	unsigned int ibias_up;
>  };
>  
> +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  			     u32 bits);
>  void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> @@ -50,8 +51,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
>  long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  			     unsigned long *parent_rate);
> -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> -				       unsigned long parent_rate);
>  
>  extern struct platform_driver mtk_hdmi_phy_driver;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index fcc42dc6ea7f..9dcf9c2ff37a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -153,6 +153,39 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  			  RG_HDMITX_DRV_IBIAS_MASK);
>  	return 0;
>  }
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	unsigned long out_rate, val;
> +
> +	val = (readl(hdmi_phy->regs + HDMI_CON6)
> +			& RG_HTPLL_PREDIV_MASK) >> RG_HTPLL_PREDIV;
> +	switch (val) {
> +	case 0x00:
> +		out_rate = parent_rate;
> +		break;
> +	case 0x01:
> +		out_rate = parent_rate / 2;
> +		break;
> +	default:
> +		out_rate = parent_rate / 4;
> +		break;
> +	}
> +
> +	val = (readl(hdmi_phy->regs + HDMI_CON6)
> +			& RG_HTPLL_FBKDIV_MASK) >> RG_HTPLL_FBKDIV;
> +	out_rate *= (val + 1) * 2;
> +	val = (readl(hdmi_phy->regs + HDMI_CON2)
> +			& RG_HDMITX_TX_POSDIV_MASK);
> +
> +	out_rate >>= (val >> RG_HDMITX_TX_POSDIV);
> +
> +	if (readl(hdmi_phy->regs + HDMI_CON2) & RG_HDMITX_EN_TX_POSDIV)
> +		out_rate = out_rate / 5;
> +
> +	return out_rate;
> +}
>  
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index ed5916b27658..cb23c1e4692a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -285,6 +285,14 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	return hdmi_phy->pll_rate;
> +}
> +
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
>  	.unprepare = mtk_hdmi_pll_unprepare,


