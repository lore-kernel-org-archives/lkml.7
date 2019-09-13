Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490AC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3194F206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4dhKWyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403874AbfIMWDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:03:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41096 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389849AbfIMWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:03:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so15946422pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25qzplbXApZnP+DKOlWLX+iTXkqbrEK2FpGiW9vlz0c=;
        b=P4dhKWyP4Ub/MZ6AMjDsPu+4zpjqVjT5+JSJvszkLnyJkhnTrKAvWBbD6wZ8exTXmo
         B+5l22PlldcHjMBnQWB/mDb/xj+p+hpHx91A9h0RsvI9KUVmPgzWrlQEDFnTFWWv3xzb
         RQyZVEjJNoL+QwHQ8/dWtl55tNjy7n4XIuRAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25qzplbXApZnP+DKOlWLX+iTXkqbrEK2FpGiW9vlz0c=;
        b=ndReCjn7hdjKl8VTW9CbGLo4rjcVGkSpc0rUshgT+O04+B6WiGkIq33harjP01tjfw
         YT3LGasvbmuey7SQ2tWKA+vBnJUJuytKnJtUZ+iZcKZR2TfuNt+BUil910XYLCF8Cy0v
         7xN3VRTpwFA72R0Wo9+gq3XpBTpVNKg0mwy61W8jCHYaEc9jAhsNMVVmI0Sh76hRPjr5
         XMPkkOGIgZMII+4f22r43W8xoJiURkf+W2AMU5leG2KcyRvUBA8/FmP2VTzWBpRtRbkC
         LaNk95lBlWS531ZAXYBiew96Uyu9NhGcTgTiNP+XgXEQ8NN+ykCMj/sQ7v3HkZProCDE
         U7PA==
X-Gm-Message-State: APjAAAUDY5ZcwvzdjF1yFEqfl5vaSF2fndsRmTL+D1q91rXJtqG0rAV7
        RY6xlymZ3bMy3HY7Cu8zGSrDIA==
X-Google-Smtp-Source: APXvYqyYA+41djJA2irqj5wpO7M+ULzOQnTc8ElqcWKy1Ruq7000CypPFM4TDB2HUSKSTm1A9MSd3Q==
X-Received: by 2002:a62:780c:: with SMTP id t12mr57332149pfc.211.1568412201427;
        Fri, 13 Sep 2019 15:03:21 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o19sm2524486pjr.23.2019.09.13.15.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:03:20 -0700 (PDT)
From:   Dmitry Torokhov <dtor@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] HID: google: whiskers: more robust tablet mode detection
Date:   Fri, 13 Sep 2019 15:03:15 -0700
Message-Id: <20190913220317.58289-1-dtor@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB interface may get detected before the platform/EC one, so let's
note the state of the base (if we receive event) and use it to correctly
initialize the tablet mode switch state.

Also let's start the HID interface immediately when probing, this will
ensure that we correctly process "base folded" events that may be sent
as we initialize the base. Note that this requires us to add a release()
function where we stop and close the hardware and switch the LED
registration away from devm interface as we need to make sure that we
destroy the LED instance before we stop the hardware.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 71 ++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 84f8c127ebdc..4f64f93ddfcb 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -35,6 +35,7 @@ struct cbas_ec {
 	struct device *dev;	/* The platform device (EC) */
 	struct input_dev *input;
 	bool base_present;
+	bool base_folded;
 	struct notifier_block notifier;
 };
 
@@ -208,7 +209,14 @@ static int __cbas_ec_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	input_report_switch(input, SW_TABLET_MODE, !cbas_ec.base_present);
+	if (!cbas_ec.base_present)
+		cbas_ec.base_folded = false;
+
+	dev_dbg(&pdev->dev, "%s: base: %d, folded: %d\n", __func__,
+		cbas_ec.base_present, cbas_ec.base_folded);
+
+	input_report_switch(input, SW_TABLET_MODE,
+			    !cbas_ec.base_present || cbas_ec.base_folded);
 
 	cbas_ec_set_input(input);
 
@@ -322,10 +330,9 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 static int hammer_register_leds(struct hid_device *hdev)
 {
 	struct hammer_kbd_leds *kbd_backlight;
+	int error;
 
-	kbd_backlight = devm_kzalloc(&hdev->dev,
-				     sizeof(*kbd_backlight),
-				     GFP_KERNEL);
+	kbd_backlight = kzalloc(sizeof(*kbd_backlight), GFP_KERNEL);
 	if (!kbd_backlight)
 		return -ENOMEM;
 
@@ -339,7 +346,26 @@ static int hammer_register_leds(struct hid_device *hdev)
 	/* Set backlight to 0% initially. */
 	hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
 
-	return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
+	error = led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
+	if (error)
+		goto err_free_mem;
+
+	hid_set_drvdata(hdev, kbd_backlight);
+	return 0;
+
+err_free_mem:
+	kfree(kbd_backlight);
+	return error;
+}
+
+static void hammer_unregister_leds(struct hid_device *hdev)
+{
+	struct hammer_kbd_leds *kbd_backlight = hid_get_drvdata(hdev);
+
+	if (kbd_backlight) {
+		led_classdev_unregister(&kbd_backlight->cdev);
+		kfree(kbd_backlight);
+	}
 }
 
 #define HID_UP_GOOGLEVENDOR	0xffd10000
@@ -376,8 +402,9 @@ static int hammer_event(struct hid_device *hid, struct hid_field *field,
 	    usage->hid == WHISKERS_KBD_FOLDED) {
 		spin_lock_irqsave(&cbas_ec_lock, flags);
 
+		cbas_ec.base_folded = value;
 		hid_dbg(hid, "%s: base: %d, folded: %d\n", __func__,
-			cbas_ec.base_present, value);
+			cbas_ec.base_present, cbas_ec.base_folded);
 
 		/*
 		 * We should not get event if base is detached, but in case
@@ -436,6 +463,14 @@ static int hammer_probe(struct hid_device *hdev,
 {
 	int error;
 
+	error = hid_parse(hdev);
+	if (error)
+		return error;
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (error)
+		return error;
+
 	/*
 	 * We always want to poll for, and handle tablet mode events from
 	 * Whiskers, even when nobody has opened the input device. This also
@@ -443,16 +478,12 @@ static int hammer_probe(struct hid_device *hdev,
 	 * the device.
 	 */
 	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
-			hammer_is_keyboard_interface(hdev))
+	    hammer_is_keyboard_interface(hdev)) {
 		hdev->quirks |= HID_QUIRK_ALWAYS_POLL;
-
-	error = hid_parse(hdev);
-	if (error)
-		return error;
-
-	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (error)
-		return error;
+		error = hid_hw_open(hdev);
+		if (error)
+			return error;
+	}
 
 	if (hammer_has_backlight_control(hdev)) {
 		error = hammer_register_leds(hdev);
@@ -465,6 +496,15 @@ static int hammer_probe(struct hid_device *hdev,
 	return 0;
 }
 
+static void hammer_remove(struct hid_device *hdev)
+{
+	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
+			hammer_is_keyboard_interface(hdev))
+		hid_hw_close(hdev);
+
+	hammer_unregister_leds(hdev);
+	hid_hw_stop(hdev);
+}
 
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
@@ -483,6 +523,7 @@ static struct hid_driver hammer_driver = {
 	.name = "hammer",
 	.id_table = hammer_devices,
 	.probe = hammer_probe,
+	.remove = hammer_remove,
 	.input_mapping = hammer_input_mapping,
 	.event = hammer_event,
 };
-- 
2.23.0.237.gc6a4ce50a0-goog

