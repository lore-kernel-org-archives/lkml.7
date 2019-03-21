Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5555218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfCUFdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:33:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14267 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725971AbfCUFdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:33:19 -0400
X-UUID: 2b3a803f35d84d9e9516ee100f4e5c6e-20190321
X-UUID: 2b3a803f35d84d9e9516ee100f4e5c6e-20190321
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 207650324; Thu, 21 Mar 2019 13:32:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 13:32:57 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 13:32:57 +0800
Message-ID: <1553146377.18216.30.camel@mtksdaap41>
Subject: Re: [PATCH V6 8/8] drm/mediatek: fix the rate of parent for hdmi
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
Date:   Thu, 21 Mar 2019 13:32:57 +0800
In-Reply-To: <1551867194.1001.8.camel@mtksdaap41>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
         <20190225020912.29120-9-wangyan.wang@mediatek.com>
         <1551867194.1001.8.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 1E2F63E8A13BFDF8D734E95CFF62D3C8C822B0801FED793E28335DF3BA9BC5AC2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wangyan:

On Wed, 2019-03-06 at 18:13 +0800, CK Hu wrote:
> Hi, Wangyan:
> 
> On Mon, 2019-02-25 at 10:09 +0800, wangyan wang wrote:
> > From: chunhui dai <chunhui.dai@mediatek.com>
> > 
> > We should not change the rate of parent for hdmi phy when
> > doing round_rate for this clock. The parent clock of hdmi
> > phy must be the same as it. We change it when doing set_rate
> > only.
> > 
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 14 --------------
> >  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 ---
> >  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 11 +++++++++++
> >  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 14 ++++++++++++++
> >  4 files changed, 25 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > index 370309d684ec..ca8bc1489f37 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> > @@ -15,20 +15,6 @@ static const struct phy_ops mtk_hdmi_phy_dev_ops = {
> >  	.owner = THIS_MODULE,
> >  };
> >  
> > -long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > -			     unsigned long *parent_rate)
> > -{
> > -	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> > -
> > -	hdmi_phy->pll_rate = rate;
> > -	if (rate <= 74250000)
> > -		*parent_rate = rate;
> > -	else
> > -		*parent_rate = rate / 2;
> > -
> > -	return rate;
> > -}
> > -
> >  u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
> >  {
> >  	return readl(hdmi_phy->regs + offset);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > index 446e2acd1926..c6061ad15ff0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> > @@ -50,9 +50,6 @@ void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> >  void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> >  		       u32 val, u32 mask);
> >  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
> > -long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > -			     unsigned long *parent_rate);
> > -
> >  extern struct platform_driver mtk_hdmi_phy_driver;
> >  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
> >  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > index 88dd9e812ca0..33893a180c2e 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > @@ -152,6 +152,17 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  			  RG_HDMITX_DRV_IBIAS_MASK);
> >  	return 0;
> >  }
> > +
> > +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +			     unsigned long *parent_rate)
> > +{
> > +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> > +
> > +	hdmi_phy->pll_rate = rate;
> 
> I think you don't need to save the rate into pll_rate here, pll_rate
> would be set in set_rate() or recalc_rate().

As offline discuss, you mention that this function just need to return
current rate. I think you could just remove this line
'hdmi_phy->pll_rate = rate;' and return rate only. You don't need to
assign hdmi_phy->pll_rate here because it would be set later in
set_rate().

Regards,
CK

> 
> Regards,
> CK
> 
> > +
> > +	return rate;
> > +}
> > +
> >  static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> >  				       unsigned long parent_rate)
> >  {
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > index 63dde42521b8..3a339f516613 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> > @@ -285,6 +285,20 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  	return 0;
> >  }
> >  
> > +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +			     unsigned long *parent_rate)
> > +{
> > +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> > +
> > +	hdmi_phy->pll_rate = rate;
> > +	if (rate <= 74250000)
> > +		*parent_rate = rate;
> > +	else
> > +		*parent_rate = rate / 2;
> > +
> > +	return rate;
> > +}
> > +
> >  static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> >  				       unsigned long parent_rate)
> >  {
> 


