Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3202CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7D3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370665;
	bh=3Rjs0Z1gCt6XyUPp8nVsGXGtVYG/LJUSO9+X8OQdK1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pD0epCp//V+3Z56a4yo08p/yKHaX+DDjf999wNTenFAHz9RpHyr1zJVIF63A2L6Qr
	 ijyyl6qtJTed8XQgbcSazP4BNnFrE/gQRAsLMd5z2aopSQBsjaQgPMuV7PXeo6bvP5
	 7P3s29Dw9Lyf7gTcyPFKSfCZM21nd2PsKPr9R3aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfDDJhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731781AbfDDJEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3875B2177E;
        Thu,  4 Apr 2019 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368685;
        bh=3Rjs0Z1gCt6XyUPp8nVsGXGtVYG/LJUSO9+X8OQdK1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFmoljkx/nmXUzt5ghqMC+Hr/6tAcDaAIpJ/WDMzJ4XmPUi3a4W1dMMsnt+oHooFD
         1LtOFTahDYtYXrIme0d41CB8OZNv53E9OVKklQ5tqjHiQMCtsz3AP7ZmDa+jcic9x6
         8WsOLxqD8jZtQ0T0ceL+6SH4rS3zatkLdvlLKsAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Auhagen <sven.auhagen@voleatech.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 116/187] net: marvell: mvpp2: fix stuck in-band SGMII negotiation
Date:   Thu,  4 Apr 2019 10:47:33 +0200
Message-Id: <20190404084608.727565391@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



