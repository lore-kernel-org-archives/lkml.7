Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E452C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6682321537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994686;
	bh=0QwXuQ75X/2IA+zk5qsZhE6ic87AMwqT5NCP3EV3mNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MomV7eMZ4Mma2/Z2kEQErHM5BSE2PQIpQMqd5q3CxMI1slS7Dj2C0gNDjTVGkEPeM
	 ekeD7pOhybawLclmngFUOEnu/PMWnQItTAklDnpYgRO88X4abZfGwIrZgaGE9e4Ju8
	 hxw3RQnRc6KtFYHhUS4KT80SvfFdag3YJyiALvp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfFHLvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfFHLrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:47:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B0B8216F4;
        Sat,  8 Jun 2019 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994465;
        bh=0QwXuQ75X/2IA+zk5qsZhE6ic87AMwqT5NCP3EV3mNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oApm50yiSQU4CNvxB7rXzoXDczU+bIEpSVZ2pwPCiuojrIPzYrYf+3JCk/vh7VtCi
         klvF496m9n4UF1L0bIG+o393ANItR6uNCmQtuzIe7JaVcQCGZLzLat5O7fkDMyNrVe
         ojG6ZITVCmBRsVA86dSivKchm/cR4Z7IuwiFSJGQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Uvarov <muvarov@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 26/31] net: phy: dp83867: Set up RGMII TX delay
Date:   Sat,  8 Jun 2019 07:46:37 -0400
Message-Id: <20190608114646.9415-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114646.9415-1-sashal@kernel.org>
References: <20190608114646.9415-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Uvarov <muvarov@gmail.com>

[ Upstream commit 2b892649254fec01678c64f16427622b41fa27f4 ]

PHY_INTERFACE_MODE_RGMII_RXID is less then TXID
so code to set tx delay is never called.

Fixes: 2a10154abcb75 ("net: phy: dp83867: Add TI dp83867 phy")
Signed-off-by: Max Uvarov <muvarov@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index c1ab976cc800..12b09e6e03ba 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -249,10 +249,8 @@ static int dp83867_config_init(struct phy_device *phydev)
 		ret = phy_write(phydev, MII_DP83867_PHYCTRL, val);
 		if (ret)
 			return ret;
-	}
 
-	if ((phydev->interface >= PHY_INTERFACE_MODE_RGMII_ID) &&
-	    (phydev->interface <= PHY_INTERFACE_MODE_RGMII_RXID)) {
+		/* Set up RGMII delays */
 		val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL);
 
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
-- 
2.20.1

