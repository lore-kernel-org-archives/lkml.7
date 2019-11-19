Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C898222A2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141290;
	bh=2ohfrYlI9AQLpAqTbHVEr+dyZe0wqqGRf+hlTW7OljU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqgdUHC/Q+X1BdFC5ZiVzW+m8QgfEVHdLgBCK8YC5w0VpPSEdCjW+GTdbOBah2iJf
	 ZFUTxxpRTNnOV8D7kRQhn2sjr+TY8YkG0TNSWerQWCh9UcIVSZNVswE+4TGh66RaKa
	 XQz46m6zqoL3Jo8rSnI55A1s0txDRqgBFJ/zk4to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfKSF2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfKSF2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:28:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F195208C3;
        Tue, 19 Nov 2019 05:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141281;
        bh=2ohfrYlI9AQLpAqTbHVEr+dyZe0wqqGRf+hlTW7OljU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1pBEN8q7hscB015nYNBWhtwL8Ke6wGVDYogIR7swd2wM8G8p+u/tJ+vD9uQF3G2d
         8OJK/nHvW4lYpFlEnQ5G6mPkS08eSXcYUEoRqPyxISvK5Gs01ILkmI0xW3n9lYhksW
         WpcYsf9S0B+LIpmcMbr9252s+sGL/pdjkBrttdDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/422] net: phy: mscc: read vsc8531,vddmac as an u32
Date:   Tue, 19 Nov 2019 06:15:05 +0100
Message-Id: <20191119051406.154190055@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

[ Upstream commit a993e0f583c7925adaa7721226ccd7a41e7e63d1 ]

In the DT binding, it is specified nowhere that 'vsc8531,vddmac' is an
u16, even though it's read as an u16 in the driver.

Let's update the driver to take into consideration that the
'vsc8531,vddmac' property is of the default type u32.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 84ca9ff40ae0b..53d63a71a03e2 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -111,7 +111,7 @@ struct vsc8531_private {
 
 #ifdef CONFIG_OF_MDIO
 struct vsc8531_edge_rate_table {
-	u16 vddmac;
+	u32 vddmac;
 	u8 slowdown[8];
 };
 
@@ -376,7 +376,7 @@ out_unlock:
 static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 {
 	u8 sd;
-	u16 vdd;
+	u32 vdd;
 	int rc, i, j;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
@@ -385,7 +385,7 @@ static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 	if (!of_node)
 		return -ENODEV;
 
-	rc = of_property_read_u16(of_node, "vsc8531,vddmac", &vdd);
+	rc = of_property_read_u32(of_node, "vsc8531,vddmac", &vdd);
 	if (rc != 0)
 		vdd = MSCC_VDDMAC_3300;
 
-- 
2.20.1



