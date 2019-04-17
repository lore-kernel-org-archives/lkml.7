Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491C7C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D520835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfDQFrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:47:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5987 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbfDQFrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:47:16 -0400
X-UUID: da3c797957e74ae4863dd889c9675c1a-20190417
X-UUID: da3c797957e74ae4863dd889c9675c1a-20190417
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 348513542; Wed, 17 Apr 2019 13:47:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 13:47:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 13:47:08 +0800
Message-ID: <1555480028.3515.4.camel@mtksdaap41>
Subject: Re: [PATCH v1 3/4] drm/mediatek: fix boot up for 720 and 480 but
 1080
From:   CK Hu <ck.hu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Date:   Wed, 17 Apr 2019 13:47:08 +0800
In-Reply-To: <20190416145848.11932-4-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
         <20190416145848.11932-4-frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

On Tue, 2019-04-16 at 16:58 +0200, Frank Wunderlich wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> - 1080 plg in/out with ng/ok
> - support other resolutions like 1280x1024

The description is so simple and I could not understand why
pll_default_off could fix this problem. And why only MT2701 has this
problem? Please describe more clear about this patch.

Regards,
CK

> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 3 +++
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        | 1 +
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 5223498502c4..edadb7a700f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(phy_provider);
>  	}
> 
> +	if (hdmi_phy->conf->pll_default_off)
> +		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
> +
>  	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>  				   hdmi_phy->pll);
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index 2d8b3182470d..f472fdeb63dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -22,6 +22,7 @@ struct mtk_hdmi_phy;
>  struct mtk_hdmi_phy_conf {
>  	bool tz_disabled;
>  	unsigned long flags;
> +	bool pll_default_off;
>  	const struct clk_ops *hdmi_phy_clk_ops;
>  	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>  	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index d3cc4022e988..6fbedacfc1e8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -239,6 +239,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
>  	.tz_disabled = true,
>  	.flags = CLK_SET_RATE_GATE,
> +	.pll_default_off = true,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> --
> 2.17.1
> 


