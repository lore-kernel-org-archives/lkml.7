Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A9C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7BD259C1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191290;
	bh=bh69YsHtzTJbjKtJ69s0EM3tDRjqnXOmqDjMzuLdUnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YroduC1pouASpD82hiGmYaatIR2MIrtPRaHzGjWVWV3j3X1rYULJ+OltHApKBMcA5
	 KQePCMPGRPPWNC/9VIhU3I5hEkH7Qni+9zvHWY+DKMnaz+/weyV6RVS9MED1/qDT3C
	 YLoeEXAK8oxM/5xIkHPZAHwnqIYzrcZ8EOkizLRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfE3DMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfE3DKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:54 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DD4244BB;
        Thu, 30 May 2019 03:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185853;
        bh=bh69YsHtzTJbjKtJ69s0EM3tDRjqnXOmqDjMzuLdUnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgGMGK0BXYB+6g4KoRWGemCOQhQCAief+lJZglUJURJeF3vvG5HTZ/1XXwtlbE072
         Fd7Qo4KqDwF5Arzf9TcCUScWVgNzPsjCW7KtHSUCN2tTo47OFMhKiJ/BAakWOGSByL
         ZsUGH4fVNvu0uQ+WhcvE+5Q6ZtQXqi1N7QeXpKws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Claire Chang <tientzu@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 143/405] Bluetooth: hci_qca: Give enough time to ROME controller to bootup.
Date:   Wed, 29 May 2019 20:02:21 -0700
Message-Id: <20190530030548.365186139@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7f09d5a6c33be66a5ca19bf9dd1c2d90c5dfcf0d ]

This patch enables enough time to ROME controller to bootup
after we bring the enable pin out of reset.

Fixes: 05ba533c5c11 ("Bluetooth: hci_qca: Add serdev support").
Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Claire Chang <tientzu@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 340c3c750b180..d3b467792eb3d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->btsoc_type != QCA_WCN3990) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(150);
 		} else {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
-- 
2.20.1



