Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F27C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8C521670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfD3JZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:25:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfD3JZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:25:55 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hLP1M-0007Sv-3m; Tue, 30 Apr 2019 09:25:52 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/2] Bluetooth: btusb: Quiesce btusb on system suspend
Date:   Tue, 30 Apr 2019 17:25:44 +0800
Message-Id: <20190430092544.13653-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430092544.13653-1-kai.heng.feng@canonical.com>
References: <20190430092544.13653-1-kai.heng.feng@canonical.com>
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
v2:
- Abstract away enabling/disabling LE advertising from btusb.

 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7db48ae65cd2..c3ae066910f2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -494,6 +494,7 @@ struct btusb_data {
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 	unsigned cmd_timeout_cnt;
+	bool suspended;
 };
 
 
@@ -3351,12 +3352,18 @@ static void btusb_disconnect(struct usb_interface *intf)
 static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
 
 	BT_DBG("intf %p", intf);
 
 	if (data->suspend_count++)
 		return 0;
 
+	if (!PMSG_IS_AUTO(message)) {
+		hci_suspend_dev(hdev);
+		data->suspended = true;
+	}
+
 	spin_lock_irq(&data->txlock);
 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
 		set_bit(BTUSB_SUSPENDING, &data->flags);
@@ -3462,6 +3469,11 @@ static int btusb_resume(struct usb_interface *intf)
 	spin_unlock_irq(&data->txlock);
 	schedule_work(&data->work);
 
+	if (data->suspended) {
+		hci_resume_dev(hdev);
+		data->suspended = false;
+	}
+
 	return 0;
 
 failed:
-- 
2.17.1

