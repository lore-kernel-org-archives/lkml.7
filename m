Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F5FC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7C21738
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562401980;
	bh=ggILC5ns02IYBE7bnvypQaUgBVlj2sYoZUaGLRW2I28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=In4wd7tXnHwWRlOfdqJw/TFbr8qyBiL2CvzjyKYtW6ifzL52ZRL5n+QKpX0ZKlOWL
	 wuGF7Q5YBPezXUBXYIrwy8T8j6pLQcG/CHPmpVMG8pyXUaIZ5WpJkqMDUVgOYOpiqf
	 sBMWtNYElXoBzapHV1uuH1UAyKCH3j+C+t0dFpDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGFIc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 04:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfGFIc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:32:59 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0140020989;
        Sat,  6 Jul 2019 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562401977;
        bh=ggILC5ns02IYBE7bnvypQaUgBVlj2sYoZUaGLRW2I28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhAMN8tijFT3xet7uhxaUWxGPcwy1MzO9IJM5AoaUowrTLQKgmb4xsOTS33HVQUOM
         88IFn5DYfKzm1ULZ0fbCepD19SSSYLafquBS2lH9QXV/7rBAflvhCVWpvU53sWhow7
         Wdm2EvxGGWpKoojCge2x+nHvpxadulHR+OC/nBMQ=
Date:   Sat, 6 Jul 2019 10:32:51 +0200
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
Message-ID: <20190706083251.GA9249@kroah.com>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org>
 <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com>
 <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Platform drivers like to add sysfs groups to their device, but right now
> > they have to do it "by hand".  The driver core should handle this for
> > them, but there is no way to get to the bus-default attribute groups as
> > all platform devices are "special and unique" one-off drivers/devices.
> >
> > To combat this, add a dev_groups pointer to platform_driver which allows
> > a platform driver to set up a list of default attributes that will be
> > properly created and removed by the platform driver core when a probe()
> > function is successful and removed right before the device is unbound.
> 
> Why is this limited to platform bus? Drivers for other buses also
> often want to augment list of their attributes during probe(). I'd
> move it to generic probe handling.

This is not limited to the platform at all, the driver core supports
this for any bus type today, but it's then up to the bus-specific code
to pass that on to the driver core.  That's usually set for the
bus-specific attributes that they want exposed for all devices of that
bus type (see the bus_groups, dev_groups, and drv_groups pointers in
struct bus_type).

For the platform devices, the problem is that this is something that the
individual drivers want after they bind to the device.  And as all
platform devices are "different" they can't be a "common" set of
attributes, so they need to be created after the device is bound to the
driver.

> > Cc: Richard Gong <richard.gong@linux.intel.com>
> > Cc: Romain Izard <romain.izard.pro@gmail.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mans Rullgard <mans@mansr.com>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: addressed Johan's comments by reordering when we remove the files
> >     from the device, and clean up on an error in a nicer way.  Ended up
> >     making the patch smaller overall, always nice.
> >
> >  drivers/base/platform.c         | 16 +++++++++++++++-
> >  include/linux/platform_device.h |  1 +
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 713903290385..74428a1e03f3 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -614,8 +614,20 @@ static int platform_drv_probe(struct device *_dev)
> >
> >         if (drv->probe) {
> >                 ret = drv->probe(dev);
> > -               if (ret)
> > +               if (ret) {
> > +                       dev_pm_domain_detach(_dev, true);
> > +                       goto out;
> > +               }
> > +       }
> > +       if (drv->dev_groups) {
> > +               ret = device_add_groups(_dev, drv->dev_groups);
> > +               if (ret) {
> > +                       if (drv->remove)
> > +                               drv->remove(dev);
> >                         dev_pm_domain_detach(_dev, true);
> > +                       return ret;
> > +               }
> > +               kobject_uevent(&_dev->kobj, KOBJ_CHANGE);
> 
> We already emit KOBJ_BIND when we finish binding device to a driver,
> regardless of the bus. I know we still need to teach systemd to handle
> it properly, but I think it is better than sprinkling KOBJ_CHANGE
> around.

But the object's attributes did just change, which is what KOBJ_CHANGE
tells userspace, so this should be the correct thing to say to
userspace.

And yes, ideally KOBJ_BIND would be handled, and it will be sent once
the device's probe function succeeds, but we have to deal with old
userspaces as well, right?

thanks,

greg k-h
