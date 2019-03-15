Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33947C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0932421873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCOCe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:34:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56883 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727103AbfCOCe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:34:27 -0400
X-UUID: d5bf4900edb7460bb49eabf8ed477170-20190315
X-UUID: d5bf4900edb7460bb49eabf8ed477170-20190315
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1001151406; Fri, 15 Mar 2019 10:34:22 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Mar 2019 10:34:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01dr.mediatek.inc
 (172.21.101.111) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 10:34:14 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 10:34:12 +0800
Message-ID: <1552617252.31200.24.camel@mhfsdcap03>
Subject: Re: [PATCH 10/18] drm/mediatek: add gmc_bits for ovl private data
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: <yongqiang.niu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 15 Mar 2019 10:34:12 +0800
In-Reply-To: <CANMq1KC_JwVfvFd46_gP_wK_QNO0LTZOcwRAbotF6MghYivJYw@mail.gmail.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-11-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KC_JwVfvFd46_gP_wK_QNO0LTZOcwRAbotF6MghYivJYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-25 at 12:15 +0800, Nicolas Boichat wrote:
> On Mon, Dec 24, 2018 at 6:53 PM Yongqiang Niu
> <yongqiang.niu@mediatek.com> wrote:
> >
> > This patch add gmc_bits for ovl private data
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > index 28d1911..afb313c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -39,7 +39,9 @@
> >  #define DISP_REG_OVL_ADDR_MT8173               0x0f40
> >  #define DISP_REG_OVL_ADDR(ovl, n)              ((ovl)->data->addr + 0x20 * (n))
> >
> > -#define        OVL_RDMA_MEM_GMC        0x40402020
> > +#define GMC_THRESHOLD_BITS     16
> > +#define GMC_THRESHOLD_HIGH     ((1 << GMC_THRESHOLD_BITS) / 4)
> > +#define GMC_THRESHOLD_LOW      ((1 << GMC_THRESHOLD_BITS) / 8)
> >
> >  #define OVL_CON_BYTE_SWAP      BIT(24)
> >  #define OVL_CON_MTX_YUV_TO_RGB (6 << 16)
> > @@ -57,6 +59,7 @@
> >
> >  struct mtk_disp_ovl_data {
> >         unsigned int addr;
> > +       unsigned int gmc_bits;
> >         bool fmt_rgb565_is_0;
> >  };
> >
> > @@ -140,9 +143,23 @@ static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
> >  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
> >  {
> >         unsigned int reg;
> > +       unsigned int gmc_thrshd_l;
> > +       unsigned int gmc_thrshd_h;
> > +       unsigned int gmc_value;
> > +       struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> >
> >         writel(0x1, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
> > -       writel(OVL_RDMA_MEM_GMC, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
> > +
> > +       gmc_thrshd_l = GMC_THRESHOLD_LOW >>
> > +                     (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> > +       gmc_thrshd_h = GMC_THRESHOLD_HIGH >>
> > +                     (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> > +       if (ovl->data->gmc_bits == 10)
> > +               gmc_value = gmc_thrshd_h | gmc_thrshd_h << 16;
> 
> I don't really get what this does, but is it intentional that you
> don't use gmc_thrshd_l here?
> 
GMC register was set RDMA ultra and pre-ultra threshold.
MT8183 GMC register define is different with other SOC, gmc_thrshd_l not
used here.

> Also, if you only ever use 8 or 10 bits gmc, maybe it's easier to
> hard-code the 2 values?
> if (ovl->data->gmc_bits == 10)
>   gmc_value = OVL_RDMA_MEM_GMC_10BIT;
> else
>   gmc_value = OVL_RDMA_MEM_GMC_8BIT; //0x40402020
> 

our internal maintainer prefer calculate GMC setting with private data
gmc bit instead of hard-core.
and with calculation function that will be more flexible 

> > +       else
> > +               gmc_value = gmc_thrshd_l | gmc_thrshd_l << 8 |
> > +                           gmc_thrshd_h << 16 | gmc_thrshd_h << 24;
> > +       writel(gmc_value, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
> >
> >         reg = readl(comp->regs + DISP_REG_OVL_SRC_CON);
> >         reg = reg | BIT(idx);
> > @@ -324,11 +341,13 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
> >
> >  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
> >         .addr = DISP_REG_OVL_ADDR_MT2701,
> > +       .gmc_bits = 8,
> >         .fmt_rgb565_is_0 = false,
> >  };
> >
> >  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
> >         .addr = DISP_REG_OVL_ADDR_MT8173,
> > +       .gmc_bits = 8,
> >         .fmt_rgb565_is_0 = true,
> >  };
> >
> > --
> > 1.8.1.1.dirty
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel


