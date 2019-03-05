Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BA2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ReZjlfy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCEKUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:20:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55992 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfCEKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101927euoutp02800ad696d29a96ffb6187d8f62c8af87~JCMAPVxQF1490714907euoutp02h
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190305101927euoutp02800ad696d29a96ffb6187d8f62c8af87~JCMAPVxQF1490714907euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781167;
        bh=2BpjDetpNJ7ni5VhYAX6nkgO0UKLqT6inWP8ROtDerY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReZjlfy9hB4ouFb9/mMf7gCy+1DKtDtGVYPG/D7E7Si1cWYhrgtnc2+jECd5f9t2e
         1/EZrwye4E1HdZn1+h5S8fEBE3GeadeY/Jx0w+50+Dzqc8xY1tjA7iYN/3jZoY6c+R
         jd7+NN/HNB5FE2m/5cmVMH7SfMwFZmhCfezMNdhU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190305101926eucas1p102c69f07ff212321963837109dc16512~JCL-p-cCQ0658206582eucas1p1Q;
        Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.9E.04294.E2D4E7C5; Tue,  5
        Mar 2019 10:19:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c~JCL_7j9XM0208002080eucas1p1k;
        Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101925eusmtrp2220ea5aafc0a67f66b80dd15925bc8ec~JCL_suASO2083020830eusmtrp21;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-8d-5c7e4d2ea133
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.1F.04128.D2D4E7C5; Tue,  5
        Mar 2019 10:19:25 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101925eusmtip1e8183f2b5ec98d86bbd46e42903434fc~JCL_JLFlR3045130451eusmtip1j;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 3/8] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Tue,  5 Mar 2019 11:19:06 +0100
Message-Id: <1551781151-5562-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7p6vnUxBq9maVlsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKeDrxCHvBQb6KCyun
        sTYwbuXpYuTkkBAwkfj18wRrFyMXh5DACkaJL+8us0A4Xxglfs1azQ7hfGaUmPz9IgtMy53J
        X6ESyxklZq29ygTXsuLvFKAMBwebgJ7EjlWFIA0iAtUSd67vZwapYRZ4yygx8+YXFpAaYQF/
        iU1PikBMFgFViTVvw0DKeQU8Ja5MncUIsUtO4ua5TmYQm1PAS2L/wvVgYyQE5rFLzLlxnB2i
        yEXix6xtULawxKvjW6BsGYn/O+czQdjFEmc7VrFB2DUS7Sd3QNVYSxw+fpEV5AZmAU2J9bv0
        IcKOEs1HP4OFJQT4JG68FQQJMwOZk7ZNZ4YI80p0tAlBVGtIbOm5ALVITGL5mmlQwz0ktp/t
        hQbuXEaJ46e3sExglJ+FsGwBI+MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwIRy+t/x
        LzsYd/1JOsQowMGoxMObYVYbI8SaWFZcmXuIUYKDWUmE9494XYwQb0piZVVqUX58UWlOavEh
        RmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRtv/sub3zx4xMrsn+3DxQs8XqT07b1/j
        n3z/TPmX8zd5debwn/nwTtt/7y1Zk7C4RSuWK606t3tdv+DEZ8kV3AY/33068uy9RklByuQl
        ez4l2cR8nCkRdNBk+1Glljq5RYl2cUcjO1z2Hl7ytFNNboPIEoGNN091GZY3eaRyumioe01m
        dDhtskqJpTgj0VCLuag4EQBC3pYiJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7q6vnUxBr9/mllsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeDrxCHvBQb6KCyunsTYwbuXpYuTkkBAwkbgz+St7
        FyMXh5DAUkaJk207WSESYhKT9m1nh7CFJf5c62IDsYUEPjFKbJwh1cXIwcEmoCexY1UhSFhE
        oF6i/80lNpA5zALfGSUOPZnACJIQFvCVOLz2JSNIPYuAqsSat2EgYV4BT4krU2cxQoyXk7h5
        rpMZxOYU8JLYv3A9M8QqT4mpXxeyTGDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw
        wLcd+7llB2PXu+BDjAIcjEo8vBlmtTFCrIllxZW5hxglOJiVRHj/iNfFCPGmJFZWpRblxxeV
        5qQWH2I0BbppIrOUaHI+MPrySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0
        MXFwSjUwSsgd3KEouetSudTzeeayTGdiPzMueps5+cviyZE/N53/HPZfeNeBkOS/Hns4TT+5
        855gi9aaPm3h3wgnm2trJ2U8OOp74thT93XLjQp77A5vFn2/7vHXxSs3+rWdL1kv+uCGdkPI
        HtULM4yKDZsW6Eavnrq1/eL307XctmyLD/07LKf3I8/12DclluKMREMt5qLiRADa8HxGhgIA
        AA==
X-CMS-MailID: 20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 6da5875..6f5db70 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1331,6 +1331,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1473,7 +1484,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.7.4

