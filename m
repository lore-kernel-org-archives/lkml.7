Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894D4C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59479217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199595;
	bh=c1Hu+BADztoE3TsovwgrW6FVJZ+9nDZP0DHc4V8kDog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LxJCJTwZdg7ukAWTbHXdK63rvVIg5Q+JZ4gX1zz1AYneNUTVKXjnJf3uDnEWKBwye
	 qTGxRParLBTGEYE6zkcDirIVecUDNCf5kjvKizqg31sOkudBt9+KPYm9C4G/c0q4Qd
	 W5GXd1v1UHYeXFcF1CXvBN8ekBrMWHferjnrFz/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfGOOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388249AbfGOOGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:06:19 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D41D2081C;
        Mon, 15 Jul 2019 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199578;
        bh=c1Hu+BADztoE3TsovwgrW6FVJZ+9nDZP0DHc4V8kDog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMu+vG5/vGwQ97ZVuCTKVTfSC7dUYJG9qzA2n3IcLviW7TfcXZuq9yrHfi9ffCrTy
         VdAmx5v/PZVOZMFOp36oOxcpYHpSe6aSPre83HWJphAd+FR+2Hp8dOcgGEBmA2o1e0
         ChivjW7owWb59R+1+T4Phs+Wa6dzV+HPHX56uvGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 047/219] net: phy: Check against net_device being NULL
Date:   Mon, 15 Jul 2019 10:00:48 -0400
Message-Id: <20190715140341.6443-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 82c76aca81187b3d28a6fb3062f6916450ce955e ]

In general, we don't want MAC drivers calling phy_attach_direct with the
net_device being NULL. Add checks against this in all the functions
calling it: phy_attach() and phy_connect_direct().

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f6a6cc5bf118..e748aee82033 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -948,6 +948,9 @@ int phy_connect_direct(struct net_device *dev, struct phy_device *phydev,
 {
 	int rc;
 
+	if (!dev)
+		return -EINVAL;
+
 	rc = phy_attach_direct(dev, phydev, phydev->dev_flags, interface);
 	if (rc)
 		return rc;
@@ -1290,6 +1293,9 @@ struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 	struct device *d;
 	int rc;
 
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
 	/* Search the list of PHY devices on the mdio bus for the
 	 * PHY with the requested name
 	 */
-- 
2.20.1

