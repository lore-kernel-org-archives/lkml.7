Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA45C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721C721928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571849752;
	bh=VPyPC4LePKk7uWBltRmK/Fded+OjFkz/1MBUzjK69yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=URXDyMr2WYR0fPdWYNsQ5L5irtcF3zLJzEMk3xQj6OBpvUnv9IXN0KJsMzJ+/o/vY
	 bnICj9XDV1qNAjjdNxuWVloSVms9jnb3K4K+3+RnwPhYdp/nrGWi6O/By1Mtgv87lT
	 yHhCIOGWwA/2KVThJW/ioKRpiBaO6D+17HTdwFkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfJWQzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfJWQzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:55:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255AC21906;
        Wed, 23 Oct 2019 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571849750;
        bh=VPyPC4LePKk7uWBltRmK/Fded+OjFkz/1MBUzjK69yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6EnkV+NncnzhwMOW6V6hkw45lZgsqg3/2TZtCGHZozEzQIq3KdMfSDzhP1HG7DEk
         M7mlDDT1+IBGeBeN7wjqNdxT1gyRg8gcrMld2vzIAOeKMgU6M5qaR4w4RXQRM3f8MR
         nDVUOk8sxVo9dbcnWMOHzMooezkVxez8zgQU2eWs=
Date:   Wed, 23 Oct 2019 17:55:44 +0100
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
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Use gather to achieve the tlb
 range flush
Message-ID: <20191023165543.GB27471@willie-the-truck>
References: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
 <1571196792-12382-4-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571196792-12382-4-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:33:08AM +0800, Yong Wu wrote:
> Use the iommu_gather mechanism to achieve the tlb range flush.
> Gather the iova range in the "tlb_add_page", then flush the merged iova
> range in iotlb_sync.
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c2f6c78..81ac95f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -245,11 +245,9 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>  					    void *cookie)
>  {
>  	struct mtk_iommu_data *data = cookie;
> -	unsigned long flags;
> +	struct iommu_domain *domain = &data->m4u_dom->domain;
>  
> -	spin_lock_irqsave(&data->tlb_lock, flags);
> -	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> -	spin_unlock_irqrestore(&data->tlb_lock, flags);
> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);

You need to be careful here, because iommu_iotlb_gather_add_page() can
call iommu_tlb_sync() in some situations and you don't hold the lock.

>  static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> @@ -469,9 +467,15 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>  				 struct iommu_iotlb_gather *gather)
>  {
>  	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> +	size_t length = gather->end - gather->start;
>  	unsigned long flags;
>  
> +	if (gather->start == ULONG_MAX)
> +		return;
> +
>  	spin_lock_irqsave(&data->tlb_lock, flags);
> +	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> +				       false, data);
>  	mtk_iommu_tlb_sync(data);
>  	spin_unlock_irqrestore(&data->tlb_lock, flags);

Modulo my comment above, this fixes my previous comment. Given that mainline
is already broken, I guess the runtime bisectability isn't a problem.

Will
