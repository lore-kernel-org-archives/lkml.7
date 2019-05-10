Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2566C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DD02177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEJOXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:23:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47758 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727807AbfEJOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:23:20 -0400
Received: (qmail 2214 invoked by uid 2102); 10 May 2019 10:23:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2019 10:23:19 -0400
Date:   Fri, 10 May 2019 10:23:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <keescook@chromium.org>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] usb: xhci: Add Clear_TT_Buffer
In-Reply-To: <1557491070-24715-3-git-send-email-jilin@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1905101019520.1516-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019, Jim Lin wrote:

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
> Here we update udev->devaddr in address_device callback function
> (this USB device address is assigned by XHCI controller) and invoke
> usb_hub_clear_tt_buffer() to send Clear_TT_Buffer request to the hub
> of the device for the following Set_Interface requests to the device
> to get ACK successfully.
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
> v7: Add devaddr field in "struct usb_device"
> v8: split as two patches
> v9: no change
> 
>  drivers/usb/host/xhci-ring.c | 12 ++++++++++++
>  drivers/usb/host/xhci.c      |  1 +
>  2 files changed, 13 insertions(+)
> 
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

How come there's no clear_tt_buffer_complete() callback?  Without it,
xhci-hcd won't know when the TT buffer has been cleared, and so it
won't know when to restart the endpoint ring for the halted endpoint.  

Note: Restarting the endpoint ring before the TT buffer has been 
cleared is not safe.

Alan Stern

> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 7fa58c99f126..68b393e5a453 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4096,6 +4096,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>  	/* Zero the input context control for later use */
>  	ctrl_ctx->add_flags = 0;
>  	ctrl_ctx->drop_flags = 0;
> +	udev->devaddr = (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
>  
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
>  		       "Internal device address = %d",
> 

