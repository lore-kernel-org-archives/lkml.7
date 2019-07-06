Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15AEC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84F82083B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562433596;
	bh=MptNP8FBOfvZAcejuztr5mKgDsORmKl359mYbRWSfLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FX4dK7knLQY3UYr2spBxPPYtuZyu327lFa3d0IKyC+ZG9QpOcBahWKViZa23/7/m5
	 FU1hq9rKIAHK+kwDEhQV1c42pWa2cRTMi5fkkn7SdOBGxx/zTltbkB+RuH+YE+V3RF
	 ZdlqIbEfjdTgqRVw7PxE2bvs5XJzUVp6hIUCdtM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfGFRTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfGFRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:19:54 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9DD2082F;
        Sat,  6 Jul 2019 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562433593;
        bh=MptNP8FBOfvZAcejuztr5mKgDsORmKl359mYbRWSfLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJrms23xKxptgn/RLeGTW1mAtXPVOIDTTChgMVj8a3BO0KKyqe9ywQx2H4xmmMt2C
         xQ/s11R3793ElE5imIMhiIfGyD2HYmHDJ0SPEEWNxvDiRctM+vAzozT4GUz+UFpd26
         NNX05Ibzo/XAvtNh2V6tsIsLT6sL71/U5ubGIaGs=
Date:   Sat, 6 Jul 2019 19:19:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190706171948.GA23324@kroah.com>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org>
 <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com>
 <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com>
 <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > > Hi Greg,
> > >
> > > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Platform drivers like to add sysfs groups to their device, but right now
> > > > they have to do it "by hand".  The driver core should handle this for
> > > > them, but there is no way to get to the bus-default attribute groups as
> > > > all platform devices are "special and unique" one-off drivers/devices.
> > > >
> > > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > > a platform driver to set up a list of default attributes that will be
> > > > properly created and removed by the platform driver core when a probe()
> > > > function is successful and removed right before the device is unbound.
> > >
> > > Why is this limited to platform bus? Drivers for other buses also
> > > often want to augment list of their attributes during probe(). I'd
> > > move it to generic probe handling.
> >
> > This is not limited to the platform at all, the driver core supports
> > this for any bus type today, but it's then up to the bus-specific code
> > to pass that on to the driver core.  That's usually set for the
> > bus-specific attributes that they want exposed for all devices of that
> > bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> > struct bus_type).
> >
> > For the platform devices, the problem is that this is something that the
> > individual drivers want after they bind to the device.  And as all
> > platform devices are "different" they can't be a "common" set of
> > attributes, so they need to be created after the device is bound to the
> > driver.
> 
> I believe that your assertion that only platform devices want to
> install custom attributes is incorrect.

Sorry, I didn't mean to imply that only platform drivers want to do
this, as you say, many other drivers do as well.

> Drivers for devices attached
> to serio, i2c, USB, spi, etc, etc, all have additional attributes:
> 
> dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
> `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
> wc -l
> 170
> 
> I am pretty sure some of this count is false positives, but majority
> is actually proper hits.

Yeah, I know, we need to add this type of functionality to those busses
as well.  I don't see a way of doing it other than this bus-by-bus
conversion, do you?

> > > We already emit KOBJ_BIND when we finish binding device to a driver,
> > > regardless of the bus. I know we still need to teach systemd to handle
> > > it properly, but I think it is better than sprinkling KOBJ_CHANGE
> > > around.
> >
> > But the object's attributes did just change, which is what KOBJ_CHANGE
> > tells userspace, so this should be the correct thing to say to
> > userspace.
> >
> > And yes, ideally KOBJ_BIND would be handled, and it will be sent once
> > the device's probe function succeeds, but we have to deal with old
> > userspaces as well, right?
> 
> Not for the new functionality, I do not think so. Newer kernels should
> be compatible with older userspace as it not breaking it, but new
> functionality is not guaranteed to be available with older userspace.

I agree, but again, this is a kobject change (adding attributes), so
I think the event type I picked here is the correct one.

thanks,

greg k-h
