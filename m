Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37862C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD4206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfDQS72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:59:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59158 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732549AbfDQS72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:59:28 -0400
Received: (qmail 3392 invoked by uid 2102); 17 Apr 2019 14:59:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2019 14:59:27 -0400
Date:   Wed, 17 Apr 2019 14:59:27 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "zhuyan (M)" <zhuyan34@huawei.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb:host: fix divide-by-zero in function fhci_queue_urb
In-Reply-To: <63401dc56ae64aa3a428c4bb8a84034e@huawei.com>
Message-ID: <Pine.LNX.4.44L0.1904171458010.1400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, zhuyan (M) wrote:

> On Wed, 17 Apr 2019, Alan Stern wrote:
> 
> > On Wed, 17 Apr 2019, zhuyan (M) wrote:
> > 
> > > On Tue, 16 Apr 2019 11:07:56 -0400, Alan Stern wrote:
> > > 
> > > > On Tue, 16 Apr 2019, zhuyan (M) wrote:
> > > > > On Tue, 16 Apr 2019 at 11:45:45 +0200, Greg KH wrote:
> > > > > > On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> > > > > > > In function fhci_queue_urb, the divisor of expression 
> > > > > > > (urb->transfer_buffer_length % usb_maxpacket(urb->dev, 
> > > > > > > urb->pipe,
> > > > > > > usb_pipeout(urb->pipe))) may be zero.
> > > > > > 
> > > > > > How can you hit that?
> > > > > > 
> > > > > > > When it is zero, unexpected results may occur, so it is 
> > > > > > > necessary to ensure that the divisor is not zero.
> > > > > > > 
> > > > > > > Signed-off-by: zhuyan <zhuyan34@huawei.com>
> > > > > > 
> > > > > > I need a "Full" name here, not just a single name.  Whatever you use to sign documents is good.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > In function usb_maxpacket, when ep is NULL, its return value is 0.  
> > > > 
> > > > fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket 
> > > > size anyway.  It should use usb_endpoint_maxp(&urb->ep->desc).
> > > 
> > > Currently, fhci_queue_urb(), call usb_maxpacket() multiple times to 
> > > calculate  the maxpacket size. The usb_maxpacket() will call 
> > > usb_endpoint_maxp() to compute the maxpacket size.
> > 
> > I know that.  What fhci_queue_urb() is doing is wrong.  You should change it: 
> > Make it call usb_endpoint_maxp directly instead of calling usb_maxpacket.
> > 
> 
> From 1996456d0cc17b5ff7746a598ff355b25d13db3e Mon Sep 17 00:00:00 2001
> From: zhuyan <zhuyan34@huawei.com>
> Date: Thu, 18 Apr 2019 00:53:03 +0800
> Subject: [PATCH] usb: host: fix divide-by-zero in function fhci_queue_urb
> 
> fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket
> size anyway.It should use usb_endpoint_maxp(&urb->ep->desc).
> 
> In function fhci_queue_urb, the divisor of expression
> (urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
> usb_pipeout(urb->pipe))) may be zero. When it is zero, unexpected results
> may occur, so it is necessary to ensure that the divisor is not zero.
> 
> Signed-off-by: zhuyan <zhuyan34@huawei.com>
> ---
>  drivers/usb/host/fhci-sched.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
> index 3d12cdd..7dcfe22 100644
> --- a/drivers/usb/host/fhci-sched.c
> +++ b/drivers/usb/host/fhci-sched.c
> @@ -704,6 +704,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
>  	struct td *td;
>  	u8 *data;
>  	u16 cnt = 0;
> +	u16 max_pkt_size = 0;
>  
>  	if (ed == NULL) {
>  		ed = fhci_get_empty_ed(fhci);
> @@ -727,8 +728,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
>  		}
>  		ed->speed = (urb->dev->speed == USB_SPEED_LOW) ?
>  			FHCI_LOW_SPEED : FHCI_FULL_SPEED;
> -		ed->max_pkt_size = usb_maxpacket(urb->dev,
> -			urb->pipe, usb_pipeout(urb->pipe));
> +		ed->max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
>  		urb->ep->hcpriv = ed;
>  		fhci_dbg(fhci, "new ep speed=%d max_pkt_size=%d\n",
>  			 ed->speed, ed->max_pkt_size);
> @@ -765,11 +765,12 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
>  
>  	switch (ed->mode) {
>  	case FHCI_TF_BULK:
> +		max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
>  		if (urb->transfer_flags & URB_ZERO_PACKET &&
>  				urb->transfer_buffer_length > 0 &&
> +				(max_pkt_size != 0) &&

Now you shouldn't need to add this extra test.

Alan Stern

>  				((urb->transfer_buffer_length %
> -				usb_maxpacket(urb->dev, urb->pipe,
> -				usb_pipeout(urb->pipe))) == 0))
> +				max_pkt_size) == 0))
>  			urb_state = US_BULK0;
>  		while (data_len > 4096) {
>  			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
> @@ -807,8 +808,8 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
>  		break;
>  	case FHCI_TF_CTRL:
>  		ed->dev_addr = usb_pipedevice(urb->pipe);
> -		ed->max_pkt_size = usb_maxpacket(urb->dev, urb->pipe,
> -			usb_pipeout(urb->pipe));
> +		ed->max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
> +
>  		/* setup stage */
>  		td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++, FHCI_TA_SETUP,
>  			USB_TD_TOGGLE_DATA0, urb->setup_packet, 8, 0, 0, true);

