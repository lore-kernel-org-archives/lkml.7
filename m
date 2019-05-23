Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B7F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfEWMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:33:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfEWMdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:33:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA87B80D;
        Thu, 23 May 2019 05:33:03 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E153F575;
        Thu, 23 May 2019 05:33:02 -0700 (PDT)
Subject: Re: implement generic dma_map_ops for IOMMUs v6
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20190523070028.7435-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <60f73595-006d-8f88-f5af-d362f9e42ec1@arm.com>
Date:   Thu, 23 May 2019 13:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523070028.7435-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2019 08:00, Christoph Hellwig wrote:
> 
> Hi Robin and Joerg,
> 
> I think we are finally ready for the generic dma-iommu series.  I have
> various DMA API changes pending, and Tom has patches ready to convert
> the AMD and Intel iommu drivers over to it.  I'd love to have this
> in a stable branch shared between the dma-mapping and iommu trees
> the day after rc2 is released.  I volunteer to create the branch,
> but I'm fine with it living in the iommu tree as well.

Yup, I'd also like to see this in -next ASAP in the hope that board 
farms and maybe even real users can start chewing on it. Thanks for 
persevering :)

Robin.

> 
> 
> A git tree is also available at:
> 
>      git://git.infradead.org/users/hch/misc.git dma-iommu-ops.6
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.6
> 
> Changes since v5:
>   - rebased to latest linus tree and dropped a patch now merged
>   - remove the now pointless __dma_iommu_mmap function
>   - restore a cleanup from Robin that would have caused a conflict in
>     last merge winow, but is fine now
> 
> Changes since v4:
>   - rebased to 5.2-rc1
> 
> Changes since v3:
>   - fold the separate patch to refactor mmap bounds checking
>   - don't warn on not finding a vm_area
>   - improve a commit log
>   - refactor __dma_iommu_free a little differently
>   - remove a minor MSI map cleanup to avoid a conflict with the
>     "Split iommu_dma_map_msi_msg" series
> 
> Changes since v2:
>   - address various review comments and include patches from Robin
> 
> Changes since v1:
>   - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
>   - keep using a scatterlist in iommu_dma_alloc
>   - split out mmap/sgtable fixes and move them early in the series
>   - updated a few commit logs
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
