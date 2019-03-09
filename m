Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A091020868
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="qds21/pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCIKEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:04:08 -0500
Received: from mail.dlink.ru ([178.170.168.18]:52154 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfCIKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:04:07 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id DF50F1B21879; Sat,  9 Mar 2019 12:54:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru DF50F1B21879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1552125261; bh=ZB+kpNUL7sfUS1P1cCsq0z8W9CajczsSspuJO2Dzhac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qds21/pqPkmxQJC2K+3S5Y34vrBSBzLcrChiLDnP5IaZLwsHEn1avaV2qGhtrYpFB
         JgicufcNR0PvOOAtHzpzjzYo6lre08bNn62EkNT9YGrmBOVbuujcTBg3L+pkobOhys
         QL/DHAl69muyC6eMhiuQqSVeog0qwCR5KL7KUOTI=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 2E09A1B21812;
        Sat,  9 Mar 2019 12:54:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 2E09A1B21812
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 0EA101B20755;
        Sat,  9 Mar 2019 12:54:17 +0300 (MSK)
Received: from localhost (unknown [176.112.142.79])
        by mail.rzn.dlink.ru (Postfix) with ESMTPSA;
        Sat,  9 Mar 2019 12:54:17 +0300 (MSK)
From:   Maxim Zhukov <mussitantesmortem@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 1/2] staging, mt7621-eth: fix api for linkmode bitmap
Date:   Sat,  9 Mar 2019 12:53:59 +0300
Message-Id: <20190309095400.26930-2-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190309095400.26930-1-mussitantesmortem@gmail.com>
References: <20190309095400.26930-1-mussitantesmortem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using new api for linkmode bitmap

Fixed build after 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/staging/mt7621-eth/mdio.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
index 5fea6a447eed..142d7a082dd3 100644
--- a/drivers/staging/mt7621-eth/mdio.c
+++ b/drivers/staging/mt7621-eth/mdio.c
@@ -89,8 +89,12 @@ int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,
 		return -ENODEV;
 	}
 
-	phydev->supported &= PHY_1000BT_FEATURES;
-	phydev->advertising = phydev->supported;
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 phydev->supported);
+
+	linkmode_copy(phydev->advertising, phydev->supported);
 
 	dev_info(eth->dev,
 		 "connected port %d to PHY at %s [uid=%08x, driver=%s]\n",
@@ -113,7 +117,9 @@ static void phy_init(struct mtk_eth *eth, struct mtk_mac *mac,
 	phy->speed = 0;
 	phy->duplex = 0;
 	phy_set_max_speed(phy, SPEED_100);
-	phy->advertising = phy->supported | ADVERTISED_Autoneg;
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+			 phy->advertising);
+
 
 	phy_start_aneg(phy);
 }
-- 
2.21.0

