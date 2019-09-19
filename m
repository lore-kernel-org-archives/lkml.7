Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F66521D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ae7QTE+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbfISNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:46:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60903 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390517AbfISNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:46:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919134623euoutp01dbfb63d6961eeaf43e0f7db78815b895~F2vNUioTf2637326373euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:46:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919134623euoutp01dbfb63d6961eeaf43e0f7db78815b895~F2vNUioTf2637326373euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568900783;
        bh=1IqbBg5jzrfPhD7Enp7RUpljzJikFkWLSh4zCwaVL0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae7QTE+C5awLxDdsZOghpPNETQBzwT8g+6shgkRlnc+yh0rhobR4S3Q3T4B/+/1r8
         piWbrjTVyBLgsgBM5ynFQWZIvZTVyjA7jIL3N6c9QCD9HC/DSUwKURUCmD/ZEtvAKu
         qWds2iJYwv4Rx8iUdeNdP8GuR+wSDDyZuIxM9/20=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919134623eucas1p287bcda319064f0fc610e66b41d60d0be~F2vM2M3Rb0635006350eucas1p20;
        Thu, 19 Sep 2019 13:46:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.95.04309.EA6838D5; Thu, 19
        Sep 2019 14:46:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe~F2vL7QmDs1263812638eucas1p1R;
        Thu, 19 Sep 2019 13:46:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190919134622eusmtrp27e280ea520aa6d3b4d93dbaabaeab3b7~F2vLtMw2u0895108951eusmtrp2U;
        Thu, 19 Sep 2019 13:46:22 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-25-5d8386ae7489
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.0A.04166.EA6838D5; Thu, 19
        Sep 2019 14:46:22 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919134621eusmtip1ea7d16f6768cd638aec9a2f87b94e507~F2vLQW_v40983909839eusmtip1g;
        Thu, 19 Sep 2019 13:46:21 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maciej Falkowski <m.falkowski@samsung.com>, krzk@kernel.org,
        mark.rutland@arm.com, robh@kernel.org, a.hajda@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 resend] ARM: dts: exynos: remove obsolete IRQ lines
Date:   Thu, 19 Sep 2019 15:45:47 +0200
Message-Id: <20190919134547.11671-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPcs5K46U9mF8evCpbEap_j0Sd5kUk-xiWjwyihAL7te=Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduznOd31bc2xBquLLG6tO8dqMf8IkDh/
        fgO7xeVdc9gsZpzfx2TxoHkdm8XaI3fZLZZev8hk8X/PDnYHTo8189Ywemxa1cnm0bdlFaPH
        501yASxRXDYpqTmZZalF+nYJXBld0yaxFrzkq7g2YSlzA2MzTxcjJ4eEgInE056tbCC2kMAK
        RokjXwS7GLmA7C+MEq2d15khnM+MEhPedLDBdFz5MZENIrGcUaJ7wTEWuJatL48yglSxCRhK
        dL3tAusQEUiUuP27nx2kiFlgDaPEl2/vWLsYOTiEBdwkVi00B6lhEVCVaNx5hh3E5hWwldi9
        9jkjxDZ5idUbDjCD2JwCgRI/3s9nApkjIfCdTWLvr6/sEEUuEms2HmeFsIUlXh3fAhWXkfi/
        E6ahmVHi4bm17BBOD6PE5aYZUCusJQ4fvwh2EbOApsT6XfoQYUeJ/20LmEHCEgJ8EjfeCoKE
        mYHMSdumQ4V5JTrahCCq1SRmHV8Ht/bghUvMELaHxLRpB9khAbSEUWLTkzXsExjlZyEsW8DI
        uIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwXZz+d/zLDsZdf5IOMQpwMCrx8CqUN8cK
        sSaWFVfmHmKU4GBWEuGdY9oUK8SbklhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZq
        akFqEUyWiYNTqoFRTNDG031Z7PcX22cYq52r03dMCM2pDj5b9m3+AvstDyqeV8wrLJ5cx7Xj
        Wn1GdVVqzqTq1CsSbJqnWpv4X6769V8gYn5KzVYOJ4YSc0ndZze/zl3U79iwRyH268kXj+T/
        ZnuqGIs6CLxLvXTKdaZOxE4TO8Z/E6WM0+yKOVubmW/tPrZje64SS3FGoqEWc1FxIgCvvl85
        EwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xu7rr2ppjDSa9Z7K4te4cq8X8I0Di
        /PkN7BaXd81hs5hxfh+TxYPmdWwWa4/cZbdYev0ik8X/PTvYHTg91sxbw+ixaVUnm0ffllWM
        Hp83yQWwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehldE2bxFrwkq/i2oSlzA2MzTxdjJwcEgImEld+TGTrYuTiEBJYyihxZnszE0RCRuLktAZW
        CFtY4s+1LqiiT4wSd57NYgZJsAkYSnS9BUlwcogIJEssPryTEaSIWWATo8TOFZeBHA4OYQE3
        iVULzUFqWARUJRp3nmEHsXkFbCV2r33OCLFAXmL1hgNgMzkFAiV+vJ8PdoSQQIDEvIZrLBMY
        +RYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIDN9tx35u3sF4aWPwIUYBDkYlHl6F8uZY
        IdbEsuLK3EOMEhzMSiK8c0ybYoV4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxhbeSXxhqaG
        5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGDvaDv9Tqm4QlawwWW/psmfa
        /ecppeaN+hKuwle6eOKmxjQKlNvrvPm5PGNbl6Evg/6LN1JSJ+scnq5uO7jIbuHPPds+R2io
        /WG5zrWwyJm9VUrcxnn3d70l1n2aATWJTx+ziemtsxHoPc8m84bJd0c584OLX2U+da+rdkl8
        Y3o7b4W4+f4wJZbijERDLeai4kQA1esEIHUCAAA=
X-CMS-MailID: 20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe
References: <CAJKOXPcs5K46U9mF8evCpbEap_j0Sd5kUk-xiWjwyihAL7te=Q@mail.gmail.com>
        <CGME20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

In commit 7222e8db2d50 ("iommu/exynos: Fix build errors") Exynos3250
iommu driver stopped supporting two IRQ lines. The second IRQ line in DTS
is ignored and is not needed.

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



