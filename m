Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02221C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE397206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ar7HTocj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLRTXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:23:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33368 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:23:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so1768388pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lrpuyzodRAJXe9cj7WS4xeUR6dCGUEFq0g86NY3jaI=;
        b=Ar7HTocj3ss1FOQ0KSQqCk77BLMaYyI5MUoXqCCjpwA5/KfyuTBlVoB2oytzOYuFZi
         SH3AgYQreSXDzQa683Nvk7/IcZL2VoxgwnHt/R6Qv76YRV2oVFZ4KlRsYe3Sn5Uo1IiJ
         OCQhpashNoGtCbWke/u3GGQorYf6hgf7SbLGhx8upORWzq95TxfaxzYJBd3Xn9oC3huF
         7DRenzD31a62zVSUcCICrgceIfFjKKVcIYKGtO7It6vWuLfgFU+cX/KGkctHdY8RoOzW
         R+qe/S/CAfkabL5VN4btu8bdPPHBt90O8hDLwc1gyOAVB/3/mjJr39U07Qy/jDVtgRBV
         jXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lrpuyzodRAJXe9cj7WS4xeUR6dCGUEFq0g86NY3jaI=;
        b=QXFWGQ17N6IT6s2vF5tb+lgLv2xdzzNkXQYqohHTT1Uhg2fCP2fAXErxDan0890mh7
         r4xwCfbVBm8xitZkEkUHlSX7mk7/g0VU6dDujttrZbKIe8U3IinnJ4fozoyhrThrhTow
         8aJ2cYGYH+ypoWm1tkrJ8egpPXvKWu18UOGNV6/YhyLsli9b0RR6U3gr9WNkVIACUmdE
         EYtSq5SpKZ5jeVpUvu0hX5eYeXnSnu+GLkPhRZf452Wa41LLKdFmREp3A+fo+ULGfWs7
         fwjZoTZnu/zYUh+BYWNfjDAo1CThkprNSnd3gd3/9zE8TLpPCXku6UEYYQOo5JgNK4OX
         ucFQ==
X-Gm-Message-State: APjAAAXh23Xm8Ca6sV1Homk+FWqlm5DL9bJBsu5OAlwt3jXNAyneiKi8
        iWGwlPMgoasROfCTGS6clEM2PzbSh6GsLM18zOOjcw==
X-Google-Smtp-Source: APXvYqxf3lN/zM4WEYaZs6naC0bKRZ1Q2nxmq4+ZPqrLJWC2LzrvzdSKfL/T4ePsM/4Td1gUlUWmscZ7GK11RsXIuqg=
X-Received: by 2002:a63:31d0:: with SMTP id x199mr4890159pgx.286.1576696979210;
 Wed, 18 Dec 2019 11:22:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576087039.git.andreyknvl@google.com> <f45a20db3e5b01002ae8c91b3a8ea58e38b7bb65.1576087039.git.andreyknvl@google.com>
 <20191218132328.GA121143@kroah.com> <CAAeHK+zXegV1GmSKD8Y3-hTbKUQceWdfo+GJPxSSzYr0zQTYKw@mail.gmail.com>
 <20191218181921.GA882018@kroah.com>
