Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE04C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6262082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAgpfG49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDJUfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:35:31 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36050 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDJUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:35:30 -0400
Received: by mail-it1-f194.google.com with SMTP id y10so5773261itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPP25IQtcJKI14NzG1OSPUQjt9b3p9zmCruJRkPzTcE=;
        b=JAgpfG49JYbu2h5eLw/q3MLmpo0V/NNOmxFX2L2Lq7kdzT3TD1NEYkv7cFKugeSGQ1
         tEl5Bl+0Zl/faad/4lys0pCg+RQDO+EQ0maR/qFcgjNPs2Iheiuez2tm7I82N+SRU7jF
         w5YVV/ljZQkm4kK/XMxKeVw/d0WeTGEiuQgco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPP25IQtcJKI14NzG1OSPUQjt9b3p9zmCruJRkPzTcE=;
        b=kHBrGpeFMp2wS1GSkeo0PvsMwmMjY0LqBIjcutjltBWzi2Fht3SqFlGFdxrjCrYEQJ
         y5j60bsFzPJrh9kcOnRpMsEkqKpNPazYE3b0gZFBVWId6F6Q45JrmZhq4pqf7Xikve1G
         7SVk3Dk07Enhf/ICCOOtMSZOZYm83CG5dA0ozAfsHtSk3PkS9yEnc+7rVuQSkUaIyGhc
         bpw7IcMWb/E5mD4tnqhqs9AWweao5RXCzrAK3uABpmoc9GPJVPa0XsLpOD45wTliK22f
         I6zcu+mZgLk4f/40fRPie344ifb8tl2VDz3Aw7y6wuyf96r6vEIcBVybSjB+pOoYXLJ2
         TLLw==
X-Gm-Message-State: APjAAAXY7M20LQy8CLKA3D9wkuI7UKfyGAqPf3GRNqn9ECKK9LMXBCzZ
        ey8f0VZMwlCdt7RUW5kQnpz7SA==
X-Google-Smtp-Source: APXvYqyD86Ui3k5afUwT7tXMcbl1qlnhxyGWVVnGw89eMj4BmyHZiOXiBYstrMZd6X2pDJ3vDriaAQ==
X-Received: by 2002:a24:e346:: with SMTP id d67mr4983131ith.42.1554928530152;
        Wed, 10 Apr 2019 13:35:30 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id u14sm13531130iom.87.2019.04.10.13.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:35:29 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     groeck@chromium.org, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
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
Subject: [PATCH] usb/hcd: Send a uevent signaling that the host controller has died
Date:   Wed, 10 Apr 2019 14:35:20 -0600
Message-Id: <20190410203520.248158-1-rrangel@chromium.org>
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
that seems to be used for hot-removal.

By notifying user space the appropriate policies can be applied.
e.g.,
 * Collect error logs.
 * Notify the user that USB is no longer functional.
 * Perform a graceful reboot.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/usb/core/hcd.c  | 25 +++++++++++++++++++++++++
 include/linux/usb/hcd.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 975d7c1288e3..b38ad9ce068b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2343,6 +2343,22 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
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
+	/* Notify user space that the host controller has died */
+	kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_CHANGE,
+			   (char *[]){ "DEAD=1", NULL });
+}
+
 /* Workqueue routine for root-hub remote wakeup */
 static void hcd_resume_work(struct work_struct *work)
 {
@@ -2488,6 +2504,13 @@ void usb_hc_died (struct usb_hcd *hcd)
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
@@ -2555,6 +2578,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
 #endif
 
+	INIT_WORK(&hcd->died_work, hcd_died_work);
+
 	hcd->driver = driver;
 	hcd->speed = driver->flags & HCD_MASK;
 	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
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

