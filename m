Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A94AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F92073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014185;
	bh=M0d+gOqWSOd0I8oIkrNJWdjHyP0Kdwz5xGK+Eo5egks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUue7fKxSj3Jh1a8AEYI0hcFMhP0gWsM7V4n+GB7l8UX0uJpOHtllGj4DTcyoM1RV
	 KnD5dHI75ZOD/k+s23f9VGTzIBDj2VLqfXTebAsjyphf7yGTEL33EvIpjO9ygxa7ri
	 0MuNF6fe2ZB9y7aPIbSYreggVbMYX3exwX349y04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLJVnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfLJVdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDCD2465B;
        Tue, 10 Dec 2019 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013626;
        bh=M0d+gOqWSOd0I8oIkrNJWdjHyP0Kdwz5xGK+Eo5egks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzmL8pSJBLVmR+G1BRIoNDvIZIK/W1fVO0xGwn+Twgs0dRkqV3RM965JEtIZ8lnkH
         Tb6S6rbpW/gpzxOFvziuO6y+dBvumV6ecCoSHNhqBRIifl+KjFv7b5TDJFNn2KptvN
         gkt6pTRMThkGF3fb03zVhBY8OUh3nrJQ2wr5rdKM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 068/177] Bluetooth: hci_bcm: Fix RTS handling during startup
Date:   Tue, 10 Dec 2019 16:30:32 -0500
Message-Id: <20191210213221.11921-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 3347a80965b38f096b1d6f995c00c9c9e53d4b8b ]

The RPi 4 uses the hardware handshake lines for CYW43455, but the chip
doesn't react to HCI requests during DT probe. The reason is the inproper
handling of the RTS line during startup. According to the startup
signaling sequence in the CYW43455 datasheet, the hosts RTS line must
be driven after BT_REG_ON and BT_HOST_WAKE.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 59e5fc5eec8f8..b88cb7bf7f8ab 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -414,9 +414,11 @@ static int bcm_open(struct hci_uart *hu)
 
 out:
 	if (bcm->dev) {
+		hci_uart_set_flow_control(hu, true);
 		hu->init_speed = bcm->dev->init_speed;
 		hu->oper_speed = bcm->dev->oper_speed;
 		err = bcm_gpio_set_power(bcm->dev, true);
+		hci_uart_set_flow_control(hu, false);
 		if (err)
 			goto err_unset_hu;
 	}
-- 
2.20.1

