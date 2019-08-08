Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6663EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9D72173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cw2cqikG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbfHHOtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:49:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43681 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbfHHOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:49:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808144942euoutp013977f7c86d4cfe6b7894e7d614e97cc7~4_ggFK_J22022720227euoutp01-
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 14:49:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808144942euoutp013977f7c86d4cfe6b7894e7d614e97cc7~4_ggFK_J22022720227euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565275782;
        bh=ETe6mWTx7M+kQkPCq5ybQ2YGQUtzej8BOuaUy6CKQEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cw2cqikGTx6W5x4puaxbxqlPNM1twAsSPJDbSmtEAvhWIcAhCd6ZfU+cUce7blhls
         O6SAsHHNF/dgrSFRwENqON4Uc0J/kUYXgnqqcbCHb+QKbUCaeRshm4S2uhPaiXRLES
         qdRsXbovTwhSCxQo0AgIZ1joAKJi3h0Orq6SDeCQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808144942eucas1p2dc0c08a1daf05235e3128fd8bcc2db0a~4_gfaQadA0510205102eucas1p2M;
        Thu,  8 Aug 2019 14:49:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.7D.04374.5863C4D5; Thu,  8
        Aug 2019 15:49:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808144941eucas1p1b6ba7aadd0c31aedf765a0f90ed6213f~4_ges5nlY0291102911eucas1p1l;
        Thu,  8 Aug 2019 14:49:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808144941eusmtrp23edc51a0d2ecb2ecccbde6cef24b04f6~4_gee4gVi2304023040eusmtrp2U;
        Thu,  8 Aug 2019 14:49:41 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-ff-5d4c3685bea5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.2D.04117.5863C4D5; Thu,  8
        Aug 2019 15:49:41 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808144940eusmtip25d5b9b954ad7871ca208eddcac8c4fc0~4_geBYPf31427914279eusmtip22;
        Thu,  8 Aug 2019 14:49:40 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/2] clk: samsung: exynos5800: Move MAU subsystem clocks
 to MAU sub-CMU
Date:   Thu,  8 Aug 2019 16:49:29 +0200
Message-Id: <20190808144929.18685-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808144929.18685-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzned1WM59Yg01dxhYbZ6xntbj+5Tmr
        xfnzG9gtPvbcY7W4vGsOm8WM8/uYLA5N3ctosfbIXXaLi6dcLQ6/aWe1+HdtI4sDt8flaxeZ
        Pd7faGX32LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mo48Ps1acFa3YnLbNtYGxttq
        XYycHBICJhI7Xk1g7mLk4hASWMEo8WnPVjYI5wujxOHuhVDOZ0aJqT/+MsO07FkJ07KcUeJI
        /w0WuJYV5y8xglSxCRhK9B7tA7NFBHQl2pftAxvFLNDCJHH1yyKwUcICMRK378xiA7FZBFQl
        dp5cwgRi8wpYS5w7uYYNYp28xOoNB4DqOTg4BWwkvr4wB5kjIdDPLrFn/QyoGheJyReb2SFs
        YYlXx7dA2TIS/3fOZ4JoaGaU6Nl9mx3CmcAocf/4AkaIKmuJw8cvsoJsYBbQlFi/Sx8i7Cix
        7PJWRpCwhACfxI23giBhZiBz0rbpzBBhXomONiGIahWJ36umM0HYUhLdT/6zQNgeEgf3LgVb
        JCTQzyhxYDXfBEb5WQi7FjAyrmIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMJqf/Hf+6
        g3Hfn6RDjAIcjEo8vA2KPrFCrIllxZW5hxglOJiVRHjvlXnGCvGmJFZWpRblxxeV5qQWH2KU
        5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamDMfPxhSj/72zMhdYxLkvkOnXHYxCL2aRLP
        QbET6sdW7NI+Hn9gQrvK6oan+9Tm31gSelq9U4JlX1Z7lPAvfff3Nh4yzj7yZqHP2ANi3Nfc
        DJy7oHXfaX+vcr0stq7XFzLXruNszNd8XO6hUBF5SSvFMs3c5PhHbuXknc/OJLvP2pbZW9hV
        bavEUpyRaKjFXFScCABYLmvHIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsVy+t/xe7qtZj6xBivWs1tsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytTj8pp3V4t+1jSwO3B6Xr11k
        9nh/o5XdY9OqTjaPvi2rGD0+b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQyzjy+DRrwVndislt21gbGG+rdTFyckgImEjsWTmBuYuRi0NI
        YCmjxJ6W/exdjBxACSmJ+S1KEDXCEn+udbFB1HxilOhvOMkKkmATMJToPdrHCGKLCOhLTG7b
        wAJSxCzQxyRx59YVsCJhgSiJv4vWMIHYLAKqEjtPLgGzeQWsJc6dXMMGsUFeYvWGA8wgizkF
        bCS+vjAHCQsBlby7sZd9AiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGBve3Yzy07
        GLveBR9iFOBgVOLh1ZD3iRViTSwrrsw9xCjBwawkwnuvzDNWiDclsbIqtSg/vqg0J7X4EKMp
        0E0TmaVEk/OBUZdXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHx
        miD70cVBvAfzg11yov6d6endeJdPRibIYmZV0LTulVy/r+z/YBje4h2zxvCs6gEPu+JHEZuD
        M98pnX9WtXH7p8dBbt23Dh9xaNrvG/VStWKiX512C/fTkHUGc0Un912ZweC7RaUv9YHEkpeh
        ExIabp/iWmz+SvGOd11FeLNx4YJo6zTlv8VKLMUZiYZazEXFiQBeXJjXggIAAA==
