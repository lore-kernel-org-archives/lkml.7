Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C8DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EFE20656
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418945;
	bh=UTXw+8OAS8XcJ+yXQiEfH5etCMRkA8k0yFtoVe6scbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZhDwmYqlln+9zBn6m0bNnY2kDeq2bUAnd6dq7QM3XjvFGvQQP/WXwxPA60KIBppWg
	 I6PbnOkfZTnsiZ56kicx9LlmG1378/zElGIv+FtaoBPUyvUTBDS/XujWfCPuv8KXFE
	 NemPkF26nltdT2mfmaNK39kxISwXjFldoD12ZPas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKVKfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfKVKfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:35:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A8B20715;
        Fri, 22 Nov 2019 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418938;
        bh=UTXw+8OAS8XcJ+yXQiEfH5etCMRkA8k0yFtoVe6scbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdZs7FZB71kKxRfHX2cemIq9gvhy8JmjTxBHJ6F8oF010y1QWP24o5jB3bxw36fnA
         KZ8/SOsvPhFmCBsfOLDKz2TqA0aCQBWdIdtLnJtFonWz8mRSzKeYeaIasE45UCqzId
         hEO612iBMsjJ8ZhqR+MHEGuLNR3A8GBemIFcXTps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 076/159] net: micrel: fix return type of ndo_start_xmit function
Date:   Fri, 22 Nov 2019 11:27:47 +0100
Message-Id: <20191122100759.515021823@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 2b49117a5abee8478b0470cba46ac74f93b4a479 ]

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8695net.c  | 2 +-
 drivers/net/ethernet/micrel/ks8851_mll.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8695net.c b/drivers/net/ethernet/micrel/ks8695net.c
index a8522d8af95d3..2126286b72e9b 100644
--- a/drivers/net/ethernet/micrel/ks8695net.c
+++ b/drivers/net/ethernet/micrel/ks8695net.c
@@ -1156,7 +1156,7 @@ ks8695_timeout(struct net_device *ndev)
  *	sk_buff and adds it to the TX ring. It then kicks the TX DMA
  *	engine to ensure transmission begins.
  */
-static int
+static netdev_tx_t
 ks8695_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ks8695_priv *ksp = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
index 2fc5cd56c0a84..8dc1f0277117d 100644
--- a/drivers/net/ethernet/micrel/ks8851_mll.c
+++ b/drivers/net/ethernet/micrel/ks8851_mll.c
@@ -1020,9 +1020,9 @@ static void ks_write_qmu(struct ks_net *ks, u8 *pdata, u16 len)
  * spin_lock_irqsave is required because tx and rx should be mutual exclusive.
  * So while tx is in-progress, prevent IRQ interrupt from happenning.
  */
-static int ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	int retv = NETDEV_TX_OK;
+	netdev_tx_t retv = NETDEV_TX_OK;
 	struct ks_net *ks = netdev_priv(netdev);
 
 	disable_irq(netdev->irq);
-- 
2.20.1



