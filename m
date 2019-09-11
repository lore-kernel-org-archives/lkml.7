Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AD5C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12A20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B/fFUHFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfIKNdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:33:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58533 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfIKNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:33:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190911133319euoutp01b1cd56e59b3a96750fba406f83950629~DZZgP9JLd0038300383euoutp01z
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:33:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190911133319euoutp01b1cd56e59b3a96750fba406f83950629~DZZgP9JLd0038300383euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568208799;
        bh=co6RF11yq8100UIrcxY4BgpZxzf0jr/xApaYPzpjXj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/fFUHFFCYGIAUxEePgmipoCELzoxeHJtURXhkG02Xb4QP/WOfWKkH0j20qxost/B
         be6tCu0gS+wq6Lto6RiLQtRr+U34RAtQTAira8cO0ZgHGmuKqUSllRhTPt6GxpIlZw
         iRneRZnIk1KRfV6P94QGqFZ7Xu9Ji3FaZgTQOi7E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190911133318eucas1p203adc11958f5a111ea768c58373c26af~DZZfdq9qg1131711317eucas1p2A;
        Wed, 11 Sep 2019 13:33:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 92.A4.04309.D97F87D5; Wed, 11
        Sep 2019 14:33:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190911133317eucas1p27f0312f5cd3e3c988399f65b07150e42~DZZee_wb60334603346eucas1p2u;
        Wed, 11 Sep 2019 13:33:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190911133317eusmtrp16d06eb6cd636152b43008dcf96aaac30~DZZed_uHi1197011970eusmtrp1K;
        Wed, 11 Sep 2019 13:33:17 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-51-5d78f79d455a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 62.AF.04117.C97F87D5; Wed, 11
        Sep 2019 14:33:17 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190911133316eusmtip1cf4aa385197592a22dbf51db67b6f041~DZZd6rE7o1961519615eusmtip12;
        Wed, 11 Sep 2019 13:33:16 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, m.falkowski@samsung.com,
        mark.rutland@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        a.hajda@samsung.com
Subject: [PATCH] dt-bindings: arm: samsung: Exynos 3250: iommu: remove
 obsolete IRQ lines
Date:   Wed, 11 Sep 2019 15:33:10 +0200
Message-Id: <20190911133310.8365-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned253ytiDWZssLC4te4cq8X8I0Ci
        c/YGdovz54HE5V1z2CxmnN/HZPGgeR2bxdojd9ktll6/yGTRuvcIuwOXx5OD85g81sxbw+ix
        aVUnm0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlvH09h7XgNF/F6ntHmRoYP3B3MXJySAiY
        SLz+/5Cti5GLQ0hgBaPErwldjBDOF0aJF/v2MEM4nxklJl7bwQbT8nvTeXaIxHJGie1fV7LB
        tRy5upkZpIpNwECi/81eFhBbRCBR4vbvfrAOZoFZjBK3r7WBJYQFoiVu3msDG8sioCrRNmka
        O4jNK2At8f7iOkaIdfISqzccABvKKRAo0bbnFBPIIAmBZnaJO+euMkMUuUi0TF8OdZ+wxKvj
        W9ghbBmJ05N7gJZxANnVEte+yUL0tjBKXJ/2FqreWuLPqolsIDXMApoS63fpQ4QdJS4tm80E
        0conceOtIEiYGcictG06M0SYV6KjTQjCVJV4MyEWolFaonXNfqjjPSRmHjwCDdEljBKvlv5j
        ncAoPwth1wJGxlWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBKeT0v+NfdjDu+pN0iFGA
        g1GJh1fgbkWsEGtiWXFl7iFGCQ5mJRHeBy1AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+i
        hQTSE0tSs1NTC1KLYLJMHJxSDYwbWc1PzG+PF5nxou4Qo1rR47evJrJ+Yoj/JRcW2eefm35C
        tuV4pOgOg/j02+4sP5tvhXyYI1R8wfNCf9qEx/tPPvstz55iev/djcnJIueWyjTO4Yl5fHHf
        nYg47bgTQW4nag38tjV8qeRRX+90W+Hei3l9hsYet0ut72ZOsL76jvOdpIKRxg0lluKMREMt
        5qLiRADE6uzUHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7pzv1fEGrScZbK4te4cq8X8I0Ci
        c/YGdovz54HE5V1z2CxmnN/HZPGgeR2bxdojd9ktll6/yGTRuvcIuwOXx5OD85g81sxbw+ix
        aVUnm0ffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
        pKTmZJalFunbJehlvH09h7XgNF/F6ntHmRoYP3B3MXJySAiYSPzedJ69i5GLQ0hgKaPEgqXf
        WCES0hL7r31kh7CFJf5c62KDKPrEKDF97UKwIjYBA4n+N3tZQGwRgWSJxYd3MoIUMQssYpS4
        /nU2WEJYIFJi/pOtTCA2i4CqRNukaWBTeQWsJd5fXMcIsUFeYvWGA8wgNqdAoETbnlNg9UIC
        ARJnjt5kncDIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgUG879nPLDsaud8GHGAU4
        GJV4eDPuV8QKsSaWFVfmHmKU4GBWEuF90AIU4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5Hxg
        xOWVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBU2mi75GH8yW5L
        ec08jrlzmpdMaWxw4xUs2bG1j5P5iYbw1WdVzUZfpaXnLVcuN63O664/m1TRNL/M71xYR4+k
        t7rzX5E9FVe+HPxm8j9j78rMqr16TFm5L76L5H/kuv05z+3xxQ1tCte+3ys63nDlMFfq6s2K
        P5hknzlPPGd5UfPJkRtW37KUWIozEg21mIuKEwH5pNJ9gAIAAA==
X-CMS-MailID: 20190911133317eucas1p27f0312f5cd3e3c988399f65b07150e42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190911133317eucas1p27f0312f5cd3e3c988399f65b07150e42
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190911133317eucas1p27f0312f5cd3e3c988399f65b07150e42
References: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
        <CGME20190911133317eucas1p27f0312f5cd3e3c988399f65b07150e42@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7222e8db2d506197ee183de0f9b76b3ad97e8c18 (iommu/exynos: Fix build
errors) Exynos3250 iommu driver stopped supporting two IRQ lines.
The second IRQ line in DTS is ignored and is not needed.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 784818490376..190d9160a5d1 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -314,8 +314,7 @@
 		sysmmu_jpeg: sysmmu@11a60000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11a60000 0x1000>;
-			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUJPEG>, <&cmu CLK_JPEG>;
 			power-domains = <&pd_cam>;
@@ -355,8 +354,7 @@
 		sysmmu_fimd0: sysmmu@11e20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11e20000 0x1000>;
-			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
 			power-domains = <&pd_lcd0>;
@@ -507,8 +505,7 @@
 		sysmmu_mfc: sysmmu@13620000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13620000 0x1000>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUMFC_L>, <&cmu CLK_MFC>;
 			power-domains = <&pd_mfc>;
-- 
2.17.1

