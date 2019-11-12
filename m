Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FCD21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YdrGV23p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKLXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:10:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKLXKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:10:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so150538pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4rz9vLo2eafCUNc201GuFg4CkJBNOXSfPFRWrTej2s=;
        b=YdrGV23pdiJ5ZLjgucgT0DxlKwouAfePKKafYNZTQTKd8xjoLafoBFdNfBzVeYnqnt
         c4gOK3Ad8c8MN3rrlLeGFK7+2G7vHF8W+OFcWIQXJf+/ywVLdspR0bjTvXhkNdAI7sVs
         2VZ3fJEfYdgurTiA/mxoV+/lEMZUGn9mWcY1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4rz9vLo2eafCUNc201GuFg4CkJBNOXSfPFRWrTej2s=;
        b=Hph2eom8e6BSFtvR+JtvTPZTuX3NnJKrIe6af0mdLS7yRny0MFQXREbTvMq6HO7mDr
         DPZhEVuFhUgX3tbEzaCRiU6eSN3NxZV9RkSWZbFL0ApdgVJq0w5uWW3+RDSHKq7JvOXP
         CSSJ3Y31Jed5DHmBMMLAf6xh9gsly8/nVVO7SXa8bqRLN8OIcqXx7nNYqf7oy7uDozSj
         IPbQz/JtiRG1MS9bfldZIiTT7U3L3QzwE7B16X91EPZjMrudtdbhqdmhPhw1ISDLeRZI
         BWWh5qPv+xb/x52/rCAOuMSvxew8f1FxXvEliRHVb+uL9MNeYW7Zg7ilf+pvaOb4aiLn
         AU3Q==
X-Gm-Message-State: APjAAAUvpCGb5VohDnueYBJzgKTfGHllKglFaKmL8RBUgih3R57Ls9AA
        wIKIStNnH3aMjYKdhP1HByz1MQ==
X-Google-Smtp-Source: APXvYqxNiq5tQHjavZGOX7zKaQThAZlf2E2vNIxN+tL5p13vlf3F2Y4nQP4Sh0rjHZ5H32a7LtAYAA==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr453243pjr.62.1573600209967;
        Tue, 12 Nov 2019 15:10:09 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w27sm67694pgc.20.2019.11.12.15.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:10:08 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
Date:   Tue, 12 Nov 2019 15:09:41 -0800
Message-Id: <20191112230944.48716-2-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112230944.48716-1-abhishekpandit@chromium.org>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without updating the patchram, the BCM4354 does not support a higher
operating speed. The normal bcm_setup follows the correct order
(init_speed, patchram and then oper_speed) but the serdev driver will
set the operating speed before calling the hu->setup function. Thus,
for the BCM4354, disallow setting the operating speed before patchram.
If set_baudrate is called before setup, it will return -EBUSY.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/bluetooth/hci_bcm.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0f851c0dde7f..6134bff58748 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -47,6 +47,14 @@
 
 #define BCM_NUM_SUPPLIES 2
 
+/**
+ * struct bcm_device_data - device specific data
+ * @no_early_set_baudrate: Disallow set baudrate before driver setup()
+ */
+struct bcm_device_data {
+	bool	no_early_set_baudrate;
+};
+
 /**
  * struct bcm_device - device driver resources
  * @serdev_hu: HCI UART controller struct
@@ -79,6 +87,7 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ * @disallow_set_baudrate: don't allow set_baudrate
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -112,6 +121,7 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+	bool			disallow_set_baudrate;
 };
 
 /* generic bcm uart resources */
@@ -141,9 +151,13 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct hci_dev *hdev = hu->hdev;
+	struct bcm_data *bcm = hu->priv;
 	struct sk_buff *skb;
 	struct bcm_update_uart_baud_rate param;
 
+	if (bcm && bcm->dev && bcm->dev->disallow_set_baudrate)
+		return -EBUSY;
+
 	if (speed > 3000000) {
 		struct bcm_write_uart_clock_setting clock;
 
@@ -551,6 +565,12 @@ static int bcm_setup(struct hci_uart *hu)
 		goto finalize;
 	}
 
+	/* If we disallow early set baudrate, we can re-enable it now that
+	 * patchram is done
+	 */
+	if (bcm->dev && bcm->dev->disallow_set_baudrate)
+		bcm->dev->disallow_set_baudrate = false;
+
 	/* Init speed if any */
 	if (hu->init_speed)
 		speed = hu->init_speed;
@@ -1371,6 +1391,15 @@ static struct platform_driver bcm_driver = {
 	},
 };
 
+static void bcm_configure_device_data(struct bcm_device *bdev)
+{
+	const struct bcm_device_data *data = device_get_match_data(bdev->dev);
+
+	if (data) {
+		bdev->disallow_set_baudrate = data->no_early_set_baudrate;
+	}
+}
+
 static int bcm_serdev_probe(struct serdev_device *serdev)
 {
 	struct bcm_device *bcmdev;
@@ -1408,6 +1437,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	if (err)
 		dev_err(&serdev->dev, "Failed to power down\n");
 
+	bcm_configure_device_data(bcmdev);
+
 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
 }
 
@@ -1419,12 +1450,16 @@ static void bcm_serdev_remove(struct serdev_device *serdev)
 }
 
 #ifdef CONFIG_OF
+struct bcm_device_data bcm4354_device_data = {
+	.no_early_set_baudrate = true,
+};
+
 static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm20702a1" },
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
-	{ .compatible = "brcm,bcm43540-bt" },
+	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

