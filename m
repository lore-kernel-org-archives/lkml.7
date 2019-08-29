Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35392339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfH2Mji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:39:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50543 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfH2Mjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:39:37 -0400
X-UUID: d364c0196eef4773b0fb14c861edcb58-20190829
X-UUID: d364c0196eef4773b0fb14c861edcb58-20190829
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 186969430; Thu, 29 Aug 2019 20:39:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Aug
 2019 20:39:34 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 20:39:33 +0800
Message-ID: <1567082367.30648.2.camel@mhfsdcap03>
Subject: Re: [PATCH v4, 12/33] drm/mediatek: split DISP_REG_CONFIG_DSI_SEL
 setting into another use case
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 29 Aug 2019 20:39:27 +0800
In-Reply-To: <1563341736.29169.15.camel@mtksdaap41>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
         <1562625253-29254-13-git-send-email-yongqiang.niu@mediatek.com>
         <1563341736.29169.15.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 1AB6CD6AEFA081CDD571265A6B6FA16D64076F9D817FB5E376E91E95D5153CED2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 13:35 +0800, CK Hu wrote:
> Hi, Yongqiang:
> 
> On Tue, 2019-07-09 at 06:33 +0800, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > Here is two modifition in this patch:
> > 1.bls->dpi0 and rdma1->dsi are differen usecase,
> > Split DISP_REG_CONFIG_DSI_SEL setting into anther usecase
> > 2.remove DISP_REG_CONFIG_DPI_SEL setting, DPI_SEL_IN_BLS is 0 and
> > this is same with hardware defautl setting,
> > 
> 
> You move 2 register setting out of the path from BLS to DPI0, does this
> path still work? Please make sure that all modification could work on
> all supported SoC.
> 
> Regards,
> CK
> 

DPI_SEL_IN_BLS is 0 and this is same with hardware default setting as
description in patch.
the removed sentence is useless.


> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index d015c1a..47b3e35 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -400,10 +400,9 @@ static void mtk_ddp_sout_sel(void __iomem *config_regs,
> >  	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> >  		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> >  			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> > +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> >  		writel_relaxed(DSI_SEL_IN_RDMA,
> >  			       config_regs + DISP_REG_CONFIG_DSI_SEL);
> > -		writel_relaxed(DPI_SEL_IN_BLS,
> > -			       config_regs + DISP_REG_CONFIG_DPI_SEL);
> >  	}
> >  }
> >  
> 
> 


