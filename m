Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFAFA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8F22089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFBW3KU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502377AbfJQQY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:24:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389405AbfJQQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tM11n8HxbnKWuIhVBFZir6ZW0eaOohaPCZqy9IypX4U=; b=SFBW3KU2AFnuPudmAUQJa1JCr
        lzNCY42eqxDiR5TpNp5EuDL8nzHiMAQ48K5MeYMzAxKbrGFWSDWMk8nwju4mlbJTvAvLQ+hE0IPXH
        wW6N08roi74hu6tGILnTfvmhDThfE55UeyADHlEOntoNPWirpMlWavoCHICueEnFAG6sWhJHWx6Cw
        cj9RGPjUb8JTHrccwaeYX3JtE/Coju00bGauyGPykagxvMPlG/cOuiXRXQgzh8FX1h6VHS30t6Ngq
        ImVcFe7rnAxwd9JQj8INAsbLw+PQP10U7atjrXkNsLllu8GjFi9/4yAo5AkcuQoqV7hKkcB7BrxLW
        vMka7sSwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL8a5-0005qh-Mk; Thu, 17 Oct 2019 16:24:53 +0000
Date:   Thu, 17 Oct 2019 09:24:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org, maz@kernel.org,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] iommu/dma: Relax locking in iommu_dma_prepare_msi()
Message-ID: <20191017162453.GA6012@infradead.org>
References: <5af5e77102ca52576cb96816f0abcf6398820055.1571245656.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af5e77102ca52576cb96816f0abcf6398820055.1571245656.git.robin.murphy@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:07:36PM +0100, Robin Murphy wrote:
> @@ -1180,7 +1179,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  	struct iommu_dma_cookie *cookie;
>  	struct iommu_dma_msi_page *msi_page;
> -	unsigned long flags;
> +	static DEFINE_MUTEX(msi_prepare_lock);

Just a style nitpick, but I find locks declared inside functions
really weird.  In addition to that locks not embedded into a structure
and not directly next to variables or data structures they protect
really need a comment explaining what they are trying to serialize.
