Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F64FC6196
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BCB2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="PmCk1vAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbfKFWhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:37:02 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54219 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbfKFWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:36:59 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EF59A23E4D;
        Wed,  6 Nov 2019 23:36:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1573079818;
        bh=Y+C2JFik0SuaDLpIqi9+CLYF43yMTrkGy5sCVB6l4Og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmCk1vAne199FyMkya45OUNfY6OEKMuPSfXsxcOnI3K2HGWhsmo4aDDpQKETYzpHx
         +lukrRcHw3K3RIuDbCLUpbhFNvbw+f+oszUERR6EJvqfKJudZ+sNy3MbIlZ1VYRu2T
         Gw0uAXVBX4tdrusC+KxMx12y6iRPILvngIyIBoW4=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 6/6] net: phy: at803x: remove config_init for AR9331
Date:   Wed,  6 Nov 2019 23:36:17 +0100
Message-Id: <20191106223617.1655-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106223617.1655-1-michael@walle.cc>
References: <20191106223617.1655-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to its datasheet, the internal PHY doesn't have debug
registers nor MMDs. Since config_init() only configures delays and
clocks and so on in these registers it won't be needed on this PHY.
Remove it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/phy/at803x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 4434d501cd4f..aee62610bade 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -755,8 +755,6 @@ static struct phy_driver at803x_driver[] = {
 	/* ATHEROS AR9331 */
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
 	.name			= "Qualcomm Atheros AR9331 built-in PHY",
-	.probe			= at803x_probe,
-	.config_init		= at803x_config_init,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	/* PHY_BASIC_FEATURES */
-- 
2.20.1

