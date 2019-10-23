Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1970021928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571849582;
	bh=F5Izp3I8AX+Ri+LTIkBe2psZof2nJUu/2jw8CqPmo+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qDLSUJQlNFI1HJkMKR5ZVF4hhBVDE8SB0dEm+j5DbCneFkvDh15wKjKOmi7e7c3SK
	 QDdz29wvYHSO/fUPWpp/7/oB63w81ippl09Wramngz9UgL6bRTkxNBHs4BzcRtoWgu
	 R741YPSzQSlxYlS55w9/RPFaDxbq5kH0zM+GrT1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfJWQxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfJWQxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:53:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2EF21906;
        Wed, 23 Oct 2019 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571849579;
        bh=F5Izp3I8AX+Ri+LTIkBe2psZof2nJUu/2jw8CqPmo+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vM3wriHv2BCfsl4QWE/Yo0Tr9tEwuSOYD/+jXqoi+TwKpYLw+r7KqC/INuDeE6paR
         8kN95fF7O/278RKBRp+COHuOA0qlcJLdeS3sShi0ETrCZk8FOTwW3RTHbduQUIfc83
         EcxQlpdh+2SDSt3EWDK/G1983yOPo7V7MQo9/1sY=
Date:   Wed, 23 Oct 2019 17:52:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        edison.hsieh@mediatek.com
Subject: Re: [PATCH v4 2/7] iommu/mediatek: Add a new tlb_lock for tlb_flush
Message-ID: <20191023165252.GA27471@willie-the-truck>
References: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
 <1571196792-12382-3-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571196792-12382-3-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:33:07AM +0800, Yong Wu wrote:
> The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> lacked the lock, then it will cause the variable "tlb_flush_active"
> may be changed unexpectedly, we could see this warning log randomly:
> 
> mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> full flush
> 
> The HW requires tlb_flush/tlb_sync in pairs strictly, this patch adds
> a new tlb_lock for tlb operations to fix this issue.
> 
> Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB
> sync")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 23 ++++++++++++++++++++++-
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 23 insertions(+), 1 deletion(-)

[...]

>  static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>  					    unsigned long iova, size_t granule,
>  					    void *cookie)
>  {
> +	struct mtk_iommu_data *data = cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data->tlb_lock, flags);
>  	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> +	spin_unlock_irqrestore(&data->tlb_lock, flags);

Given that you release the lock here, what prevents another nosync()
operation being issued before you've managed to do the sync()?

Will
