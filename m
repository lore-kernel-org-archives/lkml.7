Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89602082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbear.ru header.i=@cloudbear.ru header.b="ZRCto/nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfIEQdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:33:23 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:41664 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387514AbfIEQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:33:22 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 12:33:20 EDT
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 080B0598193A;
        Thu,  5 Sep 2019 19:26:31 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback15g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1DG2Bauavx-QUN8eCZb;
        Thu, 05 Sep 2019 19:26:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cloudbear.ru; s=mail; t=1567700791;
        bh=fAmjxskCyCm86n6Sp07wqD96KSRVJRrJH7sQMnmMMPI=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=ZRCto/nkTmO5vzLjka2QulQGcaaoGR1Bopxh+htlFipa7MYGFywO62yfYktZKhGYZ
         AtTfl+iEJ/hZp95XddAomWyV48+ssBjFKEFlHhUiulpdzOm0eRynEmd/VNsvEu2euM
         aey97L94eb7iNT8BzExmGfH+dLFxH3eeYiYY4WjI=
Authentication-Results: mxback15g.mail.yandex.net; dkim=pass header.i=@cloudbear.ru
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ymy8epsrG0-QTQqYZb0;
        Thu, 05 Sep 2019 19:26:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>
To:     davem@davemloft.net, robh+dt@kernel.org, f.fainelli@gmail.com
Cc:     Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: phy: dp83867: Add SGMII mode type switching
Date:   Thu,  5 Sep 2019 19:25:59 +0300
Message-Id: <1567700761-14195-1-git-send-email-vitaly.gaiduk@cloudbear.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ability to switch beetween two PHY SGMII modes.
Some hardware, for example, FPGA IP designs may use 6-wire mode
which enables differential SGMII clock to MAC.

Signed-off-by: Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>
---
 drivers/net/phy/dp83867.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 1f1ecee0ee2f..3efb33e7523f 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -37,6 +37,7 @@
 #define DP83867_STRAP_STS2	0x006f
 #define DP83867_RGMIIDCTL	0x0086
 #define DP83867_IO_MUX_CFG	0x0170
+#define DP83867_SGMIICTL	0x00D3
 #define DP83867_10M_SGMII_CFG   0x016F
 #define DP83867_10M_SGMII_RATE_ADAPT_MASK BIT(7)
 
@@ -61,6 +62,9 @@
 #define DP83867_RGMII_TX_CLK_DELAY_EN		BIT(1)
 #define DP83867_RGMII_RX_CLK_DELAY_EN		BIT(0)
 
+/* SGMIICTL bits */
+#define DP83867_SGMII_TYPE		BIT(14)
+
 /* STRAP_STS1 bits */
 #define DP83867_STRAP_STS1_RESERVED		BIT(11)
 
@@ -109,6 +113,7 @@ struct dp83867_private {
 	bool rxctrl_strap_quirk;
 	bool set_clk_output;
 	u32 clk_output_sel;
+	bool sgmii_type;
 };
 
 static int dp83867_ack_interrupt(struct phy_device *phydev)
@@ -197,6 +202,8 @@ static int dp83867_of_init(struct phy_device *phydev)
 	dp83867->rxctrl_strap_quirk = of_property_read_bool(of_node,
 					"ti,dp83867-rxctrl-strap-quirk");
 
+	dp83867->sgmii_type = of_property_read_bool(of_node, "ti,sgmii-type");
+
 	/* Existing behavior was to use default pin strapping delay in rgmii
 	 * mode, but rgmii should have meant no delay.  Warn existing users.
 	 */
@@ -389,6 +396,14 @@ static int dp83867_config_init(struct phy_device *phydev)
 
 		if (ret)
 			return ret;
+
+		/* SGMII type is set to 4-wire mode by default */
+		if (dp83867->sgmii_type) {
+			/* Switch-on 6-wire mode */
+			val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_SGMIICTL);
+			val |= DP83867_SGMII_TYPE;
+			phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_SGMIICTL, val);
+		}
 	}
 
 	/* Enable Interrupt output INT_OE in CFG3 register */
-- 
2.16.4

