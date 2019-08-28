Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CE5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B295208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfH1QlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1QlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:41:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85C0F356C9;
        Wed, 28 Aug 2019 16:41:05 +0000 (UTC)
Received: from ovpn-112-74.rdu2.redhat.com (ovpn-112-74.rdu2.redhat.com [10.10.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25AE64116;
        Wed, 28 Aug 2019 16:41:03 +0000 (UTC)
Message-ID: <bac067d344bef4e6fff7862fcad49cdbf4cd4ab5.camel@redhat.com>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
From:   Dan Williams <dcbw@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Julius Werner <jwerner@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>
Date:   Wed, 28 Aug 2019 11:41:03 -0500
In-Reply-To: <Pine.LNX.4.44L0.1908281155100.1302-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1908281155100.1302-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Aug 2019 16:41:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 12:17 -0400, Alan Stern wrote:
> On Tue, 27 Aug 2019, Julius Werner wrote:
> 
> > This patch adds a new "unusual" USB mass storage device driver. This
> > driver will be used for a virtual USB storage device presented by an
> > Android phone running the 'Chrome OS Recovery'* Android app. This app
> > uses the Android Open Accessory (AOA) API to talk directly to a USB host
> > attached to the phone.
> > 
> > The AOA protocol requires the host to send a custom vendor command on
> > EP0 to "switch" the phone into "AOA mode" (making it drop off the bus
> > and reenumerate with different descriptors). The ums-cros-aoa driver is
> > just a small stub driver to send these vendor commands. It identifies
> > the device it should operate on by VID/PID passed in through a module
> > parameter (e.g. from the bootloader). After the phone is in AOA mode,
> > the normal USB mass storage stack will recognize it by its special
> > VID/PID like any other "unusual dev". An initializer function will
> > further double-check that the device is the device previously operated
> > on by ums-cros-aoa.

Isn't this scenario exactly what usb_modeswitch is supposed to do, in
userspace?  Various WWAN modems also require a vendor-specific command
(or a mass storage eject) to switch from driver CD mode into modem
mode, and all those are handled by usb_modeswitch.

In summary, does this really need to be in the kernel?

Dan

> > *NOTE: The Android app is still under development and will be released
> > at a later date. I'm submitting this patch now so that the driver name
> > and module parameters can be set in stone already, because I have to
> > bake them into bootloader code that is not field-updatable.
> > 
> > Signed-off-by: Julius Werner <jwerner@chromium.org>
> > ---
> 
> > +static struct usb_device_id cros_aoa_ids[] = {
> > +     { USB_DEVICE(0, 0) },   /* to be filled out by cros_aoa_init() */
> > +     { }
> > +};
> > +/* No MODULE_DEVICE_TABLE(). Autoloading doesn't make sense for this module. */
> 
> Aren't you going to get in trouble if there are two attached devices
> that need to be put into AOA mode?
> 
> > +static int set_string(struct usb_device *udev, u16 type, const char *string)
> > +{
> > +     return usb_control_msg(udev, usb_sndctrlpipe(udev, 0), AOA_SET_STRING,
> > +                            USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > +                            0, type, (char *)string, strlen(string) + 1,
> > +                            USB_CTRL_SET_TIMEOUT);
> 
> Although this is technically invalid, it's probably okay...
> 
> > +}
> > +
> > +static int cros_aoa_probe(struct usb_interface *intf,
> > +                       const struct usb_device_id *id)
> > +{
> > +     int rv;
> > +     u16 aoa_protocol;
> > +     struct usb_device *udev = interface_to_usbdev(intf);
> > +
> > +     rv = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), AOA_GET_PROTOCOL,
> > +                          USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > +                          0, 0, &aoa_protocol, sizeof(aoa_protocol),
> > +                          USB_CTRL_GET_TIMEOUT);
> 
> but this most certainly is not okay.  Buffers passed to
> usb_control_msg() (or used with URBs in general) should be allocated
> with kmalloc.
> 
> > +     if (rv < 0 && rv != -EPROTO)
> > +             goto fail;
> > +     if (rv != sizeof(aoa_protocol) || aoa_protocol < 1) {
> > +             dev_err(&intf->dev, "bound device does not support AOA?\n");
> > +             rv = -ENODEV;
> > +             goto fail;
> > +     }
> > +
> > +     if ((rv = set_string(udev, AOA_STR_MANUFACTURER, CROS_MANUF)) < 0 ||
> > +         (rv = set_string(udev, AOA_STR_MODEL, CROS_MODEL)) < 0 ||
> > +         (rv = set_string(udev, AOA_STR_DESCRIPTION, CROS_DESC)) < 0 ||
> > +         (rv = set_string(udev, AOA_STR_VERSION, CROS_VERSION)) < 0 ||
> > +         (rv = set_string(udev, AOA_STR_URI, CROS_URI)) < 0)
> > +             goto fail;
> 
> Bad programming style (assignment within "if" expression).
> 
> > +
> > +     rv = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), AOA_START,
> > +                          USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > +                          0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
> > +
> > +     if (!rv) {
> > +             dev_info(&intf->dev, "switching to AOA mode\n");
> > +             usb_stor_cros_aoa_bind_busnum = udev->bus->busnum;
> > +             usb_stor_cros_aoa_bind_route = udev->route;
> 
> Bear in mind that udev->route is supposed to be reliable only if the 
> device is running at SuperSpeed.
> 
> > +             return 0;
> 
> Why return 0?  You're going to unbind immediately anyway.
> 
> > +     }
> > +
> > +fail:        dev_err(&intf->dev, "probe error %d\n", rv);
> > +     return rv;
> > +}
> > +
> > +static void cros_aoa_disconnect(struct usb_interface *intf)
> > +{
> > +     /* nothing to do -- we expect this to happen right after probe() */
> > +}
> > +
> > +static struct usb_driver cros_aoa_stub_driver = {
> > +     .name =         DRV_NAME,
> > +     .probe =        cros_aoa_probe,
> > +     .disconnect =   cros_aoa_disconnect,
> > +     .id_table =     cros_aoa_ids,
> > +};
> > +
> > +static int __init cros_aoa_init(void)
> > +{
> > +     if (!bind || sscanf(bind, "%hx:%hx", &cros_aoa_ids[0].idVendor,
> > +                                          &cros_aoa_ids[0].idProduct) != 2)
> > +             return -ENODEV;
> > +     pr_info(DRV_NAME ": bound to USB device %4x:%4x\n",
> > +             cros_aoa_ids[0].idVendor, cros_aoa_ids[0].idProduct);
> > +     return usb_register(&cros_aoa_stub_driver);
> 
> As Greg pointed out, there are better ways to do this.
> 
> > +}
> > +
> > +static void __exit cros_aoa_exit(void)
> > +{
> > +     usb_deregister(&cros_aoa_stub_driver);
> > +}
> > +
> > +module_init(cros_aoa_init);
> > +module_exit(cros_aoa_exit);
> > diff --git a/drivers/usb/storage/initializers.c b/drivers/usb/storage/initializers.c
> > index f8f9ce8dc7102..3056db79cd1d9 100644
> > --- a/drivers/usb/storage/initializers.c
> > +++ b/drivers/usb/storage/initializers.c
> > @@ -92,3 +92,37 @@ int usb_stor_huawei_e220_init(struct us_data *us)
> >       usb_stor_dbg(us, "Huawei mode set result is %d\n", result);
> >       return 0;
> >  }
> > +
> > +#if defined(CONFIG_USB_STORAGE_CROS_AOA) || \
> > +             defined(CONFIG_USB_STORAGE_CROS_AOA_MODULE)
> > +/*
> > + * Our VID/PID match grabs any Android device that was switched into Android
> > + * Open Accessory mode. We only want to bind to the one that was switched by the
> > + * ums-cros-aoa driver. There's no 100% way to identify the same device again
> > + * (because it changes all descriptors), but checking that it is on the same bus
> > + * with the same topology route should be a pretty good heuristic.
> > + */
> > +int usb_stor_cros_aoa_bind_busnum = -1;
> > +EXPORT_SYMBOL(usb_stor_cros_aoa_bind_busnum);
> > +u32 usb_stor_cros_aoa_bind_route;
> > +EXPORT_SYMBOL(usb_stor_cros_aoa_bind_route);
> > +
> > +int usb_stor_cros_aoa_validate(struct us_data *us)
> > +{
> > +     if (us->pusb_dev->bus->busnum != usb_stor_cros_aoa_bind_busnum ||
> > +         us->pusb_dev->route != usb_stor_cros_aoa_bind_route) {
> > +             dev_info(&us->pusb_intf->dev,
> > +                      "ums-cros-aoa ignoring unknown AOA device\n");
> > +             return -ENODEV;
> > +     }
> 
> What happens if two devices switch modes concurrently?  You have room 
> to store only one topology route.
> 
> Besides, what's wrong with binding to devices that weren't switched 
> into AOA mode?  Would that just provoke a bunch of unnecessary error 
> messages?
> 
> > +
> > +     /*
> > +      * Only interface 0 connects to the AOA app. Android devices that have
> > +      * ADB enabled also export an interface 1. We don't want it.
> > +      */
> > +     if (us->pusb_intf->cur_altsetting->desc.bInterfaceNumber != 0)
> > +             return -ENODEV;
> 
> Do you really need this test?  What would go wrong if you don't do it?
> 
> > +
> > +     return 0;
> > +}
> > +#endif /* defined(CONFIG_USB_STORAGE_CROS_AOA) || ... */
> > diff --git a/drivers/usb/storage/initializers.h b/drivers/usb/storage/initializers.h
> > index 2dbf9c7d97492..35fe9ef3247d6 100644
> > --- a/drivers/usb/storage/initializers.h
> > +++ b/drivers/usb/storage/initializers.h
> > @@ -37,3 +37,7 @@ int usb_stor_ucr61s2b_init(struct us_data *us);
> >  
> >  /* This places the HUAWEI E220 devices in multi-port mode */
> >  int usb_stor_huawei_e220_init(struct us_data *us);
> > +
> > +extern int usb_stor_cros_aoa_bind_busnum;
> > +extern u32 usb_stor_cros_aoa_bind_route;
> > +int usb_stor_cros_aoa_validate(struct us_data *us);
> > diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> > index ea0d27a94afe0..45fe9bbc6da18 100644
> > --- a/drivers/usb/storage/unusual_devs.h
> > +++ b/drivers/usb/storage/unusual_devs.h
> > @@ -2259,6 +2259,24 @@ UNUSUAL_DEV( 0x1e74, 0x4621, 0x0000, 0x0000,
> >               USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> >               US_FL_BULK_IGNORE_TAG | US_FL_MAX_SECTORS_64 ),
> >  
> > +/*
> > + * Using an Android phone as USB storage back-end for Chrome OS recovery. See
> > + * usb/storage/cros-aoa.c for details.
> > + */
> > +#if defined(CONFIG_USB_STORAGE_CROS_AOA) || \
> > +             defined(CONFIG_USB_STORAGE_CROS_AOA_MODULE)
> > +UNUSUAL_DEV(  0x18d1, 0x2d00, 0x0000, 0xffff,
> > +             "Google",
> > +             "Chrome OS Recovery via AOA",
> > +             USB_SC_SCSI, USB_PR_BULK, usb_stor_cros_aoa_validate,
> > +             US_FL_SINGLE_LUN | US_FL_CAPACITY_OK),
> > +UNUSUAL_DEV(  0x18d1, 0x2d01, 0x0000, 0xffff,
> > +             "Google",
> > +             "Chrome OS Recovery via AOA (with ADB)",
> > +             USB_SC_SCSI, USB_PR_BULK, usb_stor_cros_aoa_validate,
> > +             US_FL_SINGLE_LUN | US_FL_CAPACITY_OK),
> > +#endif /* defined(CONFIG_USB_STORAGE_CROS_AOA) || ... */
> 
> Subdrivers (the ums_* modules) are supposed to have their own 
> individual unusual_devs files.  They don't use the main file.
> 
> > > Why not do the mode switch from userspace?  I thought we were trying to move all the mode-switching stuff in that direction.....
> > 
> > I need to tie in to the main USB mass storage driver in a way that I
> > think would make it too complicated to move the mode switching part to
> > userspace. See the part I'm adding to initializers.c... that one has
> > to be in the kernel since it operates on the device after the mode
> > switch when it is claimed by the normal USB storage driver.
> 
> I'm not convinced that you really need to do this.
> 
> >  But the
> > mode switch part has to communicate information to it to make sure it
> > picks up the right device (just relying on the normal USB device
> > matching isn't enough in this case, because all Android devices in AOA
> > mode identify themselves with that well-known VID/PID... I don't know
> > if there's any other kernel driver using this protocol today, but
> > there may be at some point and then it becomes important to make sure
> > you really grab the device you meant to grab). Some of that
> > information (the 'route' field) isn't even directly available from
> > userspace (I could use the device name string instead and that would
> > roughly come out to the same thing, but seems less clean to me).
> 
> The full, reliable routing information (not just the data in
> udev->route) is indeed available to userspace.  See the definition of
> the USBDEVFS_CONNINFO_EX usbfs ioctl.
> 
> > So I could either do the mode switch in userspace and add a big custom
> > sysfs interface to the usb-storage driver to allow userspace to
> > configure all this, or I can add a small kernel shim driver like in
> > this patch. Considering how little code the shim driver actually needs
> > I expect it would come out to roughly the same amount of kernel code
> > in both cases, and I feel like this version is much simpler to follow
> > and fits cleaner in the existing "unusual device" driver
> > infrastructure.
> 
> IMO the userspace approach would be better, unless you can provide a
> really compelling argument for why it won't suffice.
> 
> Alan Stern
> 

