Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A180C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E6120830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDAJiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:38:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30058 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725817AbfDAJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:38:07 -0400
X-UUID: 0c0c3afed5e54328a463cc99afb51411-20190401
X-UUID: 0c0c3afed5e54328a463cc99afb51411-20190401
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 876917790; Mon, 01 Apr 2019 17:37:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 17:37:57 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 17:37:57 +0800
Message-ID: <1554111477.2011.22.camel@mtksdaap41>
Subject: Re: [PATCH V7 3/6] drm/mediatek: using different flags of clk for
 HDMI phy
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
Date:   Mon, 1 Apr 2019 17:37:57 +0800
In-Reply-To: <20190327091929.73162-4-wangyan.wang@mediatek.com>
References: <20190327091929.73162-1-wangyan.wang@mediatek.com>
         <20190327091929.73162-4-wangyan.wang@mediatek.com>
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

As offline discuss, I think you could just remove the flag
CLK_SET_RATE_PARENT and do not add CLK_SET_RATE_NO_REPARENT.

I would like the title to be more clear about what you do so we could
quickly understand what this patch do. For example:

drm/mediatek: remove flag CLK_SET_RATE_PARENT for MT2701 HDMI phy

And I think there are three patches is related to HDMI stable and each
one is not independent (Apply only one patch would make something wrong,
so these three patches should be applied together). So I would like you
to describe the three steps you do in each patch and what's the step of
this patch, for example:

"To make MT2701 HDMI stable, TVDPLL should not be adjusted and it's the
parent clock of HDMI phy, so HDMI phy could not adjust parent rate. This
patch is the first step to make MT2701 HDMI stable. These steps include:

1. Remove flag CLK_SET_RATE_PARENT for MT2701 HDMI phy to not propagate
rate change to parent.
2. Using new factor for tvdpll in MT2701 to ......
3. No change parent rate in round_rate() for MT2701 HDMI phy"

Regards,
CK


On Wed, 2019-03-27 at 17:19 +0800, wangyan wang wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> The parent rate of hdmi phy had set by DPI driver.
> We should not set or change the parent rate of MT2701 hdmi phy,
> as a result we should remove the flags of "CLK_SET_RATE_PARENT"
> from the clock of MT2701 hdmi phy.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 13 +++++--------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  1 +
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 13c5e65b9ead..370309d684ec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -107,13 +107,11 @@ mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
>  		return NULL;
>  }
>  
> -static void mtk_hdmi_phy_clk_get_ops(struct mtk_hdmi_phy *hdmi_phy,
> -				     const struct clk_ops **ops)
> +static void mtk_hdmi_phy_clk_get_data(struct mtk_hdmi_phy *hdmi_phy,
> +				     struct clk_init_data *clk_init)
>  {
> -	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_clk_ops)
> -		*ops = hdmi_phy->conf->hdmi_phy_clk_ops;
> -	else
> -		dev_err(hdmi_phy->dev, "Failed to get clk ops of phy\n");
> +	clk_init->flags = hdmi_phy->conf->flags;
> +	clk_init->ops = hdmi_phy->conf->hdmi_phy_clk_ops;
>  }
>  
>  static int mtk_hdmi_phy_probe(struct platform_device *pdev)
> @@ -126,7 +124,6 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  	struct clk_init_data clk_init = {
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
> -		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	};
>  
>  	struct phy *phy;
> @@ -164,7 +161,7 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  	hdmi_phy->dev = dev;
>  	hdmi_phy->conf =
>  		(struct mtk_hdmi_phy_conf *)of_device_get_match_data(dev);
> -	mtk_hdmi_phy_clk_get_ops(hdmi_phy, &clk_init.ops);
> +	mtk_hdmi_phy_clk_get_data(hdmi_phy, &clk_init);
>  	hdmi_phy->pll_hw.init = &clk_init;
>  	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
>  	if (IS_ERR(hdmi_phy->pll)) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index fdad8b17a915..446e2acd1926 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -21,6 +21,7 @@ struct mtk_hdmi_phy;
>  
>  struct mtk_hdmi_phy_conf {
>  	bool tz_disabled;
> +	unsigned long flags;
>  	const struct clk_ops *hdmi_phy_clk_ops;
>  	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>  	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index 6f29e87eefd0..fb26a83988dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -232,6 +232,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
>  	.tz_disabled = true,
> +	.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_GATE,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index cb23c1e4692a..63dde42521b8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -317,6 +317,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  }
>  
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf = {
> +	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,


