Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D0F20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDAJrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:47:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53332 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbfDAJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:47:36 -0400
X-UUID: 27493e00a4a5422ca3d5a35998cd6d66-20190401
X-UUID: 27493e00a4a5422ca3d5a35998cd6d66-20190401
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 30432239; Mon, 01 Apr 2019 17:47:27 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 17:47:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 17:47:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 17:47:20 +0800
Message-ID: <1554112040.2011.25.camel@mtksdaap41>
Subject: Re: [PATCH V7 6/6] drm/mediatek: fix the rate of parent for hdmi
 phy in MT2701
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
Date:   Mon, 1 Apr 2019 17:47:20 +0800
In-Reply-To: <20190327091929.73162-7-wangyan.wang@mediatek.com>
References: <20190327091929.73162-1-wangyan.wang@mediatek.com>
         <20190327091929.73162-7-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wangyan:

I would like the title to more clear about what this patch do. For
example:

drm/mediatek: no change parent rate in round_rate() for MT2701 HDMI phy


On Wed, 2019-03-27 at 17:19 +0800, wangyan wang wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> We should not change the rate of parent for hdmi phy when
> doing round_rate for this clock. The parent clock of hdmi
> phy must be the same as it. We change it when doing set_rate
> only.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 19 -------------------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  4 ----
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  7 +++++++
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 14 ++++++++++++++
>  4 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 370309d684ec..f753ee72971e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -15,25 +15,6 @@ static const struct phy_ops mtk_hdmi_phy_dev_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> -long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -			     unsigned long *parent_rate)
> -{
> -	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> -
> -	hdmi_phy->pll_rate = rate;
> -	if (rate <= 74250000)
> -		*parent_rate = rate;
> -	else
> -		*parent_rate = rate / 2;
> -
> -	return rate;
> -}
> -
> -u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
> -{
> -	return readl(hdmi_phy->regs + offset);
> -}

I think this function should already be removed by the patch
"drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
hardware"

Regards,
CK

> -
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  			     u32 bits)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index 446e2acd1926..4d4de4de8977 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -42,7 +42,6 @@ struct mtk_hdmi_phy {
>  	unsigned int ibias_up;
>  };
>  
> -u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  			     u32 bits);
>  void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> @@ -50,9 +49,6 @@ void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  		       u32 val, u32 mask);
>  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
> -long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -			     unsigned long *parent_rate);
> -
>  extern struct platform_driver mtk_hdmi_phy_driver;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index cb0c68c94013..6fb4ca943463 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -152,6 +152,13 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  			  RG_HDMITX_DRV_IBIAS_MASK);
>  	return 0;
>  }
> +
> +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long *parent_rate)
> +{
> +	return rate;
> +}
> +
>  static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
>  				       unsigned long parent_rate)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index 63dde42521b8..3a339f516613 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -285,6 +285,20 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long *parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	hdmi_phy->pll_rate = rate;
> +	if (rate <= 74250000)
> +		*parent_rate = rate;
> +	else
> +		*parent_rate = rate / 2;
> +
> +	return rate;
> +}
> +
>  static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
>  				       unsigned long parent_rate)
>  {


