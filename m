Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD2206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713318;
	bh=LR1E7ls6GspKL+LS6IAuEa9IGXbCO373aLev2FG4McY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VmCAMH4xh8Q7z9+NPtXyVAQV1yXpRcXG3DyLpCP313vEg6n59A8vXlDgvF5E3E101
	 AUi3xZCimyLsdpNOGa6TISodJzexOsfrSJnj8sjwgVgYVQnXmla4VsthOq0g93kHn1
	 iNBN1iF9+zdzK+u0sZBz4+7tPQ2UB8RFRukSxFZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfC0TB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389541AbfC0SOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E766B21850;
        Wed, 27 Mar 2019 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710439;
        bh=LR1E7ls6GspKL+LS6IAuEa9IGXbCO373aLev2FG4McY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJcXTLZ2eDidEaV0ToMrQy5ikW+w5VHWlXqaqGRQNKuKcndLEYUPvJKLuHmPbRS39
         2JsgZxLPBsv1iHDws5xJ+9bzhoXY1tLujNxg1jJ1mhmK3OL/g9g03TmKTxJWv8/6mU
         +CXzVD1+kXRJc9UKyzhDDRWaolHnH/9GGl2ukb5A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 120/192] net: phy: consider latched link-down status in polling mode
Date:   Wed, 27 Mar 2019 14:09:12 -0400
Message-Id: <20190327181025.13507-120-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

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
index e1225545362d..0ba3607585bd 100644
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
index 2c32c795f5dd..8a96d985a52f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1503,10 +1503,15 @@ int genphy_update_link(struct phy_device *phydev)
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

