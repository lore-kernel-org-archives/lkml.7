Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1300E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfDQNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:45:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47619 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729940AbfDQNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:45:06 -0400
Received: (qmail 28054 invoked by uid 500); 17 Apr 2019 09:45:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2019 09:45:04 -0400
Date:   Wed, 17 Apr 2019 09:45:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "zhuyan (M)" <zhuyan34@huawei.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb:host: fix divide-by-zero in function fhci_queue_urb
In-Reply-To: <cb1b585652b54d3d9ff8ef6548094d3b@huawei.com>
Message-ID: <Pine.LNX.4.44L0.1904170942530.27339-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, zhuyan (M) wrote:

> On Tue, 16 Apr 2019 11:07:56 -0400, Alan Stern wrote:
> 
> > On Tue, 16 Apr 2019, zhuyan (M) wrote:
> > > On Tue, 16 Apr 2019 at 11:45:45 +0200, Greg KH wrote:
> > > > On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> > > > > In function fhci_queue_urb, the divisor of expression 
> > > > > (urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
> > > > > usb_pipeout(urb->pipe))) may be zero.
> > > > 
> > > > How can you hit that?
> > > > 
> > > > > When it is zero, unexpected results may occur, so it is necessary 
> > > > > to ensure that the divisor is not zero.
> > > > > 
> > > > > Signed-off-by: zhuyan <zhuyan34@huawei.com>
> > > > 
> > > > I need a "Full" name here, not just a single name.  Whatever you use to sign documents is good.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > In function usb_maxpacket, when ep is NULL, its return value is 0.  
> > 
> > fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket size 
> > anyway.  It should use usb_endpoint_maxp(&urb->ep->desc).
> 
> Currently, fhci_queue_urb(), call usb_maxpacket() multiple times to calculate
>  the maxpacket size. The usb_maxpacket() will call usb_endpoint_maxp() to 
> compute the maxpacket size.

I know that.  What fhci_queue_urb() is doing is wrong.  You should
change it: Make it call usb_endpoint_maxp directly instead of calling
usb_maxpacket.

Alan Stern

