Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2104FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E926F2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfDPIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:37:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30559 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726576AbfDPIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:37:25 -0400
X-UUID: 34edd3c0ae6f46cc8673060dcf04d360-20190416
X-UUID: 34edd3c0ae6f46cc8673060dcf04d360-20190416
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1177869614; Tue, 16 Apr 2019 16:37:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 16 Apr
 2019 16:37:18 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:37:17 +0800
Message-ID: <1555403837.31200.31.camel@mhfsdcap03>
Subject: Re: [PATCH v2 18/25] drm/mediatek: add RDMA fifo size error handle
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Tue, 16 Apr 2019 16:37:17 +0800
In-Reply-To: <1555401647.11519.2.camel@mtksdaap41>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-19-git-send-email-yongqiang.niu@mediatek.com>
         <1555401647.11519.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 16:00 +0800, CK Hu wrote:
> Hi, Yongqiang:
> 
> On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > This patch add RDMA fifo size error handle
> > rdma fifo size will not always bigger than the calculated threshold
> > if that case happened, we need set fifo size as the threshold
> > 
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index b0a5cff..ead38ba 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -137,11 +137,14 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> >  {
> >  	unsigned int threshold;
> >  	unsigned int reg;
> > +	unsigned int rdma_fifo_size;
> >  	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> >  
> >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
> >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
> >  
> > +	rdma_fifo_size = RDMA_FIFO_SIZE(rdma);
> > +
> >  	/*
> >  	 * Enable FIFO underflow since DSI and DPI can't be blocked.
> >  	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> > @@ -149,8 +152,12 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> >  	 * account for blanking, and with a pixel depth of 4 bytes:
> >  	 */
> >  	threshold = width * height * vrefresh * 4 * 7 / 1000000;
> > +
> > +	if (threshold > rdma_fifo_size)
> > +		threshold = rdma_fifo_size;
> 
> I think this is a work around not a correct solution. Why MT8173 has no
> this problem but MT8183 has? Is the formula of threshold different in
> MT8173 and MT8183?
> 
> Regards,
> CK
> 

fifo size of RDMA0 and RDMA1 in MT8173 are same, which is SZ_8K.
this formula calculate result will not overflow if the screen size is
not big enough. 

but fifo size of RDMA1 in MT8183 only SZ_2K, if RDMA1 display with
solution 1080p60hz, this formula calculate result 3483 will overflow
SZ_2K. 

> > +
> >  	reg = RDMA_FIFO_UNDERFLOW_EN |
> > -	      RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
> > +	      RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
> >  	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> >  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
> >  }
> 
> 


