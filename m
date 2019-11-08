Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF9FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4A42067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239809;
	bh=OLx9Vi9JjlRltzTIwfiJ5OeN9fc4fgj5NJrc/CXMSwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOLQHbftkx5Q4Lhe5+HKZSWlw67nze3V8wGobK5Yj7ZrXYEQtYV5ZlguGFaFqBAeO
	 Wch6IgLFH9FlkBdRcNiXNxXXvxzpbpmCV5wZ/2qHm85t/EhrwjRe6UOI+naMC6vfjP
	 gyykHuxk+cJRPOANMl0vsNrsxUZDZL7Na6ijUlyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbfKHTD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbfKHTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:03:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77DE2067B;
        Fri,  8 Nov 2019 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239802;
        bh=OLx9Vi9JjlRltzTIwfiJ5OeN9fc4fgj5NJrc/CXMSwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRowG7UhteBS+eaZ7NgHZdcS8vNYWR/+MSCPKv3zv9XYBTDRLGeTLLZ60bKfTrzzF
         cG8Ook/I8rwqgOAabvdewPK94Zjs+9wLWgNmOWsTi6CdsGAwrjb1t/+SGFqe/Nl6X6
         InrBTxhQcltrG8zEARHHStREsOB95JvBMsqF4dq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 65/79] net: bcmgenet: dont set phydev->link from MAC
Date:   Fri,  8 Nov 2019 19:50:45 +0100
Message-Id: <20191108174822.160399490@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2619,10 +2619,8 @@ static void bcmgenet_irq_task(struct wor
 	spin_unlock_irq(&priv->lock);
 
 	/* Link UP/DOWN event */
-	if (status & UMAC_IRQ_LINK_EVENT) {
-		priv->dev->phydev->link = !!(status & UMAC_IRQ_LINK_UP);
+	if (status & UMAC_IRQ_LINK_EVENT)
 		phy_mac_interrupt(priv->dev->phydev);
-	}
 }
 
 /* bcmgenet_isr1: handle Rx and Tx priority queues */


