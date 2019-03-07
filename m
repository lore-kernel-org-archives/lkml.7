Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE08620835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SbDsk+98";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oFBS0GUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCGKRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:17:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGKRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:17:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF0FF609D4; Thu,  7 Mar 2019 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551953855;
        bh=5z0OXUGHDdPqXwfCPrD15+Akap4RvFoJCp8G/dhl0RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SbDsk+98qBZlxYlTH4AGluTLOVNsr7+Zqy9+eNgK8uaYPbJG8BMzaHDbmeBZtJuzY
         OdUO4P7KZtFo6pl/x6cm1RUiMrsXZTxH/SjwP81qppfq7T+Vth/xkh9QYxM0hifzhp
         W7nn6/huLb/BFzsgT8K+PS1Z0rZK3PQjGOs2P3fI=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33A9A606DB;
        Thu,  7 Mar 2019 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551953853;
        bh=5z0OXUGHDdPqXwfCPrD15+Akap4RvFoJCp8G/dhl0RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oFBS0GUNzdmGAIAhefZq5a/6qXoVfA3QTwTBBbTZY0h4Tx6iCB4g3UzlN9If/Rdf3
         /v1cdZjJ1hh2UZ6Ky/zRi1vLSMAM+mbiGSqIyGGOoccj4FDjO4ipyy/TzWhTKelXzt
         NjBPciWic3p2FHbPYUXPi5Qq0rYLO/+G6NEjI3l4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33A9A606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Enable the ldisc for ROME for x86 platforms.
Date:   Thu,  7 Mar 2019 15:47:22 +0530
Message-Id: <20190307101722.25871-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using btattach to setup Rome over ldisc we observed a crash
in qca_setup as it will try to access the serdev which is not
available in the ldisc proto. This patch will fix the crash by
support both the ldisc and serdev way in the qca hci_uart driver.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 47 ++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea34b69f..0a5c98d46864 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -963,7 +963,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
-	struct qca_serdev *qcadev;
+	struct qca_serdev *qcadev = NULL;
 	struct sk_buff *skb;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
@@ -985,18 +985,19 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	skb_queue_tail(&qca->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
+	if (hu->serdev)
+		qcadev = serdev_device_get_drvdata(hu->serdev);
 
 	/* Wait for the baudrate change request to be sent */
-
 	while (!skb_queue_empty(&qca->txq))
 		usleep_range(100, 200);
 
-	serdev_device_wait_until_sent(hu->serdev,
-		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+	if (hu->serdev)
+		serdev_device_wait_until_sent(hu->serdev,
+				msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
 
 	/* Give the controller time to process the request */
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (qcadev && qcadev->btsoc_type == QCA_WCN3990)
 		msleep(10);
 	else
 		msleep(300);
@@ -1072,10 +1073,12 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 
 static int qca_check_speeds(struct hci_uart *hu)
 {
-	struct qca_serdev *qcadev;
+	struct qca_serdev *qcadev = NULL;
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (qcadev->btsoc_type == QCA_WCN3990) {
+	if (hu->serdev)
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+
+	if (qcadev && qcadev->btsoc_type == QCA_WCN3990) {
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1091,7 +1094,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
-	struct qca_serdev *qcadev;
+	struct qca_serdev *qcadev = NULL;
 	int ret = 0;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1106,8 +1109,10 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		/* Disable flow control for wcn3990 to deassert RTS while
 		 * changing the baudrate of chip and host.
 		 */
-		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (hu->serdev)
+			qcadev = serdev_device_get_drvdata(hu->serdev);
+
+		if (qcadev && qcadev->btsoc_type == QCA_WCN3990)
 			hci_uart_set_flow_control(hu, true);
 
 		qca_baudrate = qca_get_baudrate_value(speed);
@@ -1119,7 +1124,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev && qcadev->btsoc_type == QCA_WCN3990)
 			hci_uart_set_flow_control(hu, false);
 	}
 
@@ -1181,11 +1186,15 @@ static int qca_setup(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
-	struct qca_serdev *qcadev;
+	struct qca_serdev *qcadev = NULL;
 	int ret;
 	int soc_ver = 0;
+	enum qca_btsoc_type btsoc_type = QCA_ROME;
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
+	if (hu->serdev) {
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		btsoc_type = qcadev->btsoc_type;
+	}
 
 	ret = qca_check_speeds(hu);
 	if (ret)
@@ -1194,7 +1203,7 @@ static int qca_setup(struct hci_uart *hu)
 	/* Patch downloading has to be done without IBS mode */
 	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 
-	if (qcadev->btsoc_type == QCA_WCN3990) {
+	if (qcadev && btsoc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
 
 		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
@@ -1225,7 +1234,7 @@ static int qca_setup(struct hci_uart *hu)
 		qca_baudrate = qca_get_baudrate_value(speed);
 	}
 
-	if (qcadev->btsoc_type != QCA_WCN3990) {
+	if (btsoc_type != QCA_WCN3990) {
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &soc_ver);
 		if (ret)
@@ -1234,7 +1243,7 @@ static int qca_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, soc_ver);
+	ret = qca_uart_setup(hdev, qca_baudrate, btsoc_type, soc_ver);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -1250,7 +1259,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup bdaddr */
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (btsoc_type == QCA_WCN3990)
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

