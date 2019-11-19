Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D74208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142095;
	bh=J7af8Qtw38Ew9P8n51YmBy+yIcLcxX26TQGIZ7m712s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GME+VY5DKLYSr2Gk0aEPmXOf0RTNvUiO9JPTsg2mgpTU78nd+0bA21GfrVNbW4jgb
	 kO97xnfqZU6eMmrAlyNmviRi93IqxH1GpSMj7yMpSBThvaK2Wx/2CfLmswrrRnIeb9
	 7tArWKiQbS4jlTVbw6wjK56eyIPXImMT/b4KXLxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfKSFle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbfKSFlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:41:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A6A208C3;
        Tue, 19 Nov 2019 05:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142091;
        bh=J7af8Qtw38Ew9P8n51YmBy+yIcLcxX26TQGIZ7m712s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjJ0EK9gwlJUtMkzmw5uX8mT/8eo6+qLtceF54muB2Os0KMGomC8caCsilD0d4bqH
         6LHiwPb9ugERFsdpXmKJIRCAWGK1xaBao0J8rV7+Gog50mjR9KdU9QJ7y7FAmAJd9q
         3k81Lcm3PCC6Qupwie4yGjVotMh5hqS0/Y4Gu6WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 384/422] Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing proto races
Date:   Tue, 19 Nov 2019 06:19:41 +0100
Message-Id: <20191119051423.954918516@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

[ Upstream commit 7cf7846d27bfc9731e449857db3eec5e0e9701ba ]

Clearing HCI_UART_PROTO_READY will avoid usage of proto function pointers
before running the proto close function pointer. There is chance of kernel
crash, due to usage of non proto close function pointers after proto close.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_serdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b3c2869..46e20444ba19b 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -368,6 +368,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
 
+	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
-- 
2.20.1



