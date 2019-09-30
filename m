Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB3C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3EC21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569845374;
	bh=T9SJSGU8WXO5UsIOSvNDLMijEaReW5+dr3E41swIY98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ww7dK7QNi4NCSz64w2HpE3V6MwtDKJSzQ9/x+kagiPw1z3I6rLkoofOItBNunLVRo
	 g9zmrBDE0HQuXCLmxCPZI9xyoHXWE59pXHPxl+9bUJyMiqMKqWKsm65Ym4K5JcMYGe
	 w03WZUciO3rm9ghG68ckvaP+Gh6dzSjbSqCTJkE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfI3MJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfI3MJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:09:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E43206C0;
        Mon, 30 Sep 2019 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569845373;
        bh=T9SJSGU8WXO5UsIOSvNDLMijEaReW5+dr3E41swIY98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yXC7VC+skmjWzmwCouYtMdDU+SNlxZHXtQ/mbwq6tDKFujDyqWYETrOlU3yBpanVd
         t/BPYmnze36c5QXEAlQQ8qQ05Yeo0SFhBy2mRlWC5kNCz0C6tjFYCaxSo1Daz+n9pv
         JIwrt+D0Ywqyr9eDIYz8fkeoXiv5ezfl6BcSGWdE=
Date:   Mon, 30 Sep 2019 13:09:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
Message-ID: <20190930120926.t26ydhgggi2scg3e@willie-the-truck>
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 01:42:22PM +0800, Yong Wu wrote:
> The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> lacked the dom->pgtlock, then it will cause the variable
> "tlb_flush_active" may be changed unexpectedly, we could see this warning
> log randomly:
> 
> mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> full flush
> 
> To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> And when checking this issue, we find that __arm_v7s_unmap call
> io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> this also is potential unsafe for us. There is no tlb flush queue in the
> MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> If v7s don't always gurarantee the sequence, Thus, In this patch I move
> the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> and we don't care if it is leaf, rearrange the callback functions. Also,
> the tlb flush/sync was already finished in v7s, then iotlb_sync and
> iotlb_sync_all is unnecessary.
> 
> Besides, there are two minor changes:
> a) Use writel for the register F_MMU_INV_RANGE which is for triggering the
> HW work. We expect all the setting(iova_start/iova_end...) have already
> been finished before F_MMU_INV_RANGE.
> b) Reduce the tlb timeout value from 100000us to 1000us. the original value
> is so long that affect the multimedia performance.
> 
> Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> This patch looks break the logic for tlb_flush and tlb_sync. I'm not
> sure if it
> is reasonable. If someone has concern, I could change:
> a) Add dom->pgtlock in the mtk_iommu_iotlb_sync
> b) Add a io_pgtable_tlb_sync in [1].

The patch looks ok to me, but please could you split it up so that the
timeout and writel are done separately?

Thanks,

Will