In-Reply-To: <20191218181921.GA882018@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 18 Dec 2019 20:22:47 +0100
Message-ID: <CAAeHK+zqzXBwdBnfPjN+tY4y3dZ2Fb_FR0es5_-ynOZyhrL6uQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] usb: gadget: add raw-gadget interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 7:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 18, 2019 at 06:28:19PM +0100, Andrey Konovalov wrote:
> > On Wed, Dec 18, 2019 at 2:23 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 07:02:41PM +0100, Andrey Konovalov wrote:
> > > > USB Raw Gadget is a kernel module that provides a userspace interface for
> > > > the USB Gadget subsystem. Essentially it allows to emulate USB devices
> > > > from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> > > > currently a strictly debugging feature and shouldn't be used in
> > > > production.
> > > >
> > > > Raw Gadget is similar to GadgetFS, but provides a more low-level and
> > > > direct access to the USB Gadget layer for the userspace. The key
> > > > differences are:
> > > >
> > > > 1. Every USB request is passed to the userspace to get a response, while
> > > >    GadgetFS responds to some USB requests internally based on the provided
> > > >    descriptors. However note, that the UDC driver might respond to some
> > > >    requests on its own and never forward them to the Gadget layer.
> > > >
> > > > 2. GadgetFS performs some sanity checks on the provided USB descriptors,
> > > >    while Raw Gadget allows you to provide arbitrary data as responses to
> > > >    USB requests.
> > > >
> > > > 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> > > >    while GadgetFS currently binds to the first available UDC.
> > > >
> > > > 4. Raw Gadget uses predictable endpoint names (handles) across different
> > > >    UDCs (as long as UDCs have enough endpoints of each required transfer
> > > >    type).
> > > >
> > > > 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
> > >
> > > Looks good to me, only minor comments below.
> >
> > Great, thanks!
> >
> > About reworking the logging to use dev_err/dbg(): can I pass the
> > global miscdevice struct into those macros? Or should I pass a pointer
> > to this struct into all of the functions that print log messages? The
> > latter seems unnecessarily complex, unless there's a reason to do
> > that.
>
> Ah, you are right, you only have one misc device here.  No, that's not
> good, but you can use it for some messages (your ioctl errors), but
> ideally you will have a struct device somewhere for each of the
> "instances" you create, right?  That is what you should use for that.

OK, I think I got the idea. Will do in v4.

>
> > > > +struct raw_dev {
> > > > +     struct kref                     count;
> > > > +     spinlock_t                      lock;
> > > > +
> > > > +     const char                      *udc_name;
> > > > +     struct usb_gadget_driver        driver;
> > >
> > > A dev embeds a driver?
> > >
> > > Not a pointer?
> > >
> > > But you have a kref, so the reference count of this object is there,
> > > right?
> >
> > I didn't get this comment, could you elaborate? I can make it a
> > pointer, but for each raw_dev we have a unique usb_gadget_driver
> > instance, so embedding it as is is simpler.
>
> Ok, that's fine.  But it feels odd creating a driver dynamically to me,
> but it should work (as you show.)  It doesn't give you something to use
> for the dev_* messages directly, ah, but you do have something:
>
> > > > +
> > > > +     /* Protected by lock: */
> > > > +     enum dev_state                  state;
> > > > +     bool                            gadget_registered;
> > > > +     struct usb_gadget               *gadget;
>
> There, use that pointer for your dev_* messages, and you should be fine.
>
> > > > +static void gadget_unbind(struct usb_gadget *gadget)
> > > > +{
> > > > +     struct raw_dev *dev = get_gadget_data(gadget);
> > > > +     unsigned long flags;
> > > > +
> > > > +     spin_lock_irqsave(&dev->lock, flags);
> > > > +     set_gadget_data(gadget, NULL);
> > > > +     spin_unlock_irqrestore(&dev->lock, flags);
> > > > +     /* Matches kref_get() in gadget_bind(). */
> > > > +     kref_put(&dev->count, dev_free);
> > >
> > > What protects the kref from being called 'put' twice on the same
> > > pointer at the same time?  There should be some lock somewhere, right?
> >
> > Hm, kref_put() does refcount_dec_and_test(), which in turns calls
> > atomic_dec_and_test(), so this is protected against concurrent puts
> > (which is the whole idea of kref?), and no locking is needed. Unless I
> > misunderstand something.
>
> It's late, but there should be some lock somewhere to prevent a race
> around this type of thing.  That's why we have kref_put_mutex() and
> kref_put_lock().
>
> Odds are you are fine here, but just something to be aware of...

Ah, I see. So AFAIU kref_put_lock/mutex() are meant to be used in
cases when there might be a concurrent user that doesn't have the
reference counter incremented, but holds the lock? We don't do this
kind of stuff here.
