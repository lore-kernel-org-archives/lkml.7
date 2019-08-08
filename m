Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DFC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A87214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291739;
	bh=P/54bSpCJpUwxgQUnW/OJbhwuoF+50j/V8zB5zTi/SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BqF/wucvg1zioZpAZksxagZHdAHBInmwzvjVNd5ucW/5jLtr1Wsc4t1qadg9CS4b+
	 zC/1DO4zuU/yUqt6xkUgOQK+98CftRAK7eg+FdqxXZzPELVOHDgnUWfNyP7uzaq7Tx
	 npdFtSRP0ziTVJmC8e4y3lA1AJIQE9pqQa94oQnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405322AbfHHTPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404515AbfHHTGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:06:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5917421882;
        Thu,  8 Aug 2019 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291207;
        bh=P/54bSpCJpUwxgQUnW/OJbhwuoF+50j/V8zB5zTi/SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgUbf2AGeSLivJt9yK/omvmAFz1S7xsDHWhatun/nR247jCIBaNL0mrvB4OZf3WA1
         YbOxXulR9EIuMXzZrQFdWV0L2dq16h/xxsnJjI+ru4GpBvSJaHRBMjprSxQWEYv0ZO
         HvjzCKwLhKNB9DjUwEYK8C1U0dLoc3Uq8V+QY0hY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 27/56] net: phy: mscc: initialize stats array
Date:   Thu,  8 Aug 2019 21:04:53 +0200
Message-Id: <20190808190454.020579894@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Schwab <schwab@suse.de>

[ Upstream commit f972037e71246c5e0916eef835174d58ffc517e4 ]

The memory allocated for the stats array may contain arbitrary data.

Fixes: e4f9ba642f0b ("net: phy: mscc: add support for VSC8514 PHY.")
Fixes: 00d70d8e0e78 ("net: phy: mscc: add support for VSC8574 PHY")
Fixes: a5afc1678044 ("net: phy: mscc: add support for VSC8584 PHY")
Fixes: f76178dc5218 ("net: phy: mscc: add ethtool statistics counters")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mscc.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -2226,8 +2226,8 @@ static int vsc8514_probe(struct phy_devi
 	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
 	vsc8531->hw_stats = vsc85xx_hw_stats;
 	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
-	vsc8531->stats = devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
-					    sizeof(u64), GFP_KERNEL);
+	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
+				      sizeof(u64), GFP_KERNEL);
 	if (!vsc8531->stats)
 		return -ENOMEM;
 
@@ -2251,8 +2251,8 @@ static int vsc8574_probe(struct phy_devi
 	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
 	vsc8531->hw_stats = vsc8584_hw_stats;
 	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
-	vsc8531->stats = devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
-					    sizeof(u64), GFP_KERNEL);
+	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
+				      sizeof(u64), GFP_KERNEL);
 	if (!vsc8531->stats)
 		return -ENOMEM;
 
@@ -2281,8 +2281,8 @@ static int vsc8584_probe(struct phy_devi
 	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
 	vsc8531->hw_stats = vsc8584_hw_stats;
 	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
-	vsc8531->stats = devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
-					    sizeof(u64), GFP_KERNEL);
+	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
+				      sizeof(u64), GFP_KERNEL);
 	if (!vsc8531->stats)
 		return -ENOMEM;
 
@@ -2311,8 +2311,8 @@ static int vsc85xx_probe(struct phy_devi
 	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
 	vsc8531->hw_stats = vsc85xx_hw_stats;
 	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
-	vsc8531->stats = devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
-					    sizeof(u64), GFP_KERNEL);
+	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
+				      sizeof(u64), GFP_KERNEL);
 	if (!vsc8531->stats)
 		return -ENOMEM;
 


