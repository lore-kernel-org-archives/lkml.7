Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B8C33C99
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571A722318
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ausrL/bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKRTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:21:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35883 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:21:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id d7so10325182pls.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzisFq8fux9k/N21kQN1ZtrgwBNPbrVsn1ch8Jq5ueE=;
        b=ausrL/boGyOBsVp8bS/Er5jCNIZzOWKh2raHpxUVXOoDbw/TzpEUka9AjChY7JlWZD
         vaJYqSSWuin+OnLD0jtO+eMtQmtj0eq4m22NZ8bN6ziE8szQ3czZWD8guZvCfJpG0Vpp
         c1z6UZduWEoSuucp05CcnJVlgDzFlDJmaaOT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzisFq8fux9k/N21kQN1ZtrgwBNPbrVsn1ch8Jq5ueE=;
        b=FYoCzDaAqiTu/QDRD+MErLg96I5aYqPhSsnrkAnw7CjzdqE17c19+qitOQEGCJmvsN
         34WqKV52gTId28YXTJMW0p7cO2fD4hxIekpBMD3/pd84CG9lmCl4qePgZrsJC/XOvsq1
         LV6DSsqBUlby+gucTP0sp9jkodp+cYfK2sOyMdqBVWmrb97IWvOOdMuRj6kn/dqeC9kx
         ibhcHOi8PDrPOqAhW34qAaaD2r+VQJWLp5vxAE/PZDrFwjckbtasdcJN6vB9grCQrIGb
         rqtGQmWH1N/fl5nZZ+y6QJz5CMHQVyewn//h8uKbOJF5CaTP23m6ufAmGl1fGASASiHL
         4KkA==
X-Gm-Message-State: APjAAAWgHxDWp8x4Z1kW95XYzaaHXSm/BGoB5/++vTgDwvfknM6ApLa4
        TsiMWYnR2WTxzk0gkdrF4FH8yg==
X-Google-Smtp-Source: APXvYqzytqoNTQNimKdq9gsy3IPLT3XAenDxgchZm9tK8x/gba4lmVP4pnK6MN6NeaamvxuJ+HKfzQ==
X-Received: by 2002:a17:90a:33ce:: with SMTP id n72mr747115pjb.17.1574104895674;
        Mon, 18 Nov 2019 11:21:35 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id p123sm22772633pfg.30.2019.11.18.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:21:34 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
Date:   Mon, 18 Nov 2019 11:21:20 -0800
Message-Id: <20191118110335.v6.1.I8ed714e23fdf42fa35588cfee2877b53d781df12@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191118192123.82430-1-abhishekpandit@chromium.org>
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
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
for the BCM4354, don't set the operating speed before patchram.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/bluetooth/hci_bcm.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0f851c0dde7f..ee40003008d8 100644
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
+ * @no_early_set_baudrate: don't set_baudrate before setup()
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -112,6 +121,7 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+	bool			no_early_set_baudrate;
 };
 
 /* generic bcm uart resources */
@@ -447,7 +457,13 @@ static int bcm_open(struct hci_uart *hu)
 	if (bcm->dev) {
 		hci_uart_set_flow_control(hu, true);
 		hu->init_speed = bcm->dev->init_speed;
-		hu->oper_speed = bcm->dev->oper_speed;
+
+		/* If oper_speed is set, ldisc/serdev will set the baudrate
+		 * before calling setup()
+		 */
+		if (!bcm->dev->no_early_set_baudrate)
+			hu->oper_speed = bcm->dev->oper_speed;
+
 		err = bcm_gpio_set_power(bcm->dev, true);
 		hci_uart_set_flow_control(hu, false);
 		if (err)
@@ -565,6 +581,8 @@ static int bcm_setup(struct hci_uart *hu)
 	/* Operational speed if any */
 	if (hu->oper_speed)
 		speed = hu->oper_speed;
+	else if (bcm->dev && bcm->dev->oper_speed)
+		speed = bcm->dev->oper_speed;
 	else if (hu->proto->oper_speed)
 		speed = hu->proto->oper_speed;
 	else
@@ -1374,6 +1392,7 @@ static struct platform_driver bcm_driver = {
 static int bcm_serdev_probe(struct serdev_device *serdev)
 {
 	struct bcm_device *bcmdev;
+	const struct bcm_device_data *data;
 	int err;
 
 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
@@ -1408,6 +1427,10 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	if (err)
 		dev_err(&serdev->dev, "Failed to power down\n");
 
+	data = device_get_match_data(bcmdev->dev);
+	if (data)
+		bcmdev->no_early_set_baudrate = data->no_early_set_baudrate;
+
 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
 }
 
@@ -1419,12 +1442,16 @@ static void bcm_serdev_remove(struct serdev_device *serdev)
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
2.24.0.432.g9d3f5f5b63-goog

