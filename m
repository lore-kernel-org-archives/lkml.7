Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61FB2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VWKL6a2T";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FdebKWMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfLLGG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:06:26 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:53044
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfLLGG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576130785;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=N8lPz7LGKz99PpkyJwPNrkIJPiXtzpb3CedHmFguf3s=;
        b=VWKL6a2T2uEnNxSCt3qjvYY0LNx9iw+ZsL8xfBBEdfAH1fZdLuwBuQqcoR4pOCnd
        pUdUbNRhKsLvPR/b0b+wnS2WEZ3bGjSfMEu81vtkclJ5GU+uvRaNeLMR3gUCxA+13Bk
        lQWUcYHfTv++R5TdgPYYVHwCTr3UuSnhkTF4X44g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576130785;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=N8lPz7LGKz99PpkyJwPNrkIJPiXtzpb3CedHmFguf3s=;
        b=FdebKWMzta5WxuLYSmGw9GB99baNjpQNX0f8Y9dlLhJNDFRVj8xMoFx6gVLj6XnB
        2qtRhFnuNuiTZjbgE6oNE1Vt4H8cvvCgzQADieVJKK21JpEyBhNlIjy6CVbGH9SvpfP
        RXWbzeZoWtIzphgmwrqQkf7+9YMDc1YtY4ExM5Y4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 963F3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1 1/2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA6390
Date:   Thu, 12 Dec 2019 06:06:25 +0000
Message-ID: <0101016ef8b72ed7-4ebcb350-78ea-409e-8938-1e42cd40d36f-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.17.1
X-SES-Outgoing: 2019.12.12-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for QCA6390.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/btqca.c   | 32 +++++++++++++++++++++--------
 drivers/bluetooth/btqca.h   |  1 +
 drivers/bluetooth/hci_qca.c | 40 ++++++++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index ec69e5dd7bd3..75990223e5e3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -13,6 +13,8 @@
 #include "btqca.h"
 
 #define VERSION "0.1"
+#define QCA_IS_3991_6390(soc_type)	\
+	((soc_type == QCA_WCN3991) || (soc_type == QCA_QCA6390))
 
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
 			 enum qca_btsoc_type soc_type)
@@ -32,7 +34,7 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
 	 * VSE event. WCN3991 sends version command response as a payload to
 	 * command complete event.
 	 */
