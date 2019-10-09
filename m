Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48291C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122E220B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwHQym2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJIG5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:57:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vKBYsQl0kFkDyRT0YqTcpHkTEz1PkuhlbRjhgXM8cpI=; b=ZwHQym2evAmhibdUSByOi4oUR
        bjhksOQoCEsVgWc1Q7wt4kWAT4Qn+mT8oJq1nsHWv5QWqRdAYS23zZXfCI1HjYth326SrqPDAWzaX
        txIsXC5PlOjyr0IVvhgCg9ccyKd2Cei3w0mr3fkf+Zf4ZC6zFU1fNeU6slJbqWmNKZG7mBmOd2pfh
        He9wexKeaahpCma16N86FmPTvXYD2/HNgyX18UreFdYmTusZFm6MQ7fMiQK3E5MijC/wUeWkH1nVt
        Tf1uXz2T15Why6bUyJ5C5oAKWlSAVLY93rRlxUmzU/SLNOTxQP8m1LNRvZ5tBZT1XDPyuE+C910Ht
        +3kNrli3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iI5uw-0004hU-S3; Wed, 09 Oct 2019 06:57:50 +0000
Date:   Tue, 8 Oct 2019 23:57:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, Kit Chow <kchow@gigaio.com>
Subject: Re: [PATCH 1/3] iommu/amd: Implement dma_[un]map_resource()
Message-ID: <20191009065750.GA17832@infradead.org>
References: <20191008221837.13067-1-logang@deltatee.com>
 <20191008221837.13067-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008221837.13067-2-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:18:35PM -0600, Logan Gunthorpe wrote:
> From: Kit Chow <kchow@gigaio.com>
> 
> Currently the Intel IOMMU uses the default dma_[un]map_resource()

s/Intel/AMD/ ?

> +static dma_addr_t map_resource(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct protection_domain *domain;
> +	struct dma_ops_domain *dma_dom;
> +
> +	domain = get_domain(dev);
> +	if (PTR_ERR(domain) == -EINVAL)
> +		return (dma_addr_t)paddr;

I thought that case can't happen anymore?

Also note that Joerg just applied the patch to convert the AMD iommu
driver to use the dma-iommu ops.  Can you test that series and check
it does the right thing for your use case?  From looking at the code
I think it should.
