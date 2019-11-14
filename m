Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF26C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B89206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKNMPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:15:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45383 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:14:38 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iVE12-0006Pg-KZ; Thu, 14 Nov 2019 13:14:24 +0100
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1iVE10-00019c-Dc; Thu, 14 Nov 2019 13:14:22 +0100
Date:   Thu, 14 Nov 2019 13:14:22 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Message-ID: <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
Mail-Followup-To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:28:11 up 129 days, 15:38, 132 users,  load average: 0.09, 0.18,
 0.17
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 07:14:59PM +0000, Thinh Nguyen wrote:
> Alan Stern wrote:
> > On Wed, 13 Nov 2019, Michael Olbrich wrote:
> >> On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
> >>> Michael Olbrich wrote:
> >>>> Currently, most gadget drivers handle isoc transfers on a best effort
> >>>> bases: If the request queue runs empty, then there will simply be gaps in
> >>>> the isoc data stream.
> >>>>
> >>>> The UVC gadget depends on this behaviour. It simply provides new requests
> >>>> when video frames are available and assumes that they are sent as soon as
> >>>> possible.
> >>>>
> >>>> The dwc3 gadget currently works differently: It assumes that there is a
> >>>> contiguous stream of requests without any gaps. If a request is too late,
> >>>> then it is dropped by the hardware.
> >>>> For the UVC gadget this means that a live stream stops after the first
> >>>> frame because all following requests are late.
> >>> Can you explain little more how UVC gadget fails?
> >>> dwc3 controller expects a steady stream of data otherwise it will result
> >>> in missed_isoc status, and it should be fine as long as new requests are
> >>> queued. The controller doesn't just drop the request unless there's some
> >>> other failure.
> >> UVC (with a live stream) does not fill the complete bandwidth of an
> >> isochronous endpoint. Let's assume for the example that one video frame
> >> fills 3 requests. Because it is a live stream, there will be a gap between
> >> video frames. This is unavoidable, especially for compressed video. So the
> >> UVC gadget will have requests for the frame numbers 1 2 3 5 6 7 9 10 11 13 14
> >> 15 and so on.
> >> The dwc3 hardware tries to send those with frame numbers 1 2 3 4 5 6 7 8 9
> >> 10 11 12. So except for the fist few requests, all are late and result in a
> >> missed_isoc. I tried to just ignore the missed_isoc but that did not work
> >> for me. I only received the first frame at the other end.
> >> Maybe I missing something here, i don't have access to the hardware
> >> documentation, so I can only guess from the existing driver.
> 
> The reason I asked is because your patch doesn't seem to address the 
> actual issue.
> 
> For the 2 checks you do here
> 1. There are currently no requests queued in the hardware
> 2. The current frame number provided by DSTS does not match the frame
>      number returned by the last transfer.
> 
> For #1, it's already done in the dwc3 driver. (check 
> dwc3_gadget_endpoint_transfer_in_progress())

But that's only after a isoc_missed occurred. What exactly does that mean?
Was the request transferred or not? My tests suggest that it was not
transferred, so I wanted to catch this before it happens.

> For #2, it's unlikely that DSTS current frame number will match with the 
> XferNotReady's frame number. So this check doesn't mean much.

The frame number is also updated for each "Transfer In Progress" interrupt.
If they match, then there a new request can still be queued successfully.
Without this I got unnecessary stop/start transfers in the middle of a
video frame. But maybe something else was wrong here. I'd need to recheck.

> So I'm still wondering how does this patch help resolve your issue.

With this patch, the transfer is restarted for every video frame.
Otherwise, I just get a lot of isoc_missed and ignoring those did not help.
No valid data arrived after the first video frame.

> > How about changing the gadget driver instead?  For frames where the UVC
> > gadget knows no video frame data is available (numbers 4, 8, 12, and so
> > on in the example above), queue a zero-length request.  Then there
> > won't be any gaps in the isochronous packet stream.
> 
> What Alan suggests may work. Have you tried this?

Yes and it works in general. There are however some problems with that
approach that I want to avoid:

1. It adds extra overhead to handle the extra zero-length request.
Especially for encoded video the available bandwidth can be quite a bit
larger that what is actually used. I want to avoid that.

2. The UVC gadget currently does no know how many zero-length request must
added. So it needs fill all available request until a new video frame
arrives. With the current 4 requests that is not a problem right now. But
that does not scale for USB3 bandwidths. So one thing that I want to do is
to queue many requests but only enable the interrupt for a few of than.
From what I can tell from the code, the gadget framework and the dwc3
driver should already support this.
This will result in extra latency. There is probably an acceptable
trade-off with an acceptable interrupt load and latency. But I would like
to avoid that if possible.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
