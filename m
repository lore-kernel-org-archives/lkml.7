Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5690D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713314;
	bh=K6D8LcRubxmDeT7CNye2dAHuKMxpQRe/dJEaP8VKITg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0qhqc1O+IqHwThFCHvvFgPOMKevo2J6xoU5zusV5Q1c0C1TLDIWV+cnw1D/TZEt4u
	 vOxN9f6tLqr65x9CZCiPv4o2jyHqdA4HHE/As/U7jMTdSDfz2U0FOvYp6IpoYEgawm
	 glr/D7ZYJzAAV1ldhzglnXsSkDZrQNH9qS9eeIaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbfC0SOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389200AbfC0SN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61922054F;
        Wed, 27 Mar 2019 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710437;
        bh=K6D8LcRubxmDeT7CNye2dAHuKMxpQRe/dJEaP8VKITg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4+VGe/K2LaUOv1OfFE0arDajbOZkRFUTQKT+FtFngwjR6aPN3VyGyk3LqrETN0qL
         vuDYu0I2VMm8bMJHXQKn31PBFJY2fVafU73A7T62EtCjKFJ9VvgDcrQk5/c8bibNAs
         HtzknN5jypSVnz9GHexE3oqYrfmpG/yGoEhq0nuo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 118/192] net: marvell: mvpp2: fix stuck in-band SGMII negotiation
Date:   Wed, 27 Mar 2019 14:09:10 -0400
Message-Id: <20190327181025.13507-118-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 316734fdcf70900a83065360cff11a5826919067 ]

It appears that the mvpp22 can get stuck with SGMII negotiation.  The
symptoms are that in-band negotiation never completes and the partner
(eg, PHY) never reports SGMII link up, or if it supports negotiation
bypass, goes into negotiation bypass mode (which will happen when the
PHY sees that the MAC is alive but gets no response.)

Triggering the PHY end of the link to re-negotiate results in the
bypass bit clearing on the PHY, and then re-setting - indicating that
the problem is at the mvpp22 GMAC end.

Asserting the GMAC reset and de-asserting it resolves the issue.
Arrange to assert the GMAC reset at probe time, and deassert it only
after we have configured the GMAC for the appropriate mode.  This
resolves the issue.

Tested-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f8e4808a8317..9988c89ed9fd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1372,13 +1372,9 @@ static void mvpp2_port_reset(struct mvpp2_port *port)
 	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_regs); i++)
 		mvpp2_read_count(port, &mvpp2_ethtool_regs[i]);
 
-	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG) &
-		    ~MVPP2_GMAC_PORT_RESET_MASK;
+	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG) |
+	      MVPP2_GMAC_PORT_RESET_MASK;
 	writel(val, port->base + MVPP2_GMAC_CTRL_2_REG);
-
-	while (readl(port->base + MVPP2_GMAC_CTRL_2_REG) &
-	       MVPP2_GMAC_PORT_RESET_MASK)
-		continue;
 }
 
 /* Change maximum receive size of the port */
@@ -4445,12 +4441,15 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 			      const struct phylink_link_state *state)
 {
 	u32 an, ctrl0, ctrl2, ctrl4;
+	u32 old_ctrl2;
 
 	an = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
 	ctrl0 = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
 	ctrl2 = readl(port->base + MVPP2_GMAC_CTRL_2_REG);
 	ctrl4 = readl(port->base + MVPP22_GMAC_CTRL_4_REG);
 
+	old_ctrl2 = ctrl2;
+
 	/* Force link down */
 	an &= ~MVPP2_GMAC_FORCE_LINK_PASS;
 	an |= MVPP2_GMAC_FORCE_LINK_DOWN;
@@ -4523,6 +4522,12 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 	writel(ctrl2, port->base + MVPP2_GMAC_CTRL_2_REG);
 	writel(ctrl4, port->base + MVPP22_GMAC_CTRL_4_REG);
 	writel(an, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+
+	if (old_ctrl2 & MVPP2_GMAC_PORT_RESET_MASK) {
+		while (readl(port->base + MVPP2_GMAC_CTRL_2_REG) &
+		       MVPP2_GMAC_PORT_RESET_MASK)
+			continue;
+	}
 }
 
 static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
-- 
2.19.1

