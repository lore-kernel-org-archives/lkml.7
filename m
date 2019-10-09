Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD1D20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfJINin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:38:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61433 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731138AbfJINin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:38:43 -0400
X-UUID: 23a1f3f954ed427e90f1d30049e12463-20191009
X-UUID: 23a1f3f954ed427e90f1d30049e12463-20191009
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1426748016; Wed, 09 Oct 2019 21:38:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Oct
 2019 21:38:24 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 21:38:24 +0800
Message-ID: <1570628307.19130.53.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        <youlin.pei@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>
Date:   Wed, 9 Oct 2019 21:38:27 +0800
In-Reply-To: <CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com>
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
         <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
         <1570522162.19130.38.camel@mhfsdcap03>
         <CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 9DC8DFD7C36EE50E1052EBAAB997ADF22F64BBEC2A1D9E8D110DA80EEC3D152C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 16:56 +0900, Tomasz Figa wrote:
> On Tue, Oct 8, 2019 at 5:09 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Hi Tomasz,
> >
> > Sorry for reply late.
> >
> > On Wed, 2019-10-02 at 14:18 +0900, Tomasz Figa wrote:
> > > Hi Yong,
> > >
> > > On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > >
> > > > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > > > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > > > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > > > lacked the dom->pgtlock, then it will cause the variable
> > > > "tlb_flush_active" may be changed unexpectedly, we could see this warning
> > > > log randomly:
> > > >
> > >
> > > Thanks for the patch! Please see my comments inline.
> > >
> > > > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > > > full flush
> > > >
> > > > To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> > > > And when checking this issue, we find that __arm_v7s_unmap call
> > > > io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> > > > this also is potential unsafe for us. There is no tlb flush queue in the
> > > > MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> > > > If v7s don't always gurarantee the sequence, Thus, In this patch I move
> > > > the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> > > > and we don't care if it is leaf, rearrange the callback functions. Also,
> > > > the tlb flush/sync was already finished in v7s, then iotlb_sync and
> > > > iotlb_sync_all is unnecessary.
> > >
> > > Performance-wise, we could do much better. Instead of synchronously
> > > syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
> > > beginning, if there was any previous flush still pending. We would
> > > also have to keep the .iotlb_sync() callback, to take care of waiting
> > > for the last flush. That would allow better pipelining with CPU in
> > > cases like this:
> > >
> > > for (all pages in range) {
> > >    change page table();
> > >    flush();
> > > }
> > >
> > > "change page table()" could execute while the IOMMU is flushing the
> > > previous change.
> >
> > Do you mean adding a new tlb_sync before tlb_flush_no_sync, like below:
> >
> > mtk_iommu_tlb_add_flush_nosync {
> >    + mtk_iommu_tlb_sync();
> >    tlb_flush_no_sync();
> >    data->tlb_flush_active = true;
> > }
> >
> > mtk_iommu_tlb_sync {
> >         if (!data->tlb_flush_active)
> >                 return;
> >         tlb_sync();
> >         data->tlb_flush_active = false;
> > }
> >
> > This way look improve the flow, But adjusting the flow is not the root
> > cause of this issue. the problem is "data->tlb_flush_active" may be
> > changed from mtk_iommu_iotlb_sync which don't have a dom->pglock.
> 
> That was not the only problem with existing code. Existing code also
> assumed that add_flush and sync always go in pairs, but that's not
> true.

Yes. Thus I put the tlb_flush always followed by tlb_sync to make sure
they always go in pairs.

> 
> My suggestion is to fix the locking in the driver and keep the sync
> deferred as much as possible, so that performance is not degraded. I

I really didn't get this timeout warning log in previous kernel(Many
tlb_flush followed by one tlb_sync), But deferring the sync is not
suggested by our DE, thus I still would like to fix the sequence in this
patch with putting them together.

> changed my mind, though. I think we would need to make more changes to
> the driver to make it implement the flushing efficiently, so let's go
> with the current simple approach for now and improve incrementally.
> 
> >
> > Currently the synchronisation of the tlb_flush/tlb_sync flow are
> > controlled by the variable "data->tlb_flush_active".
> >
> > In this patch putting the tlb_flush/tlb_sync together looks make
> > the flow simpler:
> > a) Don't need the sensitive variable "tlb_flush_active".
> > b) Remove mtk_iommu_iotlb_sync, Don't need add lock in it.
> > c) Simplify the tlb_flush_walk/tlb_flush_leaf.
> > is it ok?
> >
> 
> Okay, let's do so as a first step to fix the issue. Then we can
> optimize in follow up patches.

Thanks the confirm, I have sent a quick v2.

> 
> > >
> > > >
> > > > Besides, there are two minor changes:
> > > > a) Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > > > HW work. We expect all the setting(iova_start/iova_end...) have already
> > > > been finished before F_MMU_INV_RANGE.
> > > > b) Reduce the tlb timeout value from 100000us to 1000us. the original value
> > > > is so long that affect the multimedia performance.
> > >
> > > By definition, timeout is something that should not normally happen.
> > > Too long timeout affecting multimedia performance would suggest that
> > > the timeout was actually happening, which is the core problem, not the
> > > length of the timeout. Could you provide more details on this?
> >
> > As description above, this issue is because there is no dom->pgtlock in
> > the mtk_iommu_iotlb_sync. I have tried that the issue will disappear
> > after adding lock in it.
> >
> > Although the issue is fixed after this patch, I still would like to
> > reduce the timeout value for somehow error happen in the future. 100ms
> > is unnecessary for us. It looks a minor improvement rather than fixing
> > the issue. I will use a new patch for it.
> >
> 
> Okay, makes sense.
> 
> Best regards,
> Tomasz


