Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC90C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1332214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570811399;
	bh=fnuGUPlEYnveHJBCoFm6BNlgI5r2U57EfCBDivju0X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSKV2zCMM71UvpduX7wRJ77vup4wYb8Lla1QXQxo1N9oqUqU9p+IWQnw9NRfBbfFH
	 dkOieya1UcTP4qpuds+P67Fxta7sxR4DNxblt+N67dkxs0QoyNrZsN0ppTprAv8yNC
	 fB54PGxVxajdJTz0iHVncyIRpbylrs/CC4A9SuB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfJKQ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKQ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:29:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B46B206A1;
        Fri, 11 Oct 2019 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570811397;
        bh=fnuGUPlEYnveHJBCoFm6BNlgI5r2U57EfCBDivju0X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OomCe3cnkNKTi9sl0Vi5Ay7Kjv8WBCQ1b6XD1IwK/cm0Z+poV3hmYgh7RkrBqwCoM
         pjntqLBD5FtPdil6R7y2/5GQGrCBGjJDN/rnwS1X4L1SuTDzWaZMxCS07pnlNkO1A9
         MsvzOVh7vA25gXMtLUEaPzD9qiGr3zcnOdprfiRU=
Date:   Fri, 11 Oct 2019 17:29:51 +0100
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
        cui.zhang@mediatek.com, chao.hao@mediatek.com
Subject: Re: [PATCH v2 3/4] iommu/mediatek: Use writel for TLB range
 invalidation
Message-ID: <20191011162950.yg4o77mlaicacne5@willie-the-truck>
References: <1570627143-29441-1-git-send-email-yong.wu@mediatek.com>
 <1570627143-29441-3-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570627143-29441-3-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:19:02PM +0800, Yong Wu wrote:
> Use writel for the register F_MMU_INV_RANGE which is for triggering the
> HW work. We expect all the setting(iova_start/iova_end...) have already
> been finished before F_MMU_INV_RANGE.
> 
> Signed-off-by: Anan.Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> This is a improvement rather than fixing a issue.
> ---
>  drivers/iommu/mtk_iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 24a13a6..607f92c 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -187,8 +187,7 @@ static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
>  		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
>  		writel_relaxed(iova + size - 1,
>  			       data->base + REG_MMU_INVLD_END_A);
> -		writel_relaxed(F_MMU_INV_RANGE,
> -			       data->base + REG_MMU_INVALIDATE);
> +		writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);

I don't understand this change.

Why is it an "improvement" and which accesses are you ordering with the
writel?

Will
