Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5921BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E9923697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:41:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43746 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:41:33 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x839fLmN001132, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (doc.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x839fLmN001132
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Sep 2019 17:41:22 +0800
Received: from laptop-alex (172.29.36.155) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Sep 2019
 17:41:20 +0800
Date:   Tue, 3 Sep 2019 17:41:03 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Use cmd_timeout to reset Realtek device
Message-ID: <20190903094103.GA10714@laptop-alex>
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
 drivers/bluetooth/btusb.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 31d3febed187..a626de3a3f4c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -489,16 +489,19 @@ struct btusb_data {
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
-	unsigned cmd_timeout_cnt;
+	unsigned int cmd_timeout_cnt;
+	unsigned int cmd_timeout_max;
+	unsigned int reset_msecs;
+	int reset_gpio_value;
 };
 
 
-static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
+static void btusb_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
 
-	if (++data->cmd_timeout_cnt < 5)
+	if (++data->cmd_timeout_cnt < data->cmd_timeout_max)
 		return;
 
 	if (!reset_gpio) {
@@ -519,9 +522,9 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	}
 
 	bt_dev_err(hdev, "Initiating HW reset via gpio");
-	gpiod_set_value_cansleep(reset_gpio, 1);
-	msleep(100);
-	gpiod_set_value_cansleep(reset_gpio, 0);
+	gpiod_set_value_cansleep(reset_gpio, data->reset_gpio_value);
+	msleep(data->reset_msecs);
+	gpiod_set_value_cansleep(reset_gpio, !data->reset_gpio_value);
 }
 
 static inline void btusb_free_frags(struct btusb_data *data)
@@ -3723,7 +3726,10 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btusb_shutdown_intel;
 		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->cmd_timeout = btusb_cmd_timeout;
+		data->cmd_timeout_max = 5;
+		data->reset_msecs = 100;
+		data->reset_gpio_value = 1;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -3737,7 +3743,10 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->cmd_timeout = btusb_cmd_timeout;
+		data->cmd_timeout_max = 5;
+		data->reset_msecs = 100;
+		data->reset_gpio_value = 1;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -3783,6 +3792,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_REALTEK) {
 		hdev->setup = btrtl_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
+		hdev->cmd_timeout = btusb_cmd_timeout;
+		data->cmd_timeout_max = 5;
+		data->reset_msecs = 200;
+		data->reset_gpio_value = 0;
 
 		/* Realtek devices lose their updated firmware over global
 		 * suspend that means host doesn't send SET_FEATURE
-- 
2.21.0

