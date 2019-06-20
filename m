Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B5B20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054666;
	bh=tp6DY4yMQ+DaK5o5g/yaSk5enRavQe1Wh/2njTOIatE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dd3G3/5/coL3rQshEyXbDUcYlyC0kp6TDCagDaLphjhjXKycwByefqNT8nOptLs7+
	 chDY4jJPsgPAhyZzM7u8PwLkJUlC/cSy1MRUJhfvpeXWMqgXzYEtWF3pUW4tqVVq92
	 EZiC6RYyGhIoGKAYavfVowitn7eax/JmvgWJzGe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfFTSRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfFTSRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:17:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1802089C;
        Thu, 20 Jun 2019 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054658;
        bh=tp6DY4yMQ+DaK5o5g/yaSk5enRavQe1Wh/2njTOIatE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFrkAp7H0Temv3qcPMJaOAZkcIRCi7jgapTiqBa/Q21Jj62hMLW838yqyo/eI388s
         AH2ysVLQux592NVpLZsWT946wtz6+Oe4C1g0GvfxjxAj+tNraqDVqyhndJVU2f/yVs
         kyXmalIxO7CX4bPDXCo+661DN12YiQoVV56sdw1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Uvarov <muvarov@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 85/98] net: phy: dp83867: fix speed 10 in sgmii mode
Date:   Thu, 20 Jun 2019 19:57:52 +0200
Message-Id: <20190620174353.605621189@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 333061b924539c0de081339643f45514f5f1c1e6 ]

For supporting 10Mps speed in SGMII mode DP83867_10M_SGMII_RATE_ADAPT bit
of DP83867_10M_SGMII_CFG register has to be cleared by software.
That does not affect speeds 100 and 1000 so can be done on init.

Signed-off-by: Max Uvarov <muvarov@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 8448d01819ef..29cae4de9a4f 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -30,6 +30,8 @@
 #define DP83867_STRAP_STS1	0x006E
 #define DP83867_RGMIIDCTL	0x0086
 #define DP83867_IO_MUX_CFG	0x0170
+#define DP83867_10M_SGMII_CFG   0x016F
+#define DP83867_10M_SGMII_RATE_ADAPT_MASK BIT(7)
 
 #define DP83867_SW_RESET	BIT(15)
 #define DP83867_SW_RESTART	BIT(14)
@@ -277,6 +279,21 @@ static int dp83867_config_init(struct phy_device *phydev)
 				       DP83867_IO_MUX_CFG_IO_IMPEDANCE_CTRL);
 	}
 
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
+		/* For support SPEED_10 in SGMII mode
+		 * DP83867_10M_SGMII_RATE_ADAPT bit
+		 * has to be cleared by software. That
+		 * does not affect SPEED_100 and
+		 * SPEED_1000.
+		 */
+		ret = phy_modify_mmd(phydev, DP83867_DEVADDR,
+				     DP83867_10M_SGMII_CFG,
+				     DP83867_10M_SGMII_RATE_ADAPT_MASK,
+				     0);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable Interrupt output INT_OE in CFG3 register */
 	if (phy_interrupt_is_valid(phydev)) {
 		val = phy_read(phydev, DP83867_CFG3);
-- 
2.20.1



