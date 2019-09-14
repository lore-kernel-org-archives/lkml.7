Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7434C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3E206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfINNvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 09:51:11 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:40517 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728533AbfINNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 09:51:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id DE9675216E5;
        Sat, 14 Sep 2019 15:51:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A2R4GLbmMh5Y; Sat, 14 Sep 2019 15:51:06 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 74E795216ED;
        Sat, 14 Sep 2019 15:51:06 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 703945216E5;
        Sat, 14 Sep 2019 15:51:05 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] clk: sunxi-ng: h6: Use sigma-delta modulation for audio PLL
Date:   Sat, 14 Sep 2019 15:51:00 +0200
Message-Id: <20190914135100.327412-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio devices needs exact clock rates in order to correctly reproduce
the sound. Until now, only integer factors were used to configure H6
audio PLL which resulted in inexact rates. Fix that by adding support
for fractional factors using sigma-delta modulation look-up table. It
contains values for two most commonly used audio base frequencies.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
index d89353a3cdec..ed6338d74474 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -203,12 +203,21 @@ static struct ccu_nkmp pll_hsic_clk =3D {
  * hardcode it to match with the clock names.
  */
 #define SUN50I_H6_PLL_AUDIO_REG		0x078
+
+static struct ccu_sdm_setting pll_audio_sdm_table[] =3D {
+	{ .rate =3D 541900800, .pattern =3D 0xc001288d, .m =3D 1, .n =3D 22 },
+	{ .rate =3D 589824000, .pattern =3D 0xc00126e9, .m =3D 1, .n =3D 24 },
+};
+
 static struct ccu_nm pll_audio_base_clk =3D {
 	.enable		=3D BIT(31),
 	.lock		=3D BIT(28),
 	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.sdm		=3D _SUNXI_CCU_SDM(pll_audio_sdm_table,
+					 BIT(24), 0x178, BIT(31)),
 	.common		=3D {
+		.features	=3D CCU_FEATURE_SIGMA_DELTA_MOD,
 		.reg		=3D 0x078,
 		.hw.init	=3D CLK_HW_INIT("pll-audio-base", "osc24M",
 					      &ccu_nm_ops,
@@ -753,12 +762,12 @@ static const struct clk_hw *clk_parent_pll_audio[] =
=3D {
 };
=20
 /*
- * The divider of pll-audio is fixed to 8 now, as pll-audio-4x has a
- * fixed post-divider 2.
+ * The divider of pll-audio is fixed to 24 for now, so 24576000 and 2257=
9200
+ * rates can be set exactly in conjunction with sigma-delta modulation.
  */
 static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
 			    clk_parent_pll_audio,
-			    8, 1, CLK_SET_RATE_PARENT);
+			    24, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
 			    clk_parent_pll_audio,
 			    4, 1, CLK_SET_RATE_PARENT);
@@ -1215,12 +1224,12 @@ static int sun50i_h6_ccu_probe(struct platform_de=
vice *pdev)
 	}
=20
 	/*
-	 * Force the post-divider of pll-audio to 8 and the output divider
-	 * of it to 1, to make the clock name represents the real frequency.
+	 * Force the post-divider of pll-audio to 12 and the output divider
+	 * of it to 2, so 24576000 and 22579200 rates can be set exactly.
 	 */
 	val =3D readl(reg + SUN50I_H6_PLL_AUDIO_REG);
 	val &=3D ~(GENMASK(21, 16) | BIT(0));
-	writel(val | (7 << 16), reg + SUN50I_H6_PLL_AUDIO_REG);
+	writel(val | (11 << 16) | BIT(0), reg + SUN50I_H6_PLL_AUDIO_REG);
=20
 	/*
 	 * First clock parent (osc32K) is unusable for CEC. But since there
--=20
2.23.0

