Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13FF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142390;
	bh=ZNyexEAx1RmuV+lzYTzXJ6dQcA3tmfuWfsgZh64vaEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4X/Aixzsdhi+JgNy/bgqdsaTsNXuocIiEC8XVB7lPZH9uhHU38H13foFfepkI48+
	 Yb+GAAja5pUbjJlWahfQKMrk0CPyWI/woogQ9OqkKt0avxG/+Hp6t2I0fQ0iQJiC63
	 dwycoW/qzpm6rqMVCk9csAzJ/b84viNAHIq4FeCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfKSFq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbfKSFq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:46:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6A52075E;
        Tue, 19 Nov 2019 05:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142385;
        bh=ZNyexEAx1RmuV+lzYTzXJ6dQcA3tmfuWfsgZh64vaEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldPYG3ISStLwf4GUoT1dMNl8+fHWXYstIztgSjOUZWvOmCMMZrcKL/cla1U4jVJRw
         hZlgZ6JaE4B6/nE2AJsgJetD8oa8S02k/iO7b8K7jMvItBLWGvDKUO/FlucXdG+Url
         GTCRcPYVGNQwiSt+/BZHzjvnWUssCuX+3Pqkv3aI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/239] net: phy: mscc: read vsc8531, edge-slowdown as an u32
Date:   Tue, 19 Nov 2019 06:17:43 +0100
Message-Id: <20191119051311.351536362@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

[ Upstream commit 36c53cf0f46526b898390659b125155939f67892 ]

In the DT binding, it is specified nowhere that 'vsc8531,edge-slowdown'
is an u8, even though it's read as an u8 in the driver.

Let's update the driver to take into consideration that the
'vsc8531,edge-slowdown' property is of the default type u32.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 88bcdbcb432cc..fe81741ab66a3 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -112,7 +112,7 @@ struct vsc8531_private {
 #ifdef CONFIG_OF_MDIO
 struct vsc8531_edge_rate_table {
 	u32 vddmac;
-	u8 slowdown[8];
+	u32 slowdown[8];
 };
 
 static const struct vsc8531_edge_rate_table edge_table[] = {
@@ -375,8 +375,7 @@ out_unlock:
 #ifdef CONFIG_OF_MDIO
 static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 {
-	u8 sd;
-	u32 vdd;
+	u32 vdd, sd;
 	int rc, i, j;
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
@@ -389,7 +388,7 @@ static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 	if (rc != 0)
 		vdd = MSCC_VDDMAC_3300;
 
-	rc = of_property_read_u8(of_node, "vsc8531,edge-slowdown", &sd);
+	rc = of_property_read_u32(of_node, "vsc8531,edge-slowdown", &sd);
 	if (rc != 0)
 		sd = 0;
 
-- 
2.20.1



