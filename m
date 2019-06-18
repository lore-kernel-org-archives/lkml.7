Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B2C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071C920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfFRPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:30:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40204 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729209AbfFRPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:30:35 -0400
Received: (qmail 5734 invoked by uid 2102); 18 Jun 2019 11:30:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jun 2019 11:30:34 -0400
Date:   Tue, 18 Jun 2019 11:30:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     shuah@kernel.org, <valentina.manea.m@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usbip: Implement map_urb_for_dma function for vhci to
 skip dma mapping
In-Reply-To: <20190618142817.16844-1-suwan.kim027@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1906181129450.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019, Suwan Kim wrote:

> vhci doesn’t do dma for remote device. Actually, the real dma
> operation is done by network card driver. So, vhci doesn’t use and
> need dma address of transfer buffer of urb.
> 
> But hcd provides dma mapping function by defualt in usb_hcd_submit_urb()
> and it causes unnecessary dma mapping which will be done again at
> NIC driver and it wastes CPU cycles. So, implement map_urb_for_dma
> function for vhci in order to skip the dma mapping procedure.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 667d9c0ec905..9df4d9e36788 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1287,6 +1287,13 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
>  	return 0;
>  }
>  
> +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> +			    gfp_t mem_flags)
> +{
> +	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
> +	return 0;
> +}
> +
>  static const struct hc_driver vhci_hc_driver = {
>  	.description	= driver_name,
>  	.product_desc	= driver_desc,
> @@ -1302,6 +1309,7 @@ static const struct hc_driver vhci_hc_driver = {
>  	.urb_dequeue	= vhci_urb_dequeue,
>  
>  	.get_frame_number = vhci_get_frame_number,
> +	.map_urb_for_dma = vhci_map_urb_for_dma,
>  
>  	.hub_status_data = vhci_hub_status,
>  	.hub_control    = vhci_hub_control,

If the goal is to avoid wasting CPU cycles, you probably should have a 
vhci_unmap_urb_for_dma routine as well.

Alan Stern

