Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CDBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C1321473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9hGzZDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDHO0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:26:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42574 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDHO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:26:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so7419271pgh.9;
        Mon, 08 Apr 2019 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WA2ZIyl54FixGkNFyWxCs+anZ9ROZGajMMGeGEvD+iU=;
        b=W9hGzZDk77lsMZ3/fH7QWWqHgNEbPez3NMLVe6ZOOyCEsLvCVrL8iwmCKjCa2Xjuuo
         CrN0lm+fq82bwt7Qp5N4i3wdVpalwYRDf2NUtc0yXmhjs8euFdb/FVkakjjBHxFfOLZb
         hgQmxSCSSfaA1QZ42KvpqFwZjuZnAxlUpM3bMIFo/MC2+Ut1003D9wMy50D/+I6hlUfQ
         Y9bfNIwR0OoY2oFPNUKkr5/t+ANty+xhCaJe+Pk3Pqt1ajoK2U/neuZbpvwP9SHsbEke
         r1P4Ievzh24S3gh20wBNX6wc/Uh+TaYZsau1jpO99FDttyricte4w5H6flteAgeuU2vu
         ctAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WA2ZIyl54FixGkNFyWxCs+anZ9ROZGajMMGeGEvD+iU=;
        b=e9X2/j+79BwrhxagPdO65wD7oK3C+fuho9r8jl8ev0FQkBf4Ac3/FDTJIdjfl7gJtq
         No2YBm5/LOthva2T7DgITpYu71jcSQnrEvfj8JReviKrDIzKNctxcOL5zvSrAlQEl9O0
         03ySFaWwsR33wJWOgSNCmRkT5xt/C06F0qtdk9LxnhY8G6W8nDqOkPQlr73AMD7qdwbu
         HhrdiltfEZalMbdZkc24Xt4zG5SAtqWZ06SPts1e1eWQCUB9nVJxaqvcZCzz7tYUjqG5
         QKOBtxEAgeCqGopVzjlfJVP23ObI2Cd3r1R3OB7soZ2Ye1Vxnk6Hsx0VJPbLzbFYmOF/
         JQ1Q==
X-Gm-Message-State: APjAAAXz79Xhq73GZqDnN6C+D+ba83pakBcXwbxAS7CtGTNO1zIHqZth
        6O5v77TRb28PeQzO/pS+5+o=
X-Google-Smtp-Source: APXvYqzOo4tfDenGsajne7PvMzaNFpU/qu8JUDikR6hAUKSneEuAkp8ZCDMLsT82Vqvm/i+Jk/BECw==
X-Received: by 2002:a63:3dca:: with SMTP id k193mr27987679pga.146.1554733607709;
        Mon, 08 Apr 2019 07:26:47 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id c81sm11026356pfb.158.2019.04.08.07.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:26:47 -0700 (PDT)
Date:   Mon, 8 Apr 2019 23:26:42 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        mathias.nyman@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
Message-ID: <20190408142640.GA4692@localhost.localdomain>
References: <20190404121823.GA3793@localhost.localdomain>
 <Pine.LNX.4.44L0.1904041653240.1288-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904041653240.1288-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 04:54:26PM -0400, Alan Stern wrote:
> On Thu, 4 Apr 2019, Suwan Kim wrote:
> 
> > Hi Alan,
> > 
> > On Mon, Apr 01, 2019 at 10:43:24AM -0400, Alan Stern wrote:
> > > On Mon, 1 Apr 2019, Suwan Kim wrote:
> > > 
> > > > Patch "USB: HCD: support giveback of URB in tasklet context"[1]
> > > > introduced giveback of urb in tasklet context. [1] This patch was
> > > > applied to ehci but not xhci. [2] This patch significantly reduces
> > > > the hard irq time of xhci. Especially for uvc driver, the hard irq
> > > > including the uvc completion function runs quite long but applying
> > > > this patch reduces the hard irq time of xhci.
> > > 
> > > Please read the kerneldoc for usb_submit_urb() and usb_kill_urb(), in 
> > > particular, the parts that describe how isochronous URBs are treated.  
> > > Can you guarantee that with this patch applied, xhci-hcd will continue 
> > > to work as the kerneldoc describes?
> > > 
> > 
> > I read the description of usb_submit_urb() and usb_kill_urb() and i
> > think that xhci-hcd with which this patch is applied works as the
> > description of usb_submit_urb() and usb_kill_urb().
> > 
> > In the case of usb_submit_urb(), xhci spec 4.10.3.1 "Ring Overrun and
> > Underrun" describes the behavior of xhci when an isochronous ring is
> > empty due to the late URB submission in driver. (In this patch, empty
> > isochronous ring can happen due to tasklet scheduling delay in URB
> > complete function which calls the next usb_submit_urb())
> > 
> > According to the xhci spec, xHC deals with a late isochronous URB
> > according to the SIA(Start Isoch ASAP) flag of TRB and SIA flag is
> > set according to URB_ISO_ASAP flag in xhci_queue_isoc_tx().
> > 
> > If the SIA flag is set, xHC will schedule the late isochronous URB in
> > the next "Endpoint Service Interval Time" (next available frame) and
> > transmits ischronous URB in that frame.
> > 
> > If the SIA flag is cleared (URB_ISO_ASAP flag is cleared), xHC generates
> > "Missed Service Error" event and skips the late isochronous URB and
> > doen't transmit it. When the interrupt handler (xhci_irq) receives
> > "Missed Service Error" event, it returns the late isochronous URB to
> > the driver calling usb_hcd_giveback_urb() with -EXDEV error code in
> > usb_iso_packet_descriptor->status at skip_isoc_td(). So xhci behavior
> > about the late isochronous URB in spec and implementation is same
> > with the description of usb_submit_urb().
> > 
> > In the case of usb_kill_urb(), description says that it waits until
> > the URB complete function finishes and the important point is that
> > whether the USB complete function is called early or late doesn't
> > affect the behavior of usb_kill_urb() because __usb_hcd_giveback_urb()
> > wakes up usb_kill_urb() after calling URB complete function.
> > So, pending a URB complete function in tasklet doesn't affect the
> > behavior of xhci in usb_kill_urb().
> 
> Okay, good.  I just wanted to make sure you were aware of the issues 
> and had checked that using tasklets wouldn't cause any problems.

Yes, isochronous issue is very important point in this patch.
Thank you for your feedback Alan.


Mathias,

Could i receive your feedback for this patch?
Do i need more tests for SS devices or other types of tests?

Regards

Suwan Kim
