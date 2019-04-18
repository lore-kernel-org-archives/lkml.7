Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9CE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfDROdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:33:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50312 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388097AbfDROdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:33:53 -0400
Received: (qmail 3140 invoked by uid 2102); 18 Apr 2019 10:33:52 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2019 10:33:52 -0400
Date:   Thu, 18 Apr 2019 10:33:52 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "zhuyan (M)" <zhuyan34@huawei.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb:host: fix divide-by-zero in function fhci_queue_urb
In-Reply-To: <2e3a7b4df8744b508b866db40bb8cf28@huawei.com>
Message-ID: <Pine.LNX.4.44L0.1904181022320.1513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, zhuyan (M) wrote:

> > > @@ -765,11 +765,12 @@ void fhci_queue_urb(struct fhci_hcd *fhci, 
> > > struct urb *urb)
> > >  
> > >  	switch (ed->mode) {
> > >  	case FHCI_TF_BULK:
> > > +		max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
> > >  		if (urb->transfer_flags & URB_ZERO_PACKET &&
> > >  				urb->transfer_buffer_length > 0 &&
> > > +				(max_pkt_size != 0) &&
> > 
> > Now you shouldn't need to add this extra test.
> > 
> > Alan Stern

> But the return value of usb_endpoint_maxp() may be 0. 
> Do we need to take protective measures?

Yes, we do.  But the protective measures don't belong in the fhci 
driver.

They should go in core/config.c:usb_parse_endpoint().  That routine 
already has code to check for maxpacket sizes that are too large; you 
can add code that checks for maxpacket sizes that are too small.

In theory an interrupt or isochronous endpoint might have maxpacket set
to 0 -- we could warn about these and accept them -- but this is not
allowed for bulk endpoints (see section 5.8.3 of the USB 2.0
specification).  In fact, bulk endpoints are not allowed to have
maxpacket size smaller than 8.

Maybe if you make this change then fhci-hcd won't need any
modifications at all.

Alan Stern

