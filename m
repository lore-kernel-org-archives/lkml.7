Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BCC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 04:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEFC21872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 04:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh+ivRrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGTEjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 00:39:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34735 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfGTEjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 00:39:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so15843207lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 21:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yxJ0+UrYOvfs4IZaSDnAPfP4NsYyfMxgKHrRNyPkwK0=;
        b=Sh+ivRrkrNhJDEjmvmwE1tMv+cFflxKCVP/IFRkgBI+Qql0rzm8Es2abIH4agHgS7p
         QXn1Pr11DVxn1YKlNBcfRmbTNZHq4QqJVeJAJUh1j65zEhVwTMtq27ZYCyl8kJ4zI7Tj
         Yfi3ZEgMgd6oDYnju4Mztvu002CIFAtjC52s1//jmpMptAD5mqk9dYxWoQzy8+RYu30A
         PhDAjub/V1Oazd6BguGvXSUoaPldL9rE3Z4RqGJCXmCRn0ti46LfdJAhTrcxUA24UVWL
         f1NwmAkV0+PNovbUkIenHJjG3Uqz/pk3+H11gcv+xKTRj7yZYcaPwINjeC97VMP8Q7RU
         3B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yxJ0+UrYOvfs4IZaSDnAPfP4NsYyfMxgKHrRNyPkwK0=;
        b=ZTJ3W3b2hQvLE5tMJzLG44s4M5aZLwwKllqAL8P+ngdVE5D1vZ+4CWGYumiKLmR7IO
         cpUlyyilYUayOQtNBkykcnDioOh8X9+SAfk59JJ8t0U1qsLw3GCcN9uMXNzy6qOjoZs4
         leaf46n5L+v97bBM9NY0u/hyo/d4CxQADFbgQkmgKsGgliwd/OuDA2XagIMf3yHxb3bE
         /6vRMElLRcwMNQN1uAp2PM0+pauR4Lk9OiKlP3jtkfR5zQ9U2MvkrP+zXe+tRAB1JJqs
         UKxR2/dz5GBNq8kYrWANxdkHIoqFnCtsdFLfZAmP8T8zGpnsCLwDutcT0kwgGoDjbtBJ
         cONQ==
X-Gm-Message-State: APjAAAUbrnxlzj7M36eoGyhqOvgZeVwxbpq62iw976eyepKvbkLN4Tjn
        voi6pVNtcBZV9aOErBEOqAc=
X-Google-Smtp-Source: APXvYqyycah/m3qsvNZMFOjbzdL5zRupzqmYPXQS1MjIaTC+QHokQJwUjHuCkjSKc5jrTTF/SASGGg==
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr23507730lfg.152.1563597543942;
        Fri, 19 Jul 2019 21:39:03 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id x2sm4720830lfg.12.2019.07.19.21.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 21:39:02 -0700 (PDT)
Date:   Sat, 20 Jul 2019 07:38:57 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190720043857.GA14290@penguin>
References: <20190704084617.3602-2-gregkh@linuxfoundation.org>
 <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com>
 <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com>
 <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
 <20190706171948.GA23324@kroah.com>
 <CAKdAkRR=fG3i32cY69skYHYmwiT-qQ5pNAzqGkTjisKp9D7teg@mail.gmail.com>
 <20190719115220.GD20044@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719115220.GD20044@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 08:52:20PM +0900, Greg Kroah-Hartman wrote:
