Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C17C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXwF+OeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfH0XOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:14:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46443 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0XOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:14:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so347077pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++/KCfeaNC3nr4kWlrphviN9zaclx1/9AX8bnrpiuF0=;
        b=SXwF+OeE84B2m+HTgsLOn0L8LNC4QulF68aaY/IVRE9pm2jwKM0GjvgtuKP8fAbDs9
         P6wz6m78MV0qthTR1Rw1dQGesVRRT2Ul/qVw5ef5g60OMJ18WKVtayb3cJ9QdpUqY1fL
         nsFsRknxWCWEIJUgSF96Sraf1X7Uv4yDsulIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++/KCfeaNC3nr4kWlrphviN9zaclx1/9AX8bnrpiuF0=;
        b=dw4jtweywuMZJSyfjlKGyRchSxYV+i9Ygivi1Mvs1slkBGVl4GUs24CLGaL+yzr+TI
         ygxMLUI4tbsBCLcz87ojRZcpG6ZcIlsw9FkpbqKrsVey2SVXHCb7Qm0qvpPFueyywzmt
         DdoL5EhW4QLRoBCVwfQQF5o7FGML6K/qUCsnqTZUrQm/Y9RcnGMTpCenEgCPkVxGSEno
         TK+LEtewoW3bGFIpTCAmUCqh8UntQzCKqZxIU/Bo3dJKV768aA36hOMSf1b0/WB/6NbZ
         Kho8UT6FxuqlinCu9Kl8ZJ1MfSt0WJbkcVYis7pPdz7eJGeL+RQeeIkt9pCy4Hgkf+8m
         hPZg==
X-Gm-Message-State: APjAAAUKj2Ub7ToINwIzNGJ9hOvFb0wnWdKbyvO/V6EyRVdprr0BimLv
        tOn9A2ysgje30ybwwI3rZDRCwQ==
X-Google-Smtp-Source: APXvYqxdGLw+MOu8Urgu3QgnnlsAuZnZ9juHk9Et2HN9Ka+AdyrVjtV74Rtd0zj+BhdMIpmCa/dBmw==
X-Received: by 2002:a65:690b:: with SMTP id s11mr834922pgq.10.1566947664132;
        Tue, 27 Aug 2019 16:14:24 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:6a:3f83:ada3:6a0f])
        by smtp.gmail.com with ESMTPSA id a5sm238576pjs.31.2019.08.27.16.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 16:14:22 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH] usb: storage: Add ums-cros-aoa driver
Date:   Tue, 27 Aug 2019 16:14:09 -0700
Message-Id: <20190827231409.253037-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new "unusual" USB mass storage device driver. This
driver will be used for a virtual USB storage device presented by an
Android phone running the 'Chrome OS Recovery'* Android app. This app
uses the Android Open Accessory (AOA) API to talk directly to a USB host
attached to the phone.

The AOA protocol requires the host to send a custom vendor command on
EP0 to "switch" the phone into "AOA mode" (making it drop off the bus
and reenumerate with different descriptors). The ums-cros-aoa driver is
just a small stub driver to send these vendor commands. It identifies
the device it should operate on by VID/PID passed in through a module
parameter (e.g. from the bootloader). After the phone is in AOA mode,
the normal USB mass storage stack will recognize it by its special
VID/PID like any other "unusual dev". An initializer function will
further double-check that the device is the device previously operated
on by ums-cros-aoa.

*NOTE: The Android app is still under development and will be released
at a later date. I'm submitting this patch now so that the driver name
and module parameters can be set in stone already, because I have to
bake them into bootloader code that is not field-updatable.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 drivers/usb/storage/Kconfig        |  12 +++
 drivers/usb/storage/Makefile       |   2 +
 drivers/usb/storage/cros-aoa.c     | 129 +++++++++++++++++++++++++++++
 drivers/usb/storage/initializers.c |  34 ++++++++
 drivers/usb/storage/initializers.h |   4 +
 drivers/usb/storage/unusual_devs.h |  18 ++++
 6 files changed, 199 insertions(+)
 create mode 100644 drivers/usb/storage/cros-aoa.c

