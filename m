Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB86214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000196;
	bh=U18OzJ2Hs0BwigfMe9oIT1dXdOHAqd0d66RLb7M4YRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lg/R2aJiIicKtr2ZkwGWRCs0d1Edxydar+TM40QqqP1BBrz22NvqwSbXccLtuqH9s
	 b55AE7S57WGANE21EEBa1AYvdMOvH/oX3IH3SjVaBAHyy1BGDZkaCgjOqjG5wVOSxg
	 YPntdAbioEQkKLw3Wnr1Y5mkb9+ETYwcM1R6aElM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfGXU3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388693AbfGXTcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:32:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C935E20659;
        Wed, 24 Jul 2019 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996764;
        bh=U18OzJ2Hs0BwigfMe9oIT1dXdOHAqd0d66RLb7M4YRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGifrLoArhN7tNcPAl0WtJdhXReHPrCh+T9JnWH6yj7dEmGW5krjBhEcsxBvCrVo8
         iFdu6xIwhxNq3S2cFBHoJb7URcyy+qeMH4gLHOXsmxFKOfN/Du7rbtLVWwvHTqMQwk
         xFz95bz3O9X83b3/WUEatBCXXTlb7/h2LA1Zr/ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 206/413] bnxt_en: Disable bus master during PCI shutdown and driver unload.
Date:   Wed, 24 Jul 2019 21:18:17 +0200
Message-Id: <20190724191749.254613245@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c20dc142dd7b2884b8570eeab323bcd4a84294fa ]

Some chips with older firmware can continue to perform DMA read from
context memory even after the memory has been freed.  In the PCI shutdown
method, we need to call pci_disable_device() to shutdown DMA to prevent
this DMA before we put the device into D3hot.  DMA memory request in
D3hot state will generate PCI fatal error.  Similarly, in the driver
remove method, the context memory should only be freed after DMA has
been shutdown for correctness.

Fixes: 98f04cf0f1fc ("bnxt_en: Check context memory requirements from firmware.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f758b2e0591f..b9bc829aa9da 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10262,10 +10262,10 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bnxt_dcb_free(bp);
 	kfree(bp->edev);
 	bp->edev = NULL;
+	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
 	kfree(bp->ctx);
 	bp->ctx = NULL;
-	bnxt_cleanup_pci(bp);
 	bnxt_free_port_stats(bp);
 	free_netdev(dev);
 }
@@ -10859,6 +10859,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 
 	if (system_state == SYSTEM_POWER_OFF) {
 		bnxt_clear_int_mode(bp);
+		pci_disable_device(pdev);
 		pci_wake_from_d3(pdev, bp->wol);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
-- 
2.20.1



