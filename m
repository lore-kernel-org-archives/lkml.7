Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00197C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78D220838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F8/hK09G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfL0HVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:21:38 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:18616 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfL0HVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:21:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577431297; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=A2jsIFXvFMfDyC936Lc79MVOFvFnEYM7lWoKIAdnDVA=; b=F8/hK09GT2LuDISAJUq7LkEilUqgCTcfnef6Mm2uGdwqtK6Y9yvf4y1ro2K+fXpvyiTv7TfE
 CqKPZ3VDZy3JLKZ480MVBQKtq446Wg3ZHbpThpXjpwOi9++T9ghuPW6LiJMbEU230+9L/P2k
 0oA/cM5n6Z/U8J/fke4xJjbw07U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e05b100.7f7ef19de378-smtp-out-n01;
 Fri, 27 Dec 2019 07:21:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C62FC43383; Fri, 27 Dec 2019 07:21:36 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F596C433CB;
        Fri, 27 Dec 2019 07:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F596C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v3 1/4] Bluetooth: hci_qca: Add QCA Rome power off support to the qca_power_off()
Date:   Fri, 27 Dec 2019 15:21:27 +0800
Message-Id: <20191227072130.29431-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191225060317.5258-1-rjliao@codeaurora.org>
References: <20191225060317.5258-1-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need to call the qca_power_off() API to power off Rome, add the
support into it. QCA Rome is using bt_en GPIO for power off, so we just
need to pull down this bt_en GPIO to power off it.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---

Changes in v2: None
Changes in v3: None

 drivers/bluetooth/hci_qca.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b602ed01505b..43fd84028786 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1413,13 +1413,26 @@ static void qca_power_shutdown(struct hci_uart *hu)
 static int qca_power_off(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_serdev *qcadev;
+	enum qca_btsoc_type soc_type = qca_soc_type(hu);
+
+	if (qca_is_wcn399x(soc_type)) {
+		/* Perform pre shutdown command */
+		qca_send_pre_shutdown_cmd(hdev);
+
+		usleep_range(8000, 10000);
 
-	/* Perform pre shutdown command */
-	qca_send_pre_shutdown_cmd(hdev);
+		qca_power_shutdown(hu);
+	} else {
+		if (hu->serdev) {
+			qcadev = serdev_device_get_drvdata(hu->serdev);
+
+			gpiod_set_value_cansleep(qcadev->bt_en, 0);
 
-	usleep_range(8000, 10000);
+			usleep_range(8000, 10000);
+		}
+	}
 
-	qca_power_shutdown(hu);
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
