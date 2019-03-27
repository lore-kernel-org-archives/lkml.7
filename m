Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70845C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FECC2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710041;
	bh=/qgWYDLeMFWwL0C5FYRRMoxmwYrH5ceDB/8PKmQ5AHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7oVAk1mQg1bQAYjIDpk8lYUHP44AYu8aLjVQw/faUyIvGluTZYJSBwvCwakBsaYJ
	 Gp5PH0m0GFF+jv4M4Z66WfHSSQkpsqtyeYOScEjsqMqAbL3ekSme22GJAeOc20d563
	 NElIdMsqQWoUBvyx/MyLBZJtCRRF5MTo7Wym+dAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfC0SHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388110AbfC0SHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D44021734;
        Wed, 27 Mar 2019 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710033;
        bh=/qgWYDLeMFWwL0C5FYRRMoxmwYrH5ceDB/8PKmQ5AHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ws3OEMljyowhB7vJEX87gXE8lpd/dxiTe95bLvLthdPBmK5gZPjspKd3i9zL9tj5p
         bnH0u4udfwfGR+xf7+Q1e9Y7w04d8ZAB8HRTDQMcne9PmJHRy6/8WzexZfiVfCxuM8
         FdkavRiA+43nr9/KIaU7orYGPCx/F7lDuoIbONTY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 165/262] net: marvell: mvpp2: fix stuck in-band SGMII negotiation
Date:   Wed, 27 Mar 2019 14:00:20 -0400
Message-Id: <20190327180158.10245-165-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 16066c2d5b3a..931beac3359d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1380,13 +1380,9 @@ static void mvpp2_port_reset(struct mvpp2_port *port)
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
@@ -4543,12 +4539,15 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
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
@@ -4621,6 +4620,12 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
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

