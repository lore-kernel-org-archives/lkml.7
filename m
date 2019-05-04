Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA5C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512A9205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEDRW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 13:22:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39759 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfEDRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 13:22:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hMyMg-0000d9-RZ; Sat, 04 May 2019 17:22:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: uclogic: fix dereferences of hdev before null check on hdev
Date:   Sat,  4 May 2019 18:22:22 +0100
Message-Id: <20190504172222.1260-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently hdev is being dereferenced when using macro hid_to_usb_dev
before hdev is being null checked, hence there is a potential null
pointer dereference.  Fix this by only dereferencing hdev after it has
been null checked.

Fixes: 9614219e9310 ("HID: uclogic: Extract tablet parameter discovery into a module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-uclogic-params.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 0187c9f8fc22..bc5a2f860501 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -65,7 +65,7 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 					__u8 idx, size_t len)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
+	struct usb_device *udev;
 	__u8 *buf = NULL;
 
 	/* Check arguments */
@@ -73,6 +73,7 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	udev = hid_to_usb_dev(hdev);
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (buf == NULL) {
@@ -449,7 +450,7 @@ static int uclogic_params_frame_init_v1_buttonpad(
 {
 	int rc;
 	bool found = false;
-	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
+	struct usb_device *usb_dev;
 	char *str_buf = NULL;
 	const size_t str_len = 16;
 
@@ -458,6 +459,7 @@ static int uclogic_params_frame_init_v1_buttonpad(
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	usb_dev = hid_to_usb_dev(hdev);
 
 	/*
 	 * Enable generic button mode
@@ -705,7 +707,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				     struct hid_device *hdev)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
+	struct usb_device *udev;
 	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
 	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 	bool found;
@@ -720,6 +722,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	udev = hid_to_usb_dev(hdev);
 
 	/* If it's not a pen interface */
 	if (bInterfaceNumber != 0) {
@@ -832,10 +835,9 @@ int uclogic_params_init(struct uclogic_params *params,
 			struct hid_device *hdev)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
-	__u8  bNumInterfaces = udev->config->desc.bNumInterfaces;
-	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
-	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+	struct usb_device *udev;
+	struct usb_interface *iface;
+	__u8 bNumInterfaces, bInterfaceNumber;
 	bool found;
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
@@ -846,6 +848,10 @@ int uclogic_params_init(struct uclogic_params *params,
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	udev = hid_to_usb_dev(hdev);
+	bNumInterfaces = udev->config->desc.bNumInterfaces;
+	iface = to_usb_interface(hdev->dev.parent);
+	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 
 	/*
 	 * Set replacement report descriptor if the original matches the
-- 
2.20.1

