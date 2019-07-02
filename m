Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C67C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71D02082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGBOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:19:18 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57588 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfGBOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:19:12 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 10:19:12 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id EC37F60AF8;
        Tue,  2 Jul 2019 16:13:50 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH] Bluetooth: serdev: hci_ll: set operational frequency earlier
Date:   Tue,  2 Jul 2019 16:13:37 +0200
Message-Id: <20190702141337.10528-1-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uploading the firmware needs quite a few seconds if done at 115200 kbps. So set
the operational frequency, usually 3 MHz, before uploading the firmware.

I have successfully tested this with a wl1837mod.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/bluetooth/hci_ll.c | 39 ++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c04f5f9e1ed0..cbd7bc539d5e 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -601,6 +601,13 @@ static int ll_setup(struct hci_uart *hu)
 
 	serdev_device_set_flow_control(serdev, true);
 
+	if (hu->oper_speed)
+		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
+	else
+		speed = 0;
+
 	do {
 		/* Reset the Bluetooth device */
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
@@ -612,6 +619,20 @@ static int ll_setup(struct hci_uart *hu)
 			return err;
 		}
 
+		if (speed) {
+			__le32 speed_le = cpu_to_le32(speed);
+			struct sk_buff *skb;
+
+			skb = __hci_cmd_sync(hu->hdev,
+					     HCI_VS_UPDATE_UART_HCI_BAUDRATE,
+					     sizeof(speed_le), &speed_le,
+					     HCI_INIT_TIMEOUT);
+			if (!IS_ERR(skb)) {
+				kfree_skb(skb);
+				serdev_device_set_baudrate(serdev, speed);
+			}
+		}
+
 		err = download_firmware(lldev);
 		if (!err)
 			break;
@@ -636,25 +657,7 @@ static int ll_setup(struct hci_uart *hu)
 	}
 
 	/* Operational speed if any */
-	if (hu->oper_speed)
-		speed = hu->oper_speed;
-	else if (hu->proto->oper_speed)
-		speed = hu->proto->oper_speed;
-	else
-		speed = 0;
-
-	if (speed) {
-		__le32 speed_le = cpu_to_le32(speed);
-		struct sk_buff *skb;
 
-		skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
-				     sizeof(speed_le), &speed_le,
-				     HCI_INIT_TIMEOUT);
-		if (!IS_ERR(skb)) {
-			kfree_skb(skb);
-			serdev_device_set_baudrate(serdev, speed);
-		}
-	}
 
 	return 0;
 }
-- 
2.20.1

