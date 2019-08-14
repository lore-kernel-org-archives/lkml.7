Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D864C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189AC2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHNMCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:02:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40147 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:02:39 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7EC2R69024393, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (rsn1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7EC2R69024393
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 14 Aug 2019 20:02:27 +0800
Received: from toshiba (172.29.36.108) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 20:02:27 +0800
Date:   Wed, 14 Aug 2019 20:02:52 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH v3] Bluetooth: btusb: Fix suspend issue for Realtek devices
Message-ID: <20190814120252.GA4572@toshiba>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Changes in v3:
  - Change to fit for bluetooth-next
Changes in v2:
  - Change flag to be more descriptive
  - Delete pointless #ifdef CONFIG_BT_HCIBTUSB_RTL and #endif

 drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3876fee6ad13..b606c663ba57 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -435,6 +435,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_OOB_WAKE_ENABLED	11
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
+#define BTUSB_WAKEUP_DISABLE	14
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1175,6 +1176,13 @@ static int btusb_open(struct hci_dev *hdev)
 	 */
 	device_wakeup_enable(&data->udev->dev);
 
+	/* Disable device remote wakeup when host is suspended
+	 * For Realtek chips, global suspend without
+	 * SET_FEATURE (DEVICE_REMOTE_WAKEUP) can save more power in device.
+	 */
+	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+		device_wakeup_disable(&data->udev->dev);
+
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
 
@@ -1238,6 +1246,11 @@ static int btusb_close(struct hci_dev *hdev)
 		goto failed;
 
 	data->intf->needs_remote_wakeup = 0;
+
+	/* Enable remote wake up for auto-suspend */
+	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+		data->intf->needs_remote_wakeup = 1;
+
 	device_wakeup_disable(&data->udev->dev);
 	usb_autopm_put_interface(data->intf);
 
@@ -3769,11 +3782,11 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->setup = btrtl_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
 
-		/* Realtek devices lose their updated firmware over suspend,
-		 * but the USB hub doesn't notice any status change.
-		 * Explicitly request a device reset on resume.
+		/* Realtek devices lose their updated firmware over global
+		 * suspend that means host doesn't send SET_FEATURE
+		 * (DEVICE_REMOTE_WAKEUP)
 		 */
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
 	}
 #endif
 
@@ -3947,6 +3960,19 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		enable_irq(data->oob_wake_irq);
 	}
 
+	/* For global suspend, Realtek devices lose the loaded fw
+	 * in them. But for autosuspend, firmware should remain.
+	 * Actually, it depends on whether the usb host sends
+	 * set feature (enable wakeup) or not.
+	 */
+	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
+		if (PMSG_IS_AUTO(message) &&
+		    device_can_wakeup(&data->udev->dev))
+			data->udev->do_remote_wakeup = 1;
+		else if (!PMSG_IS_AUTO(message))
+			data->udev->reset_resume = 1;
+	}
+
 	return 0;
 }
 
-- 
2.19.2

