Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89767C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB6B20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfDVJUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:20:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34259 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfDVJUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:20:45 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hIV7y-00027o-PN; Mon, 22 Apr 2019 09:20:43 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] Bluetooth: btusb: Disable LE Advertising on system suspend
Date:   Mon, 22 Apr 2019 17:20:34 +0800
Message-Id: <20190422092034.21461-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422092034.21461-1-kai.heng.feng@canonical.com>
References: <20190422092034.21461-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System may freeze during suspend, and it's caused by btusb early wakeup:

kernel: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
kernel: dpm_run_callback(): pci_pm_suspend+0x0/0x130 returns -16
kernel: PM: Device 0000:00:14.0 failed to suspend async: error -16
kernel: PM: Some devices failed to suspend, or early wake event detected
kernel: usb usb1: usb resume
kernel: hub 1-0:1.0: hub_resume
kernel: usb usb1-port1: status 0507 change 0000
kernel: usb usb1-port6: status 0103 change 0004
kernel: usb usb1-port10: status 0107 change 0000

where btusb is connecte to usb1-port6.

The expirement shows that the early wakeup is caused by LE Advertising
packet.

Disabling it via event mask can prevent the issue from happening.

BugLink: https://bugs.launchpad.net/bugs/1823029
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 10c8f9872ee5..f03fcf5687e4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -490,6 +490,7 @@ struct btusb_data {
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+	bool suspended;
 };
 
 static inline void btusb_free_frags(struct btusb_data *data)
@@ -3316,12 +3317,18 @@ static void btusb_disconnect(struct usb_interface *intf)
 static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
 
 	BT_DBG("intf %p", intf);
 
 	if (data->suspend_count++)
 		return 0;
 
+	if (!PMSG_IS_AUTO(message)) {
+		hci_disable_le_advertising(hdev);
+		data->suspended = true;
+	}
+
 	spin_lock_irq(&data->txlock);
 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
 		set_bit(BTUSB_SUSPENDING, &data->flags);
@@ -3427,6 +3434,11 @@ static int btusb_resume(struct usb_interface *intf)
 	spin_unlock_irq(&data->txlock);
 	schedule_work(&data->work);
 
+	if (data->suspended) {
+		hci_enable_le_advertising(hdev);
+		data->suspended = false;
+	}
+
 	return 0;
 
 failed:
-- 
2.17.1

