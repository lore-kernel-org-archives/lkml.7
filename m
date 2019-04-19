Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED26C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2312D20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FPvJAlCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfDSTHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:07:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38838 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfDSTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141943euoutp01199879cd02edf2bee587ff86a4207fd5~W5fojiQ6g2266922669euoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419141943euoutp01199879cd02edf2bee587ff86a4207fd5~W5fojiQ6g2266922669euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683583;
        bh=C2tdTtWSeshqlPhC+pKg/s233r729zk+1+hYWIP5TKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPvJAlCdYL98oxCAuu6Ls+C3tqmX/Mbczdj4izfOqBQI/PXxu6vFd9qlNizafNoc0
         KCJcpefYim7JUIxFRH2EhzCACLOr4lCnYsbekEWYI4r+n/gPaSfgDSZTEBBkGe6Ugq
         kIjouEM05ZEGj7GmShQ3KLyvE5BwQ80pZJmg93MA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419141942eucas1p15a35b1b1d0d5ec2340fee7c539fedb53~W5fnynQfW0188401884eucas1p1G;
        Fri, 19 Apr 2019 14:19:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.B2.04325.EF8D9BC5; Fri, 19
        Apr 2019 15:19:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb~W5fnDEBTd2212122121eucas1p28;
        Fri, 19 Apr 2019 14:19:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141941eusmtrp1d0280d6a80ef72d1cb39be2a961b6d5b~W5fm07cTx1759317593eusmtrp1W;
        Fri, 19 Apr 2019 14:19:41 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-7e-5cb9d8fedb94
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.90.04140.DF8D9BC5; Fri, 19
        Apr 2019 15:19:41 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141941eusmtip23a62155f580f29aa78f32f40b53eafbd~W5fmDzTQ83043830438eusmtip2-;
        Fri, 19 Apr 2019 14:19:41 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 02/10] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date:   Fri, 19 Apr 2019 16:19:20 +0200
Message-Id: <1555683568-20882-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3bO2Y6jyWmafpkYLKNcqJVFHyqSVHCw/ggikDJq5fFCTm1H
        TTNwOrG82yw1zTIivC5Lh6iE90t5m6LivOWtrNQU80KmSB4367/f97zP+7wvLx+JiZsJK9I/
        MIRRBMoCJHwhXtGyprPf1Fd5HYtpPozeZ5USaGD5G4FeNnURqHhxCqD0tlwe6kiUo9SpWQzp
        dO8EqDNmToCGlNaot/o5Hy0lNwGUpavhIU3TqAANRxfwUePcQwLV9nmg4XVTtPpxEpwxo1dX
        1Dido+zB6arsUQFdVhTPp5NV83y6fv4Dj07RFgG6vD2SXiqzuWRyVejqzQT4hzEKR7ebQr++
        +g5+8Lg0XPOmjlACvW0CMCEhdRKqFquwBCAkxVQBgKl1scbHMoATymTAucTUEoAd6+KdjuLB
        H4TBlA/g6/li4l/H97QveAIgST7lACuL7nIN5lQkHBmo3U7FqDke7PzzG+cKZtRlOBTdvs04
        dQi2NMXzOBZRHlBdqcIN02zgYFc8xrEJdQFWF2r5XBCkJgVwdrhPYDCdg9NrGiObwZlWrZGt
        YXt6kjGIhcrkV8DAD+BUaq7R4wIbW3sIbmmMsoOl1Y4G2R3q9dM8ToaUKdT/3MPJ2BaqKzIx
        gyyCj+KMNzkCtUndPANbwPySDGM4DdcWCozneQFgnm4epIED2f+H5QFQBCyZUFbuy7BOgcw9
        B1YmZ0MDfR1uB8nLwNbnat9sXakENRu3GgBFAsluUZ26yktMyMLYCHkDgCQmMRe5e2u9xCJv
        WcR9RhF0QxEawLANYD+JSyxFkbvGr4kpX1kIc4dhghnFTpVHmlgpQYm5SJp71H7jYLfwxPX1
        swuo9Ep/ytd8f2uyc3Ci3GWo95SgTWzat4LPOO17GukWlZihclSpLEcsHg/Xa9Q+7vGnpRr/
        t3sXYp5kZ6aO/RoLCffsH4pzTu/RS7QTsbZ2F5+1tPmN5BR6Oie4O414TI165EV/alMLzrta
        fI4q9nGQ4Kyf7LgUU7CyvyGVi4BYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7p/b+yMMTg/08xi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jCsHz7AVPNCqWLv0AGsD4w2VLkZODgkBE4nVN1+y
        djFycQgJLGWUOHTqEDNEQkxi0r7t7BC2sMSfa11sEEWfGCWWnD4PlODgYBPQk9ixqhCkRkSg
        XqL/zSWwGmaBBmaJNduvsoIkhAUCJTqXzgEbxCKgKnHsSCcTiM0r4CUxaUczC8QCOYmb5zrB
        FnMKeEvsWrmFDcQWAqrZcG0v0wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY2nb
        sZ9bdjB2vQs+xCjAwajEw3tg0s4YIdbEsuLK3EOMEhzMSiK8jilbYoR4UxIrq1KL8uOLSnNS
        iw8xmgIdNZFZSjQ5HxjneSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4
        OKUaGBN/R8jr/ZB6Nyv++wK/nea2apvTEmfq3lkR/3fu/J9Zp/p/33m+xuXE5EsPhW7bHDST
        eRd/aGbgp+OZ78KVfx0rSXQ2axW8bilQ+dRpQ/uuKWZyep/rWdckHGe5cqW0beL/Pb/E9W0+
        xcVeZtukITxZrSC2IGf3bcXsyEWRm78pHvq95EjV/FNKLMUZiYZazEXFiQAmsgS3uwIAAA==
X-CMS-MailID: 20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141942eucas1p2eaa1d17d785a27632b214a2da011a9fb@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c..d9e6653 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -134,6 +134,8 @@
 #define SRC_CDREX		0x20200
 #define DIV_CDREX0		0x20500
 #define DIV_CDREX1		0x20504
+#define GATE_BUS_CDREX0		0x20700
+#define GATE_BUS_CDREX1		0x20704
 #define KPLL_LOCK		0x28000
 #define KPLL_CON0		0x28100
 #define SRC_KFC			0x28200
@@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	DIV_CDREX1,
 	SRC_KFC,
 	DIV_KFC0,
+	GATE_BUS_CDREX0,
+	GATE_BUS_CDREX1,
 };
 
 static const unsigned long exynos5800_clk_regs[] __initconst = {
@@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
 PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
 PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
 PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
+PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
+					"mout_sclk_mpll", "ff_dout_spll2",
+					"mout_sclk_spll", "mout_sclk_epll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock
@@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
 static const struct samsung_fixed_factor_clock
 		exynos5800_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
-	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
+	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
 
 static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
@@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
 
+	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
+		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
+
 	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
-			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
+			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
 	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
 			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
-	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
+	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
 	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
 
 	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
@@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
@@ -817,6 +827,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
 			DIV_CDREX0, 3, 5),
 
+	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
+
 	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
 			DIV_CDREX1, 8, 3),
 
@@ -1170,6 +1182,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
 
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
+
+	/* CDREX */
+	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
+			GATE_BUS_CDREX0, 0, 0, 0),
+	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
+			GATE_BUS_CDREX0, 1, 0, 0),
+	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
+			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
 };
 
 static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
-- 
2.7.4