diff --git a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
index 59aad38b490a6..cc901ee2bb766 100644
--- a/drivers/usb/storage/Kconfig
+++ b/drivers/usb/storage/Kconfig
@@ -184,6 +184,18 @@ config USB_STORAGE_ENE_UB6250
 	  To compile this driver as a module, choose M here: the
 	  module will be called ums-eneub6250.
 
+config USB_STORAGE_CROS_AOA
+	tristate "Support for connecting to Chrome OS Recovery Android app"
+	default n
+	depends on USB_STORAGE
+	help
+	  Say Y here if you want to connect an Android phone running the Chrome
+	  OS Recovery app to this device and mount the image served by that app
+	  as a virtual storage device. Unless you're building for Chrome OS, you
+	  probably want to say N.
+
+	  If this driver is compiled as a module, it will be named ums-cros-aoa.
+
 endif # USB_STORAGE
 
 config USB_UAS
diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
index a67ddcbb4e249..f734741d4658b 100644
--- a/drivers/usb/storage/Makefile
+++ b/drivers/usb/storage/Makefile
@@ -17,6 +17,7 @@ usb-storage-y += usual-tables.o
 usb-storage-$(CONFIG_USB_STORAGE_DEBUG) += debug.o
 
 obj-$(CONFIG_USB_STORAGE_ALAUDA)	+= ums-alauda.o
+obj-$(CONFIG_USB_STORAGE_CROS_AOA)	+= ums-cros-aoa.o
 obj-$(CONFIG_USB_STORAGE_CYPRESS_ATACB) += ums-cypress.o
 obj-$(CONFIG_USB_STORAGE_DATAFAB)	+= ums-datafab.o
 obj-$(CONFIG_USB_STORAGE_ENE_UB6250)	+= ums-eneub6250.o
@@ -31,6 +32,7 @@ obj-$(CONFIG_USB_STORAGE_SDDR55)	+= ums-sddr55.o
 obj-$(CONFIG_USB_STORAGE_USBAT)		+= ums-usbat.o
 
 ums-alauda-y		:= alauda.o
+ums-cros-aoa-y		:= cros-aoa.o
 ums-cypress-y		:= cypress_atacb.o
 ums-datafab-y		:= datafab.o
 ums-eneub6250-y		:= ene_ub6250.o
