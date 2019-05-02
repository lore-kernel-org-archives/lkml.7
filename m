Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C06C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E2F20656
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfEBKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:54:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:15382 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfEBKyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:54:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 03:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="154108748"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2019 03:54:07 -0700
Subject: Re: [PATCH v3 1/1] usb: xhci: Add Clear_TT_Buffer
To:     Jim Lin <jilin@nvidia.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
References: <1556593592-3078-1-git-send-email-jilin@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <f1688e22-05d9-ca43-5df2-2a5436631851@linux.intel.com>
Date:   Thu, 2 May 2019 13:56:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556593592-3078-1-git-send-email-jilin@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.4.2019 6.06, Jim Lin wrote:
> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> processing for full-/low-speed endpoints connected via a TT, the host
> software must use the Clear_TT_Buffer request to the TT to ensure
> that the buffer is not in the busy state".

Good point, xhci isn't making sure TT buffers get cleared when they should.

> 
> In our case, a full-speed speaker (ConferenceCam) is behind a high-
> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> request we may continue to get STALL with the folllowing requests,
> like Set_Interface.
> 
> Here we add Clear_TT_Buffer for the following Set_Interface requests
> to get ACK successfully.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>      , remove its claiming in xhci.h
> v3: Add description for clearing_tt (xhci.h)
> 
>   drivers/usb/host/xhci-ring.c | 28 ++++++++++++++++++++++++++++
>   drivers/usb/host/xhci.c      |  7 +++++++
>   drivers/usb/host/xhci.h      |  2 ++
>   3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 9215a28dad40..02b1ebad81e7 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1786,6 +1786,33 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
>   	return NULL;
>   }
>   
> +static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci,
> +	unsigned int slot_id, struct xhci_td *td)
> +{
> +	struct xhci_virt_device *dev;
> +	struct xhci_slot_ctx *slot_ctx;
> +	int saved_devnum;
> +
> +	/*
> +	 * As part of low/full-speed endpoint-halt processing
> +	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
> +	 */
> +	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
> +	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub) &&
> +	    !xhci->clearing_tt) {
> +		xhci->clearing_tt = 1;

one xhci->clearing_tt under is not enough, there might be several HS hubs, or
multi TT hubs with halted endpoints at the same time that need TT clearing.

How about a flag per endpoint?

For example Aadding a EP_CLEARING_TT flag for ep_state in struct xhci_virt_ep?
just like EP_STOP_CMD_PENDING, or EP_HALTED

> +		dev = xhci->devs[slot_id];
> +		slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
> +		/* Update devnum temporarily for usb_hub_clear_tt_buffer */
> +		saved_devnum = td->urb->dev->devnum;
> +		td->urb->dev->devnum = (int) le32_to_cpu(slot_ctx->dev_state) &
> +			DEV_ADDR_MASK;

Changing the struct usb_device devnum on the fly seems like a bit of a hack, and probably
causes issues elsewhere. Devnum is tied to uevents, usbfs, sysfs etc.

We need another solution, some options:

- Let usb_hub_clear_tt_buffer() figure out address and not just use devnum if host == xhci.
- Add address to struct usb_device, (would have both address and devnum), use it when needed.
- Provide address as parameter to usb_clear_tt_buffer() (api change, changes other host drivers)
- Force devnum to be same as address, usb core can't choose address for xhci devices.

-Mathias
