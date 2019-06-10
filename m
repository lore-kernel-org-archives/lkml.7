Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8EBC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B11920859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+8DWMq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbfFJWhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:37:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44255 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390073AbfFJWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:37:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so6098143pfe.11;
        Mon, 10 Jun 2019 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q8b2TKU6JOAJlj9dzQ91v3D4QaEKDBsjJpwMvzaCt2U=;
        b=R+8DWMq4UluXl/AGTjShDwuS1OZP5R2Hp/hgySjl4KWPHXCG20d7K+w0TfhIqLVmx2
         JJSg0tm7me4YzjGyU3OyABU3sF6+RFsNN2V2p2CR37ZlhHN7Z2kzpGsLUr/cc/FuQAS6
         DZx+U3sMe4qiPTycpKOz8Olm/m3Kf+nlCNrLU3Vma9blPPxdcj6WI0ZZLoLSKscdHZGI
         EdbNHqk3/l+IR0AdJ/YCTpu43yobSSG3VRqfvtXUrtXj+9EmXNh5sZNiqqTbO8xod0cc
         9Fb8BwWvg5mUxrtk7rjOKgPWj7FT/yoYI8V5u6SvGemhQmJ2cIZnNEtkrpGBaa/zCo5P
         Q7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q8b2TKU6JOAJlj9dzQ91v3D4QaEKDBsjJpwMvzaCt2U=;
        b=gxi2Jb2Y/QvORr9ZHK5hYT7BrGZb7XA1C6J1MDI/5X28FxH3LciLbfoNaI2tydaGs+
         fJEYrM/mV/7XIBm3zjWAV8HHk6ttlySu5MtQslUHdgr+9B4VLnLSjVrFxM6hZ+cPsqdc
         Wtu9cZSQ7xk9rnh7Y4e89yCM1SnSFjDQLMLakyHc4TfA02hYcoq8aMz370FdbtnqH0A1
         xv4O51dBpI+mnR4YScx2+lc1hj3FKOOCkXED7c4Jxp6DySefFoeeM0bD7PpVpxuaYkBN
         S/Cwk/Umgv51yHS8KLTSpQU2XbQZbrIa6wbS/d+0kNkIKFybarVpshIdClul2kOdakR7
         ziGA==
X-Gm-Message-State: APjAAAUGayG2nqxaZ91uzf9Pl0UWy6L0uzqbW1qb72YWQWZ5k941eXCv
        rdRHglSrq2hW3v/kg3+AVgk=
X-Google-Smtp-Source: APXvYqwd8sGYxy89XzGWUIQvVTvKCqg+kl6oGItr0yMFIo7CpSE1iaXNvQGc/dpHKLVKDrZXk8JXJA==
X-Received: by 2002:aa7:8ecb:: with SMTP id b11mr37159852pfr.220.1560206220888;
        Mon, 10 Jun 2019 15:37:00 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g17sm14465463pfb.56.2019.06.10.15.36.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 15:37:00 -0700 (PDT)
Date:   Mon, 10 Jun 2019 15:36:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     bleung@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, libusb-devel@lists.sourceforge.net
Subject: [PATCH] USB: add usbfs ioctl to retrieve the connection parameters
Message-ID: <20190610223658.GA162167@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently usfbs gained availability to retrieve device speed, but there
is sill no way to determine the bus number or list of ports the device
is connected to when using usbfs. While this information can be obtained
from sysfs, not all environments allow sysfs access. In a jailed
environment a program might be simply given an opened file descriptor to
usbfs device, and it is really important that all data can be gathered
from said file descriptor.

This patch introduces a new ioctl, USBDEVFS_CONNINFO_EX, which return
extended connection information for the device, including the bus
number, address, port list and speed. The API allows kernel to extend
amount of data returned by the ioctl and userspace has an option of
adjusting the amount of data it is willing to consume. A new capability,
USBDEVFS_CAP_CONNINFO_EX, is introduced to help userspace in determining
whether the kernel supports this new ioctl.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/core/devio.c          | 42 ++++++++++++++++++++++++++++++-
 include/uapi/linux/usbdevice_fs.h | 26 +++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index fa783531ee88..fb6a074e4f1d 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1308,6 +1308,39 @@ static int proc_connectinfo(struct usb_dev_state *ps, void __user *arg)
 	return 0;
 }
 
