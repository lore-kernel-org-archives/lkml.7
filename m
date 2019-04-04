Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BACC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C005A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369806;
	bh=8yO6qQI9qiLj4V24RjoKB8N2g8LJSVHHH+JuntZkMdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1kXrrewyWynfCGOJUvkKm0GZA1prajZjo1pRFV9N62565/O5fRl+L6d5Xl2KtMm+1
	 w+VP09Ii5iKx8pFh/MJvHhpkjovVc8RIHMZsv6gF1eX7fIpl4RlGGve/0qfzla8D5v
	 b1dQZDmye7xFCUox57NEhC9F70Bl9iZK/qM7/c/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfDDJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387857AbfDDJPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722C6214AF;
        Thu,  4 Apr 2019 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369318;
        bh=8yO6qQI9qiLj4V24RjoKB8N2g8LJSVHHH+JuntZkMdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzpkpcSST/84/uIoqV6SSec85bVmXH6KPTh2qtSroU0+G0EJcKRzpEKolmd1xVgJ5
         SnHn6yF2u2B9LZJHjfrScsnwDZYQflu5g2J4+6tt3pg1R1SVePWJpykrTp+p541s96
         kXek8VI2hU3cr2qiDef5rpwiIf0Wn2tBG3vryUzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Auhagen <sven.auhagen@voleatech.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 155/246] net: marvell: mvpp2: fix stuck in-band SGMII negotiation
Date:   Thu,  4 Apr 2019 10:47:35 +0200
Message-Id: <20190404084624.598251022@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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



