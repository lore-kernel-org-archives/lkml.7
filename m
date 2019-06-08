Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8894CC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56065214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994136;
	bh=dXIw594PFIhA3xlq96cbq226LcjPNYMNiR92xQ62fRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fC9OCGGNuEEGWtAduo8Ds7/OsgfzOYJjUECua02zR+XtH52WNNXFJueoob+heihwV
	 yddjjipcGQcrtE/wr9nvIRrf6gGNZxS3aV9k4NHg5ckc4rs9ZMKg3yBEaD3Dbd8/wZ
	 Rdf+qOofWrjJlAaiYTdL37FzMamv8Vr4OMotF7Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfFHLmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbfFHLmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:42:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65173216C4;
        Sat,  8 Jun 2019 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994131;
        bh=dXIw594PFIhA3xlq96cbq226LcjPNYMNiR92xQ62fRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CECzzfPEeh0+eVQzY7+5CietiYQt9+mf0dPs/Svg3cH4+TTWFYvMpmYepPt0BdUZA
         g1e1n5oDT8lnhoKfhbnd39+MQH8vu2YdaL2LfzebH0BjRiSNfE6tl1jnh29O03vLwL
         7r+W7B5quFt75eBCQ51oQLwQSqgZC+tT9axNqK0M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 61/70] net: phylink: ensure consistent phy interface mode
Date:   Sat,  8 Jun 2019 07:39:40 -0400
Message-Id: <20190608113950.8033-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit c678726305b9425454be7c8a7624290b602602fc ]

Ensure that we supply the same phy interface mode to mac_link_down() as
we did for the corresponding mac_link_up() call.  This ensures that MAC
drivers that use the phy interface mode in these methods can depend on
mac_link_down() always corresponding to a mac_link_up() call for the
same interface mode.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 89750c7dfd6f..efa31fcda505 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -51,6 +51,10 @@ struct phylink {
 
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
+
+	/* The current settings */
+	phy_interface_t cur_interface;
+
 	struct gpio_desc *link_gpio;
 	struct timer_list link_poll;
 	void (*get_fixed_state)(struct net_device *dev,
@@ -453,12 +457,12 @@ static void phylink_resolve(struct work_struct *w)
 		if (!link_state.link) {
 			netif_carrier_off(ndev);
 			pl->ops->mac_link_down(ndev, pl->link_an_mode,
-					       pl->phy_state.interface);
+					       pl->cur_interface);
 			netdev_info(ndev, "Link is Down\n");
 		} else {
+			pl->cur_interface = link_state.interface;
 			pl->ops->mac_link_up(ndev, pl->link_an_mode,
-					     pl->phy_state.interface,
-					     pl->phydev);
+					     pl->cur_interface, pl->phydev);
 
 			netif_carrier_on(ndev);
 
-- 
2.20.1

