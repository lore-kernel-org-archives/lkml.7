Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168FF208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354922;
	bh=6hPBnO6cyInfrI7QPc5HYLgV1DJSGN4IqdU+EtM4yrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9uHkth7SWc1Y1KyTxamo8DbVbExIzO+AsDdXxXfC67l/Smf0dXCJ6nLI9QIiydz9
	 iD2E2jSU7dzrHAI5DPa+zmuOl10h7VKtv8Q8buG/cqU7KuxgEUAuhHpkAJBc5UkX8/
	 ARcJ8lY8G66eww5mTTYIL0eS2lOlf+o0ONc8GRmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfKJDCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfKJCtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB7722573;
        Sun, 10 Nov 2019 02:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354174;
        bh=6hPBnO6cyInfrI7QPc5HYLgV1DJSGN4IqdU+EtM4yrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iP5tP8HLv4SsuUTqhhNrRvtLTPc1t7QJ+e+1TzCpExFnpZNKsuK1nJFJQbBgYlI6g
         nGvwenWRMqTiUVHcP9XEURdYtgkAE9JasNVESs8qBjQXP3FfEcm9ftKSm4UpAT3QA8
         Ou2WqxwF6WI15z2FtfQkZnW91t7Xkzdr7yFDzNIk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 27/66] net: micrel: fix return type of ndo_start_xmit function
Date:   Sat,  9 Nov 2019 21:48:06 -0500
Message-Id: <20191110024846.32598-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 20cb85bc0c5f8..6135d90f368fa 100644
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

