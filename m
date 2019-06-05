Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03405C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCBE208C0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BSZ2M707"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfFEQyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:54:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32880 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfFEQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:54:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165429euoutp01e176e62f8fe9d76596f8d83574ecf69a~lW7LNnt3S2985529855euoutp01c
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 16:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165429euoutp01e176e62f8fe9d76596f8d83574ecf69a~lW7LNnt3S2985529855euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753669;
        bh=IGYofIBATDN+X5Dc/eq1dCD1wJIxNFiKOKZcqDAf4DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSZ2M707uKovLeniyAKqcU6PQnnxP1KhxbRfTRAc3CM/NlCFAdryrKAL9bgVZCLhE
         ygjLDnw95aVanNuqvEhddVYv8zyPtKA/srxSc01Z/DOtHidbrWkdAfJeyddmAtRS56
         IrxzgsJd1aXINfBy9bmuAkwcPMb1Eaxykqy4otno=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165428eucas1p15664a654f2ef502887e664ef282fd71a~lW7KQmDAu0348203482eucas1p1S;
        Wed,  5 Jun 2019 16:54:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.A9.04298.4C3F7FC5; Wed,  5
        Jun 2019 17:54:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605165427eucas1p27610c38c96313dd80ab445472735a242~lW7JXJD130083500835eucas1p2Y;
        Wed,  5 Jun 2019 16:54:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165427eusmtrp20e1a2f4fe7fdf71c5c732c8c14d04a60~lW7JHYMya2868028680eusmtrp2G;
        Wed,  5 Jun 2019 16:54:27 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-02-5cf7f3c4dfdc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 21.B2.04146.3C3F7FC5; Wed,  5
        Jun 2019 17:54:27 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165425eusmtip1e7748028fe9bb0175fff5383e2ef85c4~lW7H_Hgvp0289902899eusmtip1P;
        Wed,  5 Jun 2019 16:54:25 +0000 (GMT)
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
Subject: [PATCH v8 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Wed,  5 Jun 2019 18:53:58 +0200
Message-Id: <20190605165410.14606-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0gUURiGOzOzM6O0Na2hHyUJS0EFmZXYASNNgoagyx//1EZONajkrrXj
        /RKbQpaXVjSstJtIum5XXYkKS1Nzw602MytaNyxD0czK9dpFa5qV/j3nfd/vew+Hw5Kax6ol
        bLwhSTQahAQt7UvdaZ92rmnzTOpCqlwsrjt3S4XfjA2o8OW25yp87XsfwqUdFwn8tECPzX2f
        Sex03mbws5xhBr8zBeKu+xdo7ClqQ/ic8yGBb7S5Gew6bqFx63CeCje92o5dPxfgiScfUaQf
        PzFeQvEVpk6Kv1fuZvh66ymaL8odoflHI40Ef7rBinibI5P31C/b7bPHd9MhMSE+RTSu3Rzj
        G9fyq4s+UrAw7aq5iTAh9/x85MMCFwqPis8w+ciX1XAWBMebbxLKYQxBaX+t1/Eg6De/QnMj
        RZ4Or1GD4Pu3of8jnZeKVfmIZWkuGO5aj8oDi7lM6HnTRMoZkhsm4NmPKUo2/LhoKJnKpWWm
        uBVgqitnZFZzEZCT5/C2BcG1282kzD5cJJTZbZS8CLj3DHSPzJJKaCuYR34zCvvBkL3By4Ew
        e+8yobAEpqJK79Is6DNf9GbCodXe+e/SJLcKbt1fq8hbwFI9SMkycAvg7ZdFskz+xZI7Z0lF
        VsPJExolvRIaCl94i/yh5noZo0R4KPiQpLxOKYKG2iayGAWV/++6gpAVBYjJkj5WlNYZxNRg
        SdBLyYbY4IOJ+nr093M5Zuyjd9H4ywMtiGORdr4a6iZ1GpWQIqXrWxCwpHaxWnCN6TTqQ0J6
        hmhM3G9MThClFrSUpbQB6sx5vXs1XKyQJB4WxSOicc4lWJ8lJhTXvj7lWMe2iKxRlGobSHxq
        iUoLI7t7K/y7o622r/WzjpmjuKxw19Yr4faqmzkhr3cu/1Ghyy6bHBLC1yB9RvB0clAMsTf7
        U4/OQNfEPOiuiNpROVRdOKpfmcsnCGTMwCBxPsPltoVs3OOs3NC4InQ0qmqf+5KlUY+qpTBH
        tJaS4oR1q0mjJPwB1rJHhVgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7qHP3+PMZjXz22xccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqE/l9kKuvkrlvbvZ2pgvMvTxcjJISFgItH7+RR7
        FyMXh5DAUkaJJ82rWCASYhKT9m1nh7CFJf5c62KDKPrEKDHz3xUgh4ODTUBPYseqQpAaEYF6
        if43l8BqmAUamCXWbL/KCpIQFgiWmPDsLhOIzSKgKtGwcRbYUF4Be4mm9tOMEAvkJVZvOMAM
        YnMKOEhMO74Z7AghoJpL138zT2DkW8DIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwlrYd
        +7l5B+OljcGHGAU4GJV4eCU2fo8RYk0sK67MPcQowcGsJMKbePtLjBBvSmJlVWpRfnxRaU5q
        8SFGU6CjJjJLiSbnA+M8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMH
        p1QDo5DW6z7pW76ir5YJtkn/PZXFEt3oLdj6ad6MtzUezluCBWdv63mwY7bExMndhQ02OSI8
        M6srGR/0hq/cltvfeUjHvCcg8CXbstBvf1YpLi59f0H4ROXTe36Gq7dbxEyRyspMeNX73ylw
        d/BzE51/5svZTuxz8Mtg/xgoqS47f9LDAxfl1coWKrEUZyQaajEXFScCAGkjAT27AgAA
X-CMS-MailID: 20190605165427eucas1p27610c38c96313dd80ab445472735a242
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165427eucas1p27610c38c96313dd80ab445472735a242
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165427eucas1p27610c38c96313dd80ab445472735a242
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165427eucas1p27610c38c96313dd80ab445472735a242@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469943f1..02d5ac469a3d 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -60,6 +60,7 @@
 #define CLK_MAU_EPLL		159
 #define CLK_SCLK_HSIC_12M	160
 #define CLK_SCLK_MPHY_IXTAL24	161
+#define CLK_SCLK_BPLL		162
 
 /* gate clocks */
 #define CLK_UART0		257
@@ -195,6 +196,16 @@
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
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
@@ -217,6 +228,8 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_SCLK_SPLL	660
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +261,11 @@
 #define CLK_DOUT_CCLK_DREX0	794
 #define CLK_DOUT_CLK2X_PHY0	795
 #define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_FF_DOUT_SPLL2	797
+#define CLK_DOUT_PCLK_DREX0	798
+#define CLK_DOUT_PCLK_DREX1	799
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		800
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.17.1

