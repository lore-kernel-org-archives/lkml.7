Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8070C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FAF23426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH3Rnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:43:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40788 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727904AbfH3Rnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:43:37 -0400
Received: (qmail 1647 invoked by uid 2102); 30 Aug 2019 13:43:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Aug 2019 13:43:36 -0400
Date:   Fri, 30 Aug 2019 13:43:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Julius Werner <jwerner@chromium.org>, Greg KH <greg@kroah.com>
cc:     Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
In-Reply-To: <CAODwPW8gTZ_2WEc9n=WJ2PEmQk2anTQYfwQ-898+kOq6wsjnZw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908301337150.1459-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019, Julius Werner wrote:

> > In fact, there already is a way to do this in the kernel: write to the
> > sysfs "bind" file.  The difficulty is that you can't force a driver to
> > bind to an interface if it doesn't believe it is compatible with the
> > interface.  And if the driver believes it is compatible, it will
> > automatically attempt to bind with all such interfaces regardless of
> > their path.
> >
> > Perhaps what you need is a usb_device_id flag to indicate that the
> > entry should never be used for automatic matches -- only for matches
> > made by the user via the "bind" file.  Greg KH would probably be
> > willing to accept a new USB_DEVICE_ID_MATCH_NO_AUTO flag, which
> > could be included in your unusual_devs.h entries.
> 
> This is an interesting idea, but I don't quite see how it can work as
> you described? When I write to 'bind', the driver core calls
> driver_match_device(), which ends up calling usb_device_match()
> (right?), which is the same path that it would call for automatic
> matching.

Oh, too bad.  I had a vague memory that it did not call
driver_match_device().

>  It still ends up in usb_match_one_id(), and if I check for
> the NO_AUTO flag there it would abort just as if it was an auto-match
> attempt. I see no way to pass the information that this is an
> explicit, user-requested "bind" rather than an automatic match across
> the bus->match() callback into the USB code. (I could change the
> signature of the match() callback, but that would require changing
> code for all device busses in Linux, which I assume is something we
> wouldn't want to do? I could also add a flag to struct device to
> communicate "this is currently trying to match for a user-initiated
> bind", but that seems hacky and not really the right place to put
> that.)
> 
> I could instead add a new sysfs node 'force_bind' to the driver core,
> that would work like 'bind' except for skipping the
> driver_match_device() call entirely and forcing a probe(). Do you
> think that would be acceptable? Or is that too big of a hammer to make
> available for all drivers in Linux? Maybe if I do the same thing but
> only for usb drivers, or even only for the usb-storage driver
> specifically, would that be acceptable?

This is a question for Greg.  The problem is that there may be drivers
which can't handle being probed for devices they don't match.

Still, we ought to have a mechanism for doing manual but not automatic 
matches.

Greg, any thoughts?

> If none of this works, I could also extend the new_id interface to
> allow subclass/protocol matches instead. I don't like that as much
> because it doesn't allow me to control the devpath of the device I'm
> matching, but I think it would be enough for my use case (I can't make
> the usb-storage driver bind all AOA devices at all times, but at the
> times where I do want to use it for my one device, I don't expect any
> other AOA devices to be connected). The problem with this is that the
> order of arguments for new ID is already set in stone (vendor,
> product, interface class, refVendor, refProduct), and I don't think I
> can use the refVendor/refProduct for my case so I can't just append
> more numbers behind that. I could maybe instead change it so that it
> also accepts a key-value style line (like "idVendor=abcd
> idProduct=efgh bInterfaceSubClass=ff"), while still being
> backwards-compatible to the old format if you only give it numbers?
> What do you think?

I prefer the manual/automatic approach.  It allows the user to control 
exactly which device will be probed, which could be important.

Alan Stern

