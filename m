Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05615C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A9720729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEpWkjh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKOCK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:10:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKOCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:10:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so3582688plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 18:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7SJOxkwiLZMRENvBpXVAXwHLCZSEepvE/sOZrgn1wo=;
        b=eEpWkjh0VxOJ9i7SSR2+9hN1rM79hXyOjQWAz8OjqAKdV4FLXL3hTWucxBYajkbJW3
         wGHOGlwxkS0MdGBqZGMODsQpCPMkqCo0rbM3Z6ANnYeWQ2jie0KQohy0EYpedAWYg0CH
         Se4M0+EkH8trrGwqV+xvuOnXlyHU/UqD0Gi2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7SJOxkwiLZMRENvBpXVAXwHLCZSEepvE/sOZrgn1wo=;
        b=DKNs046cqJHEQvew1M+q3ZxBkxMQbiUo/8FkFcVn6n2YGvG7U3dBqGbmwOYYv4pqSE
         00P9InvaNjoMZGs9iBLfGxXvg6Pl4o/9GbavA5G92ODWGs7BM+1Kqdcoo0OksGdFGkl4
         EtHUrHH2DymZpDkGNO6nvJwHTW6/w6FivP3R3KFVJ2Pa4bSqasgUbv7GjHnebGxmc4P1
         +6gisvZk1/lYeSAu8VniRkAHivXMAxPPDm06SgVa+fkw3vjpmzSmN3OeNSIa47Qd6S6W
         tdFA8s+6tgT97/BKkaWskhYTfCDX4ig8KKALP3kiLHt3eeBj0AhSq+vRWjEJioIA1mRG
         8yDw==
X-Gm-Message-State: APjAAAUaYc/SrLVSPFQFJnUYDkniuSjQXwowoGhg+bBipadmEO2dvEc4
        +JRmEB4qYEg6e1XNNsbHlN3RiQ==
X-Google-Smtp-Source: APXvYqwRLOZ6HpvhEoCYxqf8qSs9+T+dbiiPliTlnz6TiDZoFisNMY2tOUXPVoaWOaRdLVzkqG4Rkw==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr13183434pla.213.1573783822144;
        Thu, 14 Nov 2019 18:10:22 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id f7sm9695820pfa.150.2019.11.14.18.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 18:10:21 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
Date:   Thu, 14 Nov 2019 18:10:05 -0800
Message-Id: <20191114180959.v5.1.I8ed714e23fdf42fa35588cfee2877b53d781df12@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115021008.32926-1-abhishekpandit@chromium.org>
References: <20191115021008.32926-1-abhishekpandit@chromium.org>
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

