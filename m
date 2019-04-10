Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094262083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d4hvGje3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UVmemI1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfDJJ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:28:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbfDJJ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:28:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E69360FF3; Wed, 10 Apr 2019 09:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554888484;
        bh=iDxB1nyDECSqWjnngbEZI2x6uq5t781WRASfh4Q/YbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4hvGje3kah5HjyHPGvXjpTdaAsawRQxUgdX2NwqtKeaZBPQnOW71N762HUO/Hgcc
         koE4TFzEgRHj84wrMDDitylmv5zj2JBezoBhWyshjXeAW1vbZVNYbv785YIfmS8LJ1
         jcJcBvNQM9HcPQRExwp4CsdkYcEULv7U+BLQM+uA=
Received: from rocky-HP-EliteBook-8460p.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5590460EA5;
        Wed, 10 Apr 2019 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554888481;
        bh=iDxB1nyDECSqWjnngbEZI2x6uq5t781WRASfh4Q/YbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVmemI1ng7AraZCaHG09ba/TNI5eLBnr5N0GqwHFhRJGqJUr3A+zCwj3Xu2c9Eeay
         qS4mjcHXfyeAPN1QXS1wePbC++rppKeUAAGrncl8BGXsvtuei60VxUumI4dS0GXvET
         ER3CZwyJXtfwmBGGZ22H75a1zBimRnuYuO5adUu4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5590460EA5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, thierry.escande@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v3 1/2] Bluetooth: hci_qca: Load customized NVM based on the device property
Date:   Wed, 10 Apr 2019 17:27:31 +0800
Message-Id: <1554888451-17518-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
References: <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA BTSOC NVM is a customized firmware file and different vendors may
want to have different BTSOC configuration (e.g. Configure SCO over PCM
or I2S, Setting Tx power, etc.) via this file. This patch will allow
vendors to download different NVM firmware file by reading a device
property "firmware-name".

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
Changes in v3:
  * added firmware-name instead of nvm-postfix to specify full firmware name
---
 drivers/bluetooth/btqca.c   | 14 ++++++++++----
 drivers/bluetooth/btqca.h   |  6 ++++--
 drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 6122685..645a893 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -332,7 +332,8 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
-		   enum qca_btsoc_type soc_type, u32 soc_ver)
+		   enum qca_btsoc_type soc_type, u32 soc_ver,
+		   const char *firmware_name)
 {
 	struct rome_config config;
 	int err;
@@ -368,9 +369,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	if (soc_type == QCA_WCN3990)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crnv%02x.bin", rom_ver);
-	else
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/nvm_%08x.bin", soc_ver);
+	else {
+		if (firmware_name)
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/%s", firmware_name);
+		else
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/nvm_%08x.bin", soc_ver);
+	}
 
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 6fdc25d..41dc806 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -139,7 +139,8 @@ enum qca_btsoc_type {
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
-		   enum qca_btsoc_type soc_type, u32 soc_ver);
+		   enum qca_btsoc_type soc_type, u32 soc_ver,
+		   const char *firmware_name);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #else
@@ -150,7 +151,8 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 }
 
 static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
-				 enum qca_btsoc_type soc_type, u32 soc_ver)
+				 enum qca_btsoc_type soc_type, u32 soc_ver,
+				 const char *firmware_name)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4ea995d..9b8d4d7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -168,6 +168,7 @@ struct qca_serdev {
 	struct qca_power *bt_power;
 	u32 init_speed;
 	u32 oper_speed;
+	const char *firmware_name;
 };
 
 static int qca_power_setup(struct hci_uart *hu, bool on);
@@ -189,6 +190,17 @@ static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 	return soc_type;
 }
 
+static const char *qca_get_firmware_name(struct hci_uart *hu)
+{
+	if (hu->serdev) {
+		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
+
+		return qsd->firmware_name;
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
+	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
 	int soc_ver = 0;
 
@@ -1241,7 +1254,8 @@ static int qca_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver);
+	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver,
+			firmware_name);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -1462,6 +1476,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->bt_en);
 		}
 
+		device_property_read_string(&serdev->dev, "firmware-name",
+					 &qcadev->firmware_name);
+
 		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_err(&serdev->dev, "failed to acquire clk\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

