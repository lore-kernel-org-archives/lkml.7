Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BBDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709DC20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFUUFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:05:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:34458 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725985AbfFUUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:05:25 -0400
Received: (qmail 11223 invoked by uid 2102); 21 Jun 2019 16:05:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jun 2019 16:05:24 -0400
Date:   Fri, 21 Jun 2019 16:05:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     shuah@kernel.org, <valentina.manea.m@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
In-Reply-To: <20190621174553.28862-3-suwan.kim027@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1906211548560.1471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019, Suwan Kim wrote:

> There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> doesn't supported SG. So, USB storage driver on vhci divides SG list
> into multiple URBs and it causes buffer overflow on the xhci of the
> server. So we need to add SG support to vhci

It doesn't cause buffer overflow.  The problem was that a transfer got
terminated too early because the transfer length for one of the URBs
was not divisible by the maxpacket size.

> In this patch, vhci basically support SG and it sends each SG list
> entry to the stub driver. Then, the stub driver sees total length of
> the buffer and allocates SG table and pages according to the total
> buffer length calling sgl_alloc(). After the stub driver receives
> completed URB, it again sends each SG list entry to the vhci.
> 
> If HCD of server doesn't support SG, the stub driver allocates
> big buffer using kmalloc() instead of using sgl_alloc() which
> allocates SG list and pages.

You might be better off not using kmalloc.  It's easier for the kernel 
to allocate a bunch of small buffers than a single big one.  Then you 
can create a separate URB for each buffer.

> Alan fixed vhci bug with the USB 3.0 storage device by modifying
> USB storage driver.
> ("usb-storage: Set virt_boundary_mask to avoid SG overflows")
> But the fundamental solution of it is to add SG support to vhci.
> 
> This patch works well with the USB 3.0 storage devices without Alan's
> patch, and we can revert Alan's patch if it causes some troubles.

These last two paragraphs don't need to be in the patch description.

> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---

I'm not sufficiently familiar with the usbip drivers to review most of 
this.  However...

> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index be87c8a63e24..cc93c1a87a3e 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -696,7 +696,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  	}
>  	vdev = &vhci_hcd->vdev[portnum-1];
>  
> -	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
> +	if (!urb->transfer_buffer && !urb->num_sgs &&
> +	     urb->transfer_buffer_length) {
>  		dev_dbg(dev, "Null URB transfer buffer\n");
>  		return -EINVAL;
>  	}
> @@ -1142,6 +1143,11 @@ static int vhci_setup(struct usb_hcd *hcd)
>  		hcd->speed = HCD_USB3;
>  		hcd->self.root_hub->speed = USB_SPEED_SUPER;
>  	}
> +
> +	/* support sg */
> +	hcd->self.sg_tablesize = ~0;
> +	hcd->self.no_sg_constraint = 1;

You probably shouldn't do this, for two reasons.  First, sg_tablesize
of the server's HCD may be smaller than ~0.  If the client's value is
larger than the server's, a transfer could be accepted on the client
but then fail on the server because the SG list was too big.

Also, you may want to restrict the size of SG transfers even further,
so that you don't have to allocate a tremendous amount of memory all at
once on the server.  An SG transfer can be quite large.  I don't know 
what a reasonable limit would be -- 16 perhaps?

Alan Stern

