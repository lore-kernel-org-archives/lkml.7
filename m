Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD242186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F7IvNTrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbfCAKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:54:40 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47770 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:54:37 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1D53E10C0854;
        Fri,  1 Mar 2019 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551437677; bh=i0mh4Jr+4Cz4ugTiXMyI4TNFFuaihxXS6tuFX5rEbkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=F7IvNTrmzU6PdQSDqA3+AoIP9WpmYDgdsHKGhDHMQMrxxZ8dPGj85t266vKEpadnG
         LpqLx/G9RxQcpY+60W9E0g4P08sMtvAcQAVXZIUJ45R2CkcT1LyBGco6SevOBD8zJs
         fHTgO9W9G693fwTTIFNVhmIqUY+qc/q/m4ccqaqWYA9J4+evKc6uYaluXfIx67UC7v
         EZgeNqaCvYzb8UpWrgpyUWC7LTLnz54canM+Z2GSWSado3k7TsVQTM0d77AHew3q/O
         72Pih3EERYLNcs2ugicBb6Pp/LZSd8lnNataUIq3MJ+GmE3cPIjqDOf2PrsFhjtcIW
         1uH+WLJYpKTkw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id B6FD25021;
        Fri,  1 Mar 2019 02:54:35 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [PATCH net 2/2] net: phy: Use C45 Helpers in PHY_FORCING state
Date:   Fri,  1 Mar 2019 11:54:24 +0100
Message-Id: <8480c38d6f3bc5c4f6c332a788bc82999266aab7.1551437561.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1551437561.git.joabreu@synopsys.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
In-Reply-To: <cover.1551437561.git.joabreu@synopsys.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a C45 PHY that is in PHY_FORCING state we are currently not
taking into account that this kind of PHY has different update_link
functions.

Use the C45 Helpers instead or the driver built-in read_status() helper,
if possible.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Joao Pinto <joao.pinto@synopsys.com>
---
 drivers/net/phy/phy.c |  2 +-
 include/linux/phy.h   | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c5675df5fc6f..1ef5dbc384d0 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -940,7 +940,7 @@ void phy_state_machine(struct work_struct *work)
 		err = phy_check_link_status(phydev);
 		break;
 	case PHY_FORCING:
-		err = genphy_update_link(phydev);
+		err = phy_update_link(phydev);
 		if (err)
 			break;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 872899136fdc..67caa7eb93b1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1036,6 +1036,19 @@ static inline int phy_read_status(struct phy_device *phydev)
 		return genphy_read_status(phydev);
 }
 
+static inline int phy_update_link(struct phy_device *phydev)
+{
+	if (!phydev->drv)
+		return -EIO;
+
+	if (phydev->drv->read_status)
+		return phydev->drv->read_status(phydev);
+	else if (phydev->is_c45)
+		return gen10g_read_status(phydev);
+	else
+		return genphy_update_link(phydev);
+}
+
 void phy_driver_unregister(struct phy_driver *drv);
 void phy_drivers_unregister(struct phy_driver *drv, int n);
 int phy_driver_register(struct phy_driver *new_driver, struct module *owner);
-- 
2.7.4

