Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DE420663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mH9Z66Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDKSwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:52:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35925 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:52:37 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so6283464iop.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9LCv6hvKvVV7ugfmYyfukiH7BzQUtUryPXyxFdbIQ4=;
        b=mH9Z66DiPJdu4zjz7xq5WPrJBbeNAxbp7LYDENdORPWcjHBZbkWHfiUtffqPDob7I3
         4ztFOCPXbAf0W6WKRb3cZ5DX6h+TXLIcHwuXDUs+Jn1+mbKQfKfPZbeKfLQulaXHTlp4
         CE8YsMCqZdjH++Ugf5oXRQYhnXthmrLgOAIZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9LCv6hvKvVV7ugfmYyfukiH7BzQUtUryPXyxFdbIQ4=;
        b=TxHQLbYv6GkRHPDlkm9eYZVYWlERemgtPM4fdRAgYDiNuChkS2KkZapmOHT/botiEM
         Ize9n2wFnOEs3p7Zprrww78ik7pxqq/CN8pxix3ElhG58hxZQrcE/SrAEt8RJSf/ZPAs
         EHx+c8HwGJ1i/JBQboSbrSjYsv3CMLsTWyucg4J9yBoQmJNTNhxgWtfn6/YNWeEc+TbV
         kgNwST5+EiettyJj7jyN/vcX0wzFmPLytGldFpPtsndUFqNApnOTah7ASo+rZqvsHelj
         O5SF5UZmxFA2giS7JU+mZHzsAREvhp6s1IkwLwLAFMOhWVmUvSWUiICXZ2yMYXyj/zVQ
         CsdQ==
X-Gm-Message-State: APjAAAVz15hLdah5FumZ49jlkWZdaL1JGp/PJLLGQDsgLNSjabuWOntp
        Fd0wgHjjcZ22KyL8XFuTnTaOaw==
X-Google-Smtp-Source: APXvYqxhH06QztR2QBgwqXdZWbTNOWPDU2EvkxHNM60n/3gsKdJw2G0+oFzF/Ipceb04bvYLtsH9IA==
X-Received: by 2002:a6b:c909:: with SMTP id z9mr32966003iof.244.1555008756639;
        Thu, 11 Apr 2019 11:52:36 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t78sm2891373itb.39.2019.04.11.11.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:52:35 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     groeck@chromium.org, oneukum@suse.com, djkurtz@chromium.org,
        zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@chromium.org>,
        Suwan Kim <suwan.kim027@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v2] usb/hcd: Send a uevent signaling that the host controller has died
Date:   Thu, 11 Apr 2019 12:52:11 -0600
Message-Id: <20190411185211.235940-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will send a CHANGE event to udev with the DEAD environment
variable set when the HC dies. I chose this instead of any of the other
udev events because it's representing a state change in the host
controller. The only other event that might have fit was OFFLINE, but
that seems to be used for hot-removal and it implies the device could
come ONLINE again.

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

We could change the DEAD=1 event to maybe ERROR=1?

Also where would be a good place to document this?

Also thanks for the review. This is my first kernel patch so forgive me
if I get the workflow wrong.

Changes in v2:
- Check that the root hub still exists before sending the uevent.
- Ensure died_work has completed before deallocating.

 drivers/usb/core/hcd.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/usb/hcd.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 975d7c1288e3..7835f1a3647d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2343,6 +2343,27 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	return status;
 }
 
+
+/**
+ * hcd_died_work - Workqueue routine for root-hub has died.
+ * @hcd: primary host controller for this root hub.
+ *
+ * Do not call with the shared_hcd.
+ * */
+static void hcd_died_work(struct work_struct *work)
+{
+	struct usb_hcd *hcd = container_of(work, struct usb_hcd, died_work);
+
+	mutex_lock(&usb_bus_idr_lock);
+
+	if (hcd->self.root_hub)
+		/* Notify user space that the host controller has died */
+		kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_CHANGE,
+				   (char *[]){ "DEAD=1", NULL });
+
+	mutex_unlock(&usb_bus_idr_lock);
+}
+
 /* Workqueue routine for root-hub remote wakeup */
 static void hcd_resume_work(struct work_struct *work)
 {
@@ -2488,6 +2509,13 @@ void usb_hc_died (struct usb_hcd *hcd)
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
@@ -2555,6 +2583,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
 #endif
 
+	INIT_WORK(&hcd->died_work, hcd_died_work);
+
 	hcd->driver = driver;
 	hcd->speed = driver->flags & HCD_MASK;
 	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
@@ -2908,6 +2938,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 #ifdef CONFIG_PM
 	cancel_work_sync(&hcd->wakeup_work);
 #endif
+	cancel_work_sync(&hcd->died_work);
 	mutex_lock(&usb_bus_idr_lock);
 	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
 	mutex_unlock(&usb_bus_idr_lock);
@@ -2968,6 +2999,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 #ifdef CONFIG_PM
 	cancel_work_sync(&hcd->wakeup_work);
 #endif
+	cancel_work_sync(&hcd->died_work);
 
 	mutex_lock(&usb_bus_idr_lock);
 	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 695931b03684..ae51d5bd1dfc 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -98,6 +98,7 @@ struct usb_hcd {
 #ifdef CONFIG_PM
 	struct work_struct	wakeup_work;	/* for remote wakeup */
 #endif
+	struct work_struct	died_work;	/* for dying */
 
 	/*
 	 * hardware info/state
-- 
2.21.0.392.gf8f6787159e-goog

