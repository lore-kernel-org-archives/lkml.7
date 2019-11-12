Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C9C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0892196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVm/Dskz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKLAUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:20:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45104 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:20:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so11930742pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcCI16g4dO/Qrfro0uo1Fa9EI3/y1R2NeWHuFFGKbTs=;
        b=PVm/DskzvIOtIK+GQa0comOTWHhuqkF4T7Kxr4lb1uzHf/pjNtvYKE6GmhvZf+uAdp
         ZU6z0A7hraMCVUE5jHz1MjQXbYEeD8xrFFPTeUIBlIR0WXe6xVIz8UbMkHD4+K0i7aD+
         Fygs01VY/bqT9SoHvfFvxEoG7UF7UMrao0xmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcCI16g4dO/Qrfro0uo1Fa9EI3/y1R2NeWHuFFGKbTs=;
        b=SZJAJQXgmfh92e5+IU8BUNc7ospLxlk/GyaqgzTctgN17B81tUjBWGaQEbtydgYfs6
         rxFnIKuI/LqyWiOopWdquBgSl4+x38R5kj7kFurUEmyii+HDYjOepkCcya4jt0nDsvn9
         JQ0V2HK/Jka3tYd4dSKX3IAKiH81nSNrHQE7jnIqDWtPRGjLBddVgE7zeBEcrX2av5Xm
         Vwqc889Nul5qIdEKHZMt7oWHFmysD/0aIGS8PK/50Je4g5GT4aHuwq+Mc1uue0aYFMVf
         TbxJ4zaYBIFTYrV57K3k6BXXj4CYECJuNslPW2jriJ1JSDgfyxGq4vfzWMEi1UTt1BDQ
         MbZw==
X-Gm-Message-State: APjAAAUhMlSohUbJSUWh3AI8SIB06JrExEClZ3JRLF1pXMegfwZMuBKv
        XyFUrZvxPMM44OWSwBoxgmKKuizJxHM=
X-Google-Smtp-Source: APXvYqzWJ5i//nOANUZ8fd/LNc3QpHTPDBT+xrc6ozPqoPx25+RYtknJgZAjECFrz+PZ4keyk2zMaQ==
X-Received: by 2002:a63:1a51:: with SMTP id a17mr30972921pgm.449.1573518001020;
        Mon, 11 Nov 2019 16:20:01 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id h23sm8430898pgg.58.2019.11.11.16.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:20:00 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
Date:   Mon, 11 Nov 2019 16:19:46 -0800
Message-Id: <20191112001949.136377-2-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112001949.136377-1-abhishekpandit@chromium.org>
References: <20191112001949.136377-1-abhishekpandit@chromium.org>
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

