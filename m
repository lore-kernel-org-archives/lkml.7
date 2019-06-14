Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E3C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D662E2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFNHYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:24:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfFNHYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:20 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0000qW-RE; Fri, 14 Jun 2019 09:23:53 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0006Np-4e; Fri, 14 Jun 2019 09:23:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] Bluetooth: hci_mrvl: Add serdev support
Date:   Fri, 14 Jun 2019 09:23:51 +0200
Message-Id: <20190614072351.17390-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614072351.17390-1-s.hauer@pengutronix.de>
References: <20190614072351.17390-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds serdev support to the Marvell hci uart driver. Only basic
serdev support, none of the fancier features like regulator or enable
GPIO support is added for now.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/net/marvell-bluetooth.txt        | 25 +++++++
 drivers/bluetooth/Kconfig                     |  1 +
 drivers/bluetooth/hci_mrvl.c                  | 69 ++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/marvell-bluetooth.txt b/Documentation/devicetree/bindings/net/marvell-bluetooth.txt
new file mode 100644
index 000000000000..0e2842296032
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-bluetooth.txt
@@ -0,0 +1,25 @@
+Marvell Bluetooth Chips
+-----------------------
+
+This documents the binding structure and common properties for serial
+attached Marvell Bluetooth devices. The following chips are included in
+this binding:
+
+* Marvell 88W8897 Bluetooth devices
+
+Required properties:
+ - compatible: should be:
+    "mrvl,88w8897"
+
+Optional properties:
+None so far
+
+Example:
+
+&serial0 {
+	compatible = "ns16550a";
+	...
+	bluetooth {
+		compatible = "mrvl,88w8897";
+	};
+};
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index b9c34ff9a0d3..a3fafd781aa1 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -237,6 +237,7 @@ config BT_HCIUART_AG6XX
 config BT_HCIUART_MRVL
 	bool "Marvell protocol support"
 	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
 	select BT_HCIUART_H4
 	help
 	  Marvell is serial protocol for communication between Bluetooth
diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index a0a74362455e..f98e5cc343b2 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -13,6 +13,8 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -40,6 +42,10 @@ struct mrvl_data {
 	u8 id, rev;
 };
 
+struct mrvl_serdev {
+	struct hci_uart hu;
+};
+
 struct hci_mrvl_pkt {
 	__le16 lhs;
 	__le16 rhs;
@@ -49,6 +55,7 @@ struct hci_mrvl_pkt {
 static int mrvl_open(struct hci_uart *hu)
 {
 	struct mrvl_data *mrvl;
+	int ret;
 
 	BT_DBG("hu %p", hu);
 
@@ -62,7 +69,18 @@ static int mrvl_open(struct hci_uart *hu)
 	set_bit(STATE_CHIP_VER_PENDING, &mrvl->flags);
 
 	hu->priv = mrvl;
+
+	if (hu->serdev) {
+		ret = serdev_device_open(hu->serdev);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
+err:
+	kfree(mrvl);
+
+	return ret;
 }
 
 static int mrvl_close(struct hci_uart *hu)
@@ -71,6 +89,9 @@ static int mrvl_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (hu->serdev)
+		serdev_device_close(hu->serdev);
+
 	skb_queue_purge(&mrvl->txq);
 	skb_queue_purge(&mrvl->rawq);
 	kfree_skb(mrvl->rx_skb);
@@ -342,7 +363,11 @@ static int mrvl_setup(struct hci_uart *hu)
 	/* Let the final ack go out before switching the baudrate */
 	hci_uart_wait_until_sent(hu);
 
-	hci_uart_set_baudrate(hu, 3000000);
+	if (hu->serdev)
+		serdev_device_set_baudrate(hu->serdev, 3000000);
+	else
+		hci_uart_set_baudrate(hu, 3000000);
+
 	hci_uart_set_flow_control(hu, false);
 
 	err = mrvl_load_firmware(hu->hdev, "mrvl/uart8897_bt.bin");
@@ -365,12 +390,54 @@ static const struct hci_uart_proto mrvl_proto = {
 	.dequeue	= mrvl_dequeue,
 };
 
+static int mrvl_serdev_probe(struct serdev_device *serdev)
+{
+	struct mrvl_serdev *mrvldev;
+
+	mrvldev = devm_kzalloc(&serdev->dev, sizeof(*mrvldev), GFP_KERNEL);
+	if (!mrvldev)
+		return -ENOMEM;
+
+	mrvldev->hu.serdev = serdev;
+	serdev_device_set_drvdata(serdev, mrvldev);
+
+	return hci_uart_register_device(&mrvldev->hu, &mrvl_proto);
+}
+
+static void mrvl_serdev_remove(struct serdev_device *serdev)
+{
+	struct mrvl_serdev *mrvldev = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&mrvldev->hu);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mrvl_bluetooth_of_match[] = {
+	{ .compatible = "mrvl,88w8897" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mrvl_bluetooth_of_match);
+#endif
+
+static struct serdev_device_driver mrvl_serdev_driver = {
+	.probe = mrvl_serdev_probe,
+	.remove = mrvl_serdev_remove,
+	.driver = {
+		.name = "hci_uart_mrvl",
+		.of_match_table = of_match_ptr(mrvl_bluetooth_of_match),
+	},
+};
+
 int __init mrvl_init(void)
 {
+	serdev_device_driver_register(&mrvl_serdev_driver);
+
 	return hci_uart_register_proto(&mrvl_proto);
 }
 
 int __exit mrvl_deinit(void)
 {
+	serdev_device_driver_unregister(&mrvl_serdev_driver);
+
 	return hci_uart_unregister_proto(&mrvl_proto);
 }
-- 
2.20.1

