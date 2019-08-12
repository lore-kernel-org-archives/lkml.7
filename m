Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47680C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EB920679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfHLOVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46964 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726354AbfHLOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:15 -0400
Received: (qmail 2945 invoked by uid 2102); 12 Aug 2019 10:21:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2019 10:21:14 -0400
Date:   Mon, 12 Aug 2019 10:21:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Greg KH <greg@kroah.com>,
        syzbot <syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <kirr@nexedi.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, <lkundrak@v3.sk>,
        <logang@deltatee.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in ld_usb_release
In-Reply-To: <CAAeHK+xZgjD+gP=pCkk0uKVkuPG+XZ26mgNQCGzw2ea5mqFTJg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908121020180.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Andrey Konovalov wrote:

> Alan, could you submit this patch (if you haven't already)? Looks like
> it fixes this bug (and might fix some others).

I will.  I was waiting to see if Greg KH had any comments.

Alan Stern


> >  drivers/usb/core/file.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Index: usb-devel/drivers/usb/core/file.c
> > ===================================================================
> > --- usb-devel.orig/drivers/usb/core/file.c
> > +++ usb-devel/drivers/usb/core/file.c
> > @@ -193,9 +193,10 @@ int usb_register_dev(struct usb_interfac
> >                 intf->minor = minor;
> >                 break;
> >         }
> > -       up_write(&minor_rwsem);
> > -       if (intf->minor < 0)
> > +       if (intf->minor < 0) {
> > +               up_write(&minor_rwsem);
> >                 return -EXFULL;
> > +       }
> >
> >         /* create a usb class device for this usb interface */
> >         snprintf(name, sizeof(name), class_driver->name, minor - minor_base);
> > @@ -203,12 +204,11 @@ int usb_register_dev(struct usb_interfac
> >                                       MKDEV(USB_MAJOR, minor), class_driver,
> >                                       "%s", kbasename(name));
> >         if (IS_ERR(intf->usb_dev)) {
> > -               down_write(&minor_rwsem);
> >                 usb_minors[minor] = NULL;
> >                 intf->minor = -1;
> > -               up_write(&minor_rwsem);
> >                 retval = PTR_ERR(intf->usb_dev);
> >         }
> > +       up_write(&minor_rwsem);
> >         return retval;
> >  }
> >  EXPORT_SYMBOL_GPL(usb_register_dev);
> > @@ -234,12 +234,12 @@ void usb_deregister_dev(struct usb_inter
> >                 return;
> >
> >         dev_dbg(&intf->dev, "removing %d minor\n", intf->minor);
> > +       device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
> >
> >         down_write(&minor_rwsem);
> >         usb_minors[intf->minor] = NULL;
> >         up_write(&minor_rwsem);
> >
> > -       device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
> >         intf->usb_dev = NULL;
> >         intf->minor = -1;
> >         destroy_usb_class();

