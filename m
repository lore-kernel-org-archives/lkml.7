Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFFFC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D550D21655
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564081489;
	bh=IKeR7Qt1WU3+ofWT43cH5jhCL7rK7ADA0z4a7B5zTEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cH/Mskn6EjbLsFZJdMdNtaMEm4peNsg2xhvBUEyC6KRNlPdAqikFWxuxEbD8/B0dW
	 7RE0+KZwsRYchLahQvbVF2gaoHh1KvDBODM5INthdci3SLonetW7ejfvjC7egR/8yP
	 K90Muqas/5mTjjbvuypiWv5x6WMn6HkTvJk3+czA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfGYTEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfGYTEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:04:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04F220856;
        Thu, 25 Jul 2019 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564081486;
        bh=IKeR7Qt1WU3+ofWT43cH5jhCL7rK7ADA0z4a7B5zTEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiH7G6EzT7pX5jSFzL9L2lyDbdK6Qob1DCgJNwsIb0lxU+T9/bsjG+gK3IHA8TgOI
         /300lXr9fLjuhLjgqV1fFPsuc4WdhYWGMmASDtau5vJVGPMHQ1w/OVcd2w8U4L083T
         4++x1b+eAReZyV6y/LTKvmbbNf4p7WLuxbGHbwPk=
Date:   Thu, 25 Jul 2019 21:04:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190725190443.GA8877@kroah.com>
References: <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com>
 <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
 <20190706171948.GA23324@kroah.com>
 <CAKdAkRR=fG3i32cY69skYHYmwiT-qQ5pNAzqGkTjisKp9D7teg@mail.gmail.com>
 <20190719115220.GD20044@kroah.com>
 <20190720043857.GA14290@penguin>
 <20190725134411.GE11115@kroah.com>
 <ea210d4d-45ec-4d06-c68d-6a2374e978f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea210d4d-45ec-4d06-c68d-6a2374e978f9@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:02:03PM -0500, Richard Gong wrote:
