Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA9CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EB82081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cz2njkpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfILPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:18:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39495 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbfILPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:18:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190912151831euoutp02916e7dce8c93fce62cca423448bfb74e~DuepqICmG0931309313euoutp02d
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:18:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190912151831euoutp02916e7dce8c93fce62cca423448bfb74e~DuepqICmG0931309313euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568301511;
        bh=9fiqiegTet1HHXeKGZMH21sovxq29bLed8hpjvy2DWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz2njkpf5UHhyYyb0bge+M0bvJ8WJob7P1FUaq5/929DZQ8+RAZFjxwjoAyh+i1Hi
         3RSX1YlVSNdeAOuwotcp5jvhpwoJHzbFIiRnh46+dZuQy1I5O+UKPDxmHSCLdaceXv
         d1OTqmUYaCuhqUIuENMCh4fM+FfwrZiycfB5sM/M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190912151830eucas1p1e5abb5620ef151f7f68ed3a2d7b4ce4d~DueowiADe3012930129eucas1p1b;
        Thu, 12 Sep 2019 15:18:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D5.B3.04309.6C16A7D5; Thu, 12
        Sep 2019 16:18:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190912151829eucas1p216ca28e56f62e7f484c46ce30581200a~DueoAr4eY2540325403eucas1p2J;
        Thu, 12 Sep 2019 15:18:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190912151829eusmtrp12be9a8f85efd569bd033c9500bb244a8~DuenyN4CJ2459924599eusmtrp1q;
        Thu, 12 Sep 2019 15:18:29 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-d8-5d7a61c6c61a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.ED.04166.5C16A7D5; Thu, 12
        Sep 2019 16:18:29 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190912151829eusmtip2630c7a0d799b3bd16a7a226060870c26~DuenSC6Ei1425614256eusmtip2n;
        Thu, 12 Sep 2019 15:18:29 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, a.hajda@samsung.com, m.szyprowski@samsung.com,
        m.falkowski@samsung.com
Subject: [PATCH v2] ARM: dts: exynos: remove obsolete IRQ lines
Date:   Thu, 12 Sep 2019 17:17:56 +0200
Message-Id: <20190912151756.27173-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911133310.8365-1-m.falkowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned1jiVWxBp9OSVvcWneO1WL+ESDR
        //g1s8X58xvYLS7vmsNmMeP8PiaLB83r2CzWHrnLbrH0+kUmi9a9R9gduDzWzFvD6LFpVSeb
        R9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGVM+7OBqWAWf8WKI8vZGhjX8nQxcnBICJhI7NyQ
        18XIxSEksIJRonvyREYI5wujxJe385kgnM+MEj1b+9m6GDnBOlac64RKLGeUWLHmNztcy6Ld
        e5hAqtgEDCT63+xlAbFFBBIl3q77yQpSxCwwm1FizYLtrCAJYQF7iTOvdoHZLAKqEvc69zCC
        2LwCNhKdv86yQKyTl1i94QAzyLGcQPHD/x1B5kgI/GeT+Ng3mRWixkVi//3pjBC2sMSr41vY
        IWwZidOTe1ggHq2WuPZNFqK3hVHi+rS3UO9YS/xZNZENpIZZQFNi/S59iLCjxJ9JlxkhWvkk
        brwVBAkzA5mTtk1nhgjzSnS0CUGYqhJvJsRCNEpLtK7ZD3WLh8S0cyuZIaHTzyjR3H+AdQKj
        /CyEXQsYGVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJo3T/45/2cG460/SIUYBDkYl
        Hl4LnapYIdbEsuLK3EOMEhzMSiK8Pm8qY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYS
        SE8sSc1OTS1ILYLJMnFwSjUwls/h17EuqFnA9nPDlK6t/kr5Msmdr8q6PmRnztB/G77344qb
        TGVGC2R7D55MlL3+3ueqzILXzc/1k9mOeB1qlGzhEVPgMmTjTk1OzXpkaFjWKjn15B/1LYcj
        /WZ2/PncOj+FyVkwIytB7pLIt5SUuaaBYTJfl1osF/idOCmtKCTu7WtJpzglluKMREMt5qLi
        RAAi6P9oFgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xe7pHE6tiDV50alrcWneO1WL+ESDR
        //g1s8X58xvYLS7vmsNmMeP8PiaLB83r2CzWHrnLbrH0+kUmi9a9R9gduDzWzFvD6LFpVSeb
        R9+WVYwenzfJBbBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZk
        lqUW6dsl6GVM+7OBqWAWf8WKI8vZGhjX8nQxcnJICJhIrDjXydTFyMUhJLCUUeLZ2YesEAlp
        if3XPrJD2MISf651sYHYQgKfGCWu/LQFsdkEDCT63+xlAbFFBJIlvj3rZAEZxCywmFFi+94P
        YA3CAvYSZ17tAhvKIqAqca9zDyOIzStgI9H56ywLxAJ5idUbDjB3MXJwcALFD/93hNhlLfF7
        zSamCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSG8bZjPzfvYLy0MfgQowAHoxIP
        r4VOVawQa2JZcWXuIUYJDmYlEV6fN5WxQrwpiZVVqUX58UWlOanFhxhNgW6ayCwlmpwPjLG8
        knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MEq3sNbxOnGf60l1C
        06wX9bk8faRnp7y+4sL7zry/S/d78R6+rrvutoBR1I7HNWorYlOqXjf2u3VbOE5994VHYVeA
        xdupr5zbD3x9fe7fkdVbGd+4z91n9XvyRvPc5qfqxqEWPCs/c/hfZ+y5blqtH3L0wFu59UvK
        DRnn7F75a3f3KbU1J9UylViKMxINtZiLihMB6G1QwHkCAAA=
X-CMS-MailID: 20190912151829eucas1p216ca28e56f62e7f484c46ce30581200a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190912151829eucas1p216ca28e56f62e7f484c46ce30581200a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190912151829eucas1p216ca28e56f62e7f484c46ce30581200a
References: <20190911133310.8365-1-m.falkowski@samsung.com>
        <CGME20190912151829eucas1p216ca28e56f62e7f484c46ce30581200a@eucas1p2.samsung.com>
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
v2: 
- change commit message to proper version
- add proper recipients
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

