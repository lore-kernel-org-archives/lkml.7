Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3049FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EA020651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfD2PDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:03:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbfD2PDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:03:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0FAF80D;
        Mon, 29 Apr 2019 08:03:32 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689D63F5C1;
        Mon, 29 Apr 2019 08:03:31 -0700 (PDT)
Subject: Re: implement generic dma_map_ops for IOMMUs v3
To:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ae8ce99-65a8-711d-b17d-165df7e280d4@arm.com>
Date:   Mon, 29 Apr 2019 16:03:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> Hi Robin,
> 
> please take a look at this series, which implements a completely generic
> set of dma_map_ops for IOMMU drivers.  This is done by taking the
> existing arm64 code, moving it to drivers/iommu and then massaging it
> so that it can also work for architectures with DMA remapping.  This
> should help future ports to support IOMMUs more easily, and also allow
> to remove various custom IOMMU dma_map_ops implementations, like Tom
> was planning to for the AMD one.

Modulo a few nits, I think this looks pretty much good to go, and it 
would certainly be good to get as much as reasonable queued soon for the 
sake of progress elsewhere.

Catalin, Will, I think the arm64 parts are all OK but please take a look 
to confirm.

Thanks,
Robin.

> 
> A git tree is also available at:
> 
>      git://git.infradead.org/users/hch/misc.git dma-iommu-ops.3
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
> 
> Changes since v2:
>   - address various review comments and include patches from Robin
> 
> Changes since v1:
>   - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
>   - keep using a scatterlist in iommu_dma_alloc
>   - split out mmap/sgtable fixes and move them early in the series
>   - updated a few commit logs
> 
