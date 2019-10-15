Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6DA2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfJOFZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:25:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:25467 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728254AbfJOFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:25:33 -0400
X-UUID: b4cbd657f3384a4d9f398a13e478d426-20191015
X-UUID: b4cbd657f3384a4d9f398a13e478d426-20191015
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 420262602; Tue, 15 Oct 2019 13:25:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Oct
 2019 13:25:17 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Oct 2019 13:25:16 +0800
Message-ID: <1571117118.19130.81.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu/mediatek: Delete the leaf in the tlb flush
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, <edison.hsieh@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 15 Oct 2019 13:25:18 +0800
In-Reply-To: <20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
         <1571035101-4213-5-git-send-email-yong.wu@mediatek.com>
         <20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 1320629692F0D088FC9AD967C2A18864D2766ABDB9AA66C650AFFE4EBC49898F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 15:22 +0100, Robin Murphy wrote:
> On 14/10/2019 07:38, Yong Wu wrote:
> > In our tlb range flush, we don't care the "leaf". Remove it to simplify
> > the code. no functional change.
> 
> Presumably you don't care about the granule either?

Yes. I only keep "granule" to satisfy the format of "tlb_flush_walk",
then it's no need add a new helper function.

> 
> Robin.
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 16 ++++------------
> >   1 file changed, 4 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 8712afc..19f936c 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -174,8 +174,7 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
> >   }
> >   
> >   static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
> > -					   size_t granule, bool leaf,
> > -					   void *cookie)
> > +					   size_t granule, void *cookie)
> >   {
> >   	struct mtk_iommu_data *data = cookie;
> >   
> > @@ -219,14 +218,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
> >   static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> >   				     size_t granule, void *cookie)
> >   {
> > -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
> > -	mtk_iommu_tlb_sync(cookie);
> > -}
> > -
> > -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
> > -				     size_t granule, void *cookie)
> > -{
> > -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
> > +	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, cookie);
> >   	mtk_iommu_tlb_sync(cookie);
> >   }
> >   
> > @@ -245,7 +237,7 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> >   static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> >   	.tlb_flush_all = mtk_iommu_tlb_flush_all,
> >   	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
> > -	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
> > +	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
> >   	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
> >   };
> >   
> > @@ -475,7 +467,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> >   		spin_lock_irqsave(&dom->pgtlock, flags);
> >   
> >   	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> > -				       false, data);
> > +				       data);
> >   	mtk_iommu_tlb_sync(data);
> >   
> >   	if (!is_in_gather)
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


