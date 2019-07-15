Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39097C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BEC2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eh5O17bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfGOMor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:44:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60195 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfGOMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124443euoutp01e71e850ae87849e307913b79337b17e7~xlUhm8jJf1950319503euoutp01f
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124443euoutp01e71e850ae87849e307913b79337b17e7~xlUhm8jJf1950319503euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194683;
        bh=TNMDlrEGNX0c/FAGLJwBwogSDFomMQGZ5XtYvST6wPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eh5O17bFBwnwBxJd70Atq/x3LeK8D9H5KeLLo6NbIOqwqY35nHdAjjVypNcuIg1SE
         KNLzPqUHKwnhX1fbjqYoLRuknDrFzUZzJ78PaFGW5eO5ZfnpiOhAYqfNGoEiXAUHZE
         DINtO+xYiqDM/eMg13I9xCoUqGYgei0J9/lmX36k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124442eucas1p2562922978ee9e08e0f404e1097496662~xlUgrk9Ss3211032110eucas1p2w;
        Mon, 15 Jul 2019 12:44:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DA.D1.04377.A357C2D5; Mon, 15
        Jul 2019 13:44:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102~xlUfyZRCm2241922419eucas1p2V;
        Mon, 15 Jul 2019 12:44:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124441eusmtrp198c759f5d51d3e8d43f6025759cdd4e2~xlUfkQ2CZ0462004620eusmtrp1A;
        Mon, 15 Jul 2019 12:44:41 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-df-5d2c753a56d7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.F6.04140.9357C2D5; Mon, 15
        Jul 2019 13:44:41 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124440eusmtip2f4d8cfd6fc6015a063e3e51c1617dfd8~xlUez3HkV1115211152eusmtip2G;
        Mon, 15 Jul 2019 12:44:40 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v1 10/50] clk: samsung: change ACLK100_NOC clocks
 definitions Exynos5x
Date:   Mon, 15 Jul 2019 14:43:37 +0200
Message-Id: <20190715124417.4787-11-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87pWpTqxBldmqFjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6Mc8tOMhdckqiY/uYLSwNjv2gXIweH
        hICJxMEVGV2MXBxCAisYJfo+/mODcL4wSrQ0TWWHcD4zSqw9eJK1i5ETrGPOrJUsEInljBJd
        8/+wwrWcf/+JGWQum4CexI5VhSANIgJLGCWO/EwCqWEWuMkksefJTrBJwgIREvM/72QGsVkE
        VCWu/mhiArF5Bewlds7YzgSxTV5i9YYDYDWcQPGf0y6A3SchcIld4vvZZSwQRS4SUy/0MELY
        whKvjm9hh7BlJE5P7oGqKZZo6F0IVVMj8bh/LlSNtcTh4xdZQY5mFtCUWL9LHxIujhKfLgRD
        mHwSN94KghQzA5mTtk1nhgjzSnS0CUHM0JDY0nMB6mAxieVrpkHN9pC427oeGoaTGCVeXpvO
        MoFRfhbCrgWMjKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzEC09Tpf8e/7GDc9SfpEKMA
        B6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+i
        hQTSE0tSs1NTC1KLYLJMHJxSDYyBPLn/buzlsONfYM+wWuMH/5vP4jdl10wyfMzykydoypHk
        gHUaaSYvxdbcLpHgW55VFdphf+ju+Tk2ZodS5+XxCqq6nMmc9zp45dGcb/eXhJ4/VctsoXrI
        rOdl8x45gbV/J/7+le8T89vBe2Lvp5o5PFXfDhRNjOPNPB4QwL1LSePJxI/vcpqVWIozEg21
        mIuKEwG5y7KbTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7qWpTqxBr++qVncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mc8tOMhdckqiY/uYLSwNjv2gXIyeHhICJxJxZK1m6GLk4hASWMkos
        29vNBJEQk5i0bzs7hC0s8edaFxtE0SdGiXNrLjF3MXJwsAnoSexYVQhSIyKwglFi8glvkBpm
        gddMEkeOvmMFSQgLhEn8nfqbDcRmEVCVuPqjCWwBr4C9xM4Z26GWyUus3nCAGcTmBIr/nHYB
        rF5IwE5i8dGfTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJ1tx35u2cHY9S74
        EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYS
        Tc4HxnVeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGx1DGd7uv
        Lp8fE6ney/3fkd922qdb3+zE3y4S+7Ve4eXT+1c5A/ZYNVt2uFhMv3by22J5JbULsVHMZjt+
        M6y5o3bp7s7a2zYrOlkWdWXuePpy+edLapWrv81X4So1esJpdbo/+veyd/qPF/cH9c3yjZRz
        Uojcnf5wRWGVUinjjy/laucfO7FOUWIpzkg01GIuKk4EAL0oZN+zAgAA
X-CMS-MailID: 20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACLK100_NOC has different topology in Exynos5420 and 5422/5800.  In
Exynos5420 this clock divider has 3 bits while in 5422/5800 has 4 bits.
The patch adds needed dividers in the exynos5800_div_clks, updates
exynos5x_div_clks and exynos5420_div_clks properly. It also adds IDs to
manage clocks from DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 6164d0ca75e0..c13f34d3d9a1 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -471,7 +471,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 			SRC_TOP0, 4, 3),
 	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
 			SRC_TOP0, 16, 3),
-	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
+	MUX(CLK_MOUT_ACLK100_NOC, "mout_aclk100_noc", mout_group1_5800_p,
+			SRC_TOP0, 20, 2),
 
 	MUX(0, "mout_aclk333_432_gscl", mout_group6_5800_p, SRC_TOP1, 0, 2),
 	MUX(0, "mout_aclk333_432_isp", mout_group6_5800_p, SRC_TOP1, 4, 2),
@@ -534,6 +535,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 static const struct samsung_div_clock exynos5800_div_clks[] __initconst = {
 	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
 			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
+	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
+				DIV_TOP0, 20, 4),
 	DIV(CLK_DOUT_ACLK266_ISP, "dout_aclk266_isp", "mout_aclk266_isp",
 				DIV_TOP8, 12, 3),
 	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
@@ -569,7 +572,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 			SRC_TOP0, 4, 2),
 	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
 			SRC_TOP0, 16, 2),
-	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
+	MUX(CLK_MOUT_ACLK100_NOC, "mout_aclk100_noc", mout_group1_p,
+			SRC_TOP0, 20, 2),
 
 	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
 	MUX(0, "mout_aclk333_432_isp", mout_group4_p,
@@ -600,6 +604,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
 	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
 			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
+	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
+			DIV_TOP0, 20, 3),
 };
 
 static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
@@ -798,8 +804,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 			DIV_TOP0, 8, 3),
 	DIV(CLK_DOUT_ACLK200_FSYS2, "dout_aclk200_fsys2", "mout_aclk200_fsys2",
 			DIV_TOP0, 12, 3),
-	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
-			DIV_TOP0, 20, 3),
 	DIV(CLK_DOUT_PCLK200_FSYS, "dout_pclk200_fsys", "mout_pclk200_fsys",
 			DIV_TOP0, 24, 3),
 	DIV(CLK_DOUT_ACLK200_FSYS, "dout_aclk200_fsys", "mout_aclk200_fsys",
-- 
2.17.1

