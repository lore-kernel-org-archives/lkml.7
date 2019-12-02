Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADFC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CD82084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLBPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:41:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40843 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:41:28 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1ibnpC-0007tX-Oz; Mon, 02 Dec 2019 16:41:22 +0100
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1ibnpB-0002io-10; Mon, 02 Dec 2019 16:41:21 +0100
Date:   Mon, 2 Dec 2019 16:41:21 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Message-ID: <20191202154120.o4yt266cat6uzxd7@pengutronix.de>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191128113633.5slzlehhwlmnc3zr@pengutronix.de>
 <Pine.LNX.4.44L0.1911281242330.19734-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1911281242330.19734-100000@netrider.rowland.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:41:02 up 147 days, 21:51, 137 users,  load average: 0.42, 0.30,
 0.27
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:59:53PM -0500, Alan Stern wrote:
> On Thu, 28 Nov 2019, Michael Olbrich wrote:
> > On Fri, Nov 15, 2019 at 04:06:10PM -0500, Alan Stern wrote:
> > > On Thu, 14 Nov 2019, Thinh Nguyen wrote:
> > > > Michael Olbrich wrote:
> > > > >>> How about changing the gadget driver instead?  For frames where the UVC
> > > > >>> gadget knows no video frame data is available (numbers 4, 8, 12, and so
> > > > >>> on in the example above), queue a zero-length request.  Then there
> > > > >>> won't be any gaps in the isochronous packet stream.
> > > > >> What Alan suggests may work. Have you tried this?
> > > > > Yes and it works in general. There are however some problems with that
> > > > > approach that I want to avoid:
> > > > >
> > > > > 1. It adds extra overhead to handle the extra zero-length request.
> > > > > Especially for encoded video the available bandwidth can be quite a bit
> > > > > larger that what is actually used. I want to avoid that.
> > > 
> > > This comment doesn't seem to make sense.  If the available bandwidth is
> > > much _larger_ than what is actually used, what's the problem?  You
> > > don't run into difficulties until the available bandwidth is too
> > > _small_.
> > > 
> > > The extra overhead of a zero-length request should be pretty small.  
> > > After all, the gadget expects to send a packet for every frame anyway,
> > > more or less.
> > 
> > My current test-case is video frames with 450kB on average at 30fps. This
> > currently results in ~10 CPU load for the threaded interrupt handler.
> > At least in my test, filling the actual video data into the frame has very
> > little impact. So if I reserve 900kB to support occasionally larger video
> > frames, then I expect that this CPU load will almost double in all cases,
> > not just when the video frames are larger.
> 
> This is the sort of thing you need to confirm by experimenting.  It is 
> not at all clear that doubling the interrupt rate will also double the 
> CPU load, especially if half of the interrupts don't require the CPU to 
> do much work.

As I noted before, actually filling in the video data is only a small part
of the measured CPU load. To put in in more precise numbers:

From my limited understanding, there are 8000 interrupts per second
regardless of the bandwidth (or maybe less for very low bandwidth
configurations?).
Just queuing requests without any content (so skipping the buffer handling
and 'encode()' in uvc_video_complete()) results in ~17% CPU load.

If I fill in the data for a video stream with ~1.8MB per frame and 30 fps
(and empty requests for the rest) then the CPU load goes up to ~19.5%.
This number remains the same for different bandwidths (and therefore
different request sizes and a different zero-length request percentage).

With my patches the CPU load changes as expected. The 2.5% to fill the data
remains and the rest goes down with less interrupts.

I am hoping that more batching will help here a bit. But either way the
overhead of queuing zero-length request is significant.

