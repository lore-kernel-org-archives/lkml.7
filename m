Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E374CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6F3206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfDDUy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:54:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41708 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730021AbfDDUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:54:27 -0400
Received: (qmail 27564 invoked by uid 2102); 4 Apr 2019 16:54:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Apr 2019 16:54:26 -0400
Date:   Thu, 4 Apr 2019 16:54:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     mathias.nyman@linux.intel.com, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
In-Reply-To: <20190404121823.GA3793@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1904041653240.1288-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Suwan Kim wrote:

> Hi Alan,
> 
> On Mon, Apr 01, 2019 at 10:43:24AM -0400, Alan Stern wrote:
> > On Mon, 1 Apr 2019, Suwan Kim wrote:
> > 
> > > Patch "USB: HCD: support giveback of URB in tasklet context"[1]
> > > introduced giveback of urb in tasklet context. [1] This patch was
> > > applied to ehci but not xhci. [2] This patch significantly reduces
> > > the hard irq time of xhci. Especially for uvc driver, the hard irq
> > > including the uvc completion function runs quite long but applying
> > > this patch reduces the hard irq time of xhci.
> > 
> > Please read the kerneldoc for usb_submit_urb() and usb_kill_urb(), in 
> > particular, the parts that describe how isochronous URBs are treated.  
> > Can you guarantee that with this patch applied, xhci-hcd will continue 
> > to work as the kerneldoc describes?
> > 
> 
> I read the description of usb_submit_urb() and usb_kill_urb() and i
> think that xhci-hcd with which this patch is applied works as the
> description of usb_submit_urb() and usb_kill_urb().
> 
> In the case of usb_submit_urb(), xhci spec 4.10.3.1 "Ring Overrun and
> Underrun" describes the behavior of xhci when an isochronous ring is
> empty due to the late URB submission in driver. (In this patch, empty
> isochronous ring can happen due to tasklet scheduling delay in URB
> complete function which calls the next usb_submit_urb())
> 
> According to the xhci spec, xHC deals with a late isochronous URB
> according to the SIA(Start Isoch ASAP) flag of TRB and SIA flag is
> set according to URB_ISO_ASAP flag in xhci_queue_isoc_tx().
> 
> If the SIA flag is set, xHC will schedule the late isochronous URB in
> the next "Endpoint Service Interval Time" (next available frame) and
> transmits ischronous URB in that frame.
> 
> If the SIA flag is cleared (URB_ISO_ASAP flag is cleared), xHC generates
> "Missed Service Error" event and skips the late isochronous URB and
> doen't transmit it. When the interrupt handler (xhci_irq) receives
> "Missed Service Error" event, it returns the late isochronous URB to
> the driver calling usb_hcd_giveback_urb() with -EXDEV error code in
> usb_iso_packet_descriptor->status at skip_isoc_td(). So xhci behavior
> about the late isochronous URB in spec and implementation is same
> with the description of usb_submit_urb().
> 
> In the case of usb_kill_urb(), description says that it waits until
> the URB complete function finishes and the important point is that
> whether the USB complete function is called early or late doesn't
> affect the behavior of usb_kill_urb() because __usb_hcd_giveback_urb()
> wakes up usb_kill_urb() after calling URB complete function.
> So, pending a URB complete function in tasklet doesn't affect the
> behavior of xhci in usb_kill_urb().

Okay, good.  I just wanted to make sure you were aware of the issues 
and had checked that using tasklets wouldn't cause any problems.

Alan Stern

