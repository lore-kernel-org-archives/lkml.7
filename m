Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1810120823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByuPGERL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfCYM53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:57:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35206 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfCYM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:57:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id t13so7692825lji.2;
        Mon, 25 Mar 2019 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xok0NfJMA8aJrH6mxhd/1mvwhOz8ew9kIav2miTSjEc=;
        b=ByuPGERL5nDHzTDfwnr4Bs/hjGcDgmNaYDpkO5bwfnQ2Ko9mYCuW8wJVCHxaxjAEBA
         A1fGv1EhXK/9Uwd/hSunTVvNEsiGcWN7S7cVfKJMKdjDkRHg43I0v17nw2n0Y5fQPyF8
         DDnUcB4upJeH9s5AMzIdDcrUH+bYnVn/1gPnfPSJW0Cbn66cq8S4RYDPuO2FvTOOMwiC
         8lsJ6ctZEidUmXWRUzDqIf7PAEOD7xJHENVYudI637dU0P7cJNRZxrVRUlAzzulB7ytw
         Wvtb8BswAGsvCMJmn+RJ7KySWRS8xt7eEEUaMfb9IqlAHroxb4IhGft2BQ7nX6swLaGz
         B08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xok0NfJMA8aJrH6mxhd/1mvwhOz8ew9kIav2miTSjEc=;
        b=JEPQxyyejYU1SOyH1qZTJ3Jy6bKu4DPBJy5ZkPbSBIDCqxLNUo8UiQtK09p2RTiCxm
         zBh7e0hFTiP7omRQ0eErKBkYEmjLEmbbw3TmmybZTEPoPzzTITFlpoSpodnTkssXAALR
         H5ojJVC/oQk4y5Xn1dIa/YU2fzJm1SsU9Rir7IAiwpBv2KIEmegRl4YXLCvyqIfFhS5s
         /TMuDlEI+ypbZHawHGDLI2NQn3uvfZtrzAhWWxSCcfQ7LwqhXc1o4lfuokswADYnd9op
         Hrd6GrPx4lBzdapY+jgRJzcEU4PoS7/kvUe1iWq2n3TbYqW5h/hei8P6olv2d7XRjvdo
         LOwA==
X-Gm-Message-State: APjAAAVVOt49y+f0S1xI9HDbxnCMXRLpTkudQ07lFXL8BaWEE+tIY441
        bwrkPNEw4zU89SU9BTgZ730=
X-Google-Smtp-Source: APXvYqzdP93JTtWqhcCPczkQKmriTuPDaZKPX9+r3Mo6KfoV9eLMD2tyXDcnxukrK2RRLyDWIBOzIA==
X-Received: by 2002:a2e:9619:: with SMTP id v25mr4726652ljh.145.1553518644194;
        Mon, 25 Mar 2019 05:57:24 -0700 (PDT)
Received: from parrot.lan ([77.47.204.16])
        by smtp.gmail.com with ESMTPSA id q67sm440059lje.41.2019.03.25.05.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 05:57:23 -0700 (PDT)
From:   Vladislav Dalechyn <vlad.dalechin@gmail.com>
X-Google-Original-From: Vladislav Dalechyn <vlad.dalechin@gmail.com, hotwater438@tutanota.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        kai.heng.feng@canonical.com, swboyd@chromium.org,
        bigeasy@linutronix.de, dtor@chromium.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hotwater438@tutanota.com
Cc:     Hans De Goede <hdegoede@redhat.com>
Subject: [PATCH] ELAN touchpad i2c_hid bugs fix
Date:   Mon, 25 Mar 2019 14:57:04 +0200
Message-Id: <20190325125704.6585-1-hotwater438@tutanota.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladislav Dalechyn <hotwater438@tutanota.com>

Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
caused by an error setting the correct IRQ_TRIGGER flag:
- i2c_hid incoplete error flood in journalctl;
- Five finger tap kill's module so you have to restart it;
- Two finger scoll is working incorrect and sometimes even when you
raised one of two finger still thinks that you are scrolling.

Fix all of these with a new quirk that corrects the trigger flag
announced by the ACPI tables. (edge-falling).

Reason behind moving i2c_hid_init_irq section described below:
i2c_hid_init_irq now checks for a quirk, so we must setup the quirks
before we init the irq, and we cannot setup the quirk earlier, so we must
init the irq later.

Co-developed-by: Hans De Goede <hdegoede@redhat.com>
Signed-off-by: Vladislav Dalechyn <hotwater438@tutanota.com>
---
 drivers/hid/hid-ids.h              |  1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b6d93f4ad037..660b4e0e912e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -389,6 +389,7 @@
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
+#define I2C_DEVICE_ID_ELAN_TOUCHPAD 0x303e
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fed08d3..9b417914411f 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -51,6 +51,7 @@
 #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
 #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
 #define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
+#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING	BIT(5)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ELAN_TOUCHPAD,
+		I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
-		 I2C_HID_QUIRK_BOGUS_IRQ },
+		I2C_HID_QUIRK_BOGUS_IRQ },
 	{ 0, 0 }
 };
 
@@ -854,6 +857,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 
 	if (!irq_get_trigger_type(client->irq))
 		irqflags = IRQF_TRIGGER_LOW;
+	if (ihid->quirks & I2C_HID_QUIRK_FORCE_TRIGGER_FALLING)
+		irqflags = IRQF_TRIGGER_FALLING;
 
 	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
 				   irqflags | IRQF_ONESHOT, client->name, ihid);
@@ -1123,14 +1128,10 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto err_pm;
 
-	ret = i2c_hid_init_irq(client);
-	if (ret < 0)
-		goto err_pm;
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-		goto err_irq;
+		goto err_pm;
 	}
 
 	ihid->hid = hid;
@@ -1149,11 +1150,15 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
 
+	ret = i2c_hid_init_irq(client);
+	if (ret < 0)
+		goto err_mem_free;
+
 	ret = hid_add_device(hid);
 	if (ret) {
 		if (ret != -ENODEV)
 			hid_err(client, "can't add hid device: %d\n", ret);
-		goto err_mem_free;
+		goto err_irq;
 	}
 
 	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
@@ -1161,12 +1166,12 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	return 0;
 
+err_irq:
+	free_irq(client->irq, ihid);
+
 err_mem_free:
 	hid_destroy_device(hid);
 
-err_irq:
-	free_irq(client->irq, ihid);
-
 err_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
-- 
2.20.1

