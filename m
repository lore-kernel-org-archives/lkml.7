Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07028C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7D8208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469132;
	bh=XzeXVLEiVV+6ZXkzXguDixDLVdYui6R86Ji2rsrfGw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rjvQBVnOf9eOjnfR0vKeXrP51G7oDZSU2+e0yonC/bzdwZTVikByUnx6uD0ScHyPa
	 9teWNjKP8OspAnFG7kJO6+mWW5SwCKappcia0KWL1Ojb2bLkZNFtmQCfSqR520W2tj
	 HjH+jCQR9l50PogGcP5k5jX1ps/SpuCGj+G15v4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfL0RwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfL0RnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261B424125;
        Fri, 27 Dec 2019 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468594;
        bh=XzeXVLEiVV+6ZXkzXguDixDLVdYui6R86Ji2rsrfGw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VEsK/zavn6kF3mwz/Ucs3UcRXZonqWguFn6cMMNEufr0+F+H7m/3Unoxg9Z5crvg
         T70gxPGvsCVIyMrtZP06dRxME1TZfJx2b3CyL1uILVI3DNLnRQKNaupjTsMIJpq3QC
         MRBSvIh2AHji9+Tt1O+4S8AjIHDJpYKlQAnMfMQU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 116/187] net: phylink: fix interface passed to mac_link_up
Date:   Fri, 27 Dec 2019 12:39:44 -0500
Message-Id: <20191227174055.4923-116-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 9b2079c046a9d6c9c73a4ec33816678565ee01f3 ]

A mismerge between the following two commits:

c678726305b9 ("net: phylink: ensure consistent phy interface mode")
27755ff88c0e ("net: phylink: Add phylink_mac_link_{up, down} wrapper functions")

resulted in the wrong interface being passed to the mac_link_up()
function. Fix this up.

Fixes: b4b12b0d2f02 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 536236fdb232..bf5bbb565cf5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -444,8 +444,7 @@ static void phylink_mac_link_up(struct phylink *pl,
 
 	pl->cur_interface = link_state.interface;
 	pl->ops->mac_link_up(pl->config, pl->link_an_mode,
-			     pl->phy_state.interface,
-			     pl->phydev);
+			     pl->cur_interface, pl->phydev);
 
 	if (ndev)
 		netif_carrier_on(ndev);
-- 
2.20.1

