Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F86C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41754277CB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFBBFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:05:02 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:57513 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFBBE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:04:57 -0400
X-UUID: 265db466a56d48cc859b9c0419ee810e-20190601
X-UUID: 265db466a56d48cc859b9c0419ee810e-20190601
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 743702653; Sat, 01 Jun 2019 17:04:26 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Jun 2019 18:04:24 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 09:04:23 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 3/4] Bluetooth: btmtkuart: add an implementation for boot-gpios property
Date:   Sun, 2 Jun 2019 09:04:16 +0800
Message-ID: <1559437457-26766-4-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
References: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Not every platform has the pinctrl device integrates the GPIO the function
such as MT7621 whose pinctrl and GPIO are separate hardware so the driver
adds additional boot-gpios to let the MT766[3,8]U can enter the proper boot
mode by gpiod for such platform.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index f5dbeec8e274..1257149cfdc4 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -119,6 +119,7 @@ struct btmtkuart_dev {
 
 	struct regulator *vcc;
 	struct gpio_desc *reset;
+	struct gpio_desc *boot;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_runtime;
 	struct pinctrl_state *pins_boot;
@@ -911,6 +912,13 @@ static int btmtkuart_parse_dt(struct serdev_device *serdev)
 			return err;
 		}
 
+		bdev->boot = devm_gpiod_get_optional(&serdev->dev, "boot",
+						     GPIOD_OUT_LOW);
+		if (IS_ERR(bdev->boot)) {
+			err = PTR_ERR(bdev->boot);
+			return err;
+		}
+
 		bdev->pinctrl = devm_pinctrl_get(&serdev->dev);
 		if (IS_ERR(bdev->pinctrl)) {
 			err = PTR_ERR(bdev->pinctrl);
@@ -919,8 +927,10 @@ static int btmtkuart_parse_dt(struct serdev_device *serdev)
 
 		bdev->pins_boot = pinctrl_lookup_state(bdev->pinctrl,
 						       "default");
-		if (IS_ERR(bdev->pins_boot)) {
+		if (IS_ERR(bdev->pins_boot) && !bdev->boot) {
 			err = PTR_ERR(bdev->pins_boot);
+			dev_err(&serdev->dev,
+				"Should assign RXD to LOW at boot stage\n");
 			return err;
 		}
 
@@ -996,8 +1006,14 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 
 	if (btmtkuart_is_standalone(bdev)) {
-		/* Switch to the specific pin state for the booting requires */
-		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+		if (bdev->boot) {
+			gpiod_set_value_cansleep(bdev->boot, 1);
+		} else {
+			/* Switch to the specific pin state for the booting
+			 * requires.
+			 */
+			pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+		}
 
 		/* Power on */
 		err = regulator_enable(bdev->vcc);
@@ -1017,6 +1033,10 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 		 * mode the device requires for UART transfers.
 		 */
 		msleep(50);
+
+		if (bdev->boot)
+			devm_gpiod_put(&serdev->dev, bdev->boot);
+
 		pinctrl_select_state(bdev->pinctrl, bdev->pins_runtime);
 
 		/* A standalone device doesn't depends on power domain on SoC,
@@ -1037,10 +1057,8 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	return 0;
 
 err_regulator_disable:
-	if (btmtkuart_is_standalone(bdev))  {
-		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+	if (btmtkuart_is_standalone(bdev))
 		regulator_disable(bdev->vcc);
-	}
 
 	return err;
 }
@@ -1050,10 +1068,8 @@ static void btmtkuart_remove(struct serdev_device *serdev)
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 	struct hci_dev *hdev = bdev->hdev;
 
-	if (btmtkuart_is_standalone(bdev))  {
-		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+	if (btmtkuart_is_standalone(bdev))
 		regulator_disable(bdev->vcc);
-	}
 
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.17.1

