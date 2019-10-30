Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7564CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA12067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uEYvzQ1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfJ3Vln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:41:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RjClCXbIwBQLkxNlWfstc40OfJNOOeU+sDESejAVB2Q=; b=uEYvzQ1nc3dk6wMfF5V6miAgo
        Dkirmio0pEoS9DinmkrCztgl5Na8Evqct0LleL21apd0iabo4P9B3KbbmMDP3o/xndED4gtxctkvs
        28Qj52OIYqR/Dh4hmObviIYooPZdmPIvquPzWtQU7QFJddYbJDVJSY2MqoexYALVqErggcziqLXWA
        iHtvXIhX/PD9qmfE+LLqlCrPwSLChbAaoGX+J0gYQh8Rp4baHCraZcGfUgxcTrW+eldc/s5iia8Oi
        Je/Gw3aK7RPlhAfWgf1Zmc/Ao1Ya32dA6O7bBrWud74vKKjb7fjN4PEnfNeeZXizDojP6GoCpgCAu
        gO+r5sQ4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPvim-00020g-Ao; Wed, 30 Oct 2019 21:41:40 +0000
Date:   Wed, 30 Oct 2019 14:41:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     rubini@gnudd.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, helgaas@kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] dma-direct: check for overflows on 32 bit DMA
 addresses
Message-ID: <20191030214140.GB25515@infradead.org>
References: <20191018110044.22062-1-nsaenzjulienne@suse.de>
 <20191018110044.22062-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018110044.22062-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:00:43PM +0200, Nicolas Saenz Julienne wrote:
> +#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +	/* Check if DMA address overflowed */
> +	if (min(addr, addr + size - 1) <
> +		__phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
> +		return false;
> +#endif

Would be nice to use IS_ENABLED and PFN_PHYS here, and I also think we
need to use phys_to_dma to take care of the encryption bit.  If you then
also introduce an end variable we can make the whole thing actually look
nice:

static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
{
	dma_addr_t end = addr + size - 1;

        if (!dev->dma_mask)
                return false;

	if (!IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
		return false;

        return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
}

Otherwise this looks sensible to me.
