Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A25F22305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WSYqiLWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbfHGQZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:25:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58577 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfHGQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:25:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190807162520euoutp02d2a2187832bdb80cd4dd2d20306b805e~4sKt2y5l30958909589euoutp02t
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 16:25:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190807162520euoutp02d2a2187832bdb80cd4dd2d20306b805e~4sKt2y5l30958909589euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565195121;
        bh=e4V3n15NejQLJexU0bI5ndoE5lrFTygI51wyYNTNvSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSYqiLWbILBn9zijvg7jprJ9xI9H2Jdt51nbWngWsyCaGobzdCigv7DNbVhKjMF2W
         4ZTVQKlZys0CGhSM5yKL7Qo3C9x55TgPskmx8WWKAxPS8XeBd3wOndEKMOa6LQjXg/
         DqWbHrmPMo36E6Oyn1fqOjiYW57XtU7jB23DL8WQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190807162519eucas1p299e939670fc0f55b8acfd93fc13e04b9~4sKs1tiHo1057410574eucas1p2v;
        Wed,  7 Aug 2019 16:25:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.78.04469.F6BFA4D5; Wed,  7
        Aug 2019 17:25:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908~4sKsGwlTH1057410574eucas1p2u;
        Wed,  7 Aug 2019 16:25:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190807162518eusmtrp29c81592a58a847a1e5061d54b81ecdc6~4sKr4pti_2157121571eusmtrp2F;
        Wed,  7 Aug 2019 16:25:18 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-ec-5d4afb6ff7f6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.FF.04117.E6BFA4D5; Wed,  7
        Aug 2019 17:25:18 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807162518eusmtip2186b8040cab7be22ff541be5cec5b0ee~4sKrV-tOV0776307763eusmtip2_;
        Wed,  7 Aug 2019 16:25:18 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/2] clk: samsung: exynos5800: Move MAU subsystem clocks to
 MAU sub-CMU
Date:   Wed,  7 Aug 2019 18:24:56 +0200
Message-Id: <20190807162456.28694-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807162456.28694-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned38316xBjO2KVlsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytTj8pp3V4t+1jSwO3B6Xr11k
        9nh/o5XdY9OqTjaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgypjZMJupYKlOxZ+P/g2MZ1S7
        GDk5JARMJD7sPMfexcjFISSwglHi1up/zBDOF0aJjvaTTBDOZ0aJg/MXMMO03Li8jgnEFhJY
        zijxtk0YruPBxl/sIAk2AUOJ3qN9jCC2iICuRPuyfWwgRcwCLUwSV78sApskLBApcfzHKrAi
        FgFViV+LfoDFeQWsJS7taWWF2CYvsXrDAaA4BwengI3Ey5ehIHMkBPrZJd5/2M8EUeMisfHW
        NhYIW1ji1fEt7BC2jMT/nfOZIBqaGSV6dt9mh3AmMErcP76AEaLKWuLw8YusIBuYBTQl1u/S
        hwg7SjzvAinhALL5JG68FQQJMwOZk7ZNZ4YI80p0tAlBVKtI/F41HeocKYnuJ/+hzvGQ+LD4
        AhsksPoZJU5OZ5zAKD8LYdcCRsZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgYnk9L/j
        n3Ywfr2UdIhRgINRiYeX4YJXrBBrYllxZe4hRgkOZiUR3ntlnrFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGCeH7Z0Y2Xjpz/Q+ZrHOJZuFZa4b3vYq
        F8y6fvzV/IkNZ6J2/Sgxin+vxv+fIerCxWxWsQdaZotD27S4F8wrnRnlfPXlo6c2XSq7637p
        T43eN+0kW7Xk3J0v+hZ1XPx45ff9z4t+P1B7M88n5rTxCktFycCnnxxnrchryVGJP5arLjY7
        /Te3taESS3FGoqEWc1FxIgDJL9ekIAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xe7p5v71iDdY+0LfYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF5V1z2CxmnN/HZHFo6l5Gi7VH7rJbXDzlanH4TTurxb9rG1kcuD0uX7vI
        7PH+Riu7x6ZVnWwefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5eglzGzYTZTwVKdij8f/RsYz6h2MXJySAiYSNy4vI6pi5GLQ0hg
        KaPEzBfvWbsYOYASUhLzW5QgaoQl/lzrYoOo+cQo8WLSERaQBJuAoUTv0T5GEFtEQF9ictsG
        FpAiZoE+Jok7t66wgiSEBcIlns5/AWazCKhK/Fr0gxnE5hWwlri0p5UVYoO8xOoNB5hBFnMK
        2Ei8fBkKEhYCKpn29grrBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLDetuxn1t2
        MHa9Cz7EKMDBqMTDy3DBK1aINbGsuDL3EKMEB7OSCO+9Ms9YId6UxMqq1KL8+KLSnNTiQ4ym
        QDdNZJYSTc4HxlxeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG
        6RNMObaEm/7zP3PveXWylUruhDWzTz9isXtUz3HkYcN8ZkHLTV/2Nu5ZX695p8h02g9mo7wL
        5+/5qH+oj/b6/zl/7VXzOezSdgGCm04+aQh0zJ7FOjM/ovDRnYMGaSvVGTYt1lRU1ZA/cGqT
        08xkIV6R0/E1a9Xz+sS/FL6U3TJZt/4Nx1deJZbijERDLeai4kQAlNvfjoECAAA=
X-CMS-MailID: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
References: <20190807162456.28694-1-s.nawrocki@samsung.com>
        <CGME20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908@eucas1p2.samsung.com>
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
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 54 ++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index fdb17c799aa5..b52daf5aa755 100644
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
+	{ SRC_TOP9, 0, BIT(8) },
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

