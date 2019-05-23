Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097BC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C8D2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Iklke5qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfEWIze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:55:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46536 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfEWIze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:55:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458jyC6mxqz9tyns;
        Thu, 23 May 2019 10:55:31 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Iklke5qB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YcF6C1XFYA7y; Thu, 23 May 2019 10:55:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458jyC5ftdz9tynv;
        Thu, 23 May 2019 10:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558601731; bh=xXmpQ/75lHG0vDCaj7oB0x3Jy9haJlwrNP69w581+Es=;
        h=From:Subject:To:Cc:Date:From;
        b=Iklke5qBPVYb4Jca8Y5JfCXqwMg5aFclhkjppUMKscRZsfSZG8BIrM7zm1bilHEEw
         4t0V23pDenwRRYSXGDMhoRZ1JcoWpcMzrgQyRIikYpkq5Z9RJO2ffNotpjXklnibhc
         qMiG+KbmmqwJI5QaTJ8ls3E4yzM22x1c39mHBDTc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A27DD8B851;
        Thu, 23 May 2019 10:55:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ggCwlvWywLJG; Thu, 23 May 2019 10:55:32 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 50DBE8B77D;
        Thu, 23 May 2019 10:55:32 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 303D868518; Thu, 23 May 2019 08:55:32 +0000 (UTC)
Message-Id: <eb206b659fcae041be38d583ff139ca73e9e03c3.1558601485.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH net-next v2] net: phy: lxt: Add suspend/resume support to LXT971 and
 LXT973.
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 23 May 2019 08:55:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All LXT PHYs implement the standard "power down" bit 11 of
BMCR, so this patch adds support using the generic
genphy_{suspend,resume} functions added by
commit 0f0ca340e57b ("phy: power management support").

LXT970 is left aside because all registers get cleared upon
"power down" exit.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 I'd be happy if you could also merge that into 4.19

 v2: revised commit log without the Fixes: tag.

 drivers/net/phy/lxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index 314486288119..356bd6472f49 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -262,6 +262,8 @@ static struct phy_driver lxt97x_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.ack_interrupt	= lxt971_ack_interrupt,
 	.config_intr	= lxt971_config_intr,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
 }, {
 	.phy_id		= 0x00137a10,
 	.name		= "LXT973-A2",
@@ -271,6 +273,8 @@ static struct phy_driver lxt97x_driver[] = {
 	.probe		= lxt973_probe,
 	.config_aneg	= lxt973_config_aneg,
 	.read_status	= lxt973a2_read_status,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
 }, {
 	.phy_id		= 0x00137a10,
 	.name		= "LXT973",
@@ -279,6 +283,8 @@ static struct phy_driver lxt97x_driver[] = {
 	.flags		= 0,
 	.probe		= lxt973_probe,
 	.config_aneg	= lxt973_config_aneg,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
 } };
 
 module_phy_driver(lxt97x_driver);
-- 
2.13.3

