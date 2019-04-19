Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC369205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ge6rIrGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfDSS6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:58:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37258 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfDSS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:58:51 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so9581237itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKWEDrnvCdyRWAnFLasiRHuGQzenMHBfJfoegR52b1M=;
        b=Ge6rIrGTEyI5//vCluYLLXYM0BEHOS19zEBgywv4BZxZYxX/OQ7uKA9yn9lRjtnUDS
         Q/4HkGooOrD1jwkLdPah8cam33xajQVheRHc2b9QjXlFNEblj09iAPZNhNOVzv4oGS51
         9HCGCmtSjvZC+OEC0E05MwjKUayT8nUjEZn0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKWEDrnvCdyRWAnFLasiRHuGQzenMHBfJfoegR52b1M=;
        b=UnjsnbCPdeptHtgH+N2DNiyPhHCH9qhG0k+m7ZyFTpvN2ztBVy4NFSWhUOqX5T2Zk/
         M4YyqVm2XkH9issMWZoC04B3lEDLbjhsAIwBOHb+yOBI0uhB9bcuWNjhV+aICpzsYXNJ
         mCupUy5VoyDkj1lbb2LLbifbdK4kLY5c7aE/6QniQHfymKTP/obWH6BvAfegrpZKw9Pl
         +XZu2DGuF9iF+t99l8T0eN1MF0WOoojfRGfu8fvOeG2aWUP/9UNM7Yo0+gTptuiPC50T
         ruTIvHEj8GpXTWDCnIdesqf7B/qiFLQLE/QRrCH6EMEaQFOYPO4NJkWD/PJSBJk8cK+t
         5dow==
X-Gm-Message-State: APjAAAVixVsuiBp5L5E8S4jb2eoM9nEJjiTijun6j6rJlwHUNLD8UPvT
        W9jI8CU63NkJvoMXScD/Gbuh8PdmipMSFQ==
X-Google-Smtp-Source: APXvYqzN6lSIeY2ZE2UqGzI4o49epjvJrVuNaIz8W46J9s6R/Sn31ow/JPlS0cf9iIVnaDKggwUBDw==
X-Received: by 2002:a02:7829:: with SMTP id p41mr1364847jac.120.1555687826775;
        Fri, 19 Apr 2019 08:30:26 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id h133sm2561832itb.34.2019.04.19.08.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 08:30:25 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     groeck@chromium.org, oneukum@suse.com, djkurtz@chromium.org,
        zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4] usb/hcd: Send a uevent signaling that the host controller had died
Date:   Fri, 19 Apr 2019 09:30:22 -0600
Message-Id: <20190419153022.107358-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will send an OFFLINE event to udev with the ERROR=DEAD
environment variable set when the HC dies.

By notifying user space the appropriate policies can be applied.
i.e.,
 * Collect error logs.
 * Notify the user that USB is no longer functional.
 * Perform a graceful reboot.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I wasn't able to find any good examples of other drivers sending a dead
notification.

Use an EVENT= format
https://github.com/torvalds/linux/blob/master/drivers/acpi/dock.c#L302
https://github.com/torvalds/linux/blob/master/drivers/net/wireless/ath/wil6210/interrupt.c#L497

Uses SDEV_MEDIA_CHANGE=
https://github.com/torvalds/linux/blob/master/drivers/scsi/scsi_lib.c#L2318

Uses ERROR=1.
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/7f6d8aec5803aac44192f03dce5637b66cda7abf/drivers/input/touchscreen/atmel_mxt_ts.c#1581
I'm not a fan because it doesn't signal what the error was.


Changes in v4:
- Move hcd_died_work out of CONFIG_PM ifdef
- Make env static, but not const

Changes in v3:
- Added documentation
- Removed use of lock and null check
- Changed event to OFFLINE + ERROR=DEAD

Changes in v2:
- Check that the root hub still exists before sending the uevent.
- Ensure died_work has completed before deallocating.

 Documentation/ABI/testing/usb-uevent | 27 +++++++++++++++++++++++++++
 drivers/usb/core/hcd.c               | 24 ++++++++++++++++++++++++
 include/linux/usb/hcd.h              |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 Documentation/ABI/testing/usb-uevent