> On Sat, Jul 06, 2019 at 10:39:38AM -0700, Dmitry Torokhov wrote:
> > On Sat, Jul 6, 2019 at 10:19 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
> > > > Hi Greg,
> > > >
> > > > On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > Platform drivers like to add sysfs groups to their device, but right now
> > > > > > > they have to do it "by hand".  The driver core should handle this for
> > > > > > > them, but there is no way to get to the bus-default attribute groups as
> > > > > > > all platform devices are "special and unique" one-off drivers/devices.
> > > > > > >
> > > > > > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > > > > > a platform driver to set up a list of default attributes that will be
> > > > > > > properly created and removed by the platform driver core when a probe()
> > > > > > > function is successful and removed right before the device is unbound.
> > > > > >
> > > > > > Why is this limited to platform bus? Drivers for other buses also
> > > > > > often want to augment list of their attributes during probe(). I'd
> > > > > > move it to generic probe handling.
> > > > >
> > > > > This is not limited to the platform at all, the driver core supports
> > > > > this for any bus type today, but it's then up to the bus-specific code
> > > > > to pass that on to the driver core.  That's usually set for the
> > > > > bus-specific attributes that they want exposed for all devices of that
> > > > > bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> > > > > struct bus_type).
> > > > >
> > > > > For the platform devices, the problem is that this is something that the
> > > > > individual drivers want after they bind to the device.  And as all
> > > > > platform devices are "different" they can't be a "common" set of
> > > > > attributes, so they need to be created after the device is bound to the
> > > > > driver.
> > > >
> > > > I believe that your assertion that only platform devices want to
> > > > install custom attributes is incorrect.
> > >
> > > Sorry, I didn't mean to imply that only platform drivers want to do
> > > this, as you say, many other drivers do as well.
> > >
> > > > Drivers for devices attached
> > > > to serio, i2c, USB, spi, etc, etc, all have additional attributes:
> > > >
> > > > dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
> > > > `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
> > > > wc -l
> > > > 170
> > > >
> > > > I am pretty sure some of this count is false positives, but majority
> > > > is actually proper hits.
> > >
> > > Yeah, I know, we need to add this type of functionality to those busses
> > > as well.  I don't see a way of doing it other than this bus-by-bus
> > > conversion, do you?
> > 
> > Can't you push the **dev_groups from platform driver down to the
> > generic driver structure and handle them in driver_sysfs_add()?
> 
> Sorry for the delay, got busy with the merge window...
> 
> Anyway, no, we can't call this then, because driver_sysfs_add() is
> called before probe() is called.  So if probe() fails, we don't bind the
> device to the driver.  We also should not be creating sysfs files for a
> driver that has not had probe() called yet, as internal structures will
> not be set up at that time.

Ah, yes, I got confused by the fact that driver_sysfs_remove is called
early. Anyway, I think you want something like this:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0df9b4461766..61d9d650d890 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -515,9 +515,17 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
+	if (device_add_groups(dev, drv->dev_groups)) {
+		printk(KERN_ERR "%s: device_add_groups(%s) failed\n",
+			__func__, dev_name(dev));
+		goto dev_groups_failed;
+	}
+
 	if (test_remove) {
 		test_remove = false;
 
+		device_remove_groups(dev, drv->dev_groups);
+
 		if (dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
@@ -545,6 +553,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 	goto done;
 
+dev_groups_failed:
+	if (dev->bus->remove)
+		dev->bus->remove(dev);
+	else if (drv->remove)
+		drv->remove(dev);
 probe_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
@@ -1075,6 +1088,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		pm_runtime_put_sync(dev);
 
+		device_remove_groups(dev, drv->dev_groups);
+
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
diff --git a/include/linux/device.h b/include/linux/device.h
index 4a295e324ac5..12aa8c687404 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -259,6 +259,8 @@ enum probe_type {
  * @resume:	Called to bring a device from sleep mode.
  * @groups:	Default attributes that get created by the driver core
  *		automatically.
+ * @dev_groups:	Additional attributes attached to device instance once the
+ *		it is bound to the driver.
  * @pm:		Power management operations of the device which matched
  *		this driver.
  * @coredump:	Called when sysfs entry is written to. The device driver
@@ -293,6 +295,7 @@ struct device_driver {
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
 	const struct attribute_group **groups;
+	const struct attribute_group **dev_groups;
 
 	const struct dev_pm_ops *pm;
 	void (*coredump) (struct device *dev);


Thanks.

-- 
Dmitry
