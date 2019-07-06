Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD27C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747F20656
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWLacDx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGFRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:39:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36610 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfGFRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:39:51 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so10192893iom.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSgN4YIPgY78tSXl4YLNZectiEvL8u9te3T1X0J0d+g=;
        b=bWLacDx0CKYEX6MLtAR5OH24e4fV31GaSh7gFLKQNzK+O2ettmtDnvPMiNzcmYOR0U
         zq1mKw9kTN9T1BlRchxAyfausM8vTd9F7KLqzmSqPUKAFHYAB1PNA8VP4LdxwodSWFLk
         xrQDf1HbeKHFcj08f2z60hvM7F00t2gy6ztgyww77VXIGj/Rrd0x1MqOYxSN+YVVctmN
         uzzivzM/H0PVq1U5wbs/eRf5wfytsnUq3MAJY7slN74HV5aWvCuNsr+JR9JcQ6NDtpMm
         +2HzeYnw1jL1ZU7xaIPPHEMrJdMwv6SAUJV3eDlwZmka7fNIyk6a6f6WXezniHDJD/fp
         Y/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSgN4YIPgY78tSXl4YLNZectiEvL8u9te3T1X0J0d+g=;
        b=M+h0dUqHHlmuUkEbVF2ivO87XlT/IZHJiWabhlhSveqo4kRxn/WgDaZU0rUhCLOh9r
         ZxfHdTC59X8feDyfh9FVDnLpQ2eQhpXqss9k0oKZcbCaPTsUTeBU87XeMPFoa/2QsnDy
         S6H+Q16IG/vllPKzAIDJLbg1VdYage0ZyqJWpyeGMFP8yzYPa1p1wjYhIUTqLc/dhi/0
         EuNUvpo2e+IdW6/Jdc6cgG58Q87emmJ2z/WrVNxqbhAf1gZlJVtoYpXZ/i7Ivk5XC1p9
         nqNK285sdnREqGpwMnBQNdiP0u56FzEq+onD0Kc1C4tOtS0qfbhn+J/vKW648F74/wdH
         HAWQ==
X-Gm-Message-State: APjAAAVnLihUa+lel3AEw9txkyH7kNTIJDzHn+vLLD9OM6pyxZYWzyVG
        ka5On9gyQYOZnC3o38mP1u+heKlzorQowv9ljOhKyKav
X-Google-Smtp-Source: APXvYqwPwNlccaE3vApDCQQx6lNxfflinFigtJMilsC/cFjMU0m1njlWtmWufOB2SQolK9xN3UgBd2RW5k4iGAey6R8=
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr10269459iot.87.1562434789998;
 Sat, 06 Jul 2019 10:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org> <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com> <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com> <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
 <20190706171948.GA23324@kroah.com>
In-Reply-To: <20190706171948.GA23324@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 6 Jul 2019 10:39:38 -0700
Message-ID: <CAKdAkRR=fG3i32cY69skYHYmwiT-qQ5pNAzqGkTjisKp9D7teg@mail.gmail.com>
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct platform_driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 10:19 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> >
> > On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > > > Hi Greg,
> > > >
> > > > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > Platform drivers like to add sysfs groups to their device, but right now
> > > > > they have to do it "by hand".  The driver core should handle this for
> > > > > them, but there is no way to get to the bus-default attribute groups as
> > > > > all platform devices are "special and unique" one-off drivers/devices.
> > > > >
> > > > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > > > a platform driver to set up a list of default attributes that will be
> > > > > properly created and removed by the platform driver core when a probe()
> > > > > function is successful and removed right before the device is unbound.
> > > >
> > > > Why is this limited to platform bus? Drivers for other buses also
> > > > often want to augment list of their attributes during probe(). I'd
> > > > move it to generic probe handling.
> > >
> > > This is not limited to the platform at all, the driver core supports
> > > this for any bus type today, but it's then up to the bus-specific code
> > > to pass that on to the driver core.  That's usually set for the
> > > bus-specific attributes that they want exposed for all devices of that
> > > bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> > > struct bus_type).
> > >
> > > For the platform devices, the problem is that this is something that the
> > > individual drivers want after they bind to the device.  And as all
> > > platform devices are "different" they can't be a "common" set of
> > > attributes, so they need to be created after the device is bound to the
> > > driver.
> >
> > I believe that your assertion that only platform devices want to
> > install custom attributes is incorrect.
>
> Sorry, I didn't mean to imply that only platform drivers want to do
> this, as you say, many other drivers do as well.
>
> > Drivers for devices attached
> > to serio, i2c, USB, spi, etc, etc, all have additional attributes:
> >
> > dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
> > `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
> > wc -l
> > 170
> >
> > I am pretty sure some of this count is false positives, but majority
> > is actually proper hits.
>
> Yeah, I know, we need to add this type of functionality to those busses
> as well.  I don't see a way of doing it other than this bus-by-bus
> conversion, do you?

Can't you push the **dev_groups from platform driver down to the
generic driver structure and handle them in driver_sysfs_add()?

>
> > > > We already emit KOBJ_BIND when we finish binding device to a driver,
> > > > regardless of the bus. I know we still need to teach systemd to handle
> > > > it properly, but I think it is better than sprinkling KOBJ_CHANGE
> > > > around.
> > >
> > > But the object's attributes did just change, which is what KOBJ_CHANGE
> > > tells userspace, so this should be the correct thing to say to
> > > userspace.
> > >
> > > And yes, ideally KOBJ_BIND would be handled, and it will be sent once
> > > the device's probe function succeeds, but we have to deal with old
> > > userspaces as well, right?
> >
> > Not for the new functionality, I do not think so. Newer kernels should
> > be compatible with older userspace as it not breaking it, but new
> > functionality is not guaranteed to be available with older userspace.
>
> I agree, but again, this is a kobject change (adding attributes), so
> I think the event type I picked here is the correct one.

I guess once you push it all into core you'll end up with 2 uevents
being emitted back-to-back and this seems inefficient.

If you really want KOBJ_CHANGE maybe have some additional attribute
like "CHANGE=driver-specific-attrs" in it? It's all quite ugly though.

Thanks.

-- 
Dmitry