+static int proc_conninfo_ex(struct usb_dev_state *ps,
+			    void __user *arg, size_t size)
+{
+	struct usbdevfs_conninfo_ex ci;
+	struct usb_device *udev = ps->dev;
+
+	if (size < sizeof(ci.size))
+		return -EINVAL;
+
+	memset(&ci, 0, sizeof(ci));
+	ci.size = sizeof(ci);
+	ci.busnum = udev->bus->busnum;
+	ci.devnum = udev->devnum;
+	ci.speed = udev->speed;
+
+	while (udev && udev->portnum != 0) {
+		if (++ci.num_ports <= ARRAY_SIZE(ci.ports))
+			ci.ports[ARRAY_SIZE(ci.ports) - ci.num_ports] =
+					udev->portnum;
+		udev = udev->parent;
+	}
+
+	if (ci.num_ports < ARRAY_SIZE(ci.ports))
+		memmove(&ci.ports[0],
+			&ci.ports[ARRAY_SIZE(ci.ports) - ci.num_ports],
+			ci.num_ports);
+
+	if (copy_to_user(arg, &ci, min(sizeof(ci), size)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int proc_resetdevice(struct usb_dev_state *ps)
 {
 	struct usb_host_config *actconfig = ps->dev->actconfig;
@@ -2252,7 +2285,7 @@ static int proc_get_capabilities(struct usb_dev_state *ps, void __user *arg)
 
 	caps = USBDEVFS_CAP_ZERO_PACKET | USBDEVFS_CAP_NO_PACKET_SIZE_LIM |
 			USBDEVFS_CAP_REAP_AFTER_DISCONNECT | USBDEVFS_CAP_MMAP |
-			USBDEVFS_CAP_DROP_PRIVILEGES;
+			USBDEVFS_CAP_DROP_PRIVILEGES | USBDEVFS_CAP_CONNINFO_EX;
 	if (!ps->dev->bus->no_stop_on_short)
 		caps |= USBDEVFS_CAP_BULK_CONTINUATION;
 	if (ps->dev->bus->sg_tablesize)
@@ -2551,6 +2584,13 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		break;
 	}
 
+	/* Handle variable-length commands */
+	switch (cmd & ~IOCSIZE_MASK) {
+	case USBDEVFS_CONNINFO_EX(0):
+		ret = proc_conninfo_ex(ps, p, _IOC_SIZE(cmd));
+		break;
+	}
+
  done:
 	usb_unlock_device(dev);
 	if (ret >= 0)
diff --git a/include/uapi/linux/usbdevice_fs.h b/include/uapi/linux/usbdevice_fs.h
index 964e87217be4..393a2de914e8 100644
--- a/include/uapi/linux/usbdevice_fs.h
+++ b/include/uapi/linux/usbdevice_fs.h
@@ -76,6 +76,26 @@ struct usbdevfs_connectinfo {
 	unsigned char slow;
 };
 
+struct usbdevfs_conninfo_ex {
+	__u32 size;		/* Size of the structure from the kernel's */
+				/* point of view. Can be used by userspace */
+				/* to determine how much data can be       */
+				/* used/trusted.                           */
+	__u32 busnum;           /* USB bus number, as enumerated by the    */
+				/* kernel, the device is connected to.     */
+	__u32 devnum;           /* Device address on the bus.              */
+	__u32 speed;		/* USB_SPEED_* constants from ch9.h        */
+	u8 num_ports;		/* Number of ports the device is connected */
+				/* to on the way to the root hub. It may   */
+				/* be bigger than size of 'ports' array so */
+				/* userspace can detect overflows.         */
+	u8 ports[7];		/* List of ports on the way from the root  */
+				/* hub to the device. Current limit in     */
+				/* USB specification is 7 tiers (root hub, */
+				/* 5 intermediate hubs, device), which     */
+				/* gives at most 6 port entries.           */
+};
+
 #define USBDEVFS_URB_SHORT_NOT_OK	0x01
 #define USBDEVFS_URB_ISO_ASAP		0x02
 #define USBDEVFS_URB_BULK_CONTINUATION	0x04
@@ -137,6 +157,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_REAP_AFTER_DISCONNECT	0x10
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
+#define USBDEVFS_CAP_CONNINFO_EX		0x80
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -197,5 +218,10 @@ struct usbdevfs_streams {
 #define USBDEVFS_FREE_STREAMS      _IOR('U', 29, struct usbdevfs_streams)
 #define USBDEVFS_DROP_PRIVILEGES   _IOW('U', 30, __u32)
 #define USBDEVFS_GET_SPEED         _IO('U', 31)
+/*
+ * Returns struct usbdevfs_conninfo_ex; length is variable to allow
+ * extending size of the data returned.
+ */
+#define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog


-- 
Dmitry
