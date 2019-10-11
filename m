Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754FECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43EF21929
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570758127;
	bh=kuiJxqx7ftSjXbGl7w3Cj53FiBAzPrWqRAHm4ucmenI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=kt+ceINTWtxLdFFguZCEcdvYNhjecX6FNYj3tU1pYXlYEKZjphpYD1SJu+x1N9V+F
	 Y9lA9w5pspthVgqSDpsScwRbtePP2SNruz8bA5M/Nmyj49pLm+R0vI/opT9RgO/jPw
	 9NDEZffARcJWJ130A7dwlT3aeQXRcWQe3YK+8R4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfJKBmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfJKBmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:42:02 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC10020650;
        Fri, 11 Oct 2019 01:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570758121;
        bh=kuiJxqx7ftSjXbGl7w3Cj53FiBAzPrWqRAHm4ucmenI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JJn52lxUqYCMfBanJIi1nftwB1S1F6Gx+tmUVqgj3IQ3ltS5BXb5MEYPR0QSk23hy
         iIZLrlaemZJ7eqYcCpjh07CUnFOTvTfYzNcXvGgLI5/rzThQEKs3gt8ZSE1om21QBU
         Y4KtAPvqWYKHndyZOm7WqZuOTVKNTIKoqdw4hJU0=
Date:   Thu, 10 Oct 2019 18:42:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Rob Herring <robh@kernel.org>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] xen: Stop abusing DT of_dma_configure API
In-Reply-To: <20191008194155.4810-1-robh@kernel.org>
Message-ID: <alpine.DEB.2.21.1910101841380.9081@sstabellini-ThinkPad-T480s>
References: <20191008194155.4810-1-robh@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019, Rob Herring wrote:
> As the removed comments say, these aren't DT based devices.
> of_dma_configure() is going to stop allowing a NULL DT node and calling
> it will no longer work.
> 
> The comment is also now out of date as of commit 9ab91e7c5c51 ("arm64:
> default to the direct mapping in get_arch_dma_ops"). Direct mapping
> is now the default rather than dma_dummy_ops.
> 
> According to Stefano and Oleksandr, the only other part needed is
> setting the DMA masks and there's no reason to restrict the masks to
> 32-bits. So set the masks to 64 bits.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> v2:
>  - Setup dma masks
>  - Also fix xen_drm_front.c
>  
> This can now be applied to the Xen tree independent of the coming
> of_dma_configure() changes.
> 
> Rob
> 
>  drivers/gpu/drm/xen/xen_drm_front.c | 12 ++----------
>  drivers/xen/gntdev.c                | 13 ++-----------
>  2 files changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> index ba1828acd8c9..4be49c1aef51 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -718,17 +718,9 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>  	struct device *dev = &xb_dev->dev;
>  	int ret;
>  
> -	/*
> -	 * The device is not spawn from a device tree, so arch_setup_dma_ops
> -	 * is not called, thus leaving the device with dummy DMA ops.
> -	 * This makes the device return error on PRIME buffer import, which
> -	 * is not correct: to fix this call of_dma_configure() with a NULL
> -	 * node to set default DMA ops.
> -	 */
> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> -	ret = of_dma_configure(dev, NULL, true);
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  	if (ret < 0) {
> -		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
> +		DRM_ERROR("Cannot setup DMA mask, ret %d", ret);
>  		return ret;
>  	}
>  
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index a446a7221e13..81401f386c9c 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -22,6 +22,7 @@
>  
>  #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>  
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> @@ -34,9 +35,6 @@
>  #include <linux/slab.h>
>  #include <linux/highmem.h>
>  #include <linux/refcount.h>
> -#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> -#include <linux/of_device.h>
> -#endif
>  
>  #include <xen/xen.h>
>  #include <xen/grant_table.h>
> @@ -625,14 +623,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>  	flip->private_data = priv;
>  #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>  	priv->dma_dev = gntdev_miscdev.this_device;
> -
> -	/*
> -	 * The device is not spawn from a device tree, so arch_setup_dma_ops
> -	 * is not called, thus leaving the device with dummy DMA ops.
> -	 * Fix this by calling of_dma_configure() with a NULL node to set
> -	 * default DMA ops.
> -	 */
> -	of_dma_configure(priv->dma_dev, NULL, true);
> +	dma_coerce_mask_and_coherent(priv->dma_dev, DMA_BIT_MASK(64));
>  #endif
>  	pr_debug("priv %p\n", priv);
>  
> -- 
> 2.20.1
> 
