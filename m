Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C6C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8103D2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rBR07x2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgAHJIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:08:20 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:28994 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgAHJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:08:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578474499; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=BFIPpzWLV+ORFCb6TZ1UTOA+guIOtfqxUcT4bN/vL7k=; b=rBR07x2KBc/iVfnUyWr1XLO20OnEofX+km2OdQF+kYmOynR7S6N3wTCNXd0QnGQ1f5f7U4it
 yKm96bk+uv2K51iTLjknenugSWe1sxlUR32+A7frgO/5MpEI4kwiHY96Nw+IcjDom3XQnhzX
 UIYgdlEPOdHmzC95gQG0doJ/ye4=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e159bff.7faefb09fb20-smtp-out-n02;
 Wed, 08 Jan 2020 09:08:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB125C433CB; Wed,  8 Jan 2020 09:08:15 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D986C43383;
        Wed,  8 Jan 2020 09:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D986C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v2 2/3] Bluetooth: hci_qca: Move the power on from open() to setup() for QCA Rome
Date:   Wed,  8 Jan 2020 17:08:03 +0800
Message-Id: <20200108090804.22889-2-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108090804.22889-1-rjliao@codeaurora.org>
References: <20200107052601.32216-1-rjliao@codeaurora.org>
 <20200108090804.22889-1-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the btsoc power on from hdev->open() to hdev->setup() for
QCA Rome. And it calls the unified qca_power_on() API to perform the Rome
power on operation.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---

Changes in v2: Added this patch

 drivers/bluetooth/hci_qca.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f6555bd1adbc..8fc8c9bce9ee 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -582,13 +582,8 @@ static int qca_open(struct hci_uart *hu)
 	hu->priv = qca;
 
 	if (hu->serdev) {
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (!qca_is_wcn399x(qcadev->btsoc_type)) {
-			gpiod_set_value_cansleep(qcadev->bt_en, 1);
-			/* Controller needs time to bootup. */
-			msleep(150);
-		} else {
+		if (qca_is_wcn399x(qcadev->btsoc_type)) {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
 			ret = qca_regulator_enable(qcadev);
@@ -1593,6 +1588,9 @@ static int qca_setup(struct hci_uart *hu)
 			return ret;
 	} else {
 		bt_dev_info(hdev, "ROME setup");
+		ret = qca_power_on(hdev);
+		if (ret)
+			return ret;
 		qca_set_speed(hu, QCA_INIT_SPEED);
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
