Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CFC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4F72085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214703;
	bh=0tFSaKQyGEqGezkRj4bPM4JS9i+QDuEA8486jI4EfWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SivLraXR0HO52bwHOqfhcihHpzkeJhh0g9uAR7OEOSJKTsqMo9rojivis0y07qX9O
	 EYrtDsAklmCW+YewIac2WgpV3G5d0FGwSvwbIA8wEqt3erJSAErBlmcVz6DcXXeJwN
	 3FRSq0klw7EzAWg9NoZ1KfgQdU4w2Vz3c4DEbGiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbfKHMEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389723AbfKHLl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9B1222C4;
        Fri,  8 Nov 2019 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213318;
        bh=0tFSaKQyGEqGezkRj4bPM4JS9i+QDuEA8486jI4EfWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGe9tFSJ0LVyj5tfjMsXXMWdK2jpL+t+zy56ijqnfzwv65caZwm0IEQqT+lu1K0Vb
         hVbI12t3afhhsnJD71PCJVWd7Cba70Nbgdh8LVHlkKujpXAxhcFp4Z/0q5dS+8GBPR
         F+ZugGTcsDnlzkGIXESMdIBERwx8OC+v+Dd4Qz+g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 162/205] net: bcmgenet: Fix speed selection for reverse MII
Date:   Fri,  8 Nov 2019 06:37:09 -0500
Message-Id: <20191108113752.12502-162-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 00eb2243b933a496958f4ce1bcf59840fea8be16 ]

The phy supported speed is being used to determine if the MAC should
be configured to 100 or 1G. The masking logic is broken. Instead, look
at 1G supported speeds to enable 1G MAC support.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 0d527fa5de610..b0592fd4135b3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -226,11 +226,10 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 		 * capabilities, use that knowledge to also configure the
 		 * Reverse MII interface correctly.
 		 */
-		if ((dev->phydev->supported & PHY_BASIC_FEATURES) ==
-				PHY_BASIC_FEATURES)
-			port_ctrl = PORT_MODE_EXT_RVMII_25;
-		else
+		if (dev->phydev->supported & PHY_1000BT_FEATURES)
 			port_ctrl = PORT_MODE_EXT_RVMII_50;
+		else
+			port_ctrl = PORT_MODE_EXT_RVMII_25;
 		bcmgenet_sys_writel(priv, port_ctrl, SYS_PORT_CTRL);
 		break;
 
-- 
2.20.1

