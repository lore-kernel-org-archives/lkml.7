Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC6120693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jpqzdmb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfDSTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:07:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54636 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfDSTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141945euoutp02d805f296eb8f5f03a2c6ce5bac2eb749~W5fqCUoKb2260722607euoutp02g
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419141945euoutp02d805f296eb8f5f03a2c6ce5bac2eb749~W5fqCUoKb2260722607euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683585;
        bh=rb70fo3R6UoalWB6bfCebuUMfs2ijnziPnHY813BvAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jpqzdmb9qcOdi485AvCyDGzaC2BOYoHrMW4qpns1mAC3BN2r11L6xjsXkCZpDYkTy
         ep6KdAYI90XeMwwvlhuc50uZHvZZy4LgsaJD2Y7DSo6tKtPWcnEEjBw7688Uhd7OwX
         ufDCj85UfVnBUXO4ZHbvATYWTg3dqw8FF+2yT22U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419141944eucas1p2cb0bedc075ec2403b3671a55a6c7fa50~W5fpPplQD2300423004eucas1p2m;
        Fri, 19 Apr 2019 14:19:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.72.04298.009D9BC5; Fri, 19
        Apr 2019 15:19:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d~W5foaavMv2300323003eucas1p2p;
        Fri, 19 Apr 2019 14:19:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141943eusmtrp1dde2fb94fe9aa090fd77b880cc2c0109~W5foMawZ81759317593eusmtrp1Z;
        Fri, 19 Apr 2019 14:19:43 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-1e-5cb9d900d9ca
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4A.02.04146.FF8D9BC5; Fri, 19
        Apr 2019 15:19:43 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141942eusmtip21ec09455f0ff3aba8d40040b7c5ba168~W5fnalDKH3242832428eusmtip2T;
        Fri, 19 Apr 2019 14:19:42 +0000 (GMT)
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
Subject: [PATCH v6 03/10] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Fri, 19 Apr 2019 16:19:21 +0200
Message-Id: <1555683568-20882-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH/d27u92NZrcZ+cOGwUCoJM3Q+EUliRUXRXr8EVGGrrzozE3d
        dZUtYSpZzpk2H5mvHv9oy9LmEjXJnK/Ix3yBmVmRpWBTMx9kL3PeRf99zvec8z2HwyFxiZXw
        IBWqJEatksfJ+CJeXceybYfLSEP4zor7ruhJUTWBhhcmCXSnrZdAD+fGAcp7VYah7iwlyhn/
        giObrUaAetLsAvRGJ0WDjaV8NJ/dBlCR7TmGHrWNCdBoaiUftdqvEah5KASN/nRFSy8/ggNu
        9NKikUeX6Pp5dEPxmIA2mzL5dHb6DJ9umWnC6BsWE6Bru7T0vNnzqPCUaF8UE6e4wKh9AyNF
        MakFsQktrpc6K5eBDjxdpwckCSl/mFVA64GIlFCVAJbM5WNcsADg5wErzgXzAF5NsxN6IFzr
        aLqZs8YSqgLA9v4Ajlc7JtpCHK58ygfWmxId8kZKC98ON6/54JQdgz0/vvMcCTfqGMzQmTAH
        8ygvaL76B3ewmAqBhh91gJvlCUd6M9d0IRUKGx9Y+A4jSL0TwIlBI8YVHYSZn/r4HLvBqU6L
        gGMp7Moz8DhmoS77ntP0ChzPKXPW7IWtnf2EY2mc2garG305OQg+flaFcxdyha+nNzhkfBWN
        dbecshhez5Bw1VuhxdDnXGYTrKgqdJrTcLx9WsCdsBzAxpVaPBdsKf4/7C4AJuDOaFhlNMP6
        qZiLPqxcyWpU0T7n4pVmsPpZXX86v9WDxYGzVkCRQLZO/MLYEC4h5BfYZKUVQBKXbRQHRVnC
        JeIoefJlRh0fodbEMawVbCZ5Mnex1uXDaQkVLU9izjNMAqP+l8VIoYcOqDNSAoe7+3OhX/tx
        vboq4lCY5oxUteilIA8XTmUvbQ/KvX9ScXteNZfeEVw6uHviKyb6FdpksPuHlRWEzq4sa39H
        TtpSY+XC0HKjxxF/9yqFsr5wSHoxpyOA2LMLS3zlnT/THbx+1oh90O7XTqU0iTGb1VswO1Iz
        8f5T8AmVjMfGyP2242pW/hcOyRqYVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7r/b+yMMTj7VMRi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMapWQUH+SqOr/jJ2MC4laeLkZNDQsBEYs/EftYu
        Ri4OIYGljBKL1x1jhUiISUzat50dwhaW+HOtiw2i6BOjxP72JYxdjBwcbAJ6EjtWFYLUiAjU
        S/S/uQRWwyzQwCyxZvtVsEHCAv4Sd+ZPYASxWQRUJTa1/mMGsXkFvCR6fm1jhFggJ3HzXCdY
        nFPAW2LXyi1sILYQUM2Ga3uZJjDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYSduO
        /dy8g/HSxuBDjAIcjEo8vAcm7YwRYk0sK67MPcQowcGsJMLrmLIlRog3JbGyKrUoP76oNCe1
        +BCjKdBRE5mlRJPzgVGeVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mD
        U6qBUUrktX+uxkfHVXNE1JufSrKZ5DW6VunG7z/Eld8Sf2Xmb4WfEzcEqu3f2+HJkSVVE2pZ
        9fTjqxp2zoyWi0LT1+7X3fdmzkOT7Ya1vRuWBPzuN3OcYnxaIiKw5snuZzv+yy6L0zpjH1Ex
        f96Hpd5Oln1vmBquPmGZKvpsTgvrRqsCqdBy7W2MSizFGYmGWsxFxYkAntM8UboCAAA=
X-CMS-MailID: 20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d@eucas1p2.samsung.com>
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
index d9e6653..ddee8bd 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1323,6 +1323,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
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
@@ -1465,7 +1476,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.7.4

