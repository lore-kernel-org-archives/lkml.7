Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C43720848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F2m7k05A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCEKTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55971 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfCEKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:27 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101926euoutp02c8f1226f1f1d412563e901f84722201c~JCL-Hc6OD1593815938euoutp02f
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190305101926euoutp02c8f1226f1f1d412563e901f84722201c~JCL-Hc6OD1593815938euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781166;
        bh=VbSg3sz31vsaSgUFcPmWQjR+VHv6v3342Gm2E+CXSEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2m7k05ATvMnNUXX9BTSPDdsCuduEc50qtWdGjnjpIUQ6fywaSlywV5HdJbQKCqos
         H8/9cIUiUy5+WDR4Nzcj3KEgKQf27mFCyAp0NpKoB6L5AlqoBXwkrmpz2Ya0c1Dkmq
         +kuMI+wG67MbO1mybLMo0stLt3qWjdxJep13PKcA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190305101925eucas1p2e2e908e4dd3bd30f661ecd96c7c57e74~JCL_oG7V42249722497eucas1p26;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2B.CB.04806.D2D4E7C5; Tue,  5
        Mar 2019 10:19:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa~JCL90cJPO0658806588eucas1p1J;
        Tue,  5 Mar 2019 10:19:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101924eusmtrp2aa9337b6d22eb67970b15b9ecf326f14~JCL9lRdRx2082620826eusmtrp2P;
        Tue,  5 Mar 2019 10:19:24 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-7b-5c7e4d2d8870
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.1F.04128.C2D4E7C5; Tue,  5
        Mar 2019 10:19:24 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101924eusmtip1bd4141c0b820e2dc877f7d60f3569046~JCL9Byz-C3017830178eusmtip1H;
        Tue,  5 Mar 2019 10:19:24 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Tue,  5 Mar 2019 11:19:04 +0100
Message-Id: <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87q6vnUxBp+PKFhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKWPtmNnvBEr6KhsVL
        2BoY/3N3MXJySAiYSLy985y5i5GLQ0hgBaPE5Ymt7BDOF0aJaStvMkI4nxkl2s73s8C0dC57
        BdWynFHiybbHLHAtp66/Bern4GAT0JPYsaoQpEFEoFrizvX9YA3MAm8ZJWbe/AI2SVggWOLS
        wV/MIDaLgKpE07QZTCA2r4CnxN2r/ewQ2+Qkbp7rBKvhFPCS2L9wPdggCYHJ7BJn97WxgCyT
        EHCRmPYiEqJeWOLV8S1QvTIS/3fOZ4KwiyXOdqxig7BrJNpP7oCqsZY4fPwiK8gYZgFNifW7
        9CHCjhIPj5xng5jOJ3HjrSBImBnInLRtOjNEmFeio00IolpDYkvPBahFYhLL10yDGu4hMfnD
        bSZI6MxllDjYcJBlAqP8LIRlCxgZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmlNP/
        jn/dwbjvT9IhRgEORiUe3gyz2hgh1sSy4srcQ4wSHMxKIrx/xOtihHhTEiurUovy44tKc1KL
        DzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTA2/dnQv8hhX5rOgzuvhYsPdF/9ydAY
        sJ8rbWvwWxZH4XSOD79v6LGfdzxiuK/5s8CawviOU0nHqqPbNFzsdy8OasnJ/2B3bW6C/q7S
        eS9Mry1Yeci7hkl15T5JafOrexcfVpKpjo802sMXPp1lytVD13RSimdeuuHzcu+xre+iawwe
        Mopmei9UYinOSDTUYi4qTgQATA+bLiUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7o6vnUxBh2ztC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhc3jWHzeJz7xFGixnn9zFZrD1yl93iduMKNovD
        b9pZHXg9Nq3qZPM4+G4Pk0ffllWMHp83yQWwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
        6hkam8daGZkq6dvZpKTmZJalFunbJehlrH0zm71gCV9Fw+IlbA2M/7m7GDk5JARMJDqXvWLu
        YuTiEBJYyiix/ftRFoiEmMSkfdvZIWxhiT/Xutggij4xSqyc1wbUwcHBJqAnsWNVIUiNiEC9
        RP+bS2A1zALfGSUOPZnACJIQFgiU2Pv+PtggFgFViaZpM5hAbF4BT4m7V/uhFshJ3DzXyQxi
        cwp4SexfuB7MFgKqmfp1IcsERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAoN827Gf
        W3Ywdr0LPsQowMGoxMObYVYbI8SaWFZcmXuIUYKDWUmE9494XYwQb0piZVVqUX58UWlOavEh
        RlOgoyYyS4km5wMjMK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dU
        A+MkP/Mj85IyGGSFGCWnfpj+Uf9BwVrliyJzS5dOTXf0yLpfrOc5OfwYd/PxtlaeC3PmuMyt
        mCK87bszu5esp0xuJ/OUOSc1elUP/QqJz3K3ENxmaPu3tVgrnDPi79WHt2/u3bJjnVWLOWvq
        xeVpPA/mOxxY1vbIW1LpHO8sCc4DO5MM2tie7ldiKc5INNRiLipOBADx6ZkNiAIAAA==
X-CMS-MailID: 20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469..abb1842 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -60,6 +60,7 @@
 #define CLK_MAU_EPLL		159
 #define CLK_SCLK_HSIC_12M	160
 #define CLK_SCLK_MPHY_IXTAL24	161
+#define CLK_SCLK_BPLL		162
 
 /* gate clocks */
 #define CLK_UART0		257
@@ -195,6 +196,18 @@
 #define CLK_ACLK432_CAM		518
 #define CLK_ACLK_FL1550_CAM	519
 #define CLK_ACLK550_CAM		520
+#define CLK_CLKM_PHY0		521
+#define CLK_CLKM_PHY1		522
+#define CLK_ACLK_PPMU_DREX0_0	523
+#define CLK_ACLK_PPMU_DREX0_1	524
+#define CLK_ACLK_PPMU_DREX1_0	525
+#define CLK_ACLK_PPMU_DREX1_1	526
+#define CLK_PCLK_PPMU_DREX0_0	527
+#define CLK_PCLK_PPMU_DREX0_1	528
+#define CLK_PCLK_PPMU_DREX1_0	529
+#define CLK_PCLK_PPMU_DREX1_1	530
+#define CLK_CDREX_PAUSE		531
+#define CLK_CDREX_TIMING_SET	532
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
@@ -217,6 +230,8 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_SCLK_SPLL	660
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +263,9 @@
 #define CLK_DOUT_CCLK_DREX0	794
 #define CLK_DOUT_CLK2X_PHY0	795
 #define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_FF_DOUT_SPLL2	797
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		798
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.7.4

