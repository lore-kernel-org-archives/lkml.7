Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60F22081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LdTZIvUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfGOMsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:48:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60113 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfGOMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124438euoutp012c4029be885ead04f8ca8d6f4993911a~xlUc4YGmu1962419624euoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124438euoutp012c4029be885ead04f8ca8d6f4993911a~xlUc4YGmu1962419624euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194678;
        bh=XoFa4dmm8dDeVK12ljWsbis1GfZPOfLYGWx2zF9kYwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdTZIvUVNL74ZESo49vC4TL5yo3FqaKH9OOthO7jo2rmIHMjhRJoeptts/fD7lfRw
         dRNXpNYkPmxbFiF7IFuy+FrUBO32IQZBDW3Qrn0P2W12cDTkMxoBgHFCd5EOgvg3DY
         hwfWxlPf92y044zEGTDpxGpCIf/Z924JY8JakjW8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124437eucas1p2747bd7e25bfb480364258190704768f9~xlUcC4CGL2439124391eucas1p2G;
        Mon, 15 Jul 2019 12:44:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 44.D1.04377.5357C2D5; Mon, 15
        Jul 2019 13:44:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad~xlUbOkbKw3056930569eucas1p1L;
        Mon, 15 Jul 2019 12:44:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124436eusmtrp132f287fdda1f87a01171592cbe97eb9b~xlUbAcVPJ0462004620eusmtrp1u;
        Mon, 15 Jul 2019 12:44:36 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-cf-5d2c75359474
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.40.04146.4357C2D5; Mon, 15
        Jul 2019 13:44:36 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124435eusmtip2929ecdd38a0b73990242b46860f21749~xlUaOaKN01101111011eusmtip2H;
        Mon, 15 Jul 2019 12:44:35 +0000 (GMT)
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
Subject: [PATCH v1 04/50] clk: samsung: add IDs to manage aclk400_mscl in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:31 +0200
Message-Id: <20190715124417.4787-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeyyVcRjH+73veS/M0esgv2HUWVoXORTbb0vSlu0df6R12boYR95cDzov
        SmlRKcxtmGRJNsack1uYhIWzQy65LURJsbW5nWP0hzRyvKr/Ps/3+T7P97dnPxqXtBLWdGhk
        DKeMlEdISWNRo3Zt4KhbrKOfc8/HA2ii6gOBaguqCTS2+oNAxZqtMmtmHkcDAzUU6n+wQKGJ
        RFtUNzNKoOX0KQKNND8nUcFAG4Zeab5QqGxsCENDPV5oMqmCRMmtGgp1Ljwh0MZorcjTnFW/
        UANWN55MsXWVqST7uvQ+277UgrGZ9ZWAXamz86WuGLsHcRGhcZxS5hFgHDKa2YNH63bfzs4b
        IRNBvzgN0DRkXKH2K5UGjGkJUwFg75AKF4pVAIsKZ3eKFQBrlqqINGC0PTE6oSWFRjmAJdpk
        0b+R0r4GzLCXZJxgU+VNw4AFUwqgZi3Q4MGZTxhsmX2zvcmcuQTbH85jBhYxDnAjP4M0sJjx
        gI/al3AhzR6qat5tsxFzCq7lD24nQ2aYgtWN70nBdAYulnSKBDaHc131lMC2sDc3fUfnYWJG
        CRA4Ac5kFe14TsDOriHC8GicOQSrm2WCfBpWpeSSwo1M4fiimUHGtzCn8SkuyGKY8lgiuA/C
        +vRBTOA9sFydv7OchfqGNUw4Tw6AS3P1omxgX/g/7CUAlcCKi+UVwRx/LJK75cTLFXxsZLDT
        9ShFHdj6VL0bXatNoPl3YAdgaCA1EXsGHfGTEPI4Pl7RASCNSy3EJ39uSeIgefwdThnlr4yN
        4PgOYEOLpFbiu7umr0qYYHkMF85x0ZzybxejjawTQRbR0jFGK+O9vyvVJa54qeV5VXjqPRfZ
        upeZV1i3rzpbP+ngPhyjveDm7NyZw1EqOuHXdPPZGxoff0d0vO3auu3mswBUQC6b+NB5e1uc
        3ppcVMTrLhP7Ct3tiLDQsnCVabBOHzQsq04q1pt9m2pfr9p0PNfnb9lts7/2s5e3VMSHyF0O
        40pe/geGh6QfUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7ompTqxBlvadCxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7Gtb5TzAXv+SsmTLnM1sB4lreLkZNDQsBE4tqtY2xdjFwcQgJLGSVe
        Le1igkiISUzat50dwhaW+HOtiw3EFhL4xCixvS2/i5GDg01AT2LHqkKQsIjACkaJySe8QeYw
        C7xmkjhy9B0rSEJYIETiztsLYDNZBFQl/k3rBZvDK2An0XLwHTPEfHmJ1RsOgNmcAvYSP6dd
        gNplJ7H46E+mCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGzrZjPzfvYLy0MfgQ
        owAHoxIPr0OKdqwQa2JZcWXuIUYJDmYlEV7br0Ah3pTEyqrUovz4otKc1OJDjKZAR01klhJN
        zgdGdV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkbv9LVH92RL
        XfbY4qMl7Vd2v/j4ZIEvmR7rphxJ9+RIzTG7cKP4Elvd86OLt8zRY2Z0yZq24Jmsw9Qv4R8M
        1t0RnhB+RNdT/MEJ/tVb1T5uWGFSckv16LIPz7SfPuOf0rhh2vYtL21ZAr+cClBe3VB6M/jV
        zy8aKrHs+SxJ6y+9WPk7SDgp4MZZJZbijERDLeai4kQAk0CNrbICAAA=
X-CMS-MailID: 20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add needed IDs to MUXes which are used from DT to properly set clock
hierarchy.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 361ee53fc9fc..8f1d39cb2f1e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -462,7 +462,8 @@ static const struct samsung_fixed_factor_clock
 
 static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
-	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
+	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group3_5800_p,
+			SRC_TOP0, 4, 3),
 	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
 			SRC_TOP0, 16, 3),
 	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
@@ -548,7 +549,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 				TOP_SPARE2, 4, 1),
 
 	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
-	MUX(0, "mout_aclk400_mscl", mout_group1_p, SRC_TOP0, 4, 2),
+	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group1_p,
+			SRC_TOP0, 4, 2),
 	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
 			SRC_TOP0, 16, 2),
 	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
@@ -670,8 +672,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
 			SRC_TOP10, 0, 1),
-	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
-			SRC_TOP10, 4, 1),
+	MUX(CLK_MOUT_SW_ACLK400_MSCL, "mout_sw_aclk400_mscl",
+			mout_sw_aclk400_mscl_p,	SRC_TOP10, 4, 1),
 	MUX(CLK_MOUT_SW_ACLK200, "mout_sw_aclk200", mout_sw_aclk200_p,
 			SRC_TOP10, 8, 1),
 	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
-- 
2.17.1

