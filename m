Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8CC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A54C20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDHD5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:57:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65471 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726349AbfDHD5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:57:17 -0400
X-UUID: b2115b878b0c43bf9500f7badeb9a1d0-20190408
X-UUID: b2115b878b0c43bf9500f7badeb9a1d0-20190408
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2112315914; Mon, 08 Apr 2019 11:57:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 11:57:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 11:57:13 +0800
Message-ID: <1554695833.25248.4.camel@mtksdaap41>
Subject: Re: [PATCH V8 4/5] drm/mediatek: no change parent rate in
 round_rate() for mt2701 hdmi phy
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
Date:   Mon, 8 Apr 2019 11:57:13 +0800
In-Reply-To: <20190402093605.82004-5-wangyan.wang@mediatek.com>
References: <20190402093605.82004-1-wangyan.wang@mediatek.com>
         <20190402093605.82004-5-wangyan.wang@mediatek.com>
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

On Tue, 2019-04-02 at 17:36 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> This is the third step to make MT2701 HDMI stable.
> We should not change the rate of parent for hdmi phy when
> doing round_rate for this clock. The parent clock of hdmi
> phy must be the same as it. We change it when doing set_rate
> only.
> 
> Signed-off-by: Wangyan Wang <wangyan.wang@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 14 --------------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  2 --
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  6 ++++++
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 14 ++++++++++++++
>  4 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 13bbaf997819..fe05aa762107 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -15,20 +15,6 @@ static const struct phy_ops mtk_hdmi_phy_dev_ops = {
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
>  unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
>  				       unsigned long parent_rate)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index 0045824c1be9..86895be0d192 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -49,8 +49,6 @@ void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  		       u32 val, u32 mask);
>  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
> -long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -			     unsigned long *parent_rate);
>  unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
>  				       unsigned long parent_rate);
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index 844e622f052c..5f8c2b044034 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -154,6 +154,12 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long *parent_rate)

Align the first character to the right of '('.

> +{
> +	return rate;

You do not assign hdmi_phy->pll_rate here because you depend on the
patch 'drm/mediatek: make implementation of recalc_rate() to match the
definition', so you should move that patch before this patch.

> +}
> +
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
>  	.unprepare = mtk_hdmi_pll_unprepare,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index f44066875dcd..472d2fda0a03 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -285,6 +285,20 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long *parent_rate)

Align the first character to the right of '('.

Regards,
CK

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
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
>  	.unprepare = mtk_hdmi_pll_unprepare,