diff --git a/drivers/usb/storage/cros-aoa.c b/drivers/usb/storage/cros-aoa.c
new file mode 100644
index 0000000000000..269e9193209d9
--- /dev/null
+++ b/drivers/usb/storage/cros-aoa.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2 WITH Linux-syscall-note
+/*
+ * Driver for Chrome OS Recovery via Android Open Accessory
+ *
+ * (c) 2019 Google LLC (Julius Werner <jwerner@chromium.org>)
+ *
+ * This driver connects to an Android device via the Android Open Accessory
+ * protocol to use it as a USB storage back-end. It is used for system recovery
+ * on Chrome OS. The descriptors sent are specific to the Chrome OS Recovery app
+ * for Android. The driver is inert unless activated by boot firmware with an
+ * explicit kernel command line parameter.
+ */
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/usb.h>
+
+#include "initializers.h"
+
+#define DRV_NAME "ums-cros-aoa"
+
+MODULE_DESCRIPTION("Driver for Chrome OS Recovery via Android Open Accessory");
+MODULE_AUTHOR("Julius Werner <jwerner@chromium.org>");
+MODULE_LICENSE("GPL");
+
+#define AOA_GET_PROTOCOL	51
+#define AOA_SET_STRING		52
+#define AOA_START		53
+
+#define AOA_STR_MANUFACTURER	0
+#define AOA_STR_MODEL		1
+#define AOA_STR_DESCRIPTION	2
+#define AOA_STR_VERSION		3
+#define AOA_STR_URI		4
+#define AOA_STR_SERIAL		5
+
+#define CROS_MANUF		"Google"
+#define CROS_MODEL		"Chrome OS Recovery"
+#define CROS_DESC		"Chrome OS device in Recovery Mode"
+#define CROS_VERSION		"1.0"
+#define CROS_URI		"https://google.com/chromeos/recovery_android"
+
+static char *bind;
+module_param(bind, charp, 0);
+
+static struct usb_device_id cros_aoa_ids[] = {
+	{ USB_DEVICE(0, 0) },	/* to be filled out by cros_aoa_init() */
+	{ }
+};
+/* No MODULE_DEVICE_TABLE(). Autoloading doesn't make sense for this module. */
+
+static int set_string(struct usb_device *udev, u16 type, const char *string)
+{
+	return usb_control_msg(udev, usb_sndctrlpipe(udev, 0), AOA_SET_STRING,
+			       USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			       0, type, (char *)string, strlen(string) + 1,
+			       USB_CTRL_SET_TIMEOUT);
+}
+
+static int cros_aoa_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	int rv;
+	u16 aoa_protocol;
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	rv = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), AOA_GET_PROTOCOL,
+			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			     0, 0, &aoa_protocol, sizeof(aoa_protocol),
+			     USB_CTRL_GET_TIMEOUT);
+	if (rv < 0 && rv != -EPROTO)
+		goto fail;
+	if (rv != sizeof(aoa_protocol) || aoa_protocol < 1) {
+		dev_err(&intf->dev, "bound device does not support AOA?\n");
+		rv = -ENODEV;
+		goto fail;
+	}
+
+	if ((rv = set_string(udev, AOA_STR_MANUFACTURER, CROS_MANUF)) < 0 ||
+	    (rv = set_string(udev, AOA_STR_MODEL, CROS_MODEL)) < 0 ||
+	    (rv = set_string(udev, AOA_STR_DESCRIPTION, CROS_DESC)) < 0 ||
+	    (rv = set_string(udev, AOA_STR_VERSION, CROS_VERSION)) < 0 ||
+	    (rv = set_string(udev, AOA_STR_URI, CROS_URI)) < 0)
+		goto fail;
+
+	rv = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), AOA_START,
+			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			     0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+
+	if (!rv) {
+		dev_info(&intf->dev, "switching to AOA mode\n");
+		usb_stor_cros_aoa_bind_busnum = udev->bus->busnum;
+		usb_stor_cros_aoa_bind_route = udev->route;
+		return 0;
+	}
+
+fail:	dev_err(&intf->dev, "probe error %d\n", rv);
+	return rv;
+}
+
+static void cros_aoa_disconnect(struct usb_interface *intf)
+{
+	/* nothing to do -- we expect this to happen right after probe() */
+}
+
+static struct usb_driver cros_aoa_stub_driver = {
+	.name =		DRV_NAME,
+	.probe =	cros_aoa_probe,
+	.disconnect =	cros_aoa_disconnect,
+	.id_table =	cros_aoa_ids,
+};
+
+static int __init cros_aoa_init(void)
+{
+	if (!bind || sscanf(bind, "%hx:%hx", &cros_aoa_ids[0].idVendor,
+					     &cros_aoa_ids[0].idProduct) != 2)
+		return -ENODEV;
+	pr_info(DRV_NAME ": bound to USB device %4x:%4x\n",
+		cros_aoa_ids[0].idVendor, cros_aoa_ids[0].idProduct);
+	return usb_register(&cros_aoa_stub_driver);
+}
+
+static void __exit cros_aoa_exit(void)
+{
+	usb_deregister(&cros_aoa_stub_driver);
+}
+
+module_init(cros_aoa_init);
+module_exit(cros_aoa_exit);
diff --git a/drivers/usb/storage/initializers.c b/drivers/usb/storage/initializers.c
index f8f9ce8dc7102..3056db79cd1d9 100644
--- a/drivers/usb/storage/initializers.c
+++ b/drivers/usb/storage/initializers.c
@@ -92,3 +92,37 @@ int usb_stor_huawei_e220_init(struct us_data *us)
 	usb_stor_dbg(us, "Huawei mode set result is %d\n", result);
 	return 0;
 }
