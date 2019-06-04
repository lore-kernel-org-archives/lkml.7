Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8550AC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 01:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6948B26341
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 01:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFDB6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 21:58:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50952 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfFDB6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 21:58:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C6B991A0592;
        Tue,  4 Jun 2019 03:57:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 750431A0583;
        Tue,  4 Jun 2019 03:57:48 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B89A7402D8;
        Tue,  4 Jun 2019 09:57:34 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, maxime.ripard@bootlin.com, olof@lixom.net,
        horms+renesas@verge.net.au, jagan@amarulasolutions.com,
        bjorn.andersson@linaro.org, leonard.crestez@nxp.com,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        aisheng.dong@nxp.com, ping.bai@nxp.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 2/4] clk: imx8mm: Make 1416X/1443X PLL macro definitions common for usage
Date:   Tue,  4 Jun 2019 09:59:26 +0800
Message-Id: <20190604015928.23157-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604015928.23157-1-Anson.Huang@nxp.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

1416X/1443X PLL are used on i.MX8MM and i.MX8MN and maybe
other i.MX8M series SoC later, the macro definitions of
these PLLs' initialization should be common for usage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch.
---
 drivers/clk/imx/clk-imx8mm.c | 17 -----------------
 drivers/clk/imx/clk.h        | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index eb9fcf0..fecb3b2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -26,23 +26,6 @@ static u32 share_count_dcss;
 static u32 share_count_pdm;
 static u32 share_count_nand;
 
-#define PLL_1416X_RATE(_rate, _m, _p, _s)		\
-	{						\
-		.rate	=	(_rate),		\
-		.mdiv	=	(_m),			\
-		.pdiv	=	(_p),			\
-		.sdiv	=	(_s),			\
-	}
-
-#define PLL_1443X_RATE(_rate, _m, _p, _s, _k)		\
-	{						\
-		.rate	=	(_rate),		\
-		.mdiv	=	(_m),			\
-		.pdiv	=	(_p),			\
-		.sdiv	=	(_s),			\
-		.kdiv	=	(_k),			\
-	}
-
 static const struct imx_pll14xx_rate_table imx8mm_pll1416x_tbl[] = {
 	PLL_1416X_RATE(1800000000U, 225, 3, 0),
 	PLL_1416X_RATE(1600000000U, 200, 3, 0),
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6dcdc91..ac8c4ae 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -81,6 +81,23 @@ enum imx_pllv3_type {
 	IMX_PLLV3_AV_IMX7,
 };
 
+#define PLL_1416X_RATE(_rate, _m, _p, _s)		\
+	{						\
+		.rate	=	(_rate),		\
+		.mdiv	=	(_m),			\
+		.pdiv	=	(_p),			\
+		.sdiv	=	(_s),			\
+	}
+
+#define PLL_1443X_RATE(_rate, _m, _p, _s, _k)		\
+	{						\
+		.rate	=	(_rate),		\
+		.mdiv	=	(_m),			\
+		.pdiv	=	(_p),			\
+		.sdiv	=	(_s),			\
+		.kdiv	=	(_k),			\
+	}
+
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		const char *parent_name, void __iomem *base, u32 div_mask);
 
-- 
2.7.4

