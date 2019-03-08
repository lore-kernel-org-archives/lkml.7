Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C3A2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X0sc2yn6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UQ7gXcPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCHMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:48:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCHMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:48:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB79F602F8; Fri,  8 Mar 2019 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552049278;
        bh=uda007DdwBkZYbguYM+lYjn4IpE1n7GZoQYazu64LgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0sc2yn6qRb5XYlrhKEIc9ocEsBjnVXoKvGBuwlQ3oVjz1hdVAxV9t7GOFNcebvAb
         zGpOHfLpSOnlEwp2irOE4tPO9PMzkYJdav4DgUorFF5I8KcMhYoQdXl309Wj3IxhL9
         54dLXtTFMtM7bjhyBCg6zJeKFgIScKmuq2Y1UuwE=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEDE0602F8;
        Fri,  8 Mar 2019 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552049277;
        bh=uda007DdwBkZYbguYM+lYjn4IpE1n7GZoQYazu64LgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQ7gXcPhbXp9+iyq0x/DZ05fRGRMHcBJkLVDSgmD7yDU49BdUH0RfUzw5Lq4vVvRG
         okwW98/q924FRTo2HAluX8vuhnkstdKPSaegR8Squbtv+xDnsGwjAlTxTjKRgftCwh
         Zyl8w3WEgbw35hYXoUWGoOsOkonuxWkZJhauvn5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEDE0602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v2 1/2] Bluetooth: hci_qca: Added support for wcn3998
Date:   Fri,  8 Mar 2019 18:17:38 +0530
Message-Id: <1552049259-25429-2-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552049259-25429-1-git-send-email-c-hbandi@codeaurora.org>
References: <1552049259-25429-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new compatible for wcn3998 and corresponding voltage
and current values to wcn3998 compatible.
Changed driver code to support wcn3998

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
Changes in V2:
- Removed the Reading of regulator values from dts.
- Added new compatible for wcn3998.
---
 drivers/bluetooth/btqca.c   |  4 ++--
 drivers/bluetooth/btqca.h   |  3 ++-
 drivers/bluetooth/hci_qca.c | 40 ++++++++++++++++++++++++++--------------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 6122685..70cab13 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -344,7 +344,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	if (soc_type == QCA_WCN3990) {
+	if (soc_type >= QCA_WCN3990) {
 		/* Firmware files to download are based on ROM version.
 		 * ROM version is derived from last two bytes of soc_ver.
 		 */
@@ -365,7 +365,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
-	if (soc_type == QCA_WCN3990)
+	if (soc_type >= QCA_WCN3990)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crnv%02x.bin", rom_ver);
 	else
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index c72c56e..f03d96e 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -132,7 +132,8 @@ enum qca_btsoc_type {
 	QCA_INVALID = -1,
 	QCA_AR3002,
 	QCA_ROME,
-	QCA_WCN3990
+	QCA_WCN3990,
+	QCA_WCN3998
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea3..d623665 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -506,7 +506,7 @@ static int qca_open(struct hci_uart *hu)
 	if (hu->serdev) {
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type != QCA_WCN3990) {
+		if (qcadev->btsoc_type == QCA_ROME) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
 		} else {
 			hu->init_speed = qcadev->init_speed;
@@ -612,7 +612,7 @@ static int qca_close(struct hci_uart *hu)
 
 	if (hu->serdev) {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type >= QCA_WCN3990)
 			qca_power_shutdown(hu);
 		else
 			gpiod_set_value_cansleep(qcadev->bt_en, 0);
@@ -996,7 +996,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
 
 	/* Give the controller time to process the request */
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (qcadev->btsoc_type >= QCA_WCN3990)
 		msleep(10);
 	else
 		msleep(300);
@@ -1075,7 +1075,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 	struct qca_serdev *qcadev;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (qcadev->btsoc_type == QCA_WCN3990) {
+	if (qcadev->btsoc_type >= QCA_WCN3990) {
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1107,7 +1107,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 * changing the baudrate of chip and host.
 		 */
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type >= QCA_WCN3990)
 			hci_uart_set_flow_control(hu, true);
 
 		qca_baudrate = qca_get_baudrate_value(speed);
@@ -1119,7 +1119,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type >= QCA_WCN3990)
 			hci_uart_set_flow_control(hu, false);
 	}
 
@@ -1194,7 +1194,7 @@ static int qca_setup(struct hci_uart *hu)
 	/* Patch downloading has to be done without IBS mode */
 	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 
-	if (qcadev->btsoc_type == QCA_WCN3990) {
+	if (qcadev->btsoc_type >= QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
 
 		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
@@ -1225,7 +1225,7 @@ static int qca_setup(struct hci_uart *hu)
 		qca_baudrate = qca_get_baudrate_value(speed);
 	}
 
-	if (qcadev->btsoc_type != QCA_WCN3990) {
+	if (qcadev->btsoc_type == QCA_ROME) {
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &soc_ver);
 		if (ret)
@@ -1250,7 +1250,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup bdaddr */
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (qcadev->btsoc_type >= QCA_WCN3990)
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
@@ -1273,7 +1273,7 @@ static int qca_setup(struct hci_uart *hu)
 	.dequeue	= qca_dequeue,
 };
 
-static const struct qca_vreg_data qca_soc_data = {
+static const struct qca_vreg_data qca_soc_data_wcn3990 = {
 	.soc_type = QCA_WCN3990,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio",   1800000, 1900000,  15000  },
@@ -1284,6 +1284,17 @@ static int qca_setup(struct hci_uart *hu)
 	.num_vregs = 4,
 };
 
+static const struct qca_vreg_data qca_soc_data_wcn3998 = {
+	.soc_type = QCA_WCN3998,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio",   1800000, 1900000,  10000  },
+		{ "vddxo",   1800000, 1900000,  80000  },
+		{ "vddrf",   1300000, 1352000,  300000 },
+		{ "vddch0",  3300000, 3300000,  450000 },
+	},
+	.num_vregs = 4,
+};
+
 static void qca_power_shutdown(struct hci_uart *hu)
 {
 	struct qca_data *qca = hu->priv;
@@ -1417,8 +1428,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	qcadev->serdev_hu.serdev = serdev;
 	data = of_device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
-	if (data && data->soc_type == QCA_WCN3990) {
-		qcadev->btsoc_type = QCA_WCN3990;
+	if (data && data->soc_type >= QCA_WCN3990) {
+		qcadev->btsoc_type = data->soc_type;
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -1482,7 +1493,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (qcadev->btsoc_type >= QCA_WCN3990)
 		qca_power_shutdown(&qcadev->serdev_hu);
 	else
 		clk_disable_unprepare(qcadev->susclk);
@@ -1492,7 +1503,8 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 
 static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
-	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data},
+	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
+	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