+
+#if defined(CONFIG_USB_STORAGE_CROS_AOA) || \
+		defined(CONFIG_USB_STORAGE_CROS_AOA_MODULE)
+/*
+ * Our VID/PID match grabs any Android device that was switched into Android
+ * Open Accessory mode. We only want to bind to the one that was switched by the
+ * ums-cros-aoa driver. There's no 100% way to identify the same device again
+ * (because it changes all descriptors), but checking that it is on the same bus
+ * with the same topology route should be a pretty good heuristic.
+ */
+int usb_stor_cros_aoa_bind_busnum = -1;
+EXPORT_SYMBOL(usb_stor_cros_aoa_bind_busnum);
+u32 usb_stor_cros_aoa_bind_route;
+EXPORT_SYMBOL(usb_stor_cros_aoa_bind_route);
+
+int usb_stor_cros_aoa_validate(struct us_data *us)
+{
+	if (us->pusb_dev->bus->busnum != usb_stor_cros_aoa_bind_busnum ||
+	    us->pusb_dev->route != usb_stor_cros_aoa_bind_route) {
+		dev_info(&us->pusb_intf->dev,
+			 "ums-cros-aoa ignoring unknown AOA device\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Only interface 0 connects to the AOA app. Android devices that have
+	 * ADB enabled also export an interface 1. We don't want it.
+	 */
+	if (us->pusb_intf->cur_altsetting->desc.bInterfaceNumber != 0)
+		return -ENODEV;
+
+	return 0;
+}
+#endif /* defined(CONFIG_USB_STORAGE_CROS_AOA) || ... */
diff --git a/drivers/usb/storage/initializers.h b/drivers/usb/storage/initializers.h
index 2dbf9c7d97492..35fe9ef3247d6 100644
--- a/drivers/usb/storage/initializers.h
+++ b/drivers/usb/storage/initializers.h
@@ -37,3 +37,7 @@ int usb_stor_ucr61s2b_init(struct us_data *us);
 
 /* This places the HUAWEI E220 devices in multi-port mode */
 int usb_stor_huawei_e220_init(struct us_data *us);
+
+extern int usb_stor_cros_aoa_bind_busnum;
+extern u32 usb_stor_cros_aoa_bind_route;
+int usb_stor_cros_aoa_validate(struct us_data *us);
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index ea0d27a94afe0..45fe9bbc6da18 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2259,6 +2259,24 @@ UNUSUAL_DEV( 0x1e74, 0x4621, 0x0000, 0x0000,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BULK_IGNORE_TAG | US_FL_MAX_SECTORS_64 ),
 
+/*
+ * Using an Android phone as USB storage back-end for Chrome OS recovery. See
+ * usb/storage/cros-aoa.c for details.
+ */
+#if defined(CONFIG_USB_STORAGE_CROS_AOA) || \
+		defined(CONFIG_USB_STORAGE_CROS_AOA_MODULE)
+UNUSUAL_DEV(  0x18d1, 0x2d00, 0x0000, 0xffff,
+		"Google",
+		"Chrome OS Recovery via AOA",
+		USB_SC_SCSI, USB_PR_BULK, usb_stor_cros_aoa_validate,
+		US_FL_SINGLE_LUN | US_FL_CAPACITY_OK),
+UNUSUAL_DEV(  0x18d1, 0x2d01, 0x0000, 0xffff,
+		"Google",
+		"Chrome OS Recovery via AOA (with ADB)",
+		USB_SC_SCSI, USB_PR_BULK, usb_stor_cros_aoa_validate,
+		US_FL_SINGLE_LUN | US_FL_CAPACITY_OK),
+#endif /* defined(CONFIG_USB_STORAGE_CROS_AOA) || ... */
+
 /* Supplied with some Castlewood ORB removable drives */
 UNUSUAL_DEV(  0x2027, 0xa001, 0x0000, 0x9999,
 		"Double-H Technology",
-- 
2.20.1

