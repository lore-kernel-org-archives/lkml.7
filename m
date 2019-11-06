Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2AE217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfKFK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:27:02 -0500
Received: from mx.socionext.com ([202.248.49.38]:44295 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbfKFK0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:26:53 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 06 Nov 2019 19:26:51 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3DE4F180095;
        Wed,  6 Nov 2019 19:26:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 6 Nov 2019 19:26:57 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D78D11A04FC;
        Wed,  6 Nov 2019 19:26:50 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/6] phy: uniphier-usb3hs: Change Rx sync mode to avoid communication failure
Date:   Wed,  6 Nov 2019 19:26:18 +0900
Message-Id: <1573035979-32200-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of using default parameters, communication failure might occur
in rare cases. This sets Rx sync mode parameter to avoid the issue.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-usb3hs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
index bdf696e..a9bc741 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3hs.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
@@ -41,10 +41,12 @@
 
 #define PHY_F(regno, msb, lsb) { (regno), (msb), (lsb) }
 
+#define RX_CHK_SYNC	PHY_F(0, 5, 5)	/* RX sync mode */
+#define RX_SYNC_SEL	PHY_F(1, 1, 0)	/* RX sync length */
 #define LS_SLEW		PHY_F(10, 6, 6)	/* LS mode slew rate */
 #define FS_LS_DRV	PHY_F(10, 5, 5)	/* FS/LS slew rate */
 
-#define MAX_PHY_PARAMS	2
+#define MAX_PHY_PARAMS	4
 
 struct uniphier_u3hsphy_param {
 	struct {
@@ -395,13 +397,19 @@ static const struct uniphier_u3hsphy_soc_data uniphier_pro5_data = {
 
 static const struct uniphier_u3hsphy_soc_data uniphier_pxs2_data = {
 	.is_legacy = false,
-	.nparams = 0,
+	.nparams = 2,
+	.param = {
+		{ RX_CHK_SYNC, 1 },
+		{ RX_SYNC_SEL, 1 },
+	},
 };
 
 static const struct uniphier_u3hsphy_soc_data uniphier_ld20_data = {
 	.is_legacy = false,
-	.nparams = 2,
+	.nparams = 4,
 	.param = {
+		{ RX_CHK_SYNC, 1 },
+		{ RX_SYNC_SEL, 1 },
 		{ LS_SLEW, 1 },
 		{ FS_LS_DRV, 1 },
 	},
@@ -412,7 +420,11 @@ static const struct uniphier_u3hsphy_soc_data uniphier_ld20_data = {
 
 static const struct uniphier_u3hsphy_soc_data uniphier_pxs3_data = {
 	.is_legacy = false,
-	.nparams = 0,
+	.nparams = 2,
+	.param = {
+		{ RX_CHK_SYNC, 1 },
+		{ RX_SYNC_SEL, 1 },
+	},
 	.trim_func = uniphier_u3hsphy_trim_ld20,
 	.config0 = 0x92316680,
 	.config1 = 0x00000106,
-- 
2.7.4