> > > > > 2. The UVC gadget currently does no know how many zero-length request must
> > > > > added. So it needs fill all available request until a new video frame
> > > > > arrives. With the current 4 requests that is not a problem right now. But
> > > > > that does not scale for USB3 bandwidths. So one thing that I want to do is
> > > > > to queue many requests but only enable the interrupt for a few of than.
> > > > >  From what I can tell from the code, the gadget framework and the dwc3
> > > > > driver should already support this.
> > > > > This will result in extra latency. There is probably an acceptable
> > > > > trade-off with an acceptable interrupt load and latency. But I would like
> > > > > to avoid that if possible.
> > > 
> > > There are two different situations to consider:
> > > 
> > > 	In the middle of a video stream, latency isn't an issue.
> > > 	The gadget should expect to send a new packet for each frame,
> > > 	and it doesn't know what to put in that packet until it
> > > 	receives the video data or it knows there won't be any data.
> > > 
> > > 	At the start of a video stream, latency can be an issue.  But
> > > 	in this situation the gadget doesn't have to send 0-length
> > > 	requests until there actually is some data available.
> > > 
> > > Either way, it should be okay.
> > > 
> > > As far as interrupt load is concerned, I don't see how it relates to
> > > the issue of sending 0-length requests.
> > 
> > Maybe I don't understand, how 0-length requests work. My current
> > understanding is, that they are queued like any other request.
> 
> That's right.
> 
> > If I want to reduce the number of interrupts then I need to queue more
> > requests and only ask for an interrupt for some of them. This means that
> > potentially a lot of 0-length requests requests are queued when a new video
> > frame arrives and this means extra latency for the frame.
> 
> Let's say you ask for an interrupt for only even-numbered requests.  
> Then there would be at most one 0-length request queued when a new
> video frame arrives.  Processing that 0-length request should require
> very little CPU time (almost none) because it contains no data, so the
> extra latency would be negligible.
> 
> > I think the worst-case latency is 2x the time between two interrupts.
> > So less interrupts mean more latency.
> 
> What matters is the interrupt rate.  If you double the rate at which 
> transfers are queued but ask for an interrupt on only half of them, 
> then the overall interrupt rate will remain the same and so will the 
> average latency.
> 
> > The stop/start transfer this patch implements, the video frame can be sent
> > immediately without any extra latency.
> 
> The same would be true if you queued a request at the full isochronous
> rate.  If video data is present, put it in the request; if not then
> queue a 0-length request.

My problem is this:
Let's assume a (for simplicity) that I have a video stream that fills
almost the full available bandwidth. And two reduce the bandwidth, two
interrupts will be requested for each video frame.

- When the first frame arrives, the whole frame is queued.
- When the first half of the frame is transmitted the first interrupt
  arrives.
- The second frame has not yet arrived so half a frame worth of 0-length
  requests are queued.
- When the second half of the frame is transmitted the second interrupt
  arrives.
- The second frame has still not yet arrived so another half a frame worth
  of 0-length requests are queued.
- Immediately afterwards the second frame arrives from userspace. At this
  point, almost one frame worth of 0-length requests are queued so the
  second frame will have an extra latency of almost one frame.

With my patch this does not happen and the transmission of the second
starts immediately.

> > > > Now, with UVC, it needs to communicate to the dwc3 driver that there 
> > > > will be a gap after a certain request (and that the device is expecting 
> > > > to send 0-length data). This is not a normal operation for isoc 
> > > > transfer. You may need to introduce a new way for the function driver to 
> > > > do that, possibly a new field in usb_request structure to indicate that. 
> > > > However, this seems a little awkward. Maybe others can comment on this.
> > 
> > I'm not sure how this is supposed to work. What exactly can the dwc3 driver
> > / hardware do to handle a gap?
> 
> Are you talking about the driver on the gadget side or on the host 
> side?  The rules for the host-side driver are spelled out in the 
> kerneldoc for usb_submit_urb().  As far as I know, there is no 
> equivalent set of rules for the gadget-side drivers.

I'm unsure about the extra API Thinh was talking about. Right now in my
tests I'm queuing normal requests with 'request->length = 0' when no video
data is available. This has the problems described above.

The question is, can we do better than that? What could be done in the
driver if it knows that 0-length requests must be transmitted because no
new data is available?

> > > Note that on the host side, there is a difference between receiving 
> > > a 0-length packet and receiving no packet at all.  As long as both the 
> > > host and the gadget expect the isochronous stream to be running, there 
> > > shouldn't be any gaps if you can avoid it.
> > 
> > Huh, so how is this handled on other hardware? From what I can tell the UVC
> > gadget works with other drivers and I've not found any special handling for
> > this. Is there no packet sent or are 0-length packet generated implicitly
> > somewhere?
> 
> I don't know.  You can ask the UVC maintainer for more information; my 
> guess is that it treats 0-length packets and missing packets the same.  
> After all, what else could it do?  Either way, there is no data.

Ok.

Michael

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
