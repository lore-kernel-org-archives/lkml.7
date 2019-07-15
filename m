Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944BC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0134F21530
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A7VqZtAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfGOMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:44:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49648 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbfGOMos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124446euoutp02fee9f478b3a84227904bc51478958b41~xlUkgdmk40599405994euoutp02X
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124446euoutp02fee9f478b3a84227904bc51478958b41~xlUkgdmk40599405994euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194687;
        bh=3BRlMgsWN3g08+Y/eeiArBFHKGehsKQXE+uUMNRN0mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7VqZtAUP2A8e52mJGNLcZEQldjRkMcg7J4dFqEMTCXUiPN5uJg7RqjydLsOxVk2a
         8F6OvKAV01tK1mY5tZ2A1g1R/+3Z8CGfu8Pr1axXFQX9sqhvmjdZGqS/mE6ICk1zcE
         l27xP5brKJchz4Nr0qXTkzeK2c4ax+iTC6GtJTg8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124446eucas1p2c695ff9d9181b128a754a68d105cb2c0~xlUjx6Rim2241522415eucas1p2V;
        Mon, 15 Jul 2019 12:44:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.D1.04377.D357C2D5; Mon, 15
        Jul 2019 13:44:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124445eucas1p1a73385fcbe6205d868ae63b1198ff572~xlUjDQ5_v0154701547eucas1p1D;
        Mon, 15 Jul 2019 12:44:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124445eusmtrp184e4b75c6c69c1d6cc6eef546f578d50~xlUixhnhN0462004620eusmtrp1N;
        Mon, 15 Jul 2019 12:44:45 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-e8-5d2c753d0429
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.F6.04140.C357C2D5; Mon, 15
        Jul 2019 13:44:45 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124444eusmtip20f09feefb130d4ef0abae4837fe7c00e~xlUh5dj2f1115211152eusmtip2J;
        Mon, 15 Jul 2019 12:44:44 +0000 (GMT)
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
Subject: [PATCH v1 14/50] clk: samsung: add CLK_MOUT_SCLK_CPLL in the
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:41 +0200
Message-Id: <20190715124417.4787-15-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUhUURzFu/NWB8eeo+XFRGliSHNLk7gtpkHGfIgIPyZiYz7Ucp3nklmk
        uZumGZlEbqRpai7TKI6Y69homkvmkqYEimFp5o5U0ozP6tvvf+4558+9XBoTNxPmdGBIBKsI
        kQdJSCHe8Gar39410s776LPU42iiup9AdXk1BBpb+0KgQo1uzJr5hqGBgVoKvbu7QKGJOAuk
        nBkl0HLGNIGGm56SKG+gRYBeaqYoVDo2JEBDbz3QZHw5iZJeayjUuZBCoO3ROtzdRFZVUAVk
        S+NJlExZkUbKXpXckbV/bxbI7qsqgGxVaXmJuiw87ccGBUaxCsczV4QB5SlDRFgVdWM4X03G
        gXIyHdA0ZFxgeuXJdCCkxUw5gIWffgv4YQ3ArL45nB9WAfywtKFLGOwketJ/7LrKAJyvb6X+
        RdJG23B9L8k4wMaKcH3AlCkBULPlq/dgzEcBbJ5VE/oDE8YTjqw92GGckcKCom5czyLGDf4s
        2MT4bVawsrZthw10+lbuIKkvgsx7CvZM11L8Jc7Beq077zeBX7UqimcL2PswA+eZg3GZxYDn
        W3AmK3/Xcwp2aocIfQ3G2MCaJkdePgvrGjIB324ExxeN9TKmw5yGxxgvi2Bqsph3W0NVxqCA
        5/2wrCp3t1wGR1crd18nB8AXZYtkNrB68n9ZEQAVwIyN5IL9Wc45hI124OTBXGSIv8PV0GAl
        0P2p3m3tWiNo+uXbARgaSAxF7n623mJCHsXFBHcASGMSU5Hruk4S+cljbrKKUB9FZBDLdYAD
        NC4xE8Xu+ewlZvzlEex1lg1jFX9PBbSBeRyINtxs15iYShXktcT2SantvZVhm4OBY2MtifHW
        YKLW0hOVdnmFZtkcnpfefuSR0KGcHRinszeM/ItdD4W72QvVfcvamuGUBPWJC6qLy92utnOT
        Nc9bjbsEU/ucynyObdmtxNDrUpLJN1PFOisXq/1Gllx699b3uqgxl0lx8nkJzgXInY5gCk7+
        B3HionlPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7q2pTqxBrcmM1rcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MFe0XWQvWsFdcnruTrYFxBVsXIyeHhICJxMmuD0xdjFwcQgJLGSX+
        bz3KApEQk5i0bzs7hC0s8edaFxtE0SdGib6fu1m7GDk42AT0JHasKgSpERFYwSgx+YQ3SA2z
        wGsmiSNH37GCJIQFAiReXt8NNohFQFVi3oITYAt4Bewlfs/7zgyxQF5i9YYDYDYnUPzntAtg
        1wkJ2EksPvqTaQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsbPt2M8tOxi73gUf
        YhTgYFTi4XVI0Y4VYk0sK67MPcQowcGsJMJr+xUoxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKi
        yfnAuM4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cA4RbhUNPHh
        XR9twThL/o74ve5LnYrvT1q41Mxg26En0R0v+AwlX6yNOrvezZ03+PnDPKvkoxGbL/0R+PLg
        dV3+r6kXdddxbY14e+l9yx9lodU2zon1ijUvNuwR6S3YfvCidPiT9qsvOfdG5qduvbTHKK68
        +lYk09X3RZJFIfuvMT/WsV5fZhmjxFKckWioxVxUnAgAgmBHGrMCAAA=
X-CMS-MailID: 20190715124445eucas1p1a73385fcbe6205d868ae63b1198ff572
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124445eucas1p1a73385fcbe6205d868ae63b1198ff572
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124445eucas1p1a73385fcbe6205d868ae63b1198ff572
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124445eucas1p1a73385fcbe6205d868ae63b1198ff572@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID to mout_sclk_cpll MUX to make possible children connection in
the DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 2395b02ce8c5..6d1a0ef9172e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -696,7 +696,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 			CLK_SET_RATE_PARENT, 0),
 	MUX_F(CLK_MOUT_SCLK_DPLL, "mout_sclk_dpll", mout_dpll_p,
 			SRC_TOP6, 24, 1, CLK_IS_CRITICAL, 0),
-	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
+	MUX(CLK_MOUT_SCLK_CPLL, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
 
 	MUX(CLK_MOUT_SW_ACLK400_ISP, "mout_sw_aclk400_isp",
 			mout_sw_aclk400_isp_p, SRC_TOP10, 0, 1),
-- 
2.17.1

