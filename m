Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB74DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75020679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKLOlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:41:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:41:13 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUXLy-00032n-JI; Tue, 12 Nov 2019 15:41:10 +0100
Received: from mol by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUXLw-0005WA-PK; Tue, 12 Nov 2019 15:41:08 +0100
Date:   Tue, 12 Nov 2019 15:41:08 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] usb: dwc3: gadget: Handle dequeuing of non queued URB
 gracefully
Message-ID: <20191112144108.GA1859@pengutronix.de>
Mail-Followup-To: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20191106144553.16956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106144553.16956-1-alexandru.ardelean@analog.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:39:32 up 75 days,  2:53, 130 users,  load average: 3.78, 4.01,
 2.72
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:45:53PM +0200, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Trying to dequeue and URB that is currently not queued should be a no-op
> and be handled gracefully.
> 
> Use the list field of the URB to indicate whether it is queued or not by
> setting it to the empty list when it is not queued.
> 
> Handling this gracefully allows for race condition free synchronization
> between the complete callback being called to to a completed transfer and
> trying to call usb_ep_dequeue() at the same time.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Thanks, no more "dwc3 fe200000.usb: request 00000000cdd42e4a was not queued
to ep2in" messages with this patch applied.

Tested-by: Michael Olbrich <m.olbrich@pengutronix.de>

> ---
>  drivers/usb/dwc3/gadget.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index a9aba716bf80..b500ec6b0aa8 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -174,7 +174,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
>  {
>  	struct dwc3			*dwc = dep->dwc;
>  
> -	list_del(&req->list);
> +	list_del_init(&req->list);
>  	req->remaining = 0;
>  	req->needs_extra_trb = false;
>  
> @@ -844,6 +844,7 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
>  	req->epnum	= dep->number;
>  	req->dep	= dep;
>  	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
> +	INIT_LIST_HEAD(&req->list);
>  
>  	trace_dwc3_alloc_request(req);
>  
> @@ -1540,6 +1541,10 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
>  
> +	/* Not queued, nothing to do */
> +	if (list_empty(&req->list))
> +		goto out0;
> +
>  	list_for_each_entry(r, &dep->pending_list, list) {
>  		if (r == req)
>  			break;

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
