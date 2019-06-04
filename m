Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79193C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2F82498E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559658488;
	bh=VZDkaCpq87rFDadSl7tAiidtaZ9rcdhfskXh2iVq79k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z/Uqq6Sf5dQKBY2KlJNXnJjzSZP07Dw+7fxqBs/FcCcmOQoj89NWGOE4TlCHlskKj
	 q5QtTmEffPm34fsMaBeFVkV1LEjL0Q3ERBFvwBosCzgbIyDHYPMcEBno1+nnCvGwc/
	 BQQu4TCfmCNNZiICbeSaq/8rE9vua0V2eLr6W308=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFDO2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFDO2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:28:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6DA2498E;
        Tue,  4 Jun 2019 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559658485;
        bh=VZDkaCpq87rFDadSl7tAiidtaZ9rcdhfskXh2iVq79k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spxq2pb53AEdkC5g0+XB74dFiWVIpa8fFUsatgTCPt1qrCmojmTXutVBb2hK2uxUg
         w3Eyi8dg9BfQ+Mu9z8dnKlr2d4POJAGycNqhdS2B02hZHJIgbzBArEPf7rWVpzs0SI
         JmkREcfeSkLHp9GQ2nTS+QhcILT2gVbiZOlYl9QE=
Date:   Tue, 4 Jun 2019 16:28:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Richard Gong <richard.gong@linux.intel.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sen.li@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: A potential broken at platform driver?
Message-ID: <20190604142803.GA28355@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
 <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
 <20190603180255.GA18054@kroah.com>
 <20190604103241.GA4097@5WDYG62>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604103241.GA4097@5WDYG62>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:33:03PM +0200, Romain Izard wrote:
> On Mon, Jun 03, 2019 at 08:02:55PM +0200, Greg KH wrote:
> > > @@ -394,7 +432,7 @@ static struct platform_driver stratix10_rsu_driver = {
> > >  	.remove = stratix10_rsu_remove,
> > >  	.driver = {
> > >  		.name = "stratix10-rsu",
> > > -		.groups = rsu_groups,
> > > +//		.groups = rsu_groups,
> > 
> > Are you sure this is the correct pointer?  I think that might be
> > pointing to the driver's attributes, not the device's attributes.
> > 
> > If platform drivers do not have a way to register groups properly, then
> > that really needs to be fixed, as trying to register it by yourself as
> > you are doing, is ripe for racing with userspace.
>  
> This is a very common issue with platform drivers, and it seems to me that
> it is not possible to add device attributes when binding a device to a
> driver without entering the race condition.
> 
> My understanding is the following one:
> 
> The root cause is that the device has already been created and reported
> to the userspace with a KOBJ_ADD uevent before the device and the driver
> are bound together. On receiving this event, userspace will react, and
> it will try to read the device's attributes. In parallel the kernel will
> try to find a matching driver. If a driver is found, the kernel will
> call the probe function from the driver with the device as a parameter,
> and if successful a KOBJ_BIND uevent will be sent to userspace, but this
> is a recent addition.
> 
> Unfortunately, not all created devices will be bound to a driver, and the
> existing udev code relies on KOBJ_ADD uevents rather than KOBJ_BIND uevents.
> If new per-device attributes have been added to the device during the
> binding stage userspace may or may not see them, depending on when userspace
> tries to read the device's attributes.
> 
> I have this possible workaround, but I do not know if it is a good solution:
> 
> When binding the device and the driver together, create a new device as a
> child to the current device, and fill its "groups" member to point to the
> per-device attributes' group. As the device will be created with all the
> attributes, it will not be affected by the race issues. The functions
> handling the attributes will need to be modified to use the parents of their
> "device" parameter, instead of the device itself. Additionnaly, the sysfs
> location of the attributes will be different, as the child device will show
> up in the sysfs path. But for a newly introduced device this will not be
> a problem.
> 
> Is this a good compromise ?

Not really.  You just want the attributes on the platform device itself.

Given the horrible hack that platform devices are today, what's one more
hack!

Here's a patch below of what should probably be done here.  Richard, can
you change your code to use the new dev_groups pointer in the struct
platform_driver and this patch and let me know if that works or not?

Note, I've only compiled this code, not tested it...

thanks,

greg k-h

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d1729853d1a..3dd4b73a9b30 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -598,6 +598,7 @@ struct platform_device *platform_device_register_full(
 }
 EXPORT_SYMBOL_GPL(platform_device_register_full);
 
+static int platform_drv_remove(struct device *_dev);
 static int platform_drv_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
@@ -614,8 +615,18 @@ static int platform_drv_probe(struct device *_dev)
 
 	if (drv->probe) {
 		ret = drv->probe(dev);
-		if (ret)
+		if (ret) {
 			dev_pm_domain_detach(_dev, true);
+			goto out;
+		}
+	}
+	if (drv->dev_groups) {
+		ret = device_add_groups(_dev, drv->dev_groups);
+		if (ret) {
+			platform_drv_remove(_dev);
+			return ret;
+		}
+		kobject_uevent(&_dev->kobj, KOBJ_CHANGE);
 	}
 
 out:
@@ -640,6 +651,8 @@ static int platform_drv_remove(struct device *_dev)
 
 	if (drv->remove)
 		ret = drv->remove(dev);
+	if (drv->dev_groups)
+		device_remove_groups(_dev, drv->dev_groups);
 	dev_pm_domain_detach(_dev, true);
 
 	return ret;
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cc464850b71e..027f1e1d7af8 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -190,6 +190,7 @@ struct platform_driver {
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
+	const struct attribute_group **dev_groups;
 	bool prevent_deferred_probe;
 };
 
