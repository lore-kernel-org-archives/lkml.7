Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1335822C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564062257;
	bh=uDENGbbx7PkaAy5gt7UU18ySTmmiktsUbsvCPhis3uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gihbRq/vcY+JlmElheAcfwX9vpCx7/LP9jI1Th36RGhXSYIl5l2gPk99yXZrW1mY7
	 qXn9hLsipnnfKtXr4Gw2+9mk+8mtDx93ZrRI4yFZ1qrHJ5gK3obxnIqk+TcqI7G2UQ
	 dHZ1QQYNr0b/r3xDXjaFs0IULqsbiFeqCCRnCwOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfGYNoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389989AbfGYNoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:44:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC692238C;
        Thu, 25 Jul 2019 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564062253;
        bh=uDENGbbx7PkaAy5gt7UU18ySTmmiktsUbsvCPhis3uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x9YFF7mvI4yS3VLDnoXdx8PiTv1ca+EnwB0RQR68w+knCRMA+GHs8lCCREN+FMogw
         6pHhtKGwYGewqCC6ymSJ+rkiImAoQbJZGWmmhpef9rZd6xfJpQWWoxTeZ2nFGAtoSW
         CWQ7OXjkKPPINyxwgAct/Aao9cK+Vb77xWmAT3qM=
Date:   Thu, 25 Jul 2019 15:44:11 +0200
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
Message-ID: <20190725134411.GE11115@kroah.com>
References: <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com>
 <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com>
 <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
 <20190706171948.GA23324@kroah.com>
 <CAKdAkRR=fG3i32cY69skYHYmwiT-qQ5pNAzqGkTjisKp9D7teg@mail.gmail.com>
 <20190719115220.GD20044@kroah.com>
 <20190720043857.GA14290@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720043857.GA14290@penguin>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 07:38:57AM +0300, Dmitry Torokhov wrote:
> On Fri, Jul 19, 2019 at 08:52:20PM +0900, Greg Kroah-Hartman wrote:
> > On Sat, Jul 06, 2019 at 10:39:38AM -0700, Dmitry Torokhov wrote:
> > > On Sat, Jul 6, 2019 at 10:19 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > Platform drivers like to add sysfs groups to their device, but right now
> > > > > > > > they have to do it "by hand".  The driver core should handle this for
> > > > > > > > them, but there is no way to get to the bus-default attribute groups as
> > > > > > > > all platform devices are "special and unique" one-off drivers/devices.
> > > > > > > >
> > > > > > > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > > > > > > a platform driver to set up a list of default attributes that will be
> > > > > > > > properly created and removed by the platform driver core when a probe()
> > > > > > > > function is successful and removed right before the device is unbound.
> > > > > > >
> > > > > > > Why is this limited to platform bus? Drivers for other buses also
> > > > > > > often want to augment list of their attributes during probe(). I'd
> > > > > > > move it to generic probe handling.
> > > > > >
> > > > > > This is not limited to the platform at all, the driver core supports
> > > > > > this for any bus type today, but it's then up to the bus-specific code
> > > > > > to pass that on to the driver core.  That's usually set for the
> > > > > > bus-specific attributes that they want exposed for all devices of that
> > > > > > bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> > > > > > struct bus_type).
> > > > > >
> > > > > > For the platform devices, the problem is that this is something that the
> > > > > > individual drivers want after they bind to the device.  And as all
> > > > > > platform devices are "different" they can't be a "common" set of
> > > > > > attributes, so they need to be created after the device is bound to the
> > > > > > driver.
> > > > >
> > > > > I believe that your assertion that only platform devices want to
> > > > > install custom attributes is incorrect.
> > > >
> > > > Sorry, I didn't mean to imply that only platform drivers want to do
> > > > this, as you say, many other drivers do as well.
> > > >
> > > > > Drivers for devices attached
> > > > > to serio, i2c, USB, spi, etc, etc, all have additional attributes:
> > > > >
> > > > > dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
> > > > > `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
> > > > > wc -l
> > > > > 170
> > > > >
> > > > > I am pretty sure some of this count is false positives, but majority
> > > > > is actually proper hits.
> > > >
> > > > Yeah, I know, we need to add this type of functionality to those busses
> > > > as well.  I don't see a way of doing it other than this bus-by-bus
> > > > conversion, do you?
> > > 
> > > Can't you push the **dev_groups from platform driver down to the
> > > generic driver structure and handle them in driver_sysfs_add()?
> > 
> > Sorry for the delay, got busy with the merge window...
> > 
> > Anyway, no, we can't call this then, because driver_sysfs_add() is
> > called before probe() is called.  So if probe() fails, we don't bind the
> > device to the driver.  We also should not be creating sysfs files for a
> > driver that has not had probe() called yet, as internal structures will
> > not be set up at that time.
> 
> Ah, yes, I got confused by the fact that driver_sysfs_remove is called
> early. Anyway, I think you want something like this:

Ah, nice, this looks good.  Let me try this and see how it goes...

> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 0df9b4461766..61d9d650d890 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -515,9 +515,17 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  			goto probe_failed;
>  	}
>  
> +	if (device_add_groups(dev, drv->dev_groups)) {
> +		printk(KERN_ERR "%s: device_add_groups(%s) failed\n",
> +			__func__, dev_name(dev));

dev_err() of course :)

thanks for the review, much appreciated.

greg k-h
