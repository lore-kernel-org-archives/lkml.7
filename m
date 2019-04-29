Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57EAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907692075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TN1+azQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfD2UDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:03:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfD2UDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gXBZVUg4jQbTWNl/rOtvrBvT8zt4gzjmR4Rn7XZccXU=; b=TN1+azQlisq62Mso/YE6137jh
        dstuCHzj9XfNBJXgcAAm+Heqp8Vrft4jW4co4zD6xNMZt1YpgbG84RFfEunMIJxDVi86SaXtJJMCN
        IdUGN3+vF9/1ap56HXZq206cDipNDutppFbktg705F5ZdiuIGqR27GlLTOTTVM1cPqyP3De7MThCi
        En/BcrH3CglsKGIkLWiKGsVMyBqNik4jODOTi2TjxPJcVUy0mpKMFniparDi3tb919wEfIdpfGIaC
        4nrqM+FZGig2pP0yXHPcISAgCR8JBUGSYR/ZdpcdjgRvf3Xllvu3x4FVn2PGQ62+7bKTtZfaZhC3T
        zS+K+Q3XQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLCV0-0005Qy-Ty; Mon, 29 Apr 2019 20:03:38 +0000
Date:   Mon, 29 Apr 2019 13:03:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v3 5/8] iommu/vt-d: Implement def_domain_type iommu ops
 entry
Message-ID: <20190429200338.GA8412@infradead.org>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
 <20190429020925.18136-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429020925.18136-6-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -3631,35 +3607,30 @@ static int iommu_no_mapping(struct device *dev)
>  	if (iommu_dummy(dev))
>  		return 1;
>  
> -	if (!iommu_identity_mapping)
> -		return 0;
> -

FYI, iommu_no_mapping has been refactored in for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/vt-d&id=48b2c937ea37a3bece0094b46450ed5267525289

>  	found = identity_mapping(dev);
>  	if (found) {
> +		/*
> +		 * If the device's dma_mask is less than the system's memory
> +		 * size then this is not a candidate for identity mapping.
> +		 */
> +		u64 dma_mask = *dev->dma_mask;
> +
> +		if (dev->coherent_dma_mask &&
> +		    dev->coherent_dma_mask < dma_mask)
> +			dma_mask = dev->coherent_dma_mask;
> +
> +		if (dma_mask < dma_get_required_mask(dev)) {

I know this is mostly existing code moved around, but it really needs
some fixing.  For one dma_get_required_mask is supposed to return the
required to not bounce mask for the given device.  E.g. for a device
behind an iommu it should always just return 32-bit.  If you really
want to check vs system memory please call dma_direct_get_required_mask
without the dma_ops indirection.

Second I don't even think we need to check the coherent_dma_mask,
dma_direct is pretty good at always finding memory even without
an iommu.

Third this doesn't take take the bus_dma_mask into account.

This probably should just be:

		if (min(*dev->dma_mask, dev->bus_dma_mask) <
		    dma_direct_get_required_mask(dev)) {