X-CMS-MailID: 20190808144941eucas1p1b6ba7aadd0c31aedf765a0f90ed6213f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808144941eucas1p1b6ba7aadd0c31aedf765a0f90ed6213f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808144941eucas1p1b6ba7aadd0c31aedf765a0f90ed6213f
References: <20190808144929.18685-1-s.nawrocki@samsung.com>
        <CGME20190808144941eucas1p1b6ba7aadd0c31aedf765a0f90ed6213f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes broken sound on Exynos5422/5800 platforms after
system/suspend resume cycle in cases where the audio root clock
is derived from MAU_EPLL_CLK.

In order to preserve state of the USER_MUX_MAU_EPLL_CLK clock mux
during system suspend/resume cycle for Exynos5800 we group the MAU
block input clocks in "MAU" sub-CMU and add the clock mux control
bit to .suspend_regs.  This ensures that user configuration of the mux
is not lost after the PMU block changes the mux setting to OSC_DIV
when switching off the MAU power domain.

Adding the SRC_TOP9 register to exynos5800_clk_regs[] array is not
sufficient as at the time of the syscore_ops suspend call MAU power
domain is already turned off and we already save and subsequently
restore an incorrect register's value.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Reported-by: Jaafar Ali <jaafarkhalaf@gmail.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Jaafar Ali <jaafarkhalaf@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - added comment to the exynos5800_mau_suspend_regs[] array entry
---
 drivers/clk/samsung/clk-exynos5420.c | 54 ++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index fdb17c799aa5..2d18e1ae25d7 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -534,8 +534,6 @@ static const struct samsung_gate_clock exynos5800_gate_clks[] __initconst = {
 				GATE_BUS_TOP, 24, 0, 0),
 	GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
 				GATE_BUS_TOP, 27, CLK_IS_CRITICAL, 0),
-	GATE(CLK_MAU_EPLL, "mau_epll", "mout_user_mau_epll",
-			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
@@ -577,8 +575,13 @@ static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
 
 static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
 	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
+	/* Maudio Block */
 	GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
 			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
+		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
+		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
@@ -1017,12 +1020,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(CLK_SCLK_DP1, "sclk_dp1", "dout_dp1",
 			GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
 
-	/* Maudio Block */
-	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
-		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
-		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
-
 	/* FSYS Block */
 	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
 	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
@@ -1281,6 +1278,20 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
 	{ DIV4_RATIO, 0, 0x3 },			/* DIV dout_mfc_blk */
 };
 
+
+static const struct samsung_gate_clock exynos5800_mau_gate_clks[] __initconst = {
+	GATE(CLK_MAU_EPLL, "mau_epll", "mout_user_mau_epll",
+			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
+		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
+		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static struct exynos5_subcmu_reg_dump exynos5800_mau_suspend_regs[] = {
+	{ SRC_TOP9, 0, BIT(8) },	/* MUX mout_user_mau_epll */
+};
+
 static const struct exynos5_subcmu_info exynos5x_disp_subcmu = {
 	.div_clks	= exynos5x_disp_div_clks,
 	.nr_div_clks	= ARRAY_SIZE(exynos5x_disp_div_clks),
@@ -1311,12 +1322,27 @@ static const struct exynos5_subcmu_info exynos5x_mfc_subcmu = {
 	.pd_name	= "MFC",
 };
 
+static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
+	.gate_clks	= exynos5800_mau_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5800_mau_gate_clks),
+	.suspend_regs	= exynos5800_mau_suspend_regs,
+	.nr_suspend_regs = ARRAY_SIZE(exynos5800_mau_suspend_regs),
+	.pd_name	= "MAU",
+};
+
 static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
 	&exynos5x_disp_subcmu,
 	&exynos5x_gsc_subcmu,
 	&exynos5x_mfc_subcmu,
 };
 
+static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
+	&exynos5x_disp_subcmu,
+	&exynos5x_gsc_subcmu,
+	&exynos5x_mfc_subcmu,
+	&exynos5800_mau_subcmu,
+};
+
 static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 2000000000, 250, 3, 0),
 	PLL_35XX_RATE(24 * MHZ, 1900000000, 475, 6, 0),
@@ -1547,11 +1573,17 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	samsung_clk_extended_sleep_init(reg_base,
 		exynos5x_clk_regs, ARRAY_SIZE(exynos5x_clk_regs),
 		exynos5420_set_clksrc, ARRAY_SIZE(exynos5420_set_clksrc));
-	if (soc == EXYNOS5800)
+
+	if (soc == EXYNOS5800) {
 		samsung_clk_sleep_init(reg_base, exynos5800_clk_regs,
 				       ARRAY_SIZE(exynos5800_clk_regs));
-	exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5x_subcmus),
-			     exynos5x_subcmus);
+
+		exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5800_subcmus),
+				     exynos5800_subcmus);
+	} else {
+		exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5x_subcmus),
+				     exynos5x_subcmus);
+	}
 
 	samsung_clk_of_add_provider(np, ctx);
 }
-- 
2.17.1

