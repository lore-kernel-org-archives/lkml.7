Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6CA21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HnKhKe+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfCNKiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:38:00 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:34412 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfCNKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:37:59 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1B91010C25E5;
        Thu, 14 Mar 2019 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552559879; bh=zu3IXV2x1enxJJVP8oX8x9XRSshj58jSUHa/Lew54a0=;
        h=From:To:Cc:Subject:Date:From;
        b=HnKhKe+f7VYIeAwbvTLp2nHTxT2qBUoGNeDIm7geR7Gn7clApes2iAenOJ7G6/9br
         Rd/8Qep3e+8DybGOGsY71emxZP17cUydmWSauM8n7fRhketgP6CaJf+ALslRX04rpO
         pIszYCKFGM5IAYj3NkwNFZBFUI9jk10YgmiEJOVnYEMp5kuwfTmMUrpqE9BqRo+gCt
         QxjEwUiojwppLMKoi8yNEcHmtwh3xll2n3G15R+l1wVcW1YKRlJe1HNh6zXQOPDg/6
         10uh7uNG9B0M0v/u4T53oipAPsRpM/y1pumH3fTZr/KFAhPagemn3u8vwKY29x6VLp
         t5udvTClsTBEw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id D07D45B41;
        Thu, 14 Mar 2019 03:37:25 -0700 (PDT)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [PATCH net] net: phy: Don't assume loopback is supported
Date:   Thu, 14 Mar 2019 11:37:21 +0100
Message-Id: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PHYs may not support loopback mode so we need to check if register
is read-only.

Fixes: f0f9b4ed2338 ("net: phy: Add phy loopback support in net phy framework")
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Joao Pinto <joao.pinto@synopsys.com>
---
 drivers/net/phy/phy_device.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 49fdd1ee798e..a749639d98c3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1918,8 +1918,24 @@ EXPORT_SYMBOL(genphy_resume);
 
 int genphy_loopback(struct phy_device *phydev, bool enable)
 {
-	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
-			  enable ? BMCR_LOOPBACK : 0);
+	int ret;
+
+	ret = phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
+			 enable ? BMCR_LOOPBACK : 0);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		return ret;
+
+	if (enable) {
+		if (ret & BMCR_LOOPBACK)
+			return 0;
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(genphy_loopback);
 
-- 
2.7.4

