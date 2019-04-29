Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B34BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9772147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556538048;
	bh=4bhLqjf6wcF9clggmqlnUavyhLcFRA4gjMu2fMRolQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gXS6TPBSE6bBsMj6l69M3MFAKbZsiuqk04IRNASBmBoCdvMNfO9aWfZeci44J74Cx
	 9VxnoMvDuPrU/+gR1gLPfgZup7Ts0K4BaM7jPK1kcyvWFRuTM8TeANy61zT0y1tXcQ
	 0ofpJldpuomJ8bDfwJDOhvKi3PHlOq5fBPYcax84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfD2Lkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbfD2Lkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:40:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF94D20673;
        Mon, 29 Apr 2019 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556538045;
        bh=4bhLqjf6wcF9clggmqlnUavyhLcFRA4gjMu2fMRolQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zKanuSGkbdwExGviXcf3bK8kqOggRVqj++rnqGpMMmmLVj9oAPGmImEEMzsBYZWcN
         it7F+nETS2TwEOxdXiet1EpLm635XghgRSjqV4Exf0RU7Zay9RAMCos8iFswKZtdMk
         m7nlD8zs3GbyiNfwrKWwKoMV36m1mzwp47j4T+Tw=
Date:   Mon, 29 Apr 2019 13:40:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: xhci: Add Clear_TT_Buffer
Message-ID: <20190429114042.GA29440@kroah.com>
References: <1556534204-17826-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556534204-17826-1-git-send-email-jilin@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 06:36:44PM +0800, Jim Lin wrote:
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
> Here we add Clear_TT_Buffer for the following Set_Interface requests
> to get ACK successfully.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
>  drivers/usb/host/xhci-ring.c | 28 ++++++++++++++++++++++++++++
>  drivers/usb/host/xhci.c      |  7 +++++++
>  drivers/usb/host/xhci.h      |  3 +++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 9215a28dad40..02b1ebad81e7 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1786,6 +1786,33 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
>  	return NULL;
>  }
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
> +		dev = xhci->devs[slot_id];
> +		slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
> +		/* Update devnum temporarily for usb_hub_clear_tt_buffer */
> +		saved_devnum = td->urb->dev->devnum;
> +		td->urb->dev->devnum = (int) le32_to_cpu(slot_ctx->dev_state) &
> +			DEV_ADDR_MASK;
> +		if (usb_hub_clear_tt_buffer(td->urb))
> +			xhci->clearing_tt = 0;
> +		td->urb->dev->devnum = saved_devnum;
> +	}
> +}
> +
>  static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
>  		unsigned int slot_id, unsigned int ep_index,
>  		unsigned int stream_id, struct xhci_td *td,
> @@ -1804,6 +1831,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
>  	if (reset_type == EP_HARD_RESET) {
>  		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
>  		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
> +		xhci_clear_hub_tt_buffer(xhci, slot_id, td);
>  	}
>  	xhci_ring_cmd_db(xhci);
>  }
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 7fa58c99f126..cb8c1048d4d3 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5132,6 +5132,12 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>  }
>  EXPORT_SYMBOL_GPL(xhci_gen_setup);
>  
> +void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
> +						struct usb_host_endpoint *ep)

This can be static, right?  And odd indentation, please run
checkpatch.pl on your patches.

> +{
> +	hcd_to_xhci(hcd)->clearing_tt = 0;
> +}
> +
>  static const struct hc_driver xhci_hc_driver = {
>  	.description =		"xhci-hcd",
>  	.product_desc =		"xHCI Host Controller",
> @@ -5192,6 +5198,7 @@ static const struct hc_driver xhci_hc_driver = {
>  	.enable_usb3_lpm_timeout =	xhci_enable_usb3_lpm_timeout,
>  	.disable_usb3_lpm_timeout =	xhci_disable_usb3_lpm_timeout,
>  	.find_raw_port_number =	xhci_find_raw_port_number,
> +	.clear_tt_buffer_complete = xhci_clear_tt_buffer_complete,
>  };
>  
>  void xhci_init_driver(struct hc_driver *drv,
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 9334cdee382a..f786bb0992c4 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1864,6 +1864,7 @@ struct xhci_hcd {
>  	unsigned		hw_lpm_support:1;
>  	/* Broken Suspend flag for SNPS Suspend resume issue */
>  	unsigned		broken_suspend:1;
> +	unsigned		clearing_tt:1;
>  	/* cached usb2 extened protocol capabilites */
>  	u32                     *ext_caps;
>  	unsigned int            num_ext_caps;
> @@ -2052,6 +2053,8 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
>  		struct xhci_virt_device *virt_dev,
>  		struct usb_device *hdev,
>  		struct usb_tt *tt, gfp_t mem_flags);
> +void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
> +		struct usb_host_endpoint *ep);

I do not think this is needed, right?

thanks,

greg k-h
