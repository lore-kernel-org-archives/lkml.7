Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364ECC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A783222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKMHxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:53:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35941 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMHxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:53:14 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUnSf-0000Lh-S7; Wed, 13 Nov 2019 08:53:09 +0100
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1iUnSe-0000Km-An; Wed, 13 Nov 2019 08:53:08 +0100
Date:   Wed, 13 Nov 2019 08:53:08 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Message-ID: <20191113075308.qwwgpg7kpfcyjxau@pengutronix.de>
Mail-Followup-To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20191111152645.13792-1-m.olbrich@pengutronix.de>
 <20191111152645.13792-3-m.olbrich@pengutronix.de>
 <45ce4107-7c52-48d2-90d1-dfe835024063@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ce4107-7c52-48d2-90d1-dfe835024063@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:41:53 up 128 days, 13:52, 130 users,  load average: 0.06, 0.12,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
> Michael Olbrich wrote:
> > Currently, most gadget drivers handle isoc transfers on a best effort
> > bases: If the request queue runs empty, then there will simply be gaps in
> > the isoc data stream.
> >
> > The UVC gadget depends on this behaviour. It simply provides new requests
> > when video frames are available and assumes that they are sent as soon as
> > possible.
> >
> > The dwc3 gadget currently works differently: It assumes that there is a
> > contiguous stream of requests without any gaps. If a request is too late,
> > then it is dropped by the hardware.
> > For the UVC gadget this means that a live stream stops after the first
> > frame because all following requests are late.
> 
> Can you explain little more how UVC gadget fails?
> dwc3 controller expects a steady stream of data otherwise it will result 
> in missed_isoc status, and it should be fine as long as new requests are 
> queued. The controller doesn't just drop the request unless there's some 
> other failure.

UVC (with a live stream) does not fill the complete bandwidth of an
isochronous endpoint. Let's assume for the example that one video frame
fills 3 requests. Because it is a live stream, there will be a gap between
video frames. This is unavoidable, especially for compressed video. So the
UVC gadget will have requests for the frame numbers 1 2 3 5 6 7 9 10 11 13 14
15 and so on.
The dwc3 hardware tries to send those with frame numbers 1 2 3 4 5 6 7 8 9
10 11 12. So except for the fist few requests, all are late and result in a
missed_isoc. I tried to just ignore the missed_isoc but that did not work
for me. I only received the first frame at the other end.
Maybe I missing something here, i don't have access to the hardware
documentation, so I can only guess from the existing driver.

Regards,
Michael

> > This patch changes the behaviour of the dwc3 gadget driver to match the
> > expectations. If a request arrives too late, then the transfer will be
> > restart to create the needed gap.
> >
> > A request is late if:
> > 1. There are currently no requests queued in the hardware
> > 2. The current frame number provided by DSTS does not match the frame
> >     number returned by the last transfer.
> >
> > If this happens transfers are stopped. The following XferNotReady provides
> > the new correct frame number and restarts the transfer.
> >
> > Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> > ---
> >   drivers/usb/dwc3/gadget.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index ac4673d91939..eb7f09929f28 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1473,6 +1473,14 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
> >   				return __dwc3_gadget_start_isoc(dep);
> >   			}
> >   		}
> > +		if ((dep->flags & DWC3_EP_TRANSFER_STARTED) &&
> > +		    list_empty(&dep->started_list) &&
> > +		    ((dep->frame_number & 0x3fff) !=
> > +		    __dwc3_gadget_get_frame(dwc))) {
> > +			dwc3_stop_active_transfer(dep, true, true);
> > +			dep->flags = DWC3_EP_ENABLED;
> > +			return 0;
> > +		}
> >   	}
> >   
> >   	return __dwc3_gadget_kick_transfer(dep, false);
> 
> BR,
> Thinh
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
