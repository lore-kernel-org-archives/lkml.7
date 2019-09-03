Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E8CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0B123402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfICOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:14:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60612 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728490AbfICOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:14:37 -0400
Received: (qmail 2738 invoked by uid 2102); 3 Sep 2019 10:14:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Sep 2019 10:14:36 -0400
Date:   Tue, 3 Sep 2019 10:14:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <greg@kroah.com>
cc:     Oliver Neukum <oneukum@suse.com>,
        Julius Werner <jwerner@chromium.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
In-Reply-To: <20190903091953.GA12325@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1909031009250.1859-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019, Greg KH wrote:

> On Tue, Sep 03, 2019 at 10:46:14AM +0200, Oliver Neukum wrote:
> > Am Montag, den 02.09.2019, 18:47 +0200 schrieb Greg KH:
> > > 
> > > This should work just fine today.  Add a new device id to the "new_id"
> > > file and then tell the driver to bind.  That's pretty much the same as a
> > > "force_bind", right?
> > 
> > That looks like a race condition by design to me.
> 
> How?
> 
> Anyway, this should all "just work" somehow, there's an old lwn.net
> article I wrote about this over a decade ago when it was added.  A
> number of subsystems use this all the time (vfio?) and I haven't heard
> any issues with it in a long time.

No, this won't "just work".  The problem is that when you write to the 
new_id file, usb_store_new_id() calls driver_attach(), which tries to 
bind the driver to any matching device.  There _will_ be other matching 
devices, and trying to bind them will cause runtime errors.

That isn't what we want.  We want to bind the driver to a _specific_ 
device and no others, even if the others match the new id.

Now, this is what writing to the sysfs "bind" file does -- except that
it won't let you bind a driver to a device it doesn't match!

So we have two problems:

	Bind a driver to a particular device,

	Even though the id's for the device don't match the driver.

The kernel already contains solutions for each of these problems, but 
nothing that can handle both at once.

Alan Stern

