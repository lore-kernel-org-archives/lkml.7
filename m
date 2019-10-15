Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C95ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FEA2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfJOF0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:26:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726004AbfJOF0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:26:13 -0400
X-UUID: e3df01c6f2004888a356a9b510f70f67-20191015
X-UUID: e3df01c6f2004888a356a9b510f70f67-20191015
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2096386606; Tue, 15 Oct 2019 13:26:08 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Oct
 2019 13:26:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Oct 2019 13:26:04 +0800
Message-ID: <1571117166.19130.83.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/7] iommu/mediatek: Use gather to achieve the tlb
 range flush
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <edison.hsieh@mediatek.com>
Date:   Tue, 15 Oct 2019 13:26:06 +0800
In-Reply-To: <f35c8a3a-0693-facf-2050-65d3f7628929@arm.com>
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
         <1571035101-4213-4-git-send-email-yong.wu@mediatek.com>
         <f35c8a3a-0693-facf-2050-65d3f7628929@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 493B811D3A4FB41E5FE1A33A5F26255A7FD2DDEB47E946C9A789C9EA07E415032000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 15:21 +0100, Robin Murphy wrote:
> On 14/10/2019 07:38, Yong Wu wrote:
> > Use the iommu_gather mechanism to achieve the tlb range flush.
> > Gather the iova range in the "tlb_add_page", then flush the merged iova
> > range in iotlb_sync.
> > 
> > Note: If iotlb_sync comes from iommu_iotlb_gather_add_page, we have to
> > avoid retry the lock since the spinlock have already been acquired.
> 
> I think this could probably be even simpler - once the actual 
> register-poking is all confined to mtk_iommu_tlb_sync(), you should be 
> able get rid of the per-domain locking in map/unmap and just have a 
> single per-IOMMU lock to serialise syncs. The io-pgtable code itself 
> hasn't needed external locking for a while now.

This is more simpler! Thanks very much. I will try this.

The only concern is there is no lock in the iova_to_phys then, maybe use
the new lock instead.

> 
> Robin.
> 
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > 1) This is the special case backtrace:
> > 
> >   mtk_iommu_iotlb_sync+0x50/0xa0
> >   mtk_iommu_tlb_flush_page_nosync+0x5c/0xd0
> >   __arm_v7s_unmap+0x174/0x598
> >   arm_v7s_unmap+0x30/0x48
> >   mtk_iommu_unmap+0x50/0x78
> >   __iommu_unmap+0xa4/0xf8
> > 
> > 2) The checking "if (gather->start == ULONG_MAX) return;" also is
> > necessary. It will happened when unmap only go to _flush_walk, then
> > enter this tlb_sync.
> > ---
> >   drivers/iommu/mtk_iommu.c | 29 +++++++++++++++++++++++++----
> >   drivers/iommu/mtk_iommu.h |  1 +
> >   2 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 5f594d6..8712afc 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -234,7 +234,12 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> >   					    unsigned long iova, size_t granule,
> >   					    void *cookie)
> >   {
> > -	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> > +	struct mtk_iommu_data *data = cookie;
> > +	struct iommu_domain *domain = &data->m4u_dom->domain;
> > +
> > +	data->is_in_tlb_gather_add_page = true;
> > +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
> > +	data->is_in_tlb_gather_add_page = false;
> >   }
> >   
> >   static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> > @@ -453,12 +458,28 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
> >   static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> >   				 struct iommu_iotlb_gather *gather)
> >   {
> > +	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +	bool is_in_gather = data->is_in_tlb_gather_add_page;
> > +	size_t length = gather->end - gather->start;
> >   	unsigned long flags;
> >   
> > -	spin_lock_irqsave(&dom->pgtlock, flags);
> > -	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
> > -	spin_unlock_irqrestore(&dom->pgtlock, flags);
> > +	if (gather->start == ULONG_MAX)
> > +		return;
> > +
> > +	/*
> > +	 * Avoid acquire the lock when it's in gather_add_page since the lock
> > +	 * has already been held.
> > +	 */
> > +	if (!is_in_gather)
> > +		spin_lock_irqsave(&dom->pgtlock, flags);
> > +
> > +	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> > +				       false, data);
> > +	mtk_iommu_tlb_sync(data);
> > +
> > +	if (!is_in_gather)
> > +		spin_unlock_irqrestore(&dom->pgtlock, flags);
> >   }
> >   
> >   static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index fc0f16e..d29af1d 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -58,6 +58,7 @@ struct mtk_iommu_data {
> >   	struct iommu_group		*m4u_group;
> >   	bool                            enable_4GB;
> >   	bool				tlb_flush_active;
> > +	bool				is_in_tlb_gather_add_page;
> >   
> >   	struct iommu_device		iommu;
> >   	const struct mtk_iommu_plat_data *plat_data;
> > 


