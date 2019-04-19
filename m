Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33391C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8312064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EdyJqVYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfDSTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:08:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54674 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfDSTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141942euoutp02398f85bfb7b4c6cf0b3664a11ba9b2d0~W5fncCodI2260722607euoutp02b
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419141942euoutp02398f85bfb7b4c6cf0b3664a11ba9b2d0~W5fncCodI2260722607euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683582;
        bh=eRtHBa6GHgMeMxc3ZcJTvz/69/IBWOe0AGKFZjhpsSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdyJqVYe98MkJIcnbyrvyRPXMAsfW5DPoD+XgrUO3M96vdhvTuNxwjf/uSjLeACI5
         drfYjhwrHQLGWx6ArZwm5lKZpqFnE3ArLlDEIykdWMbFnPLtKjuPaSrSFE+4Porl36
         QTrhoFXzrU2wISJqCB2rlBCsBXauY3XP4qaoSIlc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419141941eucas1p24498ee25afa76507ad81e9617215987a~W5fmupWvN2300423004eucas1p2g;
        Fri, 19 Apr 2019 14:19:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.72.04298.DF8D9BC5; Fri, 19
        Apr 2019 15:19:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102~W5fljqR-T2100021000eucas1p20;
        Fri, 19 Apr 2019 14:19:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190419141940eusmtrp2c981277e7413504e3264f0ba4913b711~W5flVePmG2408024080eusmtrp2j;
        Fri, 19 Apr 2019 14:19:40 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-15-5cb9d8fd5b72
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.90.04140.CF8D9BC5; Fri, 19
        Apr 2019 15:19:40 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141939eusmtip2a4028f0da1a10bfa4cdd7f9b44c70186~W5fkhlOIl3043830438eusmtip29;
        Fri, 19 Apr 2019 14:19:39 +0000 (GMT)
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
Subject: [PATCH v6 01/10] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Fri, 19 Apr 2019 16:19:19 +0200
Message-Id: <1555683568-20882-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUhTcRzvt3fsOZu9ZuUvE61Jh1GaUfaDDhQUX+UfYURURr70YZFT2/PI
        LFhKmpoa69A07b5W5jXNSaXOkZI6s2ueJI0USi3P0jBzvoX/fb+fk9+XH4XJDIQjdTwimlNG
        sOFyUoJXvJ4wrp9q0wVtaH3jikpyighkGu0j0E2DkUBPhswAXX6TL0JN6QqUZf6OoZaWYjFq
        TuwXow6VE3pfdYNEIxkGgHJaXolQoaFbjDrPPSJRXX8Kgao/7EKdf+zQeMMX4G3PjI+pcSZP
        1YozutxuMVOqSSWZjKRBkqkdfCFiMrUawJQ1JjAjpc57bA5KtoVy4cdjOaXHjmDJsV/lH4mo
        ZrtTidUDpArcnZ8GKArSm+BUZXQakFAy+hGA5vPDQFhGAVSXvLQuIwCmpubOLDazDuPYfSvx
        EMDs6/o5S9JkIWbJJWl3WKk5aTEsohNgl6kas2gwul8Emyd/4xbCnt4HjTXds6k4vRKe73kw
        65XSu2Byikgoc4btxlTMMtvQu2HVYy1pyYF0hxgmGzRiQeQLTZ0tuDDbw2/1WivuBKd1N61B
        PFRl3La+4Aw0Z+VbNVthXX0rYenFaDdYVOUhwD6wWK0jhRPZwbaBhRYYmxnVFdmYAEvhhWSZ
        oF4DtRffWouWwIdPr1nDGWh6/ZUQrlMAYFntEHYJuOTOld0CQAMcuBheEcbxnhFcnDvPKviY
        iDD3kEhFKZj5W41/64crwdi7o3pAU0A+X1qj1gXJCDaWj1foAaQw+SKpT6g2SCYNZeNPc8rI
        I8qYcI7Xg2UULneQJszrOSSjw9ho7gTHRXHK/6yIsnFUgevu62mfwLyCAbfCgRCvKN/VNaF+
        OYm6+MAbXfuyA9yK/e9mjsQNB9heXZrjmwQ+GCsO2+L9XZ47RnvNwcv9P99zdvUr+Mku6DXl
        P2/45GU3vWxi1Y8rq/Qbtff5ddsn7nif3LmFc3FVBzVtfuaUXh7Ant2bt8K8uKF9/4GwPgXK
        lMhx/hjruRZT8uw/XDYMb1cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7p/buyMMZh+h89i44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jO9br7IWnOWraNr/lq2BcTFPFyMnh4SAicS5r0sZ
        QWwhgaWMEi8b9SDiYhKT9m1nh7CFJf5c62KDqPnEKPH9gGoXIwcHm4CexI5VhSBhEYF6if43
        l4BKuDiYBRqYJdZsv8oKkhAWCJZ49WkqE4jNIqAq0fpgGTNIL6+Al0RbOxPEeDmJm+c6mUFs
        TgFviV0rt0Ct8pLYcG0v0wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo2jbsZ9b
        djB2vQs+xCjAwajEw3tg0s4YIdbEsuLK3EOMEhzMSiK8jilbYoR4UxIrq1KL8uOLSnNSiw8x
        mgLdNJFZSjQ5HxjheSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUa
        GJccsJ1kuUqAR+mIw/mil49i3mlZxyo/5EqzSu5xvPpiklOlRpHy5bnfXvtdTkvPvcr2KlWi
        aW7JN8vVIVIBK8LzLnBIXauMXFTyI2PG10RVY8tHIrtOH5batlfZJX5yP4NMWMznPXO/WHrJ
        xEVz3//u+X+2IaPTCgfN5wvnx86+orPeo1A5TImlOCPRUIu5qDgRAELDPlS4AgAA
X-CMS-MailID: 20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Acked-by: Rob Herring <robh@kernel.org>
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

