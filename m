Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B3C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D282082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfEQOIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:08:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:6678 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfEQOIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:08:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 07:08:04 -0700
X-ExtLoop1: 1
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2019 07:08:02 -0700
Subject: Re: [PATCH v10 2/2] usb: xhci: Add Clear_TT_Buffer
To:     Jim Lin <jilin@nvidia.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, drinkcat@chromium.org,
        keescook@chromium.org, nsaenzjulienne@suse.de, jflat@chromium.org,
        malat@debian.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1558017657-13835-1-git-send-email-jilin@nvidia.com>
 <1558017657-13835-3-git-send-email-jilin@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <ece2b354-8b3b-6c3d-6e64-5d7e6236148e@linux.intel.com>
Date:   Fri, 17 May 2019 17:10:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1558017657-13835-3-git-send-email-jilin@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.5.2019 17.40, Jim Lin wrote:
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
> Here we invoke usb_hub_clear_tt_buffer() to send Clear_TT_Buffer
> request to the hub of the device for the following Set_Interface
> requests to the device to get ACK successfully.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>      , remove its claiming in xhci.h
> v3: Add description for clearing_tt (xhci.h)
> v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
>      to protect for Clear_TT_Buffer to be run serially.
>      Remove xhci_clear_tt_buffer_complete as it's not necessary.
>      Same reason as the above.
>      Extend usb_hub_clear_tt_buffer parameter
> v5: Not extending usb_hub_clear_tt_buffer parameter
>      Add description.
> v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
> v7: Add devaddr field in "struct usb_device"
> v8: split as two patches
> v9: no change flag
> v10: Add EP_CLEARING_TT flag
> 
>   drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++++++++++++-
>   drivers/usb/host/xhci.c      | 17 +++++++++++++++++
>   drivers/usb/host/xhci.h      |  5 +++++
>   3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 9215a28dad40..11d498b6c09b 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -399,7 +399,7 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
>   	 * stream once the endpoint is on the HW schedule.
>   	 */
>   	if ((ep_state & EP_STOP_CMD_PENDING) || (ep_state & SET_DEQ_PENDING) ||
> -	    (ep_state & EP_HALTED))
> +	    (ep_state & EP_HALTED) || (ep_state & EP_CLEARING_TT))
>   		return;
>   	writel(DB_VALUE(ep_index, stream_id), db_addr);
>   	/* The CPU has better things to do at this point than wait for a
> @@ -433,6 +433,13 @@ static void ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
>   	}
>   }
>   
> +void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
> +		unsigned int slot_id,
> +		unsigned int ep_index)
> +{
> +	ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
> +}
> +
>   /* Get the right ring for the given slot_id, ep_index and stream_id.
>    * If the endpoint supports streams, boundary check the URB's stream ID.
>    * If the endpoint doesn't support streams, return the singular endpoint ring.
> @@ -1786,6 +1793,23 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
>   	return NULL;
>   }
>   
> +static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci, struct xhci_td *td,
> +		struct xhci_virt_ep *ep)
> +{
> +	/*
> +	 * As part of low/full-speed endpoint-halt processing
> +	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
> +	 */
> +	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
> +	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub) &&
> +	    !(ep->ep_state & EP_CLEARING_TT)) {
> +		ep->ep_state |= EP_CLEARING_TT;
> +		td->urb->ep->hcpriv = td->urb->dev;
> +		if (usb_hub_clear_tt_buffer(td->urb))
> +			ep->ep_state &= ~EP_CLEARING_TT;
> +	}
> +}
> +
>   static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
>   		unsigned int slot_id, unsigned int ep_index,
>   		unsigned int stream_id, struct xhci_td *td,
> @@ -1804,6 +1828,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
>   	if (reset_type == EP_HARD_RESET) {
>   		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
>   		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
> +		xhci_clear_hub_tt_buffer(xhci, td, ep);
>   	}
>   	xhci_ring_cmd_db(xhci);
>   }
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 68b393e5a453..0dc108e61a89 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5133,6 +5133,22 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>   }
>   EXPORT_SYMBOL_GPL(xhci_gen_setup);
>   
> +static void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
> +		struct usb_host_endpoint *ep)
> +{
> +	struct xhci_hcd *xhci;
> +	struct usb_device *udev;
> +	unsigned int slot_id;
> +	unsigned int ep_index;
> +
> +	xhci = hcd_to_xhci(hcd);
> +	udev = (struct usb_device *)ep->hcpriv;
> +	slot_id = udev->slot_id;
> +	ep_index = xhci_get_endpoint_index(&ep->desc);


spin_lock_irqsave(&xhci->lock, flags);  (protecting ep_state)

> +	xhci->devs[slot_id]->eps[ep_index].ep_state &= ~EP_CLEARING_TT;
> +	xhci_ring_doorbell_for_active_rings(xhci, slot_id, ep_index);

unlock

note:
lock is already taken in xhci_cleanup_halted_endpoint()
so no need to take lock for xhci_clear_hub_tt_buffer()
  

Other than that this looks good to me.

-Mathias