-	if (soc_type == QCA_WCN3991) {
+	if (QCA_IS_3991_6390(soc_type)) {
 		event_type = 0;
 		rlen += 1;
 		rtype = EDL_PATCH_VER_REQ_CMD;
@@ -69,7 +71,7 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
 		goto out;
 	}
 
-	if (soc_type == QCA_WCN3991)
+	if ((QCA_IS_3991_6390(soc_type)))
 		memmove(&edl->data, &edl->data[1], sizeof(*ver));
 
 	ver = (struct qca_btsoc_version *)(edl->data);
@@ -139,7 +141,7 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
 static void qca_tlv_check_data(struct qca_fw_config *config,
-				const struct firmware *fw)
+		 const struct firmware *fw, enum qca_btsoc_type soc_type)
 {
 	const u8 *data;
 	u32 type_len;
@@ -148,6 +150,7 @@ static void qca_tlv_check_data(struct qca_fw_config *config,
 	struct tlv_type_hdr *tlv;
 	struct tlv_type_patch *tlv_patch;
 	struct tlv_type_nvm *tlv_nvm;
+	uint8_t nvm_baud_rate = config->user_baud_rate;
 
 	tlv = (struct tlv_type_hdr *)fw->data;
 
@@ -213,10 +216,14 @@ static void qca_tlv_check_data(struct qca_fw_config *config,
 				 * enabling software inband sleep
 				 * onto controller side.
 				 */
-				tlv_nvm->data[0] |= 0x80;
+				if (!QCA_IS_3991_6390(soc_type))
+					tlv_nvm->data[0] |= 0x80;
 
 				/* UART Baud Rate */
-				tlv_nvm->data[2] = config->user_baud_rate;
+				if ((QCA_IS_3991_6390(soc_type)))
+					tlv_nvm->data[1] = nvm_baud_rate;
+				else
+					tlv_nvm->data[2] = nvm_baud_rate;
 
 				break;
 
@@ -264,7 +271,7 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	 * VSE event. WCN3991 sends version command response as a payload to
 	 * command complete event.
 	 */
-	if (soc_type == QCA_WCN3991) {
+	if ((QCA_IS_3991_6390(soc_type))) {
 		event_type = 0;
 		rlen = sizeof(*edl);
 		rtype = EDL_PATCH_TLV_REQ_CMD;
@@ -297,7 +304,7 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 		err = -EIO;
 	}
 
-	if (soc_type == QCA_WCN3991)
+	if ((QCA_IS_3991_6390(soc_type)))
 		goto out;
 
 	tlv_resp = (struct tlv_seg_resp *)(edl->data);
@@ -354,7 +361,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
 		return ret;
 	}
 
-	qca_tlv_check_data(config, fw);
+	qca_tlv_check_data(config, fw, soc_type);
 
 	segment = fw->data;
 	remain = fw->size;
@@ -438,6 +445,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			    (soc_ver & 0x0000000f);
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crbtfw%02x.tlv", rom_ver);
+	} else if (soc_type == QCA_QCA6390) {
+		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
+						(soc_ver & 0x0000000f);
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/htbtfw%02x.tlv", rom_ver);
+
 	} else {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
@@ -460,6 +473,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	else if (qca_is_wcn399x(soc_type))
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crnv%02x.bin", rom_ver);
+	else if (soc_type == QCA_QCA6390)
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/htnv%02x.bin", rom_ver);
 	else
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/nvm_%08x.bin", soc_ver);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index f5795b1a3779..2f06ed7e1c50 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -127,6 +127,7 @@ enum qca_btsoc_type {
 	QCA_WCN3990,
 	QCA_WCN3991,
 	QCA_WCN3998,
+	QCA_QCA6390,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f10bdf8e1fc5..472f468145e8 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -25,6 +25,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
@@ -1355,6 +1356,16 @@ static const struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static const struct qca_vreg_data qca_soc_data_qca6174 = {
+	.soc_type = QCA_ROME,
+	.num_vregs = 0,
+};
+
+static const struct qca_vreg_data qca_soc_data_qca6390 = {
+	.soc_type = QCA_QCA6390,
+	.num_vregs = 0,
+};
+
 static const struct qca_vreg_data qca_soc_data_wcn3990 = {
 	.soc_type = QCA_WCN3990,
 	.vregs = (struct qca_vreg []) {
@@ -1501,7 +1512,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	qcadev->serdev_hu.serdev = serdev;
-	data = of_device_get_match_data(&serdev->dev);
+	data = device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
 	device_property_read_string(&serdev->dev, "firmware-name",
 					 &qcadev->firmware_name);
@@ -1534,7 +1545,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			goto out;
 		}
 	} else {
-		qcadev->btsoc_type = QCA_ROME;
+		if (data)
+			qcadev->btsoc_type = data->soc_type;
+		else
+			qcadev->btsoc_type = QCA_ROME;
 		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
@@ -1670,21 +1684,41 @@ static int __maybe_unused qca_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
 
+#ifdef CONFIG_OF
 static const struct of_device_id qca_bluetooth_of_match[] = {
-	{ .compatible = "qcom,qca6174-bt" },
+	{ .compatible = "qcom,qca6174-bt"  .data = &qca_soc_data_qca6174},
+	{ .compatible = "qcom,qca6390-bt"  .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
+	{ "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ "DLB26390", (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
+#endif
+
 
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
 	.remove = qca_serdev_remove,
 	.driver = {
 		.name = "hci_uart_qca",
+		#ifdef CONFIG_OF
 		.of_match_table = qca_bluetooth_of_match,
+		#endif
+		#ifdef CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
+		#endif
 		.pm = &qca_pm_ops,
 	},
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

