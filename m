Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C104C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4845420868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BcTsishM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfGOMsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:48:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49598 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfGOMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124439euoutp028be9d01ae02648017352d4875563caaf~xlUdj6fAw0715707157euoutp02E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124439euoutp028be9d01ae02648017352d4875563caaf~xlUdj6fAw0715707157euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194679;
        bh=4zrsUTzlnmSqadoHJ5f+VbeMYaBjak3MZkpWWAiAL3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcTsishMJlSsXCdWzQAPjclUpWhYJtGvNjrcMbpbKQv7jaZA4soS6P+J+3S86Aaei
         lFHW/8XnjpR3r6zZ+x0sW4cwzKEU+kqx9u4UnuFxQBWnN+2wzqXpdnwFOYf8Cc+mXa
         VnxbxwcO7D7JSBHgsvmE7VBYL1bF3fTJ+n9WNzqA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124438eucas1p2d57b3536b548e05df682317febfae6c2~xlUcySrGY0850908509eucas1p2L;
        Mon, 15 Jul 2019 12:44:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E5.D1.04377.6357C2D5; Mon, 15
        Jul 2019 13:44:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124437eucas1p2d817f0c1fcf4b523c7910218a6e557d9~xlUb-_Zmm2242322423eucas1p2J;
        Mon, 15 Jul 2019 12:44:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124437eusmtrp124daa6b8558ca2bb0eb09bbef0fae2d9~xlUbx0ur_0462004620eusmtrp1v;
        Mon, 15 Jul 2019 12:44:37 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-d1-5d2c753630b6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.F6.04140.5357C2D5; Mon, 15
        Jul 2019 13:44:37 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124436eusmtip287acc56a8509bcdeaa79d337e40e1682~xlUa-Bapw1172811728eusmtip2i;
        Mon, 15 Jul 2019 12:44:36 +0000 (GMT)
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
Subject: [PATCH v1 05/50] clk: samsung: add IDs to aclk400_isp in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:32 +0200
Message-Id: <20190715124417.4787-6-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29nZOa6Wp2n6ZpK46GZmabcPMkvKOIVBP+qPoTX1ZBedtqOW
        GWSRaaJZBmoXy2ipTTPzrrg0XY0yt0mR5lDDSRe7pwmjsjaP0r/nfZ/by8dHE/Im0oM+pErk
        1CplrEIiFdc/sRlXrEvyDV9lvjsX91UaSfyg8D6Je8bekfim3j7mWj8S2GSqonDXmU8U7kvz
        xNXWVyT+nj1A4hfN1yW40PRQhO/p+yl8p6dbhLufhWDL6TIJTtfpKdzxKYPEE68eiDe7sBU3
        KhD7tTedYqu15yVsjeYU++hLi4i9UKtF7Gj1gl1UmDQwmos9lMypVwbtlx5816URJ3xwPv7Y
        LE1DL2RZyIkGZg08MV8TZSEpLWfKEDTUGykHIWfGEBhH4wViFMGviV5q2pGRoxELRCkCi6UA
        CYPd0XomV5KFaFrC+EGj9qjD4MpoEOhtkQ4NwbwWQctwE+kgXJhQ0AxkT2IxswgsxSWTDTIm
        CO4Y/oiFNi8or2ojHNiJ2QS2fLPEEQSMkYLyLutkGTBb4e0fL0HvAiOG2qlLPaHzcvZUDg9p
        ObeQgE+CNbdoSrMBOgzdpCOGYJbB/eaVQmIwNJoCBDgbej/PcYgJO8yrLyCEtQwyz8mFjKVQ
        m20WCdgNSivyp7JZuPLyKSE8Zx6CuktrLyKvq/+rihHSIncuiY+L4fgAFXfMj1fG8UmqGL+o
        +LhqZP9QnROGsUbU/DuyHTE0UsySbY5eHi4nlcl8Slw7AppQuMo2/rSvZNHKlBOcOn6fOimW
        49vRfFqscJelznizV87EKBO5IxyXwKmnWRHt5JGGGrbs+ZGqjcQB/QaXIcR66rZfCKlZkh+Y
        TI2ofiu3bUz5dnZekM2NHdR9Wa/w7mgtG/cJDtXBzImqnpHAkAND/eleJfIw/+6OvPH3bsO2
        TP26oB2m8OfkUJR+619FkehjhDZ+UBfhW7JzkevXSsvt1rbS6N3Oh1cvXOytq6zr/KUQ8weV
        /j6Emlf+A5jimflMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7qmpTqxBvtfK1jcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M52eXsBS85K84eoGrgfEybxcjJ4eEgIlEe+8Sli5GLg4hgaWMEqfv
        LGOGSIhJTNq3nR3CFpb4c62LDcQWEvjEKPH3YmYXIwcHm4CexI5VhSBhEYEVjBKTT3iDzGEW
        eM0kceToO1aQhLCAj8SSez1gNouAqsTtBcvAZvIK2EksPf6XBWK+vMTqDQfA9nIK2Ev8nHYB
        apedxOKjP5kmMPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERg324793LKDsetd8CFG
        AQ5GJR5ehxTtWCHWxLLiytxDjBIczEoivLZfgUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqc
        D4zpvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjBcfeJ18tnfN
        LaNIpqUvV7Q3XX47K5Rz//9os1YGnkVmxyNzrWOjvdy8phuoMUgI2fNnldyqiO/Q/nn/eIjH
        LV6Dmf+crJxlnY5mXVlqOW9BSeTKxVb/WD/MZV5wVc1Ug0Voxfe4a25N9TXRR14clG/7eGRL
        08v3E12KZX3XdQYa75qQJF66TImlOCPRUIu5qDgRAH5zF3mxAgAA
X-CMS-MailID: 20190715124437eucas1p2d817f0c1fcf4b523c7910218a6e557d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124437eucas1p2d817f0c1fcf4b523c7910218a6e557d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124437eucas1p2d817f0c1fcf4b523c7910218a6e557d9
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124437eucas1p2d817f0c1fcf4b523c7910218a6e557d9@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock IDs to MUXes related to ACLK400_ISP for managing them from DT
devices.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 8f1d39cb2f1e..74276875bc3e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -461,7 +461,8 @@ static const struct samsung_fixed_factor_clock
 };
 
 static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
-	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
+	MUX(CLK_MOUT_ACLK400_ISP, "mout_aclk400_isp", mout_group3_5800_p,
+			SRC_TOP0, 0, 3),
 	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group3_5800_p,
 			SRC_TOP0, 4, 3),
 	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
@@ -548,7 +549,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
 				TOP_SPARE2, 4, 1),
 
-	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
+	MUX(CLK_MOUT_ACLK400_ISP, "mout_aclk400_isp", mout_group1_p,
+			SRC_TOP0, 0, 2),
 	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group1_p,
 			SRC_TOP0, 4, 2),
 	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
@@ -670,8 +672,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
 	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
 
-	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
-			SRC_TOP10, 0, 1),
+	MUX(CLK_MOUT_SW_ACLK400_ISP, "mout_sw_aclk400_isp",
+			mout_sw_aclk400_isp_p, SRC_TOP10, 0, 1),
 	MUX(CLK_MOUT_SW_ACLK400_MSCL, "mout_sw_aclk400_mscl",
 			mout_sw_aclk400_mscl_p,	SRC_TOP10, 4, 1),
 	MUX(CLK_MOUT_SW_ACLK200, "mout_sw_aclk200", mout_sw_aclk200_p,
-- 
2.17.1

