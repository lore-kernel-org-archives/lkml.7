Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE5C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0F8206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfJHISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:18:42 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28715 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730309AbfJHISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:18:41 -0400
X-UUID: 0b511a8e3bf04a068a8709439614994f-20191008
X-UUID: 0b511a8e3bf04a068a8709439614994f-20191008
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1743715037; Tue, 08 Oct 2019 16:18:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Oct
 2019 16:18:33 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Oct 2019 16:18:32 +0800
Message-ID: <1570522712.19130.42.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 8 Oct 2019 16:18:32 +0800
In-Reply-To: <20190930120926.t26ydhgggi2scg3e@willie-the-truck>
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
         <20190930120926.t26ydhgggi2scg3e@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 7D17782CEA9D438245218EEEE6BBEC1C3BB60458E15FE650459FFB65E1DB5FFA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-30 at 13:09 +0100, Will Deacon wrote:
> On Mon, Sep 30, 2019 at 01:42:22PM +0800, Yong Wu wrote:
> > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > lacked the dom->pgtlock, then it will cause the variable
> > "tlb_flush_active" may be changed unexpectedly, we could see this warning
> > log randomly:
> > 
> > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > full flush
> > 
> > To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> > And when checking this issue, we find that __arm_v7s_unmap call
> > io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> > this also is potential unsafe for us. There is no tlb flush queue in the
> > MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> > If v7s don't always gurarantee the sequence, Thus, In this patch I move
> > the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> > and we don't care if it is leaf, rearrange the callback functions. Also,
> > the tlb flush/sync was already finished in v7s, then iotlb_sync and
> > iotlb_sync_all is unnecessary.
> > 
> > Besides, there are two minor changes:
> > a) Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > HW work. We expect all the setting(iova_start/iova_end...) have already
> > been finished before F_MMU_INV_RANGE.
> > b) Reduce the tlb timeout value from 100000us to 1000us. the original value
> > is so long that affect the multimedia performance.
> > 
> > Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > This patch looks break the logic for tlb_flush and tlb_sync. I'm not
> > sure if it
> > is reasonable. If someone has concern, I could change:
> > a) Add dom->pgtlock in the mtk_iommu_iotlb_sync
> > b) Add a io_pgtable_tlb_sync in [1].
> 
> The patch looks ok to me, but please could you split it up so that the
> timeout and writel are done separately?

Thanks for the quick review, I will separate them.

> 
> Thanks,
> 
> Will


