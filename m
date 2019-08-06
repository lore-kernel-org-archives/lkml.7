Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18779C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0259208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="VF/YxkoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfHFTrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:47:19 -0400
Received: from alpha.anastas.io ([104.248.188.109]:34451 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFTrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:47:19 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 15:47:19 EDT
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 2FB9F7F91A;
        Tue,  6 Aug 2019 14:39:08 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1565120352; bh=HXAHKgiQsfJr2nTxca5W5Al0GVPsqRNPo3FiFtTBIoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VF/YxkoGj8ca1JQcWi5sYSQVWRKBYyZtR9HUzDE+ew2GrVyUCIeEXZFt6rVd6W6wg
         vtSTCcBTAjJH0ZszPuJKYt0eFgEDwICoBRPS0wGBydBz0++9N23+H7Ed3B5qGV1VMC
         LvZrV59lni9MLs/JcvnzGbRKNJzNv+d8Qk4W2RBQao6w281+TddI5F/TzpRT8SkiIO
         nhUyXU745H9K0uufXJpjZAa7VpAkGr/JSB0EdEr/q/xdFRPa19oitpAqc+ktLxg9Is
         kcvPFe0HGSSTtWUCJqLE5dUJRbo5Vz5U2m6kzrfDAVngIfOzeFSuQSEh/otww7M/bt
         SjEGu4AGs8jvg==
Subject: Re: [PATCH 1/2] dma-mapping: fix page attributes for dma_mmap_*
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gavin Li <git@thegavinli.com>
References: <20190805080145.5694-1-hch@lst.de>
 <20190805080145.5694-2-hch@lst.de>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <7df95ffb-6df3-b118-284c-ee32cad81199@anastas.io>
Date:   Tue, 6 Aug 2019 21:39:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190805080145.5694-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 10:01 AM, Christoph Hellwig wrote:
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 3813211a9aad..9ae5cee543c4 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -42,13 +42,8 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   		dma_addr_t dma_addr, unsigned long attrs);
>   long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
>   		dma_addr_t dma_addr);
> -
> -#ifdef CONFIG_ARCH_HAS_DMA_MMAP_PGPROT
>   pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
>   		unsigned long attrs);
> -#else
> -# define arch_dma_mmap_pgprot(dev, prot, attrs)	pgprot_noncached(prot)
> -#endif

Nit, but maybe the prototype should still be ifdef'd here? It at least
could prevent a reader from incorrectly thinking that the function is
always present.

Also, like Will mentioned earlier, the function name isn't entirely
accurate anymore. I second the suggestion of using something like
arch_dma_noncoherent_pgprot(). As for your idea of defining
pgprot_dmacoherent for all architectures as

#ifndef pgprot_dmacoherent
#define pgprot_dmacoherent pgprot_noncached
#endif

I think that the name here is kind of misleading too, since this
definition will only be used when there is no support for proper
DMA coherency.

