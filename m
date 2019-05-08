Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ABF205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfEHOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:41:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40036 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726592AbfEHOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:41:41 -0400
Received: (qmail 4140 invoked by uid 2102); 8 May 2019 10:41:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2019 10:41:41 -0400
Date:   Wed, 8 May 2019 10:41:41 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <keescook@chromium.org>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] usb: xhci: Add Clear_TT_Buffer
In-Reply-To: <1557320740-17853-1-git-send-email-jilin@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1905081039380.1699-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019, Jim Lin wrote:

> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> processing for full-/low-speed endpoints connected via a TT, the host
> software must use the Clear_TT_Buffer request to the TT to ensure
> that the buffer is not in the busy state".
> 
> In our case, a full-speed speaker (ConferenceCam) is behind a high-
> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> request we may continue to get STALL with the folllowing requests,
> like Set_Interface.
> 
> Solution is for XHCI driver to invoke usb_hub_clear_tt_buffer() to
> send Clear_TT_Buffer request to the hub of the device for the
> following Set_Interface requests to the device to get ACK
> successfully.
> 
> The Clear_TT_Buffer request sent to the hub includes the address of
> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
> uses udev->devnum to set the address wValue. This won't work for
> devices connected to xHC.
> 
> For other host controllers udev->devnum is the same as the address of
> the usb device, chosen and set by usb core. With xHC the controller
> hardware assigns the address, and won't be the same as devnum.
> 
> In the fix we get that address from slot context if it's XHC.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>     , remove its claiming in xhci.h
> v3: Add description for clearing_tt (xhci.h)
> v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
>     to protect for Clear_TT_Buffer to be run serially.
>     Remove xhci_clear_tt_buffer_complete as it's not necessary.
>     Same reason as the above.
>     Extend usb_hub_clear_tt_buffer parameter
> v5: Not extending usb_hub_clear_tt_buffer parameter
>     Add description.
> v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
> 
>  drivers/usb/core/hub.c       | 17 ++++++++++++++++-
>  drivers/usb/host/xhci-ring.c | 12 ++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 15a2934dc29d..00d994908217 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -35,6 +35,7 @@
>  
>  #include "hub.h"
>  #include "otg_whitelist.h"
> +#include "../host/xhci.h"
>  
>  #define USB_VENDOR_GENESYS_LOGIC		0x05e3
>  #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
> @@ -858,6 +859,10 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>  	struct usb_tt		*tt = udev->tt;
>  	unsigned long		flags;
>  	struct usb_tt_clear	*clear;
> +	struct xhci_hcd *xhci;
> +	struct xhci_virt_device *dev;
> +	struct xhci_slot_ctx *slot_ctx;
> +	int devnum;
>  
>  	/* we've got to cope with an arbitrary number of pending TT clears,
>  	 * since each TT has "at least two" buffers that can need it (and
> @@ -873,7 +878,17 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>  	/* info that CLEAR_TT_BUFFER needs */
>  	clear->tt = tt->multi ? udev->ttport : 1;
>  	clear->devinfo = usb_pipeendpoint (pipe);
> -	clear->devinfo |= udev->devnum << 4;
> +	/* If slot_id is nonzero, then it's XHCI */
> +	if (udev->slot_id) {
> +		xhci = hcd_to_xhci(bus_to_hcd(udev->bus));
> +		dev = xhci->devs[udev->slot_id];
> +		slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
> +		/* Device address is assigned by XHC */
> +		devnum = (int) le32_to_cpu(slot_ctx->dev_state) &
> +			DEV_ADDR_MASK;
> +		clear->devinfo |= devnum << 4;

This is a horrendous layering violation!  The hub driver shouldn't need 
to know anything about how the xHCI driver works.

Please don't do it this way.  Instead, add a field to store the 
hardware address in the usb_device structure, as discussed earlier.

Alan Stern

> +	} else
> +		clear->devinfo |= udev->devnum << 4;
>  	clear->devinfo |= usb_pipecontrol(pipe)
>  			? (USB_ENDPOINT_XFER_CONTROL << 11)
>  			: (USB_ENDPOINT_XFER_BULK << 11);
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 9215a28dad40..739737faf752 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1786,6 +1786,17 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
>  	return NULL;
>  }
>  
> +static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci, struct xhci_td *td)
> +{
> +	/*
> +	 * As part of low/full-speed endpoint-halt processing
> +	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
> +	 */
> +	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
> +	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub))
> +		usb_hub_clear_tt_buffer(td->urb);
> +}
> +
>  static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
>  		unsigned int slot_id, unsigned int ep_index,
>  		unsigned int stream_id, struct xhci_td *td,
> @@ -1804,6 +1815,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
>  	if (reset_type == EP_HARD_RESET) {
>  		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
>  		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
> +		xhci_clear_hub_tt_buffer(xhci, td);
>  	}
>  	xhci_ring_cmd_db(xhci);
>  }
> 

