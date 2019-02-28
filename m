Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36545C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F312720854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfB1N4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:56:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:42346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730385AbfB1N4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:56:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32638ADE1;
        Thu, 28 Feb 2019 13:56:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     oneukum@suse.de, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Date:   Thu, 28 Feb 2019 14:55:55 +0100
Message-Id: <20190228135556.14713-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A whole set of Primax manufactured wireless keyboards won't work out of
the box as they provide wrong HID descriptors. In this case the offense
being defining the "Usage Maximum/Minimum" local items before the "Usage
Page". This will make the parser use the previous "Usage Page" on those
local items, generating a wrong HID report. This is not a parser error
as the spec clearly states that "Usage Page" applies to any item that
follows it (see 6.2.2.7).

In other words, we get this:

15 00          Logical Minimum (0),
26 ff 00       Logical Maximum (255),
19 00          Usage Minimum (00h),
2a ff 00       Usage Maximum (FFh),
05 07          Usage Page (Keyboard),          ; Keyboard/keypad (07h)
75 08          Report Size (8),
95 06          Report Count (6),
81 00          Input,

Yet they meant this:

15 00          Logical Minimum (0),
26 ff 00       Logical Maximum (255),
05 07          Usage Page (Keyboard),          ; Keyboard/keypad (07h)
19 00          Usage Minimum (00h),
2a ff 00       Usage Maximum (FFh),
75 08          Report Size (8),
95 06          Report Count (6),
81 00          Input,

This patch fixes the issue by overwriting the offending report with a
correct one.

This was made thanks to the user's answers provided here, also full HID
descriptors are available there:
https://unix.stackexchange.com/questions/377830/linux-hid-driver-for-primax-wireless-keyboards/

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE: This is an RFC as I'm unable to test my fix. Apart from the
  devices mentioned in the patch there is a whole list of them, yet I
  didn't include them as I was unable to access their HID descriptors.

 drivers/hid/hid-ids.h    |  3 +++
 drivers/hid/hid-primax.c | 30 +++++++++++++++++++++++++++++-
 drivers/hid/hid-quirks.c |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 24f846d67478..b39f9f36d41f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -714,6 +714,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL	0x609b
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
@@ -1225,6 +1226,8 @@
 #define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
+#define USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E63	0x4e63
+#define USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E80	0x4e80
 
 
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c
index 3a1c3c4c50dc..033f6660e8b6 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -2,9 +2,11 @@
  * HID driver for primax and similar keyboards with in-band modifiers
  *
  * Copyright 2011 Google Inc. All Rights Reserved
+ * Copyright 2019 Nicolas Saenz Julienne
  *
- * Author:
+ * Authors:
  *	Terry Lambert <tlambert@google.com>
+ *	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -27,6 +29,9 @@ static int px_raw_event(struct hid_device *hid, struct hid_report *report,
 {
 	int idx = size;
 
+	if (hid->product != USB_DEVICE_ID_PRIMAX_KEYBOARD)
+		return 0;
+
 	switch (report->id) {
 	case 0:		/* keyboard input */
 		/*
@@ -64,8 +69,29 @@ static int px_raw_event(struct hid_device *hid, struct hid_report *report,
 	return 0;
 }
 
+/*
+ * Some Primax manufactured keyboards set "Usage Minimum/Maximum" values before
+ * setting the "Usage Page". This is not supported as per spec 6.2.2.7.
+ */
+static __u8 *px_fixup(struct hid_device *hid, __u8 *rdesc, unsigned int *rsize)
+{
+	__u8 wrong_report[] = { 0x19, 0x00, 0x2a, 0xff, 0x05, 0x07 };
+	__u8 fixed_report[] = { 0x05, 0x07, 0x19, 0x00, 0x2a, 0xff };
+
+	if (*rsize > 57 &&
+	    !memcmp(&rdesc[51], wrong_report, ARRAY_SIZE(wrong_report))) {
+		hid_info(hid, "fixing up Primax report descriptor\n");
+		memcpy(&rdesc[51], fixed_report, ARRAY_SIZE(fixed_report));
+	}
+
+	return rdesc;
+}
+
 static const struct hid_device_id px_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E63) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, px_devices);
@@ -74,8 +100,10 @@ static struct hid_driver px_driver = {
 	.name = "primax",
 	.id_table = px_devices,
 	.raw_event = px_raw_event,
+	.report_fixup = px_fixup,
 };
 module_hid_driver(px_driver);
 
 MODULE_AUTHOR("Terry Lambert <tlambert@google.com>");
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 94088c0ed68a..9fd256fea231 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -563,6 +563,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_PRIMAX)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E63) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL) },
 #endif
 #if IS_ENABLED(CONFIG_HID_PRODIKEYS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
-- 
2.20.1

