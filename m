Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C51C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D923206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPfI7ONs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfDQTDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:03:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43418 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:03:33 -0400
Received: by mail-io1-f65.google.com with SMTP id x3so21477654iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u37q2PdjPmsH+zxnPWwd7CvdWLV3S+cZA+PAcW+7ldE=;
        b=SPfI7ONsVKaNi89TQRHsgWcCCFRAUJciaromL3MbBrBzcqnmMwnrwz+jKkmbmGXlVl
         GbFrEDIHbTuTK+Z559uMzJiTxoTspuugUs9pJWHbNr5jKf18RTDy+kQLsmrf0++tsxag
         TadMvyWgMLa/y2aNGrUXEhOEgXIjkc2k04X6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u37q2PdjPmsH+zxnPWwd7CvdWLV3S+cZA+PAcW+7ldE=;
        b=TIBl2i6B+PRPf/9Da9s7mNVybbA1jC4jvXW7P0wQE98V3VmxXwivsG+XMBQI/MX9Mu
         9UT6u7FIPacU9emmyAd2PWpm27l/QQLtdqlu33zYKznpWYzLlsTPcJ4TQ0HCHPTL2FVG
         heoqNy0fgiV2bnvd2b/Zzv9ZKewgMo5Kxn2FV+V4y9v3xcTfNqjiGCVaFd7u2jnEpg1W
         PXUhXNWjCLPsxv07rfnUuisOKs1fJhqOqIsfUenhoic+2Jcw/VHEv/3JAEMgGWkziXw4
         VDGYB11nlti+eNYt3XHBfuJaYgf0ITc9GECQ7gzJBrQlJR3qzXBF1OyqO98JOYZh55e6
         IczA==
X-Gm-Message-State: APjAAAUXRn1oNWCw5E0sAiztsYXs0qzgMfzLGo5RQPPzbJv1Atf0+byu
        2rBS4G4HwiRJIoeg1ooOXyEXXg==
X-Google-Smtp-Source: APXvYqz18F6zPQqwl5lXk4ymPKRgbEtgXzEdLOSFmCta2sA/hyBafnpHLB03uErGPmArkXTQGPylsA==
X-Received: by 2002:a6b:5118:: with SMTP id f24mr23994987iob.62.1555527812351;
        Wed, 17 Apr 2019 12:03:32 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id y17sm2632087ita.2.2019.04.17.12.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 12:03:31 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     groeck@chromium.org, oneukum@suse.com, djkurtz@chromium.org,
        zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v3] usb/hcd: Send a uevent signaling that the host controller had died
Date:   Wed, 17 Apr 2019 13:03:16 -0600
Message-Id: <20190417190316.10032-1-rrangel@chromium.org>
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


Changes in v3:
- Added documentation
- Removed use of lock and null check
- Changed event to OFFLINE + ERROR=DEAD

Changes in v2:
- Check that the root hub still exists before sending the uevent.
- Ensure died_work has completed before deallocating.

 Documentation/ABI/testing/usb-uevent | 27 +++++++++++++++++++++++++++
 drivers/usb/core/hcd.c               | 25 +++++++++++++++++++++++++
 include/linux/usb/hcd.h              |  1 +
 3 files changed, 53 insertions(+)
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
index 975d7c1288e3..145b058705fe 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2343,6 +2343,20 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	return status;
 }
 
+
+/* Workqueue routine for when the root-hub has died. */
+static void hcd_died_work(struct work_struct *work)
+{
+	struct usb_hcd *hcd = container_of(work, struct usb_hcd, died_work);
+	char *env[] = {
+		"ERROR=DEAD",
+		NULL
+	};
+
+	/* Notify user space that the host controller has died */
+	kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_OFFLINE, env);
+}
+
 /* Workqueue routine for root-hub remote wakeup */
 static void hcd_resume_work(struct work_struct *work)
 {
@@ -2488,6 +2502,13 @@ void usb_hc_died (struct usb_hcd *hcd)
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
@@ -2555,6 +2576,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
 #endif
 
+	INIT_WORK(&hcd->died_work, hcd_died_work);
+
 	hcd->driver = driver;
 	hcd->speed = driver->flags & HCD_MASK;
 	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
@@ -2908,6 +2931,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 #ifdef CONFIG_PM
 	cancel_work_sync(&hcd->wakeup_work);
 #endif
+	cancel_work_sync(&hcd->died_work);
 	mutex_lock(&usb_bus_idr_lock);
 	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
 	mutex_unlock(&usb_bus_idr_lock);
@@ -2968,6 +2992,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
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

