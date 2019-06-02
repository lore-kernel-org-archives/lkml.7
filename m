Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD058C28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB386277D2
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFBBE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:04:58 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:57513 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFBBE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:04:57 -0400
X-UUID: d94cac872b104b4c8cc425c4ebba2e79-20190601
X-UUID: d94cac872b104b4c8cc425c4ebba2e79-20190601
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2052023471; Sat, 01 Jun 2019 17:04:27 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Jun 2019 18:04:25 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 09:04:24 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 4/4] Bluetooth: btmtkuart: add an implementation for clock osc property
Date:   Sun, 2 Jun 2019 09:04:17 +0800
Message-ID: <1559437457-26766-5-git-send-email-sean.wang@mediatek.com>
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

Some board requires explicitily control external osscilator via GPIO.
So, add an implementation of a clock property for an external oscillator
to the device.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 1257149cfdc4..e11169ad8247 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -115,8 +115,9 @@ struct btmtk_hci_wmt_params {
 struct btmtkuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
-	struct clk *clk;
 
+	struct clk *clk;
+	struct clk *osc;
 	struct regulator *vcc;
 	struct gpio_desc *reset;
 	struct gpio_desc *boot;
@@ -912,6 +913,12 @@ static int btmtkuart_parse_dt(struct serdev_device *serdev)
 			return err;
 		}
 
+		bdev->osc = devm_clk_get_optional(&serdev->dev, "osc");
+		if (IS_ERR(bdev->osc)) {
+			err = PTR_ERR(bdev->osc);
+			return err;
+		}
+
 		bdev->boot = devm_gpiod_get_optional(&serdev->dev, "boot",
 						     GPIOD_OUT_LOW);
 		if (IS_ERR(bdev->boot)) {
@@ -1006,6 +1013,10 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 
 	if (btmtkuart_is_standalone(bdev)) {
+		err = clk_prepare_enable(bdev->osc);
+		if (err < 0)
+			return err;
+
 		if (bdev->boot) {
 			gpiod_set_value_cansleep(bdev->boot, 1);
 		} else {
@@ -1017,8 +1028,10 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 
 		/* Power on */
 		err = regulator_enable(bdev->vcc);
-		if (err < 0)
+		if (err < 0) {
+			clk_disable_unprepare(bdev->osc);
 			return err;
+		}
 
 		/* Reset if the reset-gpios is available otherwise the board
 		 * -level design should be guaranteed.
@@ -1068,8 +1081,10 @@ static void btmtkuart_remove(struct serdev_device *serdev)
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 	struct hci_dev *hdev = bdev->hdev;
 
-	if (btmtkuart_is_standalone(bdev))
+	if (btmtkuart_is_standalone(bdev)) {
 		regulator_disable(bdev->vcc);
+		clk_disable_unprepare(bdev->osc);
+	}
 
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.17.1

