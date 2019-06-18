Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40054C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F812146F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfFRMJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:09:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25327 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728845AbfFRMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:09:13 -0400
X-UUID: 869e132c44684e91b1a10166255098c0-20190618
X-UUID: 869e132c44684e91b1a10166255098c0-20190618
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 634461938; Tue, 18 Jun 2019 20:09:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Jun
 2019 20:09:04 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Jun 2019 20:09:03 +0800
Message-ID: <1560859743.8082.23.camel@mhfsdcap03>
Subject: Re: [PATCH v7 14/21] iommu/mediatek: Add mmu1 support
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@google.com>
CC:     <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <yingjoe.chen@mediatek.com>, <anan.sun@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 18 Jun 2019 20:09:03 +0800
In-Reply-To: <CAAFQd5A5GUn1Zq1xF2_2V0MReNPd5bra2F=nquvodSAZUua5AQ@mail.gmail.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
         <1560169080-27134-15-git-send-email-yong.wu@mediatek.com>
         <CAAFQd5A5GUn1Zq1xF2_2V0MReNPd5bra2F=nquvodSAZUua5AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 15:19 +0900, Tomasz Figa wrote:
> On Mon, Jun 10, 2019 at 9:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Normally the M4U HW connect EMI with smi. the diagram is like below:
> >               EMI
> >                |
> >               M4U
> >                |
> >             smi-common
> >                |
> >        -----------------
> >        |    |    |     |    ...
> >     larb0 larb1  larb2 larb3
> >
> > Actually there are 2 mmu cells in the M4U HW, like this diagram:
> >
> >               EMI
> >            ---------
> >             |     |
> >            mmu0  mmu1     <- M4U
> >             |     |
> >            ---------
> >                |
> >             smi-common
> >                |
> >        -----------------
> >        |    |    |     |    ...
> >     larb0 larb1  larb2 larb3
> >
> > This patch add support for mmu1. In order to get better performance,
> > we could adjust some larbs go to mmu1 while the others still go to
> > mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
> >
> > mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> > value of that register is 0 which means all the larbs go to mmu0
> > defaultly.
> >
> > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 29 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 3a14301..ec4ce74 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -72,26 +72,32 @@
> >  #define F_INT_CLR_BIT                          BIT(12)
> >
> >  #define REG_MMU_INT_MAIN_CONTROL               0x124
> > -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> > -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> > -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> > -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> > -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> > -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> > -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> > +                                               /* mmu0 | mmu1 */
> > +#define F_INT_TRANSLATION_FAULT                        (BIT(0) | BIT(7))
> > +#define F_INT_MAIN_MULTI_HIT_FAULT             (BIT(1) | BIT(8))
> > +#define F_INT_INVALID_PA_FAULT                 (BIT(2) | BIT(9))
> > +#define F_INT_ENTRY_REPLACEMENT_FAULT          (BIT(3) | BIT(10))
> > +#define F_INT_TLB_MISS_FAULT                   (BIT(4) | BIT(11))
> > +#define F_INT_MISS_TRANSACTION_FIFO_FAULT      (BIT(5) | BIT(12))
> > +#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   (BIT(6) | BIT(13))
> 
> If there are two IOMMUs, shouldn't we have two driver instances handle
> them, instead of making the driver combine them two internally?

Actually it means only one IOMMU(M4U) HW here. Each a M4U HW has two
small iommu cells which have independent MTLB. As the diagram above, M4U
contain mmu0 and mmu1.

MT8173 and MT8183 have only one M4U HW while MT2712 have 2 M4U HWs(two
driver instances).

> 
> And, what is even more important from security point of view actually,
> have two separate page tables (aka IOMMU groups) for them?

Each a IOMMU(M4U) have its own pagetable, thus, mt8183 have only one
pagetable while mt2712 have two.

> 
> Best regards,
> Tomasz
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