> Hi Greg,
> 
> On 7/25/19 8:44 AM, Greg Kroah-Hartman wrote:
> > On Sat, Jul 20, 2019 at 07:38:57AM +0300, Dmitry Torokhov wrote:
> > > On Fri, Jul 19, 2019 at 08:52:20PM +0900, Greg Kroah-Hartman wrote:
> > > > On Sat, Jul 06, 2019 at 10:39:38AM -0700, Dmitry Torokhov wrote:
> > > > > On Sat, Jul 6, 2019 at 10:19 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > 
> > > > > > On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > 
> > > > > > > > On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > > > > > > > > Hi Greg,
> > > > > > > > > 
> > > > > > > > > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > > 
> > > > > > > > > > Platform drivers like to add sysfs groups to their device, but right now
> > > > > > > > > > they have to do it "by hand".  The driver core should handle this for
> > > > > > > > > > them, but there is no way to get to the bus-default attribute groups as
> > > > > > > > > > all platform devices are "special and unique" one-off drivers/devices.
> > > > > > > > > > 
> > > > > > > > > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > > > > > > > > a platform driver to set up a list of default attributes that will be
> > > > > > > > > > properly created and removed by the platform driver core when a probe()
> > > > > > > > > > function is successful and removed right before the device is unbound.
> > > > > > > > > 
> > > > > > > > > Why is this limited to platform bus? Drivers for other buses also
> > > > > > > > > often want to augment list of their attributes during probe(). I'd
> > > > > > > > > move it to generic probe handling.
> > > > > > > > 
> > > > > > > > This is not limited to the platform at all, the driver core supports
> > > > > > > > this for any bus type today, but it's then up to the bus-specific code
> > > > > > > > to pass that on to the driver core.  That's usually set for the
> > > > > > > > bus-specific attributes that they want exposed for all devices of that
> > > > > > > > bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> > > > > > > > struct bus_type).
> > > > > > > > 
> > > > > > > > For the platform devices, the problem is that this is something that the
> > > > > > > > individual drivers want after they bind to the device.  And as all
> > > > > > > > platform devices are "different" they can't be a "common" set of
> > > > > > > > attributes, so they need to be created after the device is bound to the
> > > > > > > > driver.
> > > > > > > 
> > > > > > > I believe that your assertion that only platform devices want to
> > > > > > > install custom attributes is incorrect.
> > > > > > 
> > > > > > Sorry, I didn't mean to imply that only platform drivers want to do
> > > > > > this, as you say, many other drivers do as well.
> > > > > > 
> > > > > > > Drivers for devices attached
> > > > > > > to serio, i2c, USB, spi, etc, etc, all have additional attributes:
> > > > > > > 
> > > > > > > dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
> > > > > > > `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
> > > > > > > wc -l
> > > > > > > 170
> > > > > > > 
> > > > > > > I am pretty sure some of this count is false positives, but majority
> > > > > > > is actually proper hits.
> > > > > > 
> > > > > > Yeah, I know, we need to add this type of functionality to those busses
> > > > > > as well.  I don't see a way of doing it other than this bus-by-bus
> > > > > > conversion, do you?
> > > > > 
> > > > > Can't you push the **dev_groups from platform driver down to the
> > > > > generic driver structure and handle them in driver_sysfs_add()?
> > > > 
> > > > Sorry for the delay, got busy with the merge window...
> > > > 
> > > > Anyway, no, we can't call this then, because driver_sysfs_add() is
> > > > called before probe() is called.  So if probe() fails, we don't bind the
> > > > device to the driver.  We also should not be creating sysfs files for a
> > > > driver that has not had probe() called yet, as internal structures will
> > > > not be set up at that time.
> > > 
> > > Ah, yes, I got confused by the fact that driver_sysfs_remove is called
> > > early. Anyway, I think you want something like this:
> > 
> > Ah, nice, this looks good.  Let me try this and see how it goes...
> > 
> 
> I tried Dmitry's patch on Intel Stratix10 platform and it works.
> 
> I added one minor change on the top of Dmitry's patch, since I think we need
> add one additional check prior to device_add_groups(). To align with
> Dmitry's patch, I also change my code to use the new dev_groups pointer in
> the struct of device_driver.

Thanks for testing!

> My changes are below,

<snip>

> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -391,9 +391,9 @@ static int stratix10_rsu_remove(struct platform_device
> *pdev)
>  static struct platform_driver stratix10_rsu_driver = {
>         .probe = stratix10_rsu_probe,
>         .remove = stratix10_rsu_remove,
>         .driver = {
>                 .name = "stratix10-rsu",
> +               .dev_groups = rsu_groups,

I'd prefer to leave the dev_groups in the platform driver code, as no
one should have to do this crazy "sub structure definition" that
platform drivers seem to love to do.

Here's the patch that I currently have on top of Dmitry's that is
getting run through 0-day right now.

I'll resend the whole patch series once it passes (hopefully tomorrow).

thanks,

greg k-h


From 6ad595541f81407f401d992b89ae1269e88cb3be Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2019 15:54:24 +0200
Subject: [PATCH 02/13] platform: add a dev_groups pointer to struct
 platform_driver

As the driver core now provides the ability to directly add/remove
device groups when a driver is bound/unbound to a device, just pass that
pointer along to the driver core.

This allows us to fix up platform drivers to not need to create/remove
groups "by hand" anymore.

Cc: Richard Gong <richard.gong@linux.intel.com>
Cc: Romain Izard <romain.izard.pro@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mans Rullgard <mans@mansr.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/platform.c         | 1 +
 include/linux/platform_device.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 506a0175a5a7..21b3817569cd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -667,6 +667,7 @@ int __platform_driver_register(struct platform_driver *drv,
 	drv->driver.probe = platform_drv_probe;
 	drv->driver.remove = platform_drv_remove;
 	drv->driver.shutdown = platform_drv_shutdown;
+	drv->driver.dev_groups = drv->dev_groups;
 
 	return driver_register(&drv->driver);
 }
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9bc36b589827..9945a08b872a 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -189,6 +189,7 @@ struct platform_driver {
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
+	const struct attribute_group **dev_groups;
 	bool prevent_deferred_probe;
 };
 
-- 
2.22.0

