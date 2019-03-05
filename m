Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13038C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55D020842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RnTnpGoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCEKUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:20:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55991 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfCEKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101926euoutp0261274d2672b3fa48bfdc81c30b2a9f36~JCL-oOyEG1526615266euoutp02T
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190305101926euoutp0261274d2672b3fa48bfdc81c30b2a9f36~JCL-oOyEG1526615266euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781166;
        bh=U5K8xHcUvhZEOi6XmO+Yoim6jfdlGDdgbGbWMk2RDBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnTnpGoaWY23sz6WWHqg5fur5fNpIEAvOTWUX4dT7JXph0hUiC8+dqLjOI7nAGaO8
         72CLKzMualDfhc/VU5P+D2RiRJdkigG5Nla6MwLV+J/7LCuE1VRoWsfmZgcFuIzIWi
         wKwxjWR/v/MxhktbeYQYBh8Vdx2F1ruu6rHUAyKU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190305101926eucas1p2f8aed19ca981b58e0396076afde45312~JCL__lGke2248022480eucas1p2D;
        Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D9.9E.04294.D2D4E7C5; Tue,  5
        Mar 2019 10:19:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395~JCL_ORe2t2248422484eucas1p20;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101925eusmtrp2f532dda2fdd459194a74b6233c1b947e~JCL_M8UXg2083020830eusmtrp2z;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-8a-5c7e4d2d0644
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.46.04284.D2D4E7C5; Tue,  5
        Mar 2019 10:19:25 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101924eusmtip13221e7248f835e02a145f18e13b9be3f~JCL9lTHvT3017830178eusmtip1I;
        Tue,  5 Mar 2019 10:19:24 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 2/8] clk: samsung: add new clocks for DMC for Exynos5422
 SoC
Date:   Tue,  5 Mar 2019 11:19:05 +0100
Message-Id: <1551781151-5562-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7q6vnUxBv/2mllsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKODu3j63gv05Fz60V
        TA2MF9S6GDk5JARMJDZ1tzJ3MXJxCAmsYJRo2v6JHcL5wijx/VI7E4TzmVGi998eti5GDrCW
        Zx0pEPHljBKXPv5lhOs4cmI6E0gRm4CexI5VhSArRASqJe5c3w+2glngLaPEzJtfWEASwgKB
        Em09j1lBbBYBVYlF0zayg/TyCnhKXPouBXGenMTNc53MIDangJfE/oXrweZICExnl9ixYD8b
        RJGLxPWmQywQtrDEq+Nb2CFsGYn/O+czQdjFEmc7VkHV10i0n9wBVWMtcfj4RVaQvcwCmhLr
        d+lDhB0l9n+4zQzxL5/EjbeCIGFmIHPStulQYV6JjjYhiGoNiS09F6AWiUksXzMNariHxPNN
        C1ggoTOXUWLtyaesExjlZyEsW8DIuIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwoZz+
        d/zLDsZdf5IOMQpwMCrx8GaY1cYIsSaWFVfmHmKU4GBWEuH9I14XI8SbklhZlVqUH19UmpNa
        fIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoFxjv42NZWD4sW8zU8WFL9fO/PUzay8
        qW0TJlifW7TIy+vO6bbCkg2TOp1fX16/Nv0ve11U1SnLAz5aR8/0Xkl4YP5jvsKK/HAJC41F
        q9fPPr7ZiJm5pnv+zhfOMhOZ+du9V0eyPg7g0JaYtJtHu+X9jLi3us02T0+kMCSqZH92YC1+
        cYrz4MmDSizFGYmGWsxFxYkATOivACQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7q6vnUxBmf3C1lsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLODu3j63gv05Fz60VTA2MF9S6GDk4JARMJJ51pHQx
        cnIICSxllDi9SBTElhAQk5i0bzs7hC0s8edaF1sXIxdQzSdGiSOHr7KB9LIJ6EnsWFUIUiMi
        UC/R/+YSWA2zwHdGiUNPJjCCJIQF/CUm3J7ICmKzCKhKLJq2kR2kl1fAU+LSdymI+XISN891
        MoPYnAJeEvsXrmeGuMdTYurXhSwTGPkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAzv
        bcd+bt7BeGlj8CFGAQ5GJR7eDLPaGCHWxLLiytxDjBIczEoivH/E62KEeFMSK6tSi/Lji0pz
        UosPMZoC3TSRWUo0OR8Ye3kl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqY
        ODilGhgbPj/RDI5S74hZoS5okxt8bWEQ/45rOSIcd1Tc7shXu6s4Wr18lRpxfstVJh7B7XMO
        TzyydkHERo7F14WOmIe+Cb91t2h3mNBNLf0DJVk3Hy56lL9F3aj93m7JqNkWdRVRVxcwHdz0
        TX3qYTGDRK1zDdzrOv0Pxnw4Xn9j5wKV4HbZg19SluYpsRRnJBpqMRcVJwIA0gkToIUCAAA=
X-CMS-MailID: 20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 54 +++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c..6da5875 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -134,6 +134,10 @@
 #define SRC_CDREX		0x20200
 #define DIV_CDREX0		0x20500
 #define DIV_CDREX1		0x20504
+#define GATE_BUS_CDREX0		0x20700
+#define GATE_BUS_CDREX1		0x20704
+#define CDREX_PAUSE		0x2091c
+#define CDREX_LPDDR3PHY_CON3	0x20a20
 #define KPLL_LOCK		0x28000
 #define KPLL_CON0		0x28100
 #define SRC_KFC			0x28200
@@ -248,6 +252,10 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	DIV_CDREX1,
 	SRC_KFC,
 	DIV_KFC0,
+	GATE_BUS_CDREX0,
+	GATE_BUS_CDREX1,
+	CDREX_PAUSE,
+	CDREX_LPDDR3PHY_CON3,
 };
 
 static const unsigned long exynos5800_clk_regs[] __initconst = {
@@ -425,6 +433,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
 PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
 PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
 PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
+PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
+					"mout_sclk_mpll", "ff_dout_spll2",
+					"mout_sclk_spll", "mout_sclk_epll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock
@@ -450,7 +461,7 @@ static const struct samsung_fixed_factor_clock
 static const struct samsung_fixed_factor_clock
 		exynos5800_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
-	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
+	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
 
 static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
@@ -472,11 +483,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
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
@@ -648,7 +662,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
@@ -817,6 +831,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
 			DIV_CDREX0, 3, 5),
 
+	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
+
 	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
 			DIV_CDREX1, 8, 3),
 
@@ -1170,6 +1186,36 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
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
+
+	GATE(CLK_CDREX_PAUSE, "clk_cdrex_pause", NULL, CDREX_PAUSE, 0, 0, 0),
+	GATE(CLK_CDREX_TIMING_SET, "clk_cdrex_timing_set", NULL,
+			CDREX_LPDDR3PHY_CON3, 28, 0, 0),
 };
 
 static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
-- 
2.7.4

