Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6647CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7DB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cCke353T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lqFL9USf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfDAJtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:49:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDAJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:49:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A2B161B99; Mon,  1 Apr 2019 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554112164;
        bh=VG3TqCxnl22+Ls83Eg0BsM79wjR3v/RdDX0Zthgp6pQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cCke353Trlq+wRsFl7mgkDdb97SZFfNz31kV3velgd5onDKm37afgO4aij0H7NMAh
         MY24CdGVGs8onscetkwGdCVgIVqgicwvNnNkZ1NkpP3XijT9l54BgvO6adEGRDCKSH
         sip5lXurqTUkaA8swSbwAECFozNuj5xGQKk0L40o=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6E4A61B89;
        Mon,  1 Apr 2019 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554112162;
        bh=VG3TqCxnl22+Ls83Eg0BsM79wjR3v/RdDX0Zthgp6pQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lqFL9USfwO3J62/FlGCjo8qtQ9Sr8xFfcXNEgATbkokbtq+pXDBtrxnkKBfkRHsSd
         lTF5yAiAI93+eYyjll7CC4nUY+hQyGQiDJhC3L00OZP5lCAerbWolgmmrUPFtuZ6Mi
         LfwHKSpWTgYEcCA4QzknVggfQMfOuyxzJylci0H8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6E4A61B89
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Give enough time to ROME controller to bootup.
Date:   Mon,  1 Apr 2019 15:19:08 +0530
Message-Id: <20190401094908.11460-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables enough time to ROME controller to bootup
after we bring the enable pin out of reset.

Fixes: 05ba533c5c11 ("Bluetooth: hci_qca: Add serdev support").
Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Claire Chang <tientzu@chromium.org>
---
Changes in v2:
  * added fixes tag in the commit text.
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4ea995d610d2..a80c3bc90904 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -523,6 +523,8 @@ static int qca_open(struct hci_uart *hu)
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->btsoc_type != QCA_WCN3990) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(150);
 		} else {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

