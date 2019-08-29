Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C3EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AD42080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfH2Pll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:41:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44918 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726518AbfH2Pll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:41:41 -0400
Received: (qmail 2493 invoked by uid 2102); 29 Aug 2019 11:41:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Aug 2019 11:41:40 -0400
Date:   Thu, 29 Aug 2019 11:41:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Julius Werner <jwerner@chromium.org>
cc:     Dan Williams <dcbw@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
In-Reply-To: <CAODwPW-+c6Ty_gqEFEaE0YhtutMR2tFnhEFOQre81uyM3mfMVA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908291038050.1306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Julius Werner wrote:

> (Thanks for the reviews... I'll get back to the kernel code details
> after double-checking if this can be done from userspace.)
> 
> > > Besides, what's wrong with binding to devices that weren't switched
> > > into AOA mode?  Would that just provoke a bunch of unnecessary error
> > > messages?
> 
> It's not about devices that aren't switched into AOA mode... it's
> about devices that are switched into AOA mode for other reasons
> (connecting to other Android apps). I don't think a kernel driver like
> that exists today, but it could be added, or people could use libusb
> to talk to an AOA device. AOA is just a general mechanism to talk to
> an Android app for whatever you want, and the descriptors sent during
> mode switch clarify what app it's talking to (and thereby what
> protocol it is using... it could be mass storage or it could be
> something entirely different). But a device switched into AOA mode for
> whatever app will always use that same well-known VID/PID (18d1:2d00).
> So if I just add that VID/PID to the IDs bound by the usb-storage
> driver, it would also grab a device that was mode-switched by
> userspace to talk to a completely different app. I need some way to
> make sure it only grabs the intended device, and there's no good
> identifier for that other than comparing the dev path to what you
> originally mode switched.

Okay, I see.  This sounds like a problem of communication between 
userspace and the kernel driver; you want to tell the driver to bind 
only to a specific device that is distinguishable only by its path.

In fact, there already is a way to do this in the kernel: write to the
sysfs "bind" file.  The difficulty is that you can't force a driver to
bind to an interface if it doesn't believe it is compatible with the
interface.  And if the driver believes it is compatible, it will
automatically attempt to bind with all such interfaces regardless of
their path.

Perhaps what you need is a usb_device_id flag to indicate that the 
entry should never be used for automatic matches -- only for matches 
made by the user via the "bind" file.  Greg KH would probably be 
willing to accept a new USB_DEVICE_ID_MATCH_NO_AUTO flag, which 
could be included in your unusual_devs.h entries.

> > > > +     /*
> > > > +      * Only interface 0 connects to the AOA app. Android devices that have
> > > > +      * ADB enabled also export an interface 1. We don't want it.
> > > > +      */
> > > > +     if (us->pusb_intf->cur_altsetting->desc.bInterfaceNumber != 0)
> > > > +             return -ENODEV;
> > >
> > > Do you really need this test?  What would go wrong if you don't do it?
> 
> Yes, otherwise two separate usb-storage instances bind to the two
> interfaces. The second interface is meant for a special ADB debugging
> protocol and will not respond at all to USB mass storage packets, so
> eventually the first request to it times out and
> usb_stor_invoke_transport() will do a port reset to recover. That also
> kills the first interface asynchronously even though it was working
> fine.

This isn't an issue if you rely on sysfs-directed binding.  You write 
the name of the specific interface to the "bind" file.

> > > IMO the userspace approach would be better, unless you can provide a
> > > really compelling argument for why it won't suffice.
> 
> Well... okay, let me think through that again. I just found the new_id
> sysfs API that I wasn't aware of before, maybe I could leverage that
> to bind this from userspace after doing the mode switch. But it looks
> like that only operates on whole devices... is there any way to force
> it to only bind one particular interface?

No.  But with the NO_AUTO flag in your match flags, this wouldn't 
matter.  Besides, the IDs you want to add aren't really dynamic -- they 
are fixed and known in advance.

Try something like the patch below (completely untested).  You'd
probably divide this up into two separate patches for submission: one
for the NO_AUTO flag and one to modify usb-storage.

Alan Stern


 drivers/usb/core/driver.c          |    4 ++++
 drivers/usb/storage/unusual_devs.h |   13 +++++++++++++
 drivers/usb/storage/usb.c          |    2 ++
 drivers/usb/storage/usual-tables.c |    6 ++++++
 include/linux/mod_devicetable.h    |    1 +
 include/linux/usb.h                |   20 ++++++++++++++++++++
 6 files changed, 46 insertions(+)

