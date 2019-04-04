Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEBF20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l7xs+VlC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L9LGQkl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDDGiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:38:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:38:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C926F60850; Thu,  4 Apr 2019 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554359878;
        bh=QHc39TnLMYe3Q5fvIhCrbFFNcYr6BIee6kf28XtTS0M=;
        h=From:To:Cc:Subject:Date:From;
        b=l7xs+VlCnHATZbHLm5P3r4AzweZE4qKWXKK6GSTIXJFxscWnQIunclVQ+BN2Y8SJD
         s43NiXfV3Ro/ZXvafbhRYHwl5/L8WYF6RBXqeIDYLMhs7NKNbT+UxgCFFeA25/hP/o
         P/iuqY0P14EU1xI0jRrilc76LFlI5tTsfOK5f4nA=
Received: from rocky-HP-EliteBook-8460p.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 334E260721;
        Thu,  4 Apr 2019 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554359877;
        bh=QHc39TnLMYe3Q5fvIhCrbFFNcYr6BIee6kf28XtTS0M=;
        h=From:To:Cc:Subject:Date:From;
        b=L9LGQkl50uHJ9UHdLJOOFx7fbS4uBmNH9Unqv2sGEbgmbOQASbt/oIm+NbSqJyktw
         sJUbyx1dHbSxjhqhcoJMvKcNPOssXzXnfrWQs9Mq0bvKKgpSs3vZfgP6rNGkztlEzU
         HxOTse2XHZT6C8DcXJf8qvebXkJ+F2BDd31pgquQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 334E260721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH] Bluetooth: hci_qca: Load customized NVM based on the device property
Date:   Thu,  4 Apr 2019 14:37:38 +0800
Message-Id: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA BTSOC nvm is a customized file and different vendor/platoform may want
to have different BTSOC configuration via this file (e.g. Configure SCO over
PCM or I2S, Setting Tx power, etc.) This patch will allow vendors to download
different nvm file by reading a device property as the nvm file name postfix.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/btqca.c   | 13 +++++++++----
 drivers/bluetooth/btqca.h   |  4 ++--
 drivers/bluetooth/hci_qca.c | 18 +++++++++++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 6122685..81e42f3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -332,7 +332,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
-		   enum qca_btsoc_type soc_type, u32 soc_ver)
+		   enum qca_btsoc_type soc_type, u32 soc_ver, const char *nvm_postfix)
 {
 	struct rome_config config;
 	int err;
@@ -368,9 +368,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	if (soc_type == QCA_WCN3990)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crnv%02x.bin", rom_ver);
-	else
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/nvm_%08x.bin", soc_ver);
+	else {
+		if (NULL == nvm_postfix)
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/nvm_%08x.bin", soc_ver);
+		else
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/nvm_%08x_%s.bin", soc_ver, nvm_postfix);
+	}
 
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 6fdc25d..60a868f 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -139,7 +139,7 @@ enum qca_btsoc_type {
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
-		   enum qca_btsoc_type soc_type, u32 soc_ver);
+		   enum qca_btsoc_type soc_type, u32 soc_ver, const char *nvm_postfix);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #else
@@ -150,7 +150,7 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 }
 
 static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
-				 enum qca_btsoc_type soc_type, u32 soc_ver)
+				 enum qca_btsoc_type soc_type, u32 soc_ver, const char *nvm_postfix)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4ea995d..f495f3b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -164,6 +164,7 @@ struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct clk	 *susclk;
+	const char   *nvm_postfix;
 	enum qca_btsoc_type btsoc_type;
 	struct qca_power *bt_power;
 	u32 init_speed;
@@ -189,6 +190,17 @@ static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 	return soc_type;
 }
 
+static const char *qca_get_nvm_postfix(struct hci_uart *hu)
+{
+	if (hu->serdev) {
+		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
+
+		return qsd->nvm_postfix;
+	} else {
+		return NULL;
+	}
+}
+
 static void __serial_clock_on(struct tty_struct *tty)
 {
 	/* TODO: Some chipset requires to enable UART clock on client
@@ -1191,6 +1203,7 @@ static int qca_setup(struct hci_uart *hu)
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
+	const char *nvm_postfix = qca_get_nvm_postfix(hu);
 	int ret;
 	int soc_ver = 0;
 
@@ -1241,7 +1254,7 @@ static int qca_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver);
+	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver, nvm_postfix);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -1462,6 +1475,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->bt_en);
 		}
 
+		device_property_read_string(&serdev->dev, "nvm-postfix",
+					 &qcadev->nvm_postfix);
+
 		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_err(&serdev->dev, "failed to acquire clk\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

