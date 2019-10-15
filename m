Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C8BECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfJOBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:51:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30209 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726450AbfJOBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:51:53 -0400
X-UUID: f6970995dbc8493bb4365a0938f2f170-20191015
X-UUID: f6970995dbc8493bb4365a0938f2f170-20191015
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 468638640; Tue, 15 Oct 2019 09:51:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Oct
 2019 09:51:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Oct 2019 09:51:35 +0800
Message-ID: <1571104296.19130.67.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/4] iommu/mediatek: Use writel for TLB range
 invalidation
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>
Date:   Tue, 15 Oct 2019 09:51:36 +0800
In-Reply-To: <20191014211113.jq5qwe5pfonyocr3@willie-the-truck>
References: <1570627143-29441-1-git-send-email-yong.wu@mediatek.com>
         <1570627143-29441-3-git-send-email-yong.wu@mediatek.com>
         <20191011162950.yg4o77mlaicacne5@willie-the-truck>
         <1570861427.19130.65.camel@mhfsdcap03>
         <20191014211113.jq5qwe5pfonyocr3@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2A0569C4EE061B0093306730CED8C43106D58A6D2203E5BAA9BAE2B73DFF6B432000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 22:11 +0100, Will Deacon wrote:
> On Sat, Oct 12, 2019 at 02:23:47PM +0800, Yong Wu wrote:
> > On Fri, 2019-10-11 at 17:29 +0100, Will Deacon wrote:
> > > On Wed, Oct 09, 2019 at 09:19:02PM +0800, Yong Wu wrote:
> > > > Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > > > HW work. We expect all the setting(iova_start/iova_end...) have already
> > > > been finished before F_MMU_INV_RANGE.
> > > > 
> > > > Signed-off-by: Anan.Sun <anan.sun@mediatek.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > > This is a improvement rather than fixing a issue.
> > > > ---
> > > >  drivers/iommu/mtk_iommu.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > > index 24a13a6..607f92c 100644
> > > > --- a/drivers/iommu/mtk_iommu.c
> > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > @@ -187,8 +187,7 @@ static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> > > >  		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
> > > >  		writel_relaxed(iova + size - 1,
> > > >  			       data->base + REG_MMU_INVLD_END_A);
> > > > -		writel_relaxed(F_MMU_INV_RANGE,
> > > > -			       data->base + REG_MMU_INVALIDATE);
> > > > +		writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
> > > 
> > > I don't understand this change.
> > > 
> > > Why is it an "improvement" and which accesses are you ordering with the
> > > writel?
> > 
> > The register(F_MMU_INV_RANGE) will trigger HW to begin flush range. HW
> > expect the other register iova_start/end/flush_type always is ready
> > before trigger. thus I'd like use writel to guarantee the previous
> > register has been finished.
> 
> Given that these are all MMIO writes to the same device, then
> writel_relaxed() should give you the ordering you need. If you look at
> memory_barriers.txt, it says:
> 
>   | they [readX_relaxed() and writeX_relaxed()] are still guaranteed to
>   | be ordered with respect to other accesses from the same CPU thread
>   | to the same peripheral when operating on __iomem pointers mapped
>   | with the default I/O attributes.

Thanks for this info. See it now. then I will delete this patch in next
version.

> 
> > I didn't see the writel_relaxed cause some error in practice, we only
> > think writel is necessary here in theory. so call it "improvement".
> 
> Ok, but I don't think it's needed in this case.
> 
> Will


