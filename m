Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1551EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D966E20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050445;
	bh=sBjtU5TT1V1Gzcn9lLKsjz8nlrnXqRcMXeXUwu45toQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rXipoY4ILnTTIRxKBr2xY52+HRLg45IX0mj3Z8UNYhh0LgSPBsT7OOSRGSAenNpLZ
	 QuJNJt+2iZpsazLZbtV/v6fLu+hafzGgZ5b08sZe3iKg3dFP5UukE1nq5LYQpEpPp3
	 XyzK2x/11EWKiyHhUiRTHcy6aOnWn6xtZwNq9tNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCHMyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfCHMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76BA20449;
        Fri,  8 Mar 2019 12:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049655;
        bh=sBjtU5TT1V1Gzcn9lLKsjz8nlrnXqRcMXeXUwu45toQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWOUWAYrf9t6wgLZDNxJmk9lRYlpfmiGamfal5VV4bimeh/V3iwl3PRxr3hdYxOf/
         7G00VUN8Qv+pmCUDNXlgtdZJmivms14WJ/1+85i9J69L8yj9r0Rc6apSRdrE9PmCre
         VqHKK5qZ+lWL3I9essmyGzT7P9xMPHWTYoWtiXM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 22/76] net: mscc: Enable all ports in QSGMII
Date:   Fri,  8 Mar 2019 13:49:34 +0100
Message-Id: <20190308124915.561260801@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>

[ Upstream commit 084e5bb16bd7dc2b551bbd9fb358bf73e03ee8d8 ]

When Ocelot phy-mode is QSGMII, all 4 ports involved in
QSGMII shall be kept out of reset and
Tx lanes shall be enabled to pass the data.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
Signed-off-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Co-developed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mscc/ocelot_board.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -266,6 +266,7 @@ static int mscc_ocelot_probe(struct plat
 		struct phy *serdes;
 		void __iomem *regs;
 		char res_name[8];
+		int phy_mode;
 		u32 port;
 
 		if (of_property_read_u32(portnp, "reg", &port))
@@ -291,11 +292,11 @@ static int mscc_ocelot_probe(struct plat
 		if (err)
 			return err;
 
-		err = of_get_phy_mode(portnp);
-		if (err < 0)
+		phy_mode = of_get_phy_mode(portnp);
+		if (phy_mode < 0)
 			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
 		else
-			ocelot->ports[port]->phy_mode = err;
+			ocelot->ports[port]->phy_mode = phy_mode;
 
 		switch (ocelot->ports[port]->phy_mode) {
 		case PHY_INTERFACE_MODE_NA:
@@ -303,6 +304,13 @@ static int mscc_ocelot_probe(struct plat
 		case PHY_INTERFACE_MODE_SGMII:
 			break;
 		case PHY_INTERFACE_MODE_QSGMII:
+			/* Ensure clock signals and speed is set on all
+			 * QSGMII links
+			 */
+			ocelot_port_writel(ocelot->ports[port],
+					   DEV_CLOCK_CFG_LINK_SPEED
+					   (OCELOT_SPEED_1000),
+					   DEV_CLOCK_CFG);
 			break;
 		default:
 			dev_err(ocelot->dev,


