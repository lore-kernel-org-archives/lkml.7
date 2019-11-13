Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6824F207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfKMICM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:02:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:02:12 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUnbL-0001eo-2r; Wed, 13 Nov 2019 09:02:07 +0100
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1iUnbJ-00017p-QQ; Wed, 13 Nov 2019 09:02:05 +0100
Date:   Wed, 13 Nov 2019 09:02:05 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more
 robust
Message-ID: <20191113080205.tsqnzjgwtdmmudef@pengutronix.de>
Mail-Followup-To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20191111152645.13792-1-m.olbrich@pengutronix.de>
 <20191111152645.13792-2-m.olbrich@pengutronix.de>
 <49416a44-6317-c3e5-dca6-d33f3d8c9c89@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49416a44-6317-c3e5-dca6-d33f3d8c9c89@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:58:15 up 128 days, 14:08, 130 users,  load average: 0.30, 0.21,
 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 13, 2019 at 03:55:30AM +0000, Thinh Nguyen wrote:
> Michael Olbrich wrote:
> > Currently __dwc3_gadget_start_isoc must be called very shortly after
> > XferNotReady. Otherwise the frame number is outdated and start transfer
> > will fail, even with several retries.
> >
> > DSTS provides the lower 14 bit of the frame number. Use it in combination
> > with the frame number provided by XferNotReady to guess the current frame
> > number. This will succeed unless more than one 14 rollover has happened
> > since XferNotReady.
> >
> > Start transfer might still fail if the frame number is increased
> > immediately after DSTS is read. So retries are still needed.
> > Don't drop the current request if this happens. This way it is not lost and
> > can be used immediately to try again with the next frame number.
> >
> > With this change, __dwc3_gadget_start_isoc is still not successfully in all
> > cases bit it increases the acceptable delay after XferNotReady
> > significantly.
> >
> > Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> > ---
> >   drivers/usb/dwc3/core.h   |  1 +
> >   drivers/usb/dwc3/gadget.c | 31 +++++++++++++++++++++++--------
> >   2 files changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 3dd783b889cb..c5b223656e08 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -709,6 +709,7 @@ struct dwc3_ep {
> >   	u8			type;
> >   	u8			resource_index;
> >   	u32			frame_number;
> > +	u32			last_frame_number;
> 
> There's no need to add a new field for last_frame_number. Just store the 
> value in a local variable in __dwc3_gadget_start_isoc().

I'm using it to check for rollover, so __dwc3_gadget_start_isoc does not
help. I introduced it because I caused a second (incorrect) rollover when
the first try failed. But now that I think about it, it should be possible
without the extra variable.

> >   	u32			interval;
> >   
> >   	char			name[20];
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 173f5329d3d9..ac4673d91939 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1204,7 +1204,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
> >   	}
> >   }
> >   
> > -static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
> > +static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, bool keep_req)
> >   {
> >   	struct dwc3_gadget_ep_cmd_params params;
> >   	struct dwc3_request		*req;
> > @@ -1242,7 +1242,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
> >   	}
> >   
> >   	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
> > -	if (ret < 0) {
> > +	if (ret < 0 && (!keep_req || ret != -EAGAIN)) {
> >   		/*
> >   		 * FIXME we need to iterate over the list of requests
> >   		 * here and stop, unmap, free and del each of the linked
> > @@ -1254,7 +1254,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
> >   		return ret;
> >   	}
> >   
> > -	return 0;
> > +	return ret;
> >   }
> >   
> >   static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
> > @@ -1377,7 +1377,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
> >   	dep->start_cmd_status = 0;
> >   	dep->combo_num = 0;
> >   
> > -	return __dwc3_gadget_kick_transfer(dep);
> > +	return __dwc3_gadget_kick_transfer(dep, false);
> >   }
> >   
> >   static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
> > @@ -1402,9 +1402,23 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
> >   	}
> >   
> >   	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
> > -		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
> > +		/*
> > +		 * last_frame_number is set from XferNotReady and may be
> > +		 * already out of date. DSTS only provides the lower 14 bit
> > +		 * of the current frame number. So add the upper two bits of
> > +		 * last_frame_number and handle a possible rollover.
> > +		 * This will provide the correct frame_number unless more than
> > +		 * rollover has happened since XferNotReady.
> > +		 */
> > +		u32 frame = __dwc3_gadget_get_frame(dwc);
> > +
> > +		dep->frame_number = (dep->last_frame_number & ~0x3fff) | frame;
> > +		if (frame < (dep->last_frame_number & 0x3fff))
> > +			dep->frame_number += 0x4000;
> 
> Use BIT(14) rather than 0x4000? It's clearer in in my opinion. We

Ok.

> started using 0x3fff in multiple places now, can we create a macro for that?

Makes sense. Any preferences for the name? <something>_MASK I guess, but I
don't know what the correct name for the 14 bit frame number should be.

> Also, add an empty line here.

ok.

> > +		dep->frame_number = DWC3_ALIGN_FRAME(dep, 1);
> >   
> > -		ret = __dwc3_gadget_kick_transfer(dep);
> > +		ret = __dwc3_gadget_kick_transfer(dep,
> > +				i + 1 < DWC3_ISOC_MAX_RETRIES);
> >   		if (ret != -EAGAIN)
> >   			break;
> >   	}
> > @@ -1461,7 +1475,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
> >   		}
> >   	}
> >   
> > -	return __dwc3_gadget_kick_transfer(dep);
> > +	return __dwc3_gadget_kick_transfer(dep, false);
> >   }
> >   
> >   static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
> > @@ -2467,7 +2481,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
> >   
> >   	if (!dwc3_gadget_ep_request_completed(req) &&
> >   			req->num_pending_sgs) {
> > -		__dwc3_gadget_kick_transfer(dep);
> > +		__dwc3_gadget_kick_transfer(dep, false);
> >   		goto out;
> >   	}
> >   
> > @@ -2497,6 +2511,7 @@ static void dwc3_gadget_endpoint_frame_from_event(struct dwc3_ep *dep,
> >   		const struct dwc3_event_depevt *event)
> >   {
> >   	dep->frame_number = event->parameters;
> > +	dep->last_frame_number = event->parameters;
> >   }
> >   
> >   static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
> 
> Other than the comments I provided, this patch looks fine to me.

Great. Thanks for the review.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
