Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1757C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D76E217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfEURU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:20:26 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33696 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727990AbfEURU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:20:26 -0400
Received: (qmail 6374 invoked by uid 2102); 21 May 2019 13:20:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 May 2019 13:20:25 -0400
Date:   Tue, 21 May 2019 13:20:25 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
cc:     hch@lst.de, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <marex@denx.de>, <leoyang.li@nxp.com>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <noring@nocrew.org>, <JuergenUrban@gmx.de>
Subject: Re: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
In-Reply-To: <20190521140748.20012-3-laurentiu.tudor@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1905211309270.1634-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 laurentiu.tudor@nxp.com wrote:

> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> For HCs that have local memory, replace the current DMA API usage
> with a genalloc generic allocator to manage the mappings for these
> devices. To help users, introduce a new HCD API,
> usb_hcd_setup_local_mem() that will setup up the genalloc backing
> up the device local memory. It will be used in subsequent patches.
> This is in preparation for dropping the existing "coherent" dma
> mem declaration APIs. Current implementation was relying on a short
> circuit in the DMA API that in the end, was acting as an allocator
> for these type of devices.
> 
> For context, see thread here: https://lkml.org/lkml/2019/4/22/357
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---

> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -29,6 +29,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/types.h>
> +#include <linux/genalloc.h>
> +#include <linux/io.h>
>  
>  #include <linux/phy/phy.h>
>  #include <linux/usb.h>
> @@ -3039,6 +3041,40 @@ usb_hcd_platform_shutdown(struct platform_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_hcd_platform_shutdown);
>  
> +int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
> +			    dma_addr_t dma, size_t size)
> +{
> +	int err;
> +	void __iomem *local_mem;
> +
> +	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
> +						  dev_to_node(hcd->self.sysdev),
> +						  "ohci-hcd");

Surely that string is a mistake.  You could use 
dev_name(hcd->self.sysdev) or a name passed by the caller.

> +	if (IS_ERR(hcd->localmem_pool))
> +		return PTR_ERR(hcd->localmem_pool);
> +
> +	local_mem = devm_memremap(hcd->self.sysdev, phys_addr,
> +				  size, MEMREMAP_WC);
> +	if (!local_mem)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Here we pass a dma_addr_t but the arg type is a phys_addr_t.
> +	 * It's not backed by system memory and thus there's no kernel mapping
> +	 * for it.
> +	 */
> +	err = gen_pool_add_virt(hcd->localmem_pool, (unsigned long)local_mem,
> +				dma, size, dev_to_node(hcd->self.sysdev));
> +	if (err < 0) {
> +		dev_err(hcd->self.sysdev, "gen_pool_add_virt failed with %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_hcd_setup_local_mem);

If you have a usb_hcd_setup_local_mem() function then you should also 
have a usb_hcd_remove_local_mem() function.

> --- a/drivers/usb/host/ohci-mem.c
> +++ b/drivers/usb/host/ohci-mem.c
> @@ -36,6 +36,12 @@ static void ohci_hcd_init (struct ohci_hcd *ohci)
>  
>  static int ohci_mem_init (struct ohci_hcd *ohci)
>  {
> +	if (ohci_to_hcd(ohci)->localmem_pool) {
> +		ohci->td_cache = NULL;
> +		ohci->ed_cache = NULL;
> +		return 0;
> +	}

This really isn't necessary.  The entire ohci_hcd structure is
initialized to 0 when it is first allocated.

> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -216,6 +216,9 @@ struct usb_hcd {
>  #define	HC_IS_RUNNING(state) ((state) & __ACTIVE)
>  #define	HC_IS_SUSPENDED(state) ((state) & __SUSPEND)
>  
> +	/* allocator for HCs having local memory */

"allocator" is the wrong word -- an allocator is something that 
allocates.  Perhaps "memory area" or something along those lines.

Alan Stern

