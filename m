Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C3DC3A5A9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94119206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfIECiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 22:38:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53172 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfIECiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:38:54 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x852cXBX027863, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (doc.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x852cXBX027863
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 5 Sep 2019 10:38:39 +0800
Received: from laptop-alex (172.29.36.155) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 5 Sep 2019
 10:36:48 +0800
Date:   Thu, 5 Sep 2019 10:36:31 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH v2] Bluetooth: btusb: Use cmd_timeout to reset Realtek device
Message-ID: <20190905023631.GA29398@laptop-alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.29.36.155]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

Realtek Bluetooth controller provides a BT_DIS reset pin for hardware
reset of it. The cmd_timeout is helpful on Realtek bluetooth controller
where the firmware gets stuck.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
Changes in v2
  - Provide a dedicated btusb_rtl_cmd_timeout in case of Realtek hardware

 drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 31d3febed187..4ac012df5666 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -524,6 +524,36 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
+static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct gpio_desc *reset_gpio = data->reset_gpio;
+
+	if (++data->cmd_timeout_cnt < 5)
+		return;
+
+	if (!reset_gpio) {
+		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
+		return;
+	}
+
+	/*
+	 * Toggle the hard reset line. The Realtek device is going to yank
+	 * itself off the USB and then replug. The cleanup is handled correctly
+	 * on the way out(standard USB disconnect), and the new device is
+	 * detected cleanly and bound to the driver again like it should be.
+	 */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return;
+	}
+
+	bt_dev_err(hdev, "Reset Realtek device via gpio");
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	msleep(200);
+	gpiod_set_value_cansleep(reset_gpio, 1);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -3783,6 +3813,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_REALTEK) {
 		hdev->setup = btrtl_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
+		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
 		/* Realtek devices lose their updated firmware over global
 		 * suspend that means host doesn't send SET_FEATURE
-- 
2.21.0

