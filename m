Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC52C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D30B20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369829;
	bh=IbPcy0E3XWWTakrYe9lPkMq0MC0r4YM+cWYRHjWsCFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pp2PIe/8585nr/llx55b6WwwzXuJC61AYCApioiKDWzFxzsWsQmE30nWLw1RXimpd
	 uE+PbeyS67K/t3RGrixMOvugQZ6Rpt6niUH3sgWlbvjAK+wG3tUjcGmPuQExSS9PSf
	 N/o0h89qiLKUvTTB5nAn2qcI7CDnt+Gn4+U85yIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfDDJPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387786AbfDDJO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BCB42054F;
        Thu,  4 Apr 2019 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369295;
        bh=IbPcy0E3XWWTakrYe9lPkMq0MC0r4YM+cWYRHjWsCFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSDGgqEHAlTctCVO6nYOgshX1062xAhogjgWRjTA4tLDLk1XHM6hj1qwGGrd7a1WC
         I5HLjwBNG+7Z2NX++gjxHGqUvtMMfJ+w7JYuvKBVjHlY/rTSRh3ThbSkSA9fEWB9PB
         4oW+y+a5jmdqJObZVVgbiY1pAi377LtBfpYenG4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 157/246] net: phy: consider latched link-down status in polling mode
Date:   Thu,  4 Apr 2019 10:47:37 +0200
Message-Id: <20190404084624.668164669@linuxfoundation.org>
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

[ Upstream commit 93c0970493c71f264e6c3c7caf1ff24a9e1de786 ]

The link status value latches link-down events. To get the current
status we read the register twice in genphy_update_link(). There's
a potential risk that we miss a link-down event in polling mode.
This may cause issues if the user e.g. connects his machine to a
different network.

On the other hand reading the latched value may cause issues in
interrupt mode. Following scenario:

- After boot link goes up
- phy_start() is called triggering an aneg restart, hence link goes
  down and link-down info is latched.
- After aneg has finished link goes up and triggers an interrupt.
  Interrupt handler reads link status, means it reads the latched
  "link is down" info. But there won't be another interrupt as long
  as link stays up, therefore phylib will never recognize that link
  is up.

Deal with both scenarios by reading the register twice in interrupt
mode only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy-c45.c    | 10 ++++++++--
 drivers/net/phy/phy_device.c | 13 +++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 03af927fa5ad..e39bf0428dd9 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -147,9 +147,15 @@ int genphy_c45_read_link(struct phy_device *phydev, u32 mmd_mask)
 		mmd_mask &= ~BIT(devad);
 
 		/* The link state is latched low so that momentary link
-		 * drops can be detected.  Do not double-read the status
-		 * register if the link is down.
+		 * drops can be detected. Do not double-read the status
+		 * in polling mode to detect such short link drops.
 		 */
+		if (!phy_polling_mode(phydev)) {
+			val = phy_read_mmd(phydev, devad, MDIO_STAT1);
+			if (val < 0)
+				return val;
+		}
+
 		val = phy_read_mmd(phydev, devad, MDIO_STAT1);
 		if (val < 0)
 			return val;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 739434fe04fa..adf79614c2db 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1683,10 +1683,15 @@ int genphy_update_link(struct phy_device *phydev)
 {
 	int status;
 
-	/* Do a fake read */
-	status = phy_read(phydev, MII_BMSR);
-	if (status < 0)
-		return status;
+	/* The link state is latched low so that momentary link
+	 * drops can be detected. Do not double-read the status
+	 * in polling mode to detect such short link drops.
+	 */
+	if (!phy_polling_mode(phydev)) {
+		status = phy_read(phydev, MII_BMSR);
+		if (status < 0)
+			return status;
+	}
 
 	/* Read link and autonegotiation status */
 	status = phy_read(phydev, MII_BMSR);
-- 
2.19.1



