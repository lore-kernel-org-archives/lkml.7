Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D01C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A840229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfGZLwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:52:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47272 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfGZLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:52:04 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6QBpqSd015619, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (msx.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6QBpqSd015619
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Jul 2019 19:51:52 +0800
Received: from toshiba (172.29.36.108) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Jul
 2019 19:51:51 +0800
Date:   Fri, 26 Jul 2019 19:52:08 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Fix suspend issue for Realtek
Message-ID: <20190726115208.GA8152@toshiba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.29.36.108]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

From the perspective of controller, global suspend means there is no
SET_FEATURE (DEVICE_REMOTE_WAKEUP) and controller would drop the
firmware. It would consume less power. So we should not send this kind
of SET_FEATURE when host goes to suspend state.
Otherwise, when making device enter selective suspend, host should send
SET_FEATURE to make sure the firmware remains.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
 drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 50aed5259c2b..69f6b4208901 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -426,6 +426,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_DIAG_RUNNING	10
 #define BTUSB_OOB_WAKE_ENABLED	11
 #define BTUSB_HW_RESET_ACTIVE	12
+#define BTUSB_QUIRK_SUSPEND	13
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1165,6 +1166,15 @@ static int btusb_open(struct hci_dev *hdev)
 	 */
 	device_wakeup_enable(&data->udev->dev);
 
+	/* Disable device remote wakeup when host is suspended
+	 * For Realtek chips, global suspend without
+	 * SET_FEATURE (DEVICE_REMOTE_WAKEUP) can save more power in device.
+	 */
+#ifdef CONFIG_BT_HCIBTUSB_RTL
+	if (test_bit(BTUSB_QUIRK_SUSPEND, &data->flags))
+		device_wakeup_disable(&data->udev->dev);
+#endif
+
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
 
@@ -1227,6 +1237,13 @@ static int btusb_close(struct hci_dev *hdev)
 		goto failed;
 
 	data->intf->needs_remote_wakeup = 0;
+
+	/* Enable remote wake up for auto-suspend */
+#ifdef CONFIG_BT_HCIBTUSB_RTL
+	if (test_bit(BTUSB_QUIRK_SUSPEND, &data->flags))
+		data->intf->needs_remote_wakeup = 1;
+#endif
+
 	device_wakeup_disable(&data->udev->dev);
 	usb_autopm_put_interface(data->intf);
 
@@ -3185,11 +3202,11 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_REALTEK) {
 		hdev->setup = btrtl_setup_realtek;
 
-		/* Realtek devices lose their updated firmware over suspend,
-		 * but the USB hub doesn't notice any status change.
-		 * Explicitly request a device reset on resume.
+		/* Realtek devices lose their updated firmware over global
+		 * suspend that means host doesn't send SET_FEATURE
+		 * (DEVICE_REMOTE_WAKEUP)
 		 */
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+		set_bit(BTUSB_QUIRK_SUSPEND, &data->flags);
 	}
 #endif
 
@@ -3363,6 +3380,21 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		enable_irq(data->oob_wake_irq);
 	}
 
+#ifdef CONFIG_BT_HCIBTUSB_RTL
+	/* For global suspend, Realtek devices lose the loaded fw
+	 * in them. But for autosuspend, firmware should remain.
+	 * Actually, it depends on whether the usb host sends
+	 * set feature (enable wakeup) or not.
+	 */
+	if (test_bit(BTUSB_QUIRK_SUSPEND, &data->flags)) {
+		if (PMSG_IS_AUTO(message) &&
+		    device_can_wakeup(&data->udev->dev))
+			data->udev->do_remote_wakeup = 1;
+		else if (!PMSG_IS_AUTO(message))
+			data->udev->reset_resume = 1;
+	}
+#endif
+
 	return 0;
 }
 
-- 
2.19.2

