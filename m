Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F8FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CA92067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404056AbfJPQDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:03:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbfJPQDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:03:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 852C0B412;
        Wed, 16 Oct 2019 16:03:16 +0000 (UTC)
Date:   Wed, 16 Oct 2019 18:03:14 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
Message-ID: <20191016160314.GH4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
 <1571237982.5937.60.camel@lca.pw>
 <20191016153112.GF4695@suse.de>
 <1571241213.5937.64.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571241213.5937.64.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:53:33AM -0400, Qian Cai wrote:
> On Wed, 2019-10-16 at 17:31 +0200, Joerg Roedel wrote:

> The x86 one might just be a mistake.
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index ad05484d0c80..63c4b894751d 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2542,7 +2542,7 @@ static int amd_iommu_map(struct iommu_domain *dom,
> unsigned long iova,
>         if (iommu_prot & IOMMU_WRITE)
>                 prot |= IOMMU_PROT_IW;
>  
> -       ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
> +       ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);

Yeah, that is a bug, I spotted that too.

> @@ -1185,7 +1185,7 @@ static struct iommu_dma_msi_page
> *iommu_dma_get_msi_page(struct device *dev,
>         if (!iova)
>                 goto out_free_page;
>  
> -       if (iommu_map(domain, iova, msi_addr, size, prot))
> +       if (iommu_map_atomic(domain, iova, msi_addr, size, prot))
>                 goto out_free_iova;

Not so sure this is a bug, this code is only about setting up MSIs on
ARM. It probably doesn't need to be atomic.

Regards,

	Joerg
