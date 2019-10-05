Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3906EC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 07:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93B2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570260383;
	bh=xFrXVj45JYqwx14emMFIPwY8ZuiE+j2pGgmNe8jT3vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1LV+L3/kIqNreEbxo1EHhhSP45A4dZYJ8NskjiJkO4zFjC8cFRzDoZOINeJ/5oJn6
	 GeY1AjAiSUpXcwKVPwdJMoeWtGCCqv3S/+AEmp+AJjsh0x0fhdjtvVxV1Yu4z68Qh2
	 hiDmhEn3eUN9A197XC6ydSSoAZaFsjFgVbR1xhaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfJEH0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 03:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEH0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 03:26:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EF120830;
        Sat,  5 Oct 2019 07:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570260381;
        bh=xFrXVj45JYqwx14emMFIPwY8ZuiE+j2pGgmNe8jT3vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htZNkApCedGQroo8d6Fz6NZ17pKIL5w52kCPF98KRNd3LBUeP4ewyKCqBya09yPc8
         rpXlwcINKSgJY87L/3GiNqdVcIsmj2iuryXkw53Exrqk0rK3GBqpZQdTUSjIAzpK7E
         Mho1CPRlJ4eTErIoDFtt9E5zWoE/LSDwCnYVtNio=
Date:   Sat, 5 Oct 2019 09:26:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] dma-mapping: Move vmap address checks into
 dma_map_single()
Message-ID: <20191005072618.GA930906@kroah.com>
References: <201910041420.F6E55D29A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910041420.F6E55D29A@keescook>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:28:16PM -0700, Kees Cook wrote:
> As we've seen from USB and other areas, we need to always do runtime
> checks for DMA operating on memory regions that might be remapped. This
> moves the existing checks from USB into dma_map_single(), but leaves
> the slightly heavier checks as they are.
> 
> Suggested-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: Only add is_vmalloc_addr()
> v1: https://lore.kernel.org/lkml/201910021341.7819A660@keescook
> ---
>  drivers/usb/core/hcd.c      | 8 +-------
>  include/linux/dma-mapping.h | 7 +++++++
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index f225eaa98ff8..281568d464f9 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  		if (hcd->self.uses_pio_for_control)
>  			return ret;
>  		if (hcd_uses_dma(hcd)) {
> -			if (is_vmalloc_addr(urb->setup_packet)) {
> -				WARN_ONCE(1, "setup packet is not dma capable\n");
> -				return -EAGAIN;
> -			} else if (object_is_on_stack(urb->setup_packet)) {
> +			if (object_is_on_stack(urb->setup_packet)) {
>  				WARN_ONCE(1, "setup packet is on stack\n");
>  				return -EAGAIN;
>  			}
> @@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  					ret = -EAGAIN;
>  				else
>  					urb->transfer_flags |= URB_DMA_MAP_PAGE;
> -			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
> -				WARN_ONCE(1, "transfer buffer not dma capable\n");
> -				ret = -EAGAIN;
>  			} else if (object_is_on_stack(urb->transfer_buffer)) {
>  				WARN_ONCE(1, "transfer buffer is on stack\n");
>  				ret = -EAGAIN;
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

If you use dev_warn() here you get all of that "unknown driver/device"
checking and handling set properly.  And it's in the "standard" format
that userspace tools know how to check.

thanks,

greg k-h
