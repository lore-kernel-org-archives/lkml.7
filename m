Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E273C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F059A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IzIsINoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfDDRWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49045 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:48 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190404172245epoutp01b4728d9289925043af9a1b3a10a0d84c~SVUJuT_U91973719737epoutp01p;
        Thu,  4 Apr 2019 17:22:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190404172245epoutp01b4728d9289925043af9a1b3a10a0d84c~SVUJuT_U91973719737epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398565;
        bh=dDJj7cygsR/Ujzoc6i/7zV99lnRysyucTL0YNXQfzSQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=IzIsINoN+pDXK1XF99y6i0HgtfsKRxI+XVqVP6c7jDsdCvAxaXi5i4kAZjVytD6/G
         klbAl3AM5zT1Pp9FuqUHF5pTF7OmDYVBLxg8sPeHzeXVqeDfBIcOMCbwFdelYyNiaz
         IH8zolWugaiRFP2wPVF42+U1UDkozjQjLfCJ9DXs=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190404172244epcas1p15a340b6153cd1cad1eda0c5952dc727e~SVUJL2ESn1312213122epcas1p1P;
        Thu,  4 Apr 2019 17:22:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.5A.04143.46D36AC5; Fri,  5 Apr 2019 02:22:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190404172243epcas1p39af2498a51772ee4ab2a31f26e469c5b~SVUH-YZ2E0537505375epcas1p3H;
        Thu,  4 Apr 2019 17:22:43 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-78-5ca63d64f940
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.B9.03598.36D36AC5; Fri,  5 Apr 2019 02:22:43 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:43 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: [PATCH RFC 5/8] ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Date:   Thu, 04 Apr 2019 19:17:32 +0200
Message-id: <20190404171735.12815-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCmvm6K7bIYg7kblCw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik8XtxhVsFou2fmG3
        aN17hN2B12PNvDWMHptWdbJ5bF5S79G3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZPz+9YCtY
        x1bxqm8iewPjJtYuRk4OCQETiemLXrN0MXJxCAnsYJQ4tGgDG4TznVGi88huuKqGvn3sEInd
        jBJzzuxihHB+MkqsnLGGEaSKTcBQovdoH5gtIiAscW/pcrAOZoETTBKzjh0DGyUs4CXxcPYS
        sCIWAVWJefN2Ai3n4OAVsJbY9sQNYpu8xOoNB5hBbE4BG4nHS96AnSQhsINN4nnfUhaIIheJ
        tWsmMIP0SghIS1w6agtR08wo0bP7NjuEM4FR4v7xBYwQDdYSh49fBDuCWYBP4t3XHlaIZl6J
        jjYhiBIPiQt7NrJCfNbPKLF9djMr0IgFjAyrGMVSC4pz01OLDQuM9YoTc4tL89L1kvNzNzGC
        Y1TLfAfjhnM+hxgFOBiVeHg1mJbFCLEmlhVX5h5ilOBgVhLhDf6+NEaINyWxsiq1KD++qDQn
        tfgQozQHi5I473oH5xghgfTEktTs1NSC1CKYLBMHp1QDo9uE4qP1H8xr+2scu2M2S2y+GfVY
        /4kkY0j3xIu37nzpvSSqvG1X4j+lqN6O9MNZJ59krJu2OTE7fWvO+Y51n38d379ZdWuqvOOW
        ddd/KpVfuP9mttQnQZlZab2lG5irOeNCNx+9Pe9K1vZdad8OqHDoKcxrne3vfnkL+92X0x9L
        pj+aejeZO0KJpTgj0VCLuag4EQD0YKmxzQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jAd1k22UxBvcvCVhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLsDr8eaeWsYPTat6mTz2Lyk3qNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyfn56wVaw
        jq3iVd9E9gbGTaxdjJwcEgImEg19+9i7GLk4hAR2Mkpc/PyJFcL5yShx7cQEJpAqNgFDid6j
        fYwgtoiAsMS9pcvBOpgFTjBJ/F+4hgUkISzgJfFw9hKwIhYBVYl583YCxTk4eAWsJbY9cYPY
        Ji+xesMBZhCbU8BG4vGSN2wgJUJAJd+3JExg5FnAyLCKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0
        L10vOT93EyMw/LYd1urbwXh/SfwhRgEORiUeXg2mZTFCrIllxZW5hxglOJiVRHiDvy+NEeJN
        SaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFxscTGpr6e5pDt
        Tt82Cqx8/fP4t6mmIaeqEmUfvl1t4G+9+vXP0JoZhW/DG1xLa6ZK1KQsDxTqCdGN6XsR5vf7
        zqca3w8dB88t2Xi8f990l6J1y2XDu9Iy7iXe+VFl6cO+YvkhD6ny5FeXZJyNf1pOvtpyw2fS
        eg/DoAU/Xadd+2H8oF2m1v6zEktxRqKhFnNRcSIANLPjCzsCAAA=
X-CMS-MailID: 20190404172243epcas1p39af2498a51772ee4ab2a31f26e469c5b
CMS-TYPE: 101P
X-CMS-RootMailID: 20190404172243epcas1p39af2498a51772ee4ab2a31f26e469c5b
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172243epcas1p39af2498a51772ee4ab2a31f26e469c5b@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

As now we have chipid driver to initialize SoC related information
let's include it in build by default.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b40963cf91c7..e3e63aa5d60a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
-- 
2.17.1

