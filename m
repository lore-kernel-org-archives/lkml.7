Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4BAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B8E204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfDPPH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:07:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42826 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725796AbfDPPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:07:57 -0400
Received: (qmail 5569 invoked by uid 2102); 16 Apr 2019 11:07:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Apr 2019 11:07:56 -0400
Date:   Tue, 16 Apr 2019 11:07:56 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "zhuyan (M)" <zhuyan34@huawei.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb:host: fix divide-by-zero in function fhci_queue_urb
In-Reply-To: <c2bfec411cb742ec9aca66d278cca93f@huawei.com>
Message-ID: <Pine.LNX.4.44L0.1904161102400.1605-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, zhuyan (M) wrote:

> On Tue, 16 Apr 2019 at 11:45:45 +0200, Greg KH wrote:
> > On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> > > In function fhci_queue_urb, the divisor of expression 
> > > (urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
> > > usb_pipeout(urb->pipe))) may be zero.
> > 
> > How can you hit that?
> > 
> > > When it is zero, unexpected results may occur, so it is necessary to 
> > > ensure that the divisor is not zero.
> > > 
> > > Signed-off-by: zhuyan <zhuyan34@huawei.com>
> > 
> > I need a "Full" name here, not just a single name.  Whatever you use to sign documents is good.
> > 
> > thanks,
> > 
> > greg k-h
> 
> In function usb_maxpacket, when ep is NULL, its return value is 0.  

fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket size 
anyway.  It should use usb_endpoint_maxp(&urb->ep->desc).

Alan Stern

> Then, in function fhci_queue_urb, the divisor of expression  
> (urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe, usb_pipeout(urb->pipe))) 
> is zero. It will lead to unpredictable results.

