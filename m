Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DBAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD47C2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4MBxL3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfDXOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:32:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbfDXOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HH6es2owcH1NcV2/iXg+dvHnsEeqH9IglqJIj3+7hj8=; b=F4MBxL3d56lZLKwK2Dt9NbXbG
        Y6yc9XvLpG4AXRwmThWqtySUpjjaMbKclSBKS+x7vFyIy0ZA+oANaRj6QhwwCwz8VtjlPcVGg9JFC
        cOL3sF5/EmtJKKT4Q0OGQlx/T3fr9fwc9u+6ca9mMxieBuBYo1hx05k0QfvgterpvNu37rdj8DFHz
        vee6uyung/Ue7elGZKJiSYTKEfeIpSWUlBUDq+QIu6K58DGk2H2q9BJ83wEkFhTdUuDgs5sQaitxN
        DngHKU7Q+1iNG6WraZo5JIkwKC2rTNzcZK70jgc8sNF/4oqnn8wklLOhVlczF24mrSbj1zZj07utm
        eJ9QdC7eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJIx4-0008FO-5m; Wed, 24 Apr 2019 14:32:46 +0000
Date:   Wed, 24 Apr 2019 07:32:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        murphyt7@tcd.ie
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190424143246.GA24079@infradead.org>
References: <20190424141900.8883-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424141900.8883-1-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:18:59PM +0100, Tom Murphy via iommu wrote:
> check if there is a not-present cache present and flush it if there is.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f7cdd2ab7f11..8ef43224aae0 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
>  		pte[i] = __pte;
>  
>  	update_domain(dom);
> +	if (!dom->updated) {
> +		if (unlikely(amd_iommu_np_cache)) {
> +			domain_flush_pages(dom, bus_addr, page_size);
> +			domain_flush_complete(dom);
> +		}
> +	}

The two conditions can go into one if statement to make this a little
more clear.

And I'd really like to understand the unlikely - amd_iommu_np_cache
is set based on a hardware capability, so it seems rather odd to mark
it unlikely.  Dynamic branch prediction really should do the right thing
here usually.
