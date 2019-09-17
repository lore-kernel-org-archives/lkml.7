Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7839C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787B1214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekxsLZG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfIQV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:27:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35607 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfIQV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:27:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so2915230pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVgucFJAelOsG1cYk0ZwI8jbcxq/aZbc1aGImvYo+Kg=;
        b=ekxsLZG9e1UCzUHwmV8a6YjZRvP5DOm0nftM9jZZmh4xj5OkNxkVBrFGwJzKcu7CxN
         P0nD0U3WK/nMAFv/E8iEAhjkheSIYgNhzy1RSg1O2nIuuqupIc0H3XqjHMxz4Lpua/9v
         A82S2jar6XjX8TuY5T/Kxv4fICXLfkiJNMxK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVgucFJAelOsG1cYk0ZwI8jbcxq/aZbc1aGImvYo+Kg=;
        b=LB/Os9aV6aq4273NcR+XyqOPaL4cv56RbH1i3xpulHiD7FFwYVwXG0ptoGm7IypJO0
         stDcHVXZpXDOOf9KBkelvgAdmL2+aUla5W2TppwaqFUwilOq8WCARUt1dmcJu2Ybh2Mw
         AjHdIpJy/DatNB7lqqZ2fCAwHzUOY6SPnbACMZM11ZrITfdNS2z+xL4AzLl4IBnzgx4g
         nL7Vk1jY5Y5NsVb//hZq0VHQMk0zuYEt7MPXkQU/rQbPPg4oYL2xjKUSo07+sg9wE1hB
         lMKCXuDSPygOHft76nwX2opldG4FRAL2B/Zrw12QGctdX7detnSwZGPyihTWiJRHF+eG
         0jlg==
X-Gm-Message-State: APjAAAW8fGOcoY66bCSDt74S/ftSxaH3hQ6tuVcKULyj4CrWOUJ38Wxe
        kEq1BzGh1jf3FhsF6dEkZuIR3A==
X-Google-Smtp-Source: APXvYqwh1/Gdgxjw0OQCqx4pGO9085aKBpGIl4gHgu2UFsAgMTKzg68u/ygjs4CoGtWcRweRvxvFjw==
X-Received: by 2002:a63:fc60:: with SMTP id r32mr905195pgk.160.1568755658223;
        Tue, 17 Sep 2019 14:27:38 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id l7sm8489803pga.92.2019.09.17.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:27:37 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Reset realtek devices on user suspend
Date:   Tue, 17 Sep 2019 14:27:02 -0700
Message-Id: <20190917212702.35747-3-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
In-Reply-To: <20190917212702.35747-1-abhishekpandit@chromium.org>
References: <20190917212702.35747-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset realtek devices on user suspend if not configured as a wakeup source.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btusb.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9c35ebb30f8..ce3a10642f4e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -493,6 +493,8 @@ struct btusb_data {
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 	unsigned cmd_timeout_cnt;
+
+	bool reset_on_suspend; /* reset on suspend if not a wakeup source */
 };
 
 
@@ -3818,6 +3820,8 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		/* We'll explicitly reset the device around user suspend too. */
+		data->reset_on_suspend = true;
 	}
 #endif
 
@@ -4007,6 +4011,22 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
+static int btusb_suspend_noirq(struct usb_interface *intf, pm_message_t message)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+
+	BT_DBG("suspend_noirq %p", intf);
+
+	/* Only reset if not configured for wakeup */
+	if (!device_may_wakeup(&data->udev->dev) &&
+	    data->reset_on_suspend && data->reset_gpio) {
+		BT_DBG("resetting in suspend_noirq\n");
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+	}
+
+	return 0;
+}
+
 static void play_deferred(struct btusb_data *data)
 {
 	struct urb *urb;
@@ -4048,6 +4068,11 @@ static int btusb_resume(struct usb_interface *intf)
 	if (--data->suspend_count)
 		return 0;
 
+	if (data->reset_on_suspend && data->reset_gpio) {
+		BT_DBG("restoring reset in resume\n");
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+	}
+
 	/* Disable only if not already disabled (keep it balanced) */
 	if (test_and_clear_bit(BTUSB_OOB_WAKE_ENABLED, &data->flags)) {
 		disable_irq(data->oob_wake_irq);
@@ -4107,6 +4132,7 @@ static struct usb_driver btusb_driver = {
 	.disconnect	= btusb_disconnect,
 #ifdef CONFIG_PM
 	.suspend	= btusb_suspend,
+	.suspend_noirq	= btusb_suspend_noirq,
 	.resume		= btusb_resume,
 #endif
 	.id_table	= btusb_table,
-- 
2.23.0.237.gc6a4ce50a0-goog

