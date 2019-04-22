Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA419C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954A0218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962228;
	bh=UOU6FUG+VXleh2JjO6ITLP+aTgrnGn34mCPzPn+iu/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yzLiVKUiiaak11CypM6AiSR7VkeN8KIPNHK5jXaWYk6zTqW/1gFRbM1qaMoWz1hkk
	 5lMCKKD99I/wT1ezEdYsdGFZaV0wzb2nZKbebXxHTHSuT4unbIqp9UQd821kGOeobJ
	 kx+SFo0qzVKP8Iei3ZTw7hIDrPh7wV5NVOsYCDc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfDVTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbfDVTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C43C0218DA;
        Mon, 22 Apr 2019 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962223;
        bh=UOU6FUG+VXleh2JjO6ITLP+aTgrnGn34mCPzPn+iu/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8arCcwo3Cy48EtHQRZ8OGWElwRZdE597NMhFpPGVQAOgfJWtvbjvYODUWA4RuVkf
         Ki4wfnAvXm60NI1VZIxZ0evvY/hH/zBMhm5yR0ei2Z5bKhJ8/imJ5RQlrvzRaj9sVm
         J9ciLO/bdVH0cSOn/TwS27dUHQTNa3yQLa6PdROc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 45/98] net: phy: Add DP83825I to the DP83822 driver
Date:   Mon, 22 Apr 2019 15:41:12 -0400
Message-Id: <20190422194205.10404-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

[ Upstream commit 06acc17a96215a11134114aee26532b12dc8fde1 ]

Add the DP83825I ethernet PHY to the DP83822 driver.
These devices share the same WoL register bits and addresses.

The phy_driver init was made into a macro as there may be future
devices appended to this driver that will share the register space.

http://www.ti.com/lit/gpn/dp83825i

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/phy/dp83822.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 24c7f149f3e6..e11057892f07 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -23,6 +23,8 @@
 #include <linux/netdevice.h>
 
 #define DP83822_PHY_ID	        0x2000a240
+#define DP83825I_PHY_ID		0x2000a150
+
 #define DP83822_DEVADDR		0x1f
 
 #define MII_DP83822_PHYSCR	0x11
@@ -312,26 +314,30 @@ static int dp83822_resume(struct phy_device *phydev)
 	return 0;
 }
 
+#define DP83822_PHY_DRIVER(_id, _name)				\
+	{							\
+		PHY_ID_MATCH_MODEL(_id),			\
+		.name		= (_name),			\
+		.features	= PHY_BASIC_FEATURES,		\
+		.soft_reset	= dp83822_phy_reset,		\
+		.config_init	= dp83822_config_init,		\
+		.get_wol = dp83822_get_wol,			\
+		.set_wol = dp83822_set_wol,			\
+		.ack_interrupt = dp83822_ack_interrupt,		\
+		.config_intr = dp83822_config_intr,		\
+		.suspend = dp83822_suspend,			\
+		.resume = dp83822_resume,			\
+	}
+
 static struct phy_driver dp83822_driver[] = {
-	{
-		.phy_id = DP83822_PHY_ID,
-		.phy_id_mask = 0xfffffff0,
-		.name = "TI DP83822",
-		.features = PHY_BASIC_FEATURES,
-		.config_init = dp83822_config_init,
-		.soft_reset = dp83822_phy_reset,
-		.get_wol = dp83822_get_wol,
-		.set_wol = dp83822_set_wol,
-		.ack_interrupt = dp83822_ack_interrupt,
-		.config_intr = dp83822_config_intr,
-		.suspend = dp83822_suspend,
-		.resume = dp83822_resume,
-	 },
+	DP83822_PHY_DRIVER(DP83822_PHY_ID, "TI DP83822"),
+	DP83822_PHY_DRIVER(DP83825I_PHY_ID, "TI DP83825I"),
 };
 module_phy_driver(dp83822_driver);
 
 static struct mdio_device_id __maybe_unused dp83822_tbl[] = {
 	{ DP83822_PHY_ID, 0xfffffff0 },
+	{ DP83825I_PHY_ID, 0xfffffff0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, dp83822_tbl);
-- 
2.19.1

