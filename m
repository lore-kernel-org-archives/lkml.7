Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A41D222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qhGd5MP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLSGw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:52:26 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:53780 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfLSGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:52:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576738345; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=R4pG3Dx1SRgEuA1xuLK7CEXE7WH4oBwCAk7ZxvQgeRc=; b=qhGd5MP8K7AZuFmVHJ/m0Hv0oRyBFRoSfHooUMIoBrtKuN7Nb+llrLcr+mwhLQF3uTIISaiR
 qZwju2uwKyes8HJFdtFf3BFHez9nb2x+gQiwfYNgqiqOS0VeXPQwOcevyK2v0kOScX037C8w
 nZOr+xif7b7EazoDWJyIW/bx/bI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb1e28.7f3277fb8d88-smtp-out-n03;
 Thu, 19 Dec 2019 06:52:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58BC8C55682; Thu, 19 Dec 2019 06:52:23 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 320A5C48B2D;
        Thu, 19 Dec 2019 06:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 320A5C48B2D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Retry btsoc initialize when it fails
Date:   Thu, 19 Dec 2019 14:52:17 +0800
Message-Id: <20191219065217.14122-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the retry of btsoc initialization when it fails. There are
reports that the btsoc initialization may fail on some platforms but the
repro ratio is very low. The failure may be caused by UART, platform HW or
the btsoc itself but it's very difficlut to root cause, given the repro
ratio is very low. Add a retry for the btsoc initialization will resolve
most of the failures and make Bluetooth finally works.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1cb706acdef6..af45b31f1b5f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -53,6 +53,9 @@
 /* Controller debug log header */
 #define QCA_DEBUG_HANDLE	0x2EDC
 
+/* max retry count when init fails */
+#define QCA_MAX_INIT_RETRY_COUNT 3
+
 enum qca_flags {
 	QCA_IBS_ENABLED,
 	QCA_DROP_VENDOR_EVENT,
@@ -1259,6 +1262,7 @@ static int qca_setup(struct hci_uart *hu)
 	struct qca_data *qca = hu->priv;
 	struct qca_serdev *qcadev;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
+	unsigned int init_retry_count = 0;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
@@ -1276,6 +1280,7 @@ static int qca_setup(struct hci_uart *hu)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
+retry:
 	if (qca_is_wcn399x(soc_type)) {
 		bt_dev_info(hdev, "setting up wcn3990");
 
@@ -1341,6 +1346,20 @@ static int qca_setup(struct hci_uart *hu)
 		 * patch/nvm-config is found, so run with original fw/config.
 		 */
 		ret = 0;
+	} else {
+		if (init_retry_count < QCA_MAX_INIT_RETRY_COUNT) {
+			qca_power_off(hdev);
+			if (hu->serdev) {
+				serdev_device_close(hu->serdev);
+				ret = serdev_device_open(hu->serdev);
+				if (ret) {
+					bt_dev_err(hu->hdev, "open port fail");
+					return ret;
+				}
+			}
+			init_retry_count++;
+			goto retry;
+		}
 	}
 
 	/* Setup bdaddr */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
