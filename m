Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA03C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4665F20723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKOVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:06:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55502 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726605AbfKOVGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:06:11 -0500
Received: (qmail 7153 invoked by uid 2102); 15 Nov 2019 16:06:10 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2019 16:06:10 -0500
Date:   Fri, 15 Nov 2019 16:06:10 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
In-Reply-To: <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
Message-ID: <Pine.LNX.4.44L0.1911151549370.1527-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Thinh Nguyen wrote:

> Michael Olbrich wrote:

> >>> How about changing the gadget driver instead?  For frames where the UVC
> >>> gadget knows no video frame data is available (numbers 4, 8, 12, and so
> >>> on in the example above), queue a zero-length request.  Then there
> >>> won't be any gaps in the isochronous packet stream.
> >> What Alan suggests may work. Have you tried this?
> > Yes and it works in general. There are however some problems with that
> > approach that I want to avoid:
> >
> > 1. It adds extra overhead to handle the extra zero-length request.
> > Especially for encoded video the available bandwidth can be quite a bit
> > larger that what is actually used. I want to avoid that.

This comment doesn't seem to make sense.  If the available bandwidth is
much _larger_ than what is actually used, what's the problem?  You
don't run into difficulties until the available bandwidth is too
_small_.

The extra overhead of a zero-length request should be pretty small.  
After all, the gadget expects to send a packet for every frame anyway,
more or less.

> > 2. The UVC gadget currently does no know how many zero-length request must
> > added. So it needs fill all available request until a new video frame
> > arrives. With the current 4 requests that is not a problem right now. But
> > that does not scale for USB3 bandwidths. So one thing that I want to do is
> > to queue many requests but only enable the interrupt for a few of than.
> >  From what I can tell from the code, the gadget framework and the dwc3
> > driver should already support this.
> > This will result in extra latency. There is probably an acceptable
> > trade-off with an acceptable interrupt load and latency. But I would like
> > to avoid that if possible.

There are two different situations to consider:

	In the middle of a video stream, latency isn't an issue.
	The gadget should expect to send a new packet for each frame,
	and it doesn't know what to put in that packet until it
	receives the video data or it knows there won't be any data.

	At the start of a video stream, latency can be an issue.  But
	in this situation the gadget doesn't have to send 0-length
	requests until there actually is some data available.

Either way, it should be okay.

As far as interrupt load is concerned, I don't see how it relates to
the issue of sending 0-length requests.

> I think I understand the problem you're trying to solve now.
> 
> The dwc3 driver does not know that there's a gap until after a new 
> request was queued, which then it will send an END_TRANSFER command and 
> dequeue all the requests to restart the transfer due to missed_isoc.
> We do this because the dwc3 driver does not know whether the new request 
> is actually stale data, and we should not change this behavior.
> 
> Now, with UVC, it needs to communicate to the dwc3 driver that there 
> will be a gap after a certain request (and that the device is expecting 
> to send 0-length data). This is not a normal operation for isoc 
> transfer. You may need to introduce a new way for the function driver to 
> do that, possibly a new field in usb_request structure to indicate that. 
> However, this seems a little awkward. Maybe others can comment on this.

Note that on the host side, there is a difference between receiving 
a 0-length packet and receiving no packet at all.  As long as both the 
host and the gadget expect the isochronous stream to be running, there 
shouldn't be any gaps if you can avoid it.

Alan Stern

