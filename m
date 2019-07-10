Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBBEC73C6E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9BD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfGJFEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:04:54 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:43605 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfGJFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 161B4181D33FB;
        Wed, 10 Jul 2019 05:04:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fang39_c6a5a3a50f08
X-Filterd-Recvd-Size: 2562
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:45 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Nelson Chang <nelson.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] net: ethernet: mediatek: Fix misuses of GENMASK macro
Date:   Tue,  9 Jul 2019 22:04:20 -0700
Message-Id: <1961dd832a1363b6dfdbac6cb0b1c71fa838d258.1562734889.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 2 +-
 drivers/net/ethernet/mediatek/mtk_sgmii.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 876ce6798709..221012ecb845 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -712,7 +712,7 @@ struct mtk_soc_data {
 #define MTK_MAX_DEVS			2
 
 #define MTK_SGMII_PHYSPEED_AN          BIT(31)
-#define MTK_SGMII_PHYSPEED_MASK        GENMASK(0, 2)
+#define MTK_SGMII_PHYSPEED_MASK        GENMASK(2, 0)
 #define MTK_SGMII_PHYSPEED_1000        BIT(0)
 #define MTK_SGMII_PHYSPEED_2500        BIT(1)
 #define MTK_HAS_FLAGS(flags, _x)       (((flags) & (_x)) == (_x))
diff --git a/drivers/net/ethernet/mediatek/mtk_sgmii.c b/drivers/net/ethernet/mediatek/mtk_sgmii.c
index 136f90ce5a65..ff509d42d818 100644
--- a/drivers/net/ethernet/mediatek/mtk_sgmii.c
+++ b/drivers/net/ethernet/mediatek/mtk_sgmii.c
@@ -82,7 +82,7 @@ int mtk_sgmii_setup_mode_force(struct mtk_sgmii *ss, int id)
 		return -EINVAL;
 
 	regmap_read(ss->regmap[id], ss->ana_rgc3, &val);
-	val &= ~GENMASK(2, 3);
+	val &= ~GENMASK(3, 2);
 	mode = ss->flags[id] & MTK_SGMII_PHYSPEED_MASK;
 	val |= (mode == MTK_SGMII_PHYSPEED_1000) ? 0 : BIT(2);
 	regmap_write(ss->regmap[id], ss->ana_rgc3, val);
-- 
2.15.0

