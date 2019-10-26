Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA2CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED992070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096728;
	bh=lNE/iFYTemrJ0U4ih+mPRuo3i1mqFeCu4YAsb3gOBHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TSGK+9mkNlcCKASciQXgXvdmigJ4inEHOFgqarAWVEq99y6OgDdqjZm87fUVPDHeq
	 wANr95NnY9s1QutClhoPqlDaVB5s2Y3sGYGIjJ71k3JdyOI2u4usSOU0IRwoJ9j/i+
	 KbL+XsplelwdfDka1p3WAbIikoIBfq7CV8Hf/glQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfJZNSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfJZNSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:18:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8F8222CD;
        Sat, 26 Oct 2019 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095921;
        bh=lNE/iFYTemrJ0U4ih+mPRuo3i1mqFeCu4YAsb3gOBHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIavvMqho5RPGtKrtlv5U4EWr01h8VxyQtRO+GbVJA/tJnMw7NY0RTwSDk8wYaCiw
         6ZY8koUCBOqmEDg8Ol99xGAw8pKvrYEdfTE+/9QlzKSfrTqqDP9EOWfq8n45bdcymH
         XNou+TDtD3IXZ55PnwkMqHrdmASPbpfCKZOkcAiw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 90/99] net: bcmgenet: don't set phydev->link from MAC
Date:   Sat, 26 Oct 2019 09:15:51 -0400
Message-Id: <20191026131600.2507-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 7de48402faa32298c3551ea32c76ccb4f9d3025d ]

When commit 28b2e0d2cd13 ("net: phy: remove parameter new_link from
phy_mac_interrupt()") removed the new_link parameter it set the
phydev->link state from the MAC before invoking phy_mac_interrupt().

However, once commit 88d6272acaaa ("net: phy: avoid unneeded MDIO
reads in genphy_read_status") was added this initialization prevents
the proper determination of the connection parameters by the function
genphy_read_status().

This commit removes that initialization to restore the proper
functionality.

Fixes: 88d6272acaaa ("net: phy: avoid unneeded MDIO reads in genphy_read_status")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b22196880d6d3..f7359d2271dfa 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2617,10 +2617,8 @@ static void bcmgenet_irq_task(struct work_struct *work)
 	spin_unlock_irq(&priv->lock);
 
 	/* Link UP/DOWN event */
-	if (status & UMAC_IRQ_LINK_EVENT) {
-		priv->dev->phydev->link = !!(status & UMAC_IRQ_LINK_UP);
+	if (status & UMAC_IRQ_LINK_EVENT)
 		phy_mac_interrupt(priv->dev->phydev);
-	}
 }
 
 /* bcmgenet_isr1: handle Rx and Tx priority queues */
-- 
2.20.1

