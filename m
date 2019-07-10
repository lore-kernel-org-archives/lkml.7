Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5041C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B467F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGJFFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:05:00 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:56954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726392AbfGJFEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CB52F1803A16D;
        Wed, 10 Jul 2019 05:04:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coal43_ccb02173980f
X-Filterd-Recvd-Size: 2914
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:47 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] net: stmmac: Fix misuses of GENMASK macro
Date:   Tue,  9 Jul 2019 22:04:21 -0700
Message-Id: <b38b0b67e724cd026709194b68c2be5ee1058c57.1562734889.git.joe@perches.com>
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
 drivers/net/ethernet/stmicro/stmmac/descs.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/descs.h b/drivers/net/ethernet/stmicro/stmmac/descs.h
index 10429b05f932..9f0b9a9e63b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs.h
@@ -123,7 +123,7 @@
 #define	ETDES1_BUFFER2_SIZE_SHIFT	16
 
 /* Extended Receive descriptor definitions */
-#define	ERDES4_IP_PAYLOAD_TYPE_MASK	GENMASK(2, 6)
+#define	ERDES4_IP_PAYLOAD_TYPE_MASK	GENMASK(6, 2)
 #define	ERDES4_IP_HDR_ERR		BIT(3)
 #define	ERDES4_IP_PAYLOAD_ERR		BIT(4)
 #define	ERDES4_IP_CSUM_BYPASSED		BIT(5)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 6d5cba4075eb..4c5db00c1d18 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -192,7 +192,7 @@ static const struct emac_variant emac_variant_h6 = {
 
 /* Used in RX_CTL1*/
 #define EMAC_RX_MD              BIT(1)
-#define EMAC_RX_TH_MASK		GENMASK(4, 5)
+#define EMAC_RX_TH_MASK		GENMASK(5, 4)
 #define EMAC_RX_TH_32		0
 #define EMAC_RX_TH_64		(0x1 << 4)
 #define EMAC_RX_TH_96		(0x2 << 4)
@@ -203,7 +203,7 @@ static const struct emac_variant emac_variant_h6 = {
 /* Used in TX_CTL1*/
 #define EMAC_TX_MD              BIT(1)
 #define EMAC_TX_NEXT_FRM        BIT(2)
-#define EMAC_TX_TH_MASK		GENMASK(8, 10)
+#define EMAC_TX_TH_MASK		GENMASK(10, 8)
 #define EMAC_TX_TH_64		0
 #define EMAC_TX_TH_128		(0x1 << 8)
 #define EMAC_TX_TH_192		(0x2 << 8)
-- 
2.15.0

