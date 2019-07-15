Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C40C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984272067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FFikBvAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfGOMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60259 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbfGOMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124450euoutp0142748da29f4d411ce65b24764328ec8c~xlUnveUWO1960819608euoutp01b
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124450euoutp0142748da29f4d411ce65b24764328ec8c~xlUnveUWO1960819608euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194690;
        bh=3iMiE1nebw7ymoKs7LTFQoEktkfy+i+PN+GxjbHobXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFikBvAkWtgru8gZUVXAXnGfhCS9rSgHzPYU5hWhVLq6V6gCe5oBb902+dhWYguBx
         yAevVF+ddcoAuDJFx3qEcD8ws8/ffZYnkA1mn9I600vJcL6L+noE0uH3hUH7tRfthJ
         kqbYCAmIRjHlGgbNjSOVlVGwpObgr/eZA3hd3PzM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124449eucas1p100261903364e8c0310850db7f4bdc768~xlUm3ZFGp0570905709eucas1p1D;
        Mon, 15 Jul 2019 12:44:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 62.B0.04325.1457C2D5; Mon, 15
        Jul 2019 13:44:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124448eucas1p1b3a8d16d6f5e9fd4ed49c3b7fa66e18e~xlUl-pPZj3191231912eucas1p1a;
        Mon, 15 Jul 2019 12:44:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124448eusmtrp1c394831890e757c003e0da31033e1a00~xlUlxZNih0462004620eusmtrp1c;
        Mon, 15 Jul 2019 12:44:48 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-ce-5d2c75413573
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.40.04146.0457C2D5; Mon, 15
        Jul 2019 13:44:48 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124447eusmtip21149f1e8873a78ccd48ccb31e70577f9~xlUlAwYKU1115211152eusmtip2L;
        Mon, 15 Jul 2019 12:44:47 +0000 (GMT)
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
Subject: [PATCH v1 18/50] ARM: dts: exynos: add bus_isp with OPP table
Date:   Mon, 15 Jul 2019 14:43:45 +0200
Message-Id: <20190715124417.4787-19-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/exex0u7qbkQSVpFJaWZgUdyNKwYvVHRFBYJjnzppJO23Wa
        JjQVK80eGE2J8kG+mtrU5ms+8IWmklMCX1GYVuYjtVRKMmnXu+q/7/d7Pr/f+XI4NC4zkY50
        uCqGVauUEXKRmKjpXOnbdVizM3B3Tb8Yjb7oI1FltoFEQ0uTJMrtsNj7EzM4MpsrKPQ6eZZC
        o1pnVDUxSKJvGe9J9Mb0RISyzc0YKu94R6HCoQEMDfQcRW+TSkQotamDQu2zt0i0NlhJ+Nop
        ynLKgGJ+OJVSVOnTRIqXBTcUrXONmOKeUQ8Ui1WbT1Hnxd4hbER4LKv2PBQkDssq1Yqiq8XX
        xn7lk1qQQqcDGxoy++BUXpooHYhpGVMC4IcxPSGYJQCLkscxwSwCWGuot2D0+siPhhh+WsYU
        A2jKdfs30FrXgvGMiPGAdfqrPGPPFADYsRLMMzgzgsHGj/Ukz9gxx2BxqRPPEMw2mFTYS/Ba
        wvjA57+XMaGdCyytaMF5bWPJV3T9600hM0jB2pZuSuhzBOYV2Qu8HZzuMlKCdoa9DzMIQXNQ
        ezcfCDoRTtx/amUOwPaugfU6OLMDGkyeQnwYZpq7rNs3wuGvUj7GLTKzJgsXYgm8fVMm0Nuh
        MaPfWngTLC7TWZcr4NQzo/VpMwHUD3/BHgCXx/8vywNADxxYDRcZynJ7VWycB6eM5DSqUI9L
        UZFVwPKjete6lutA82pwG2BoILeV+Ia4B8pIZSwXH9kGII3L7SUHly2RJEQZn8Cqoy6qNREs
        1wacaELuILm+YSxAxoQqY9grLBvNqv+eYrSNoxYEVd9MqS2XEvVe7uPe+zUb/M3S4LgA5zU/
        P2Oy46PVhEnc8QQeZpvpMyD9rvq8hS07N62Smma6G2JtcrSN7onyPVu1yGfyeOLpe0exswsX
        ktJqFuyHm5pmtpnP/EydvUwRyTp/SUgdTRlcdSOu7J2IeT+ToUe3ce5VXOdJ109yggtTernh
        ak75Bwn7/XFNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7oOpTqxBvPbhSxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7G9NUNbAVbuSoe/F7I2sDYzNHFyMEhIWAi8X13SRcjF4eQwFJGiXOH
        77F0MXICxcUkJu3bzg5hC0v8udbFBlH0iVHi3uqFjCDNbAJ6EjtWFYLUiAisYJSYfMIbpIZZ
        4DWTxJGj71hBaoQF3CSWr5YGqWERUJVoXHoabD6vgL3Eyr9fmSDmy0us3nCAGcTmBIr/nHaB
        DcQWErCTWHz0J9MERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuNm27Gfm3cwXtoY
        fIhRgINRiYfXIUU7Vog1say4MvcQowQHs5IIr+1XoBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJL
        iSbnA2M6ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo6TGzHN2
        2z6a7TK6tXHvuWJLn48HvjzqVOWdxj/LffHlogkBKdIymte4HhwKfnJlY/crS8kHZgFJejPq
        D+yZIL/OTvCBmVXMxWnG3x6U8EhaWV6b5laSnf01atHNLa/ezb19PT8/+OOHk/lBTsmZTl4X
        dJWOtZXdn/NI6/bGW8bRBZNn/fu2S0OJpTgj0VCLuag4EQCBSUn8sQIAAA==
X-CMS-MailID: 20190715124448eucas1p1b3a8d16d6f5e9fd4ed49c3b7fa66e18e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124448eucas1p1b3a8d16d6f5e9fd4ed49c3b7fa66e18e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124448eucas1p1b3a8d16d6f5e9fd4ed49c3b7fa66e18e
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124448eucas1p1b3a8d16d6f5e9fd4ed49c3b7fa66e18e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bus_isp which controls ACLK400_ISP clock. The OPPs are aligned to
parent clock and PLL rate so that the PLL would not need to be
reprogrammed.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5fb2326875dc..1b717c5c3b1a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1095,6 +1095,14 @@
 			status = "disabled";
 		};
 
+		bus_isp: bus_isp {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DOUT_ACLK400_ISP>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_isp_opp_table>;
+			status = "disabled";
+		};
+
 		bus_wcore_opp_table: opp_table2 {
 			compatible = "operating-points-v2";
 
@@ -1337,6 +1345,23 @@
 				opp-hz = /bits/ 64 <400000000>;
 			};
 		};
+
+		bus_isp_opp_table: opp_table17 {
+			compatible = "operating-points-v2";
+
+			opp00 {
+				opp-hz = /bits/ 64 <150000000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <300000000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <400000000>;
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.17.1

