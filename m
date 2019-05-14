Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32044C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5F32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfENOmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:42:32 -0400
Received: from verein.lst.de ([213.95.11.211]:46209 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:42:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7826268B05; Tue, 14 May 2019 16:42:10 +0200 (CEST)
Date:   Tue, 14 May 2019 16:42:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [RFC PATCH v2 1/3] USB: use genalloc for USB HCs with local
 memory
Message-ID: <20190514144210.GA14625@lst.de>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com> <20190514143807.7745-2-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143807.7745-2-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -136,6 +137,10 @@ void *hcd_buffer_alloc(
>  		if (size <= pool_max[i])
>  			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
>  	}
> +
> +	if (hcd->driver->flags & HCD_LOCAL_MEM)
> +		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);

I think this check needs to be before the above code to use the dma
pools, as we should always use the HCD local memory.  Probably all the
way up just below the size == 0 check, that way we can also remove the
other HCD_LOCAL_MEM check.

> @@ -165,5 +170,10 @@ void hcd_buffer_free(
>  			return;
>  		}
>  	}
> -	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
> +
> +	if (hcd->driver->flags & HCD_LOCAL_MEM)
> +		gen_pool_free(hcd->localmem_pool, (unsigned long)addr,
> +			      size);
> +	else
> +		dma_free_coherent(hcd->self.sysdev, size, addr, dma);

Same here.

> @@ -505,8 +506,15 @@ static int ohci_init (struct ohci_hcd *ohci)
>  	timer_setup(&ohci->io_watchdog, io_watchdog_func, 0);
>  	ohci->prev_frame_no = IO_WATCHDOG_OFF;
>  
> -	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
> -			sizeof(*ohci->hcca), &ohci->hcca_dma, GFP_KERNEL);
> +	if (hcd->driver->flags & HCD_LOCAL_MEM)
> +		ohci->hcca = gen_pool_dma_alloc(hcd->localmem_pool,
> +						sizeof(*ohci->hcca),
> +						&ohci->hcca_dma);
> +	else
> +		ohci->hcca = dma_alloc_coherent(hcd->self.controller,
> +						sizeof(*ohci->hcca),
> +						&ohci->hcca_dma,
> +						GFP_KERNEL);

I wonder if we could just use hcd_buffer_alloc/free here, althought
that would require them to be exported.  I'll leave that decision to
the relevant maintainers, though.

Except for this the series looks exactly what I had envisioned to
get rid of the device local dma_declare_coherent use case, thanks!