Index: usb-devel/drivers/usb/core/driver.c
===================================================================
--- usb-devel.orig/drivers/usb/core/driver.c
+++ usb-devel/drivers/usb/core/driver.c
@@ -685,6 +685,10 @@ int usb_match_one_id(struct usb_interfac
 	if (id == NULL)
 		return 0;
 
+	/* Don't match entries intended only for manual binding */
+	if (id->match_flags & USB_DEVICE_ID_MATCH_NO_AUTO)
+		return 0;
+
 	intf = interface->cur_altsetting;
 	dev = interface_to_usbdev(interface);
 
Index: usb-devel/drivers/usb/storage/unusual_devs.h
===================================================================
--- usb-devel.orig/drivers/usb/storage/unusual_devs.h
+++ usb-devel/drivers/usb/storage/unusual_devs.h
@@ -2183,6 +2183,19 @@ UNUSUAL_DEV(  0x1822, 0x0001, 0x0000, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, usb_stor_euscsi_init,
 		US_FL_SCM_MULT_TARG ),
 
+/* Reported by Julius Werner <jwerner@chromium.org> */
+UNUSUAL_DEV_NO_AUTO(  0x18d1, 0x2d00, 0x0000, 0xffff,
+		"Google",
+		"Chrome OS Recovery via AOA",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_SINGLE_LUN | US_FL_CAPACITY_OK),
+
+UNUSUAL_DEV_NO_AUTO(  0x18d1, 0x2d01, 0x0000, 0xffff,
+		"Google",
+		"Chrome OS Recovery via AOA (with ADB)",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_SINGLE_LUN | US_FL_CAPACITY_OK),
+
 /*
  * Reported by Hans de Goede <hdegoede@redhat.com>
  * These Appotech controllers are found in Picture Frames, they provide a
Index: usb-devel/drivers/usb/storage/usb.c
===================================================================
--- usb-devel.orig/drivers/usb/storage/usb.c
+++ usb-devel/drivers/usb/storage/usb.c
@@ -104,6 +104,8 @@ MODULE_PARM_DESC(quirks, "supplemental l
 
 #define COMPLIANT_DEV	UNUSUAL_DEV
 
+#define UNUSUAL_DEV_NO_AUTO	UNUSUAL_DEV
+
 #define USUAL_DEV(use_protocol, use_transport) \
 { \
 	.useProtocol = use_protocol,	\
Index: usb-devel/drivers/usb/storage/usual-tables.c
===================================================================
--- usb-devel.orig/drivers/usb/storage/usual-tables.c
+++ usb-devel/drivers/usb/storage/usual-tables.c
@@ -23,6 +23,12 @@
 
 #define COMPLIANT_DEV	UNUSUAL_DEV
 
+#define UNUSUAL_DEV_NO_AUTO(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
+		    vendorName, productName, useProtocol, useTransport, \
+		    initFunction, flags) \
+{ USB_DEVICE_VER_NO_AUTO(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax), \
+  .driver_info = (flags) }
+
 #define USUAL_DEV(useProto, useTrans) \
 { USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, useProto, useTrans) }
 
Index: usb-devel/include/linux/mod_devicetable.h
===================================================================
--- usb-devel.orig/include/linux/mod_devicetable.h
+++ usb-devel/include/linux/mod_devicetable.h
@@ -158,6 +158,7 @@ struct usb_device_id {
 #define USB_DEVICE_ID_MATCH_INT_SUBCLASS	0x0100
 #define USB_DEVICE_ID_MATCH_INT_PROTOCOL	0x0200
 #define USB_DEVICE_ID_MATCH_INT_NUMBER		0x0400
+#define USB_DEVICE_ID_MATCH_NO_AUTO		0x0800
 
 #define HID_ANY_ID				(~0)
 #define HID_BUS_ANY				0xffff
Index: usb-devel/include/linux/usb.h
===================================================================
--- usb-devel.orig/include/linux/usb.h
+++ usb-devel/include/linux/usb.h
@@ -925,6 +925,9 @@ static inline int usb_make_path(struct u
 		(USB_DEVICE_ID_MATCH_DEV_LO | USB_DEVICE_ID_MATCH_DEV_HI)
 #define USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION \
 		(USB_DEVICE_ID_MATCH_DEVICE | USB_DEVICE_ID_MATCH_DEV_RANGE)
+#define USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION_NO_AUTO \
+		(USB_DEVICE_ID_MATCH_DEVICE | USB_DEVICE_ID_MATCH_DEV_RANGE | \
+		USB_DEVICE_ID_MATCH_NO_AUTO)
 #define USB_DEVICE_ID_MATCH_DEV_INFO \
 		(USB_DEVICE_ID_MATCH_DEV_CLASS | \
 		USB_DEVICE_ID_MATCH_DEV_SUBCLASS | \
@@ -961,6 +964,23 @@ static inline int usb_make_path(struct u
 	.idVendor = (vend), \
 	.idProduct = (prod), \
 	.bcdDevice_lo = (lo), \
+	.bcdDevice_hi = (hi)
+/**
+ * USB_DEVICE_VER_NO_AUTO - describe a specific usb device with a version range
+ * @vend: the 16 bit USB Vendor ID
+ * @prod: the 16 bit USB Product ID
+ * @lo: the bcdDevice_lo value
+ * @hi: the bcdDevice_hi value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific device, with a version range, but it is meant for manual binding
+ * only, not automatic binding.
+ */
+#define USB_DEVICE_VER_NO_AUTO(vend, prod, lo, hi) \
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION_NO_AUTO, \
+	.idVendor = (vend), \
+	.idProduct = (prod), \
+	.bcdDevice_lo = (lo), \
 	.bcdDevice_hi = (hi)
 
 /**

