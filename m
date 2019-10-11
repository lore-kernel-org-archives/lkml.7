Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA8CC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA62196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570770135;
	bh=gL4yGj0SioGU1fefwakreiUM7DxKSrIrbCHtwBEgApM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fVlsPQ4NwSH4iETX+ngXLsTnPXabHHkk1rEMnLTUElCTF64f49HTQVX6YmU8XzNss
	 V3d/JRx5UsczMni8UL9rR67Sl/0BGWBj7R1keuWVlEKAFqIFyI/vBlpLlvzsQNF/RP
	 J/X75qfAr8cK8SWTQubeXI8uvX3R44BGkehrZ7yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfJKFCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJKFCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:02:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C878214E0;
        Fri, 11 Oct 2019 05:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570770130;
        bh=gL4yGj0SioGU1fefwakreiUM7DxKSrIrbCHtwBEgApM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boAOtvmCgRi3utYxVgbaKp/aOrYMOXLTUoZ4+SDlZRQ4FMEhDMiOXkGQLIcbmLvOM
         nGxxJ4yX4yyVDd60TH67Coyw5iTm3Dl3MbKo0pN2023VfERjvxVFX4wk8/c8ij47mq
         O68rooK6BtpQmjGir5uykiTv931nWb+IR8x70CYQ=
Date:   Fri, 11 Oct 2019 07:02:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <20191011050208.GA978459@kroah.com>
References: <20191010222829.21940-1-keescook@chromium.org>
 <20191010222829.21940-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010222829.21940-2-keescook@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:28:28PM -0700, Kees Cook wrote:
> As we've seen from USB and other areas[1], we need to always do runtime
> checks for DMA operating on memory regions that might be remapped. This
> adds vmap checks (similar to those already in USB but missing in other
> places) into dma_map_single() so all callers benefit from the checking.
> 
> [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
> 
> Suggested-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/dma-mapping.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a1c4fca475a..ff4e91c66f44 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	/* DMA must never operate on areas that might be remapped. */
> +	if (unlikely(is_vmalloc_addr(ptr))) {
> +		dev_warn_once(dev, "bad map: %zu bytes in vmalloc\n", size);

Can we get a bit better error text here?  In USB we were at least giving
people a hint as to what went wrong, "bad map" might not really make
that much sense to a USB developer as to what they needed to do to fix
this issue.

Other than that minor nit, I have no objection to this series, thanks
for fixing this up!

greg k-h
