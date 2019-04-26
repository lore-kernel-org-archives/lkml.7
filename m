Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A2CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406502077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDZOEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:04:32 -0400
Received: from 8bytes.org ([81.169.241.247]:37764 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDZOEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:04:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2E59F447; Fri, 26 Apr 2019 16:04:31 +0200 (CEST)
Date:   Fri, 26 Apr 2019 16:04:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, murphyt7@tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190426140429.GG24576@8bytes.org>
References: <20190424165051.13614-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424165051.13614-1-tmurphy@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:50:51PM +0100, Tom Murphy wrote:
> check if there is a not-present cache present and flush it if there is.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f7cdd2ab7f11..91fe5cb10f50 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1637,6 +1637,11 @@ static int iommu_map_page(struct protection_domain *dom,
>  
>  	update_domain(dom);
>  
> +	if (unlikely(amd_iommu_np_cache && !dom->updated)) {
> +		domain_flush_pages(dom, bus_addr, page_size);
> +		domain_flush_complete(dom);
> +	}
> +

The iommu_map_page function is called once per physical page that is
mapped, so in the worst case for every 4k mapping established. So it is
not the right place to put this check in.

From a quick glance this check belongs into the map_sg() and the
amd_iommu_map() function, but without the dom->updated check.

Besides, to really support systems with np-cache in a way that doesn't
destroy all performance, the driver also needs range-flushes for IOTLBs.
Currently it can only flush a 4k page of the full address space of a
domain. But that doesn't mean we shouldn't fix the missing flushes now.

So please re-send the patch with the check at the two places I pointed
out above.

Thanks,

	Joerg