diff --git a/Documentation/ABI/testing/usb-uevent b/Documentation/ABI/testing/usb-uevent
new file mode 100644
index 000000000000..d35c3cad892c
--- /dev/null
+++ b/Documentation/ABI/testing/usb-uevent
@@ -0,0 +1,27 @@
+What:		Raise a uevent when a USB Host Controller has died
+Date:		2019-04-17
+KernelVersion:	5.2
+Contact:	linux-usb@vger.kernel.org
+Description:	When the USB Host Controller has entered a state where it is no
+		longer functional a uevent will be raised. The uevent will
+		contain ACTION=offline and ERROR=DEAD.
+
+		Here is an example taken using udevadm monitor -p:
+
+		KERNEL[130.428945] offline  /devices/pci0000:00/0000:00:10.0/usb2 (usb)
+		ACTION=offline
+		BUSNUM=002
+		DEVNAME=/dev/bus/usb/002/001
+		DEVNUM=001
+		DEVPATH=/devices/pci0000:00/0000:00:10.0/usb2
+		DEVTYPE=usb_device
+		DRIVER=usb
+		ERROR=DEAD
+		MAJOR=189
+		MINOR=128
+		PRODUCT=1d6b/2/414
+		SEQNUM=2168
+		SUBSYSTEM=usb
+		TYPE=9/0/1
+
+Users:		chromium-os-dev@chromium.org
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 975d7c1288e3..0c0fd574bab5 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2448,6 +2448,19 @@ EXPORT_SYMBOL_GPL(usb_hcd_irq);
 
 /*-------------------------------------------------------------------------*/
 
+/* Workqueue routine for when the root-hub has died. */
+static void hcd_died_work(struct work_struct *work)
+{
+	struct usb_hcd *hcd = container_of(work, struct usb_hcd, died_work);
+	static char *env[] = {
+		"ERROR=DEAD",
+		NULL
+	};
+
+	/* Notify user space that the host controller has died */
+	kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_OFFLINE, env);
+}
+
 /**
  * usb_hc_died - report abnormal shutdown of a host controller (bus glue)
  * @hcd: pointer to the HCD representing the controller
@@ -2488,6 +2501,13 @@ void usb_hc_died (struct usb_hcd *hcd)
 			usb_kick_hub_wq(hcd->self.root_hub);
 		}
 	}
+
+	/* Handle the case where this function gets called with a shared HCD */
+	if (usb_hcd_is_primary_hcd(hcd))
+		schedule_work(&hcd->died_work);
+	else
+		schedule_work(&hcd->primary_hcd->died_work);
+
 	spin_unlock_irqrestore (&hcd_root_hub_lock, flags);
 	/* Make sure that the other roothub is also deallocated. */
 }
@@ -2555,6 +2575,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
 #endif
 
+	INIT_WORK(&hcd->died_work, hcd_died_work);
+
 	hcd->driver = driver;
 	hcd->speed = driver->flags & HCD_MASK;
 	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
@@ -2908,6 +2930,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 #ifdef CONFIG_PM
 	cancel_work_sync(&hcd->wakeup_work);
 #endif
+	cancel_work_sync(&hcd->died_work);
 	mutex_lock(&usb_bus_idr_lock);
 	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
 	mutex_unlock(&usb_bus_idr_lock);
@@ -2968,6 +2991,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 #ifdef CONFIG_PM
 	cancel_work_sync(&hcd->wakeup_work);
 #endif
+	cancel_work_sync(&hcd->died_work);
 
 	mutex_lock(&usb_bus_idr_lock);
 	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 695931b03684..66a24b13e2ab 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -98,6 +98,7 @@ struct usb_hcd {
 #ifdef CONFIG_PM
 	struct work_struct	wakeup_work;	/* for remote wakeup */
 #endif
+	struct work_struct	died_work;	/* for when the device dies */
 
 	/*
 	 * hardware info/state
-- 
2.21.0.392.gf8f6787159e-goog

