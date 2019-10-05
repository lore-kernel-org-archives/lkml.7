Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E2EC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6A222C7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 08:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfJEIkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 04:40:40 -0400
Received: from verein.lst.de ([213.95.11.211]:49377 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEIkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 04:40:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EC3168B05; Sat,  5 Oct 2019 10:40:34 +0200 (CEST)
Date:   Sat, 5 Oct 2019 10:40:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] dma-mapping: Move vmap address checks into
 dma_map_single()
Message-ID: <20191005084033.GA14801@lst.de>
References: <201910041420.F6E55D29A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910041420.F6E55D29A@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please split the usb and dma-mapping parts into separate patches.

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a1c4fca475a..12dbd07f74f2 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -583,6 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	/* DMA must never operate on areas that might be remapped. */
> +	if (WARN_ONCE(is_vmalloc_addr(ptr),
> +		      "%s %s: driver maps %lu bytes from vmalloc area\n",
> +		      dev ? dev_driver_string(dev) : "unknown driver",
> +		      dev ? dev_name(dev) : "unknown device", size))
> +		return DMA_MAPPING_ERROR;

a NULL device isn't supported any more, so we can remove the handling
for it here.
