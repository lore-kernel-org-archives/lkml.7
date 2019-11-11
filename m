Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D179C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B2920674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497954;
	bh=+Vpmt56nQU9q+fWQ80iwQhJ7ao0djqDkThe4tFknWvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sVssp2Luhu9jpGpaPi/6DTQeoUqErqVnvp8Ag3qRmGDd7i4DmvG4DX7X69RRcWb9N
	 oNAzYDOOeR8bezLL6mBTYKi9nzWtoy1Konf6zf77dUg5l7Z0Ew0GDC2nehjpnDiaw/
	 rKINgttp4TL0xSBNZghATT8nJq/vQue1bU/APeUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfKKSpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfKKSpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:45:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA12920674;
        Mon, 11 Nov 2019 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497950;
        bh=+Vpmt56nQU9q+fWQ80iwQhJ7ao0djqDkThe4tFknWvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mstTC3iAPl7ThYOghBhUf56aAyPnNnpmZ3fl5YFYgwo+71xObBYGqTn5lolJwf6IR
         inBWdTN1rtHrgRz1Jyt91k5aVAmjxArpITdYHgKb1cV3jqWTHCCeTkul6WTD3QbNfO
         ZJgIhvjng1Nz1R6pBGSe/mmT+BXY5IWkVDcCRpXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Nicolas Waisman <nico@semmle.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 105/125] fjes: Handle workqueue allocation failure
Date:   Mon, 11 Nov 2019 19:29:04 +0100
Message-Id: <20191111181453.950179740@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit 85ac30fa2e24f628e9f4f9344460f4015d33fd7d ]

In the highly unlikely event that we fail to allocate either of the
"/txrx" or "/control" workqueues, we should bail cleanly rather than
blindly march on with NULL queue pointer(s) installed in the
'fjes_adapter' instance.

Cc: "David S. Miller" <davem@davemloft.net>
Reported-by: Nicolas Waisman <nico@semmle.com>
Link: https://lore.kernel.org/lkml/CADJ_3a8WFrs5NouXNqS5WYe7rebFP+_A5CheeqAyD_p7DFJJcg@mail.gmail.com/
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/fjes/fjes_main.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index d3eae12390457..61a9843346ad7 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1252,8 +1252,17 @@ static int fjes_probe(struct platform_device *plat_dev)
 	adapter->open_guard = false;
 
 	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx", WQ_MEM_RECLAIM, 0);
+	if (unlikely(!adapter->txrx_wq)) {
+		err = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	adapter->control_wq = alloc_workqueue(DRV_NAME "/control",
 					      WQ_MEM_RECLAIM, 0);
+	if (unlikely(!adapter->control_wq)) {
+		err = -ENOMEM;
+		goto err_free_txrx_wq;
+	}
 
 	INIT_WORK(&adapter->tx_stall_task, fjes_tx_stall_task);
 	INIT_WORK(&adapter->raise_intr_rxdata_task,
@@ -1270,7 +1279,7 @@ static int fjes_probe(struct platform_device *plat_dev)
 	hw->hw_res.irq = platform_get_irq(plat_dev, 0);
 	err = fjes_hw_init(&adapter->hw);
 	if (err)
-		goto err_free_netdev;
+		goto err_free_control_wq;
 
 	/* setup MAC address (02:00:00:00:00:[epid])*/
 	netdev->dev_addr[0] = 2;
@@ -1292,6 +1301,10 @@ static int fjes_probe(struct platform_device *plat_dev)
 
 err_hw_exit:
 	fjes_hw_exit(&adapter->hw);
+err_free_control_wq:
+	destroy_workqueue(adapter->control_wq);
+err_free_txrx_wq:
+	destroy_workqueue(adapter->txrx_wq);
 err_free_netdev:
 	free_netdev(netdev);
 err_out:
-- 
2.20.1



