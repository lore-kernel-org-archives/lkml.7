Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E760C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0991218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfCUDXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:23:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61326 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727507AbfCUDXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:23:19 -0400
X-UUID: 82149459e4c245f492e9744ce3bae319-20190321
X-UUID: 82149459e4c245f492e9744ce3bae319-20190321
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1385589213; Thu, 21 Mar 2019 11:23:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 11:23:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 11:23:12 +0800
Message-ID: <1553138590.18216.26.camel@mtksdaap41>
Subject: Re: [PATCH v6 1/8] drm/mediatek: recalculate hdmi phy clock of
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
Date:   Thu, 21 Mar 2019 11:23:10 +0800
In-Reply-To: <1551866854.1001.6.camel@mtksdaap41>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
         <20190225020912.29120-2-wangyan.wang@mediatek.com>
         <1551866854.1001.6.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 33F5F639D58E9339469006AC6A7E3800AE5E60B36126227855B0C18855B1DF962000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wangyan:

On Wed, 2019-03-06 at 18:07 +0800, CK Hu wrote:
> Hi, Wangyan:
> 
> On Mon, 2019-02-25 at 10:09 +0800, wangyan wang wrote:
> > From: chunhui dai <chunhui.dai@mediatek.com>
> > 
> > Recalculate the rate of this clock, by querying hardware.
> > 
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  7 ++----
> >  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 +--
> >  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 35 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  8 ++++++
> >  4 files changed, 46 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > index 4ef9c57ffd44..13c5e65b9ead 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > @@ -29,12 +29,9 @@ long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> >  	return rate;
> >  }
> >  
> > -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> > -				       unsigned long parent_rate)
> > +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
> >  {
> > -	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> > -
> > -	return hdmi_phy->pll_rate;
> > +	return readl(hdmi_phy->regs + offset);
> >  }
> >  
> >  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > index f39b1fc66612..fdad8b17a915 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > @@ -41,6 +41,7 @@ struct mtk_hdmi_phy {
> >  	unsigned int ibias_up;
> >  };
> >  
> > +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
> >  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> >  			     u32 bits);
> >  void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> > @@ -50,8 +51,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> >  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
> >  long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> >  			     unsigned long *parent_rate);
> > -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> > -				       unsigned long parent_rate);
> >  
> >  extern struct platform_driver mtk_hdmi_phy_driver;
> >  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > index fcc42dc6ea7f..b25c9dfc432a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > @@ -153,6 +153,41 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  			  RG_HDMITX_DRV_IBIAS_MASK);
> >  	return 0;
> >  }
> > +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> > +				       unsigned long parent_rate)
> > +{
> > +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> > +	unsigned long out_rate, val;
> > +
> > +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
> > +			& RG_HTPLL_PREDIV_MASK) >> RG_HTPLL_PREDIV;
> > +	switch (val) {
> > +	case 0x00:
> > +		out_rate = parent_rate;
> > +		break;
> > +	case 0x01:
> > +		out_rate = parent_rate / 2;
> > +		break;
> > +	default:
> > +		out_rate = parent_rate / 4;
> > +		break;
> > +	}
> > +
> > +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
> > +			& RG_HTPLL_FBKDIV_MASK) >> RG_HTPLL_FBKDIV;
> > +	out_rate *= (val + 1) * 2;
> > +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2)
> > +			& RG_HDMITX_TX_POSDIV_MASK);
> > +
> > +	out_rate >>= (val >> RG_HDMITX_TX_POSDIV);
> > +
> > +	if (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2) & RG_HDMITX_EN_TX_POSDIV)
> > +		out_rate = out_rate / 5;
> > +
> 
> All the register you read here is set in mtk_hdmi_pll_set_rate(), so I
> think you could determine the out_rate in mtk_hdmi_pll_set_rate().

As offline discuss, you mention that when
cat /sys/kernel/debug/ckl/clk_summary, mtk_hdmi_pll_recalc_rate() is
called, so read register to get the real clock. The clk_summary call
clk_core_get_rate() to get rate, and clk_core_get_rate() would check the
flag CLK_GET_RATE_NOCACHE to call __clk_recalc_rates(), but mtk_hdmi_phy
does not have this flag, so this function would not be called when
clk_summary. So I still think you could determine the out_rate in
mtk_hdmi_pll_set_rate().

Regards,
CK

> 
> Regards,
> CK
> 
> > +	hdmi_phy->pll_rate = out_rate;
> > +
> > +	return hdmi_phy->pll_rate;
> > +}
> >  
> >  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
> >  	.prepare = mtk_hdmi_pll_prepare,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > index ed5916b27658..cb23c1e4692a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > @@ -285,6 +285,14 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  	return 0;
> >  }
> >  
> > +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> > +				       unsigned long parent_rate)
> > +{
> > +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> > +
> > +	return hdmi_phy->pll_rate;
> > +}
> > +
> >  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
> >  	.prepare = mtk_hdmi_pll_prepare,
> >  	.unprepare = mtk_hdmi_pll_unprepare,
> 


