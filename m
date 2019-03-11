Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6660FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyBS3S//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCKSir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:38:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34965 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKSir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:38:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id e17so4707230pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u01bYJ/l9Az44AOBm/0TnoM+YfKDb2HHRe9QKjsfY44=;
        b=XyBS3S//z9BxOC7Jt8Tg5Qu6SNasXCzvgNJeIOmpAxhtHau/oUIhFFv+TJqpI+eIU6
         t+fetguqtlPzp716YTZvtcPoI98qsY4JIWFxeX9lNWCm+DPi1Ufnr5+e2LctAxRmcUmy
         4/+EbQHoF8S1c+erw0ozgHvoq51bDE8quPu7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u01bYJ/l9Az44AOBm/0TnoM+YfKDb2HHRe9QKjsfY44=;
        b=UMvs2D9ezyEKEFH+R3B+2oz7f6y6NAGAv1djFJcFzHb7g6a/EvjpLrCmFBKYr2W0Rv
         daUT7QbCU0yhFFCMyDcUJE4ABhKyZHRhQhqqiOfmQuQTgXUIGKvRBCVfVPGokMbZA6ND
         ebhSPG2oMm+9NJhuhORGookyNzOH4xGu2Vxd/rbVFmgmJQ/7NhHEaSNPgHjPm2EdnQPX
         YaeOeElCDJfXXImSqMV6BZxwhvGFeLyOmncmk68OJo3pOpJ0KmE5fwZvQ8sznsRJ6M8v
         NDsesSV1ZHv8U1VbKNOABM0iXGJsCTeGPqHVXDpGFnFBdIn/hTZWHmC1LjAFkLiAHW3U
         8D6w==
X-Gm-Message-State: APjAAAUqwLXdCFxqt/J6ZTrr5bL7gEOGk3O7vhLof2lM1TZ3xKNC2lml
        eyqZ2/ZawD8Ehgp9vCMVkfKEWQ==
X-Google-Smtp-Source: APXvYqxzb0T+I55JohejGXhAu4ebNG4pR5Nh68aKCuo1nB7MUfud5suiKaoanMFy+yKS7BmNNNIHww==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr31247311pgi.318.1552329526045;
        Mon, 11 Mar 2019 11:38:46 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u8sm8196388pgp.48.2019.03.11.11.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 11:38:45 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Add helper function to get the chip family
Date:   Mon, 11 Mar 2019 11:38:31 -0700
Message-Id: <20190311183831.174391-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many functions obtain a 'struct qca_serdev' only to read the btsoc_type
field. Add a helper function that encapsulates this.

This also fixes crashes observed on platforms with ROME controllers
that are instantiated through ldisc and not as serdev clients. The
crashes are caused by NULL pointer dereferentiations, which stem from
the driver's assumption that a QCA HCI device is always associated with
a serdev device.

Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- make ROME the default type for non-serdev platforms
---
 drivers/bluetooth/hci_qca.c | 45 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea34b69f..4ea995d610d2 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -174,6 +174,21 @@ static int qca_power_setup(struct hci_uart *hu, bool on);
 static void qca_power_shutdown(struct hci_uart *hu);
 static int qca_power_off(struct hci_dev *hdev);
 
+static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
+{
+	enum qca_btsoc_type soc_type;
+
+	if (hu->serdev) {
+		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
+
+		soc_type = qsd->btsoc_type;
+	} else {
+		soc_type = QCA_ROME;
+	}
+
+	return soc_type;
+}
+
 static void __serial_clock_on(struct tty_struct *tty)
 {
 	/* TODO: Some chipset requires to enable UART clock on client
@@ -963,7 +978,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
-	struct qca_serdev *qcadev;
 	struct sk_buff *skb;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
@@ -985,8 +999,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	skb_queue_tail(&qca->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-
 	/* Wait for the baudrate change request to be sent */
 
 	while (!skb_queue_empty(&qca->txq))
@@ -996,7 +1008,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
 
 	/* Give the controller time to process the request */
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (qca_soc_type(hu) == QCA_WCN3990)
 		msleep(10);
 	else
 		msleep(300);
@@ -1072,10 +1084,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 
 static int qca_check_speeds(struct hci_uart *hu)
 {
-	struct qca_serdev *qcadev;
-
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (qcadev->btsoc_type == QCA_WCN3990) {
+	if (qca_soc_type(hu) == QCA_WCN3990) {
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1091,7 +1100,6 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
-	struct qca_serdev *qcadev;
 	int ret = 0;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1099,6 +1107,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		if (speed)
 			host_set_baudrate(hu, speed);
 	} else {
+		enum qca_btsoc_type soc_type = qca_soc_type(hu);
+
 		speed = qca_get_speed(hu, QCA_OPER_SPEED);
 		if (!speed)
 			return 0;
@@ -1106,8 +1116,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		/* Disable flow control for wcn3990 to deassert RTS while
 		 * changing the baudrate of chip and host.
 		 */
-		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (soc_type == QCA_WCN3990)
 			hci_uart_set_flow_control(hu, true);
 
 		qca_baudrate = qca_get_baudrate_value(speed);
@@ -1119,7 +1128,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (soc_type == QCA_WCN3990)
 			hci_uart_set_flow_control(hu, false);
 	}
 
@@ -1181,12 +1190,10 @@ static int qca_setup(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
-	struct qca_serdev *qcadev;
+	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	int ret;
 	int soc_ver = 0;
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-
 	ret = qca_check_speeds(hu);
 	if (ret)
 		return ret;
@@ -1194,7 +1201,7 @@ static int qca_setup(struct hci_uart *hu)
 	/* Patch downloading has to be done without IBS mode */
 	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 
-	if (qcadev->btsoc_type == QCA_WCN3990) {
+	if (soc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
 
 		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
@@ -1225,7 +1232,7 @@ static int qca_setup(struct hci_uart *hu)
 		qca_baudrate = qca_get_baudrate_value(speed);
 	}
 
-	if (qcadev->btsoc_type != QCA_WCN3990) {
+	if (soc_type != QCA_WCN3990) {
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &soc_ver);
 		if (ret)
@@ -1234,7 +1241,7 @@ static int qca_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, soc_ver);
+	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -1250,7 +1257,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup bdaddr */
-	if (qcadev->btsoc_type == QCA_WCN3990)
+	if (soc_type == QCA_WCN3990)
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
-- 
2.21.0.360.g471c308f928-goog

