Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BABC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FED2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054335;
	bh=Gp1Vmj3iN/kkjOdO44mChH4+YNTQwOMCrfilW1G1DvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQaEDErCbIoH1LRnMF7v+Yd6r4gAjDWM9u3/59DqpYD9IgyVG6WSST9VX6p47MoZV
	 XAt1Turo30+/87wcPghKZWdgGlaYKeUD1b6gpxrEvz98aHZDUE1u5EZcggFR7TYQ09
	 27gpLx8yQuQSHOZdg/0JNO3O55Ymlh6tqDWnq/uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfFTSMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfFTSMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:12:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0851F2070B;
        Thu, 20 Jun 2019 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054327;
        bh=Gp1Vmj3iN/kkjOdO44mChH4+YNTQwOMCrfilW1G1DvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQfKrdyzR6fKmlhILHp9Tyh96wcKqmgHopllDNofDupSm+ZXFfTY88R0vLQJcgO8M
         gYEyfoWxfe8GLwpa6LncpTEc2hd1rNCxl12359/CmwjVwbaU+HkPgghkwPKJFa07zB
         t2+oHqrSXSG93zSrIIbvxxAVQZaFfAFH+HhMG+mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/61] net: phylink: ensure consistent phy interface mode
Date:   Thu, 20 Jun 2019 19:57:47 +0200
Message-Id: <20190620174346.246862470@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index c5a509129ae6..b7dafa9dfef4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -54,6 +54,10 @@ struct phylink {
 
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
+
+	/* The current settings */
+	phy_interface_t cur_interface;
+
 	struct gpio_desc *link_gpio;
 	struct timer_list link_poll;
 	void (*get_fixed_state)(struct net_device *dev,
@@ -477,12 +481,12 @@ static void phylink_resolve(struct work_struct *w)
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



