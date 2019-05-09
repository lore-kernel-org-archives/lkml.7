Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52956C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304E6208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEIOcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:32:01 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43782 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726704AbfEIOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:32:00 -0400
Received: (qmail 14260 invoked by uid 2102); 9 May 2019 10:31:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2019 10:31:59 -0400
Date:   Thu, 9 May 2019 10:31:59 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Jim Lin <jilin@nvidia.com>, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <keescook@chromium.org>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/1] usb: xhci: Add Clear_TT_Buffer
In-Reply-To: <20190509122534.GA31542@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1905091015440.1480-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019, Greg KH wrote:

> On Thu, May 09, 2019 at 08:03:15PM +0800, Jim Lin wrote:
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -625,6 +625,7 @@ struct usb3_lpm_parameters {
> >   *		parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
> >   *
> >   *	Will be used as wValue for SetIsochDelay requests.
> > + * @devaddr: address on a USB bus, assigned by controller like XHCI
> >   *
> >   * Notes:
> >   * Usbcore drivers should not set usbdev->state directly.  Instead use
> > @@ -709,6 +710,7 @@ struct usb_device {
> >  	unsigned lpm_disable_count;
> >  
> >  	u16 hub_delay;
> > +	int devaddr;
> 
> Shouldn't this be u32?

In fact the device address is an unsigned 7-bit value.  The size of the 
variable we store it in doesn't matter much.

BUT!  If it's going to be stored in a regular int then it's foolish to 
leave a 16-bit gap between it and the preceding field in the structure.  
It should be added at some appropriate spot in the structure, not at 
the end.

Overall I think this should be broken up into two patches: one to
introduce the new field and one to implement Clear-TT-Buffer for xHCI.

Furthermore, update_devnum() in hub.c should do:

	if (udev->devaddr == 0)
		udev->devaddr = devnum;

Then the code usb_hub_clear_tt_buffer() can just use devaddr without
needing to check the HCD type.

Alan Stern

