Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8743C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68C22067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mr1Q5BNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfGOMr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60313 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbfGOMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124451euoutp01c7db8b391b9682719834247235886d74~xlUpDgeQE1960819608euoutp01e
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124451euoutp01c7db8b391b9682719834247235886d74~xlUpDgeQE1960819608euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194691;
        bh=aLhnyTWdZ5o8tYVZnpxOlyYCNVbl4sFXcCeL4NDnAzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr1Q5BNnJX05hVaeDYUZ1wttZbZ1MQPW3fGI2ighsqEKb/yTq6ko/bLF8xBRN0wWW
         oWw+ejT3OL8fVvUiwtXdad8vslidgg2LZzAW/jGKythVJeUr/DTuo7GnM+jCTJyq20
         KuCTtvUG0DDyxR6i2YcbE3EdSEZvCXV0rk2F3UTQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124451eucas1p15f2d0d90b44efa83f2ef99b3e5f2e043~xlUoQ6V460571105711eucas1p16;
        Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E4.B0.04325.2457C2D5; Mon, 15
        Jul 2019 13:44:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124450eucas1p189043d196375aa6adacf898de81bfa9b~xlUnk9cAm0154001540eucas1p1F;
        Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124450eusmtrp1cd38d6f5340299905ea08b0461293d57~xlUnW0GLU0462004620eusmtrp1h;
        Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-d2-5d2c754264e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.40.04146.1457C2D5; Mon, 15
        Jul 2019 13:44:49 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124449eusmtip2f61e0c5c000efa07dbc20e389625a118~xlUmir9vb1176011760eusmtip21;
        Mon, 15 Jul 2019 12:44:49 +0000 (GMT)
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
Subject: [PATCH v1 20/50] ARM: dts: exynos: change and rename FSYS OPP table
 in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:47 +0200
Message-Id: <20190715124417.4787-21-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeyxVcRzvd849D3duO13Gz6PMFeuFSm2/Db2m7bb6g1abKauLE/LsHlek
        lZI8klclC8nmtUvhMkNSuItYXVTctFK0Wd6Ghsm6x2H99/l+Xt/vfvvRuPQlYUkHh0exynBF
        qIwUi+rfLukcj6n2+O5danVEgy8+EKgmt4pAA/OjBCrUGsaMkXEc6XTVFHp/e4JCg/HWSDPS
        T6DZtO8E+tiUT6JcXQuGnmu/UahkoBdDvV3H0ddb5SRKfKWlUPtEEoFW+2tER0zklU8rgXxa
        n0jJNeoUUl5bfFPeOtWMydPr1EA+p9nmSfmI3QLY0OBoVul86KI4qDZzkYgcF8eUDU2L4sFP
        OhUY0ZA5ANtTu8hUIKalTDmAo8sNmDDMA6jVDOHCMAfgvcYqciOSPjdICUIZgOPFy4AX1iL1
        2hupgKZJxgk2qK/wtClTbGha8uP9OPMFg82/GgleMGHOw5TpWpL3ixh7mPzJlqclzGFYsjBN
        CbtsYEX1G5zHRgZ+Kadn7VTI9FGwtDAN8FnIeMCkBFPBbwLHOurWs9aw+0GaSMAcjL9fBAR8
        HY5kFKx7XGF7Ry/B1+DMTljV5CzQR+Hw70lMaN8M9ZNbeBo3wOz6x7hAS2DyXang3gHr0now
        AZvBssqc9XI5TJgYXn+obACHelaxTGDz5P+yZwCogTmr4sICWc4lnL3qxCnCOFV4oJN/RJgG
        GL5U92rHQgNoWfFrAwwNZMaSIwG7faWEIpqLDWsDkMZlphL3BQMlCVDEXmOVEReUqlCWawNW
        tEhmLonb9OOclAlURLEhLBvJKjdUjDayjAfpq/UgLybrb1+kq+JOl7dF52X8oRvZqffeflLc
        WeBYpGvLem3vBcZiM4oD9PCPJL+5Iw4PHrcz7z84k+vknxfs+jnk9NlTtVunxlyUnp3Gcw75
        sskKu3QgszJ6NNMcY9Fu68NdClnZ746X2i6yJSoHvVfvuwi1uVnTGY/ZExYyERek2LcLV3KK
        f88lzFVOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7qOpTqxBjs3W1rcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MzRN+sBa85qpYfv89SwPjQ44uRk4OCQETib7Pt9i7GLk4hASWMkq8
        XXKFDSIhJjFp33Z2CFtY4s+1LjaIok+MEmffrmftYuTgYBPQk9ixqhCkRkRgBaPE5BPeIDXM
        Aq+ZJI4cfccKkhAWiJI4frabCaSeRUBVouOKIkiYV8BeYunX91Dz5SVWbzjADGJzAsV/TrsA
        doOQgJ3E4qM/mSYw8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGDnbjv3cvIPx0sbg
        Q4wCHIxKPLwOKdqxQqyJZcWVuYcYJTiYlUR4bb8ChXhTEiurUovy44tKc1KLDzGaAt00kVlK
        NDkfGNV5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYCx+0b5fp
        tmlVf1+u+Vot+Pghyf1lDxJ+WzK/t1RXm3N9bs/a8HOTnJ5af3pjmFojave6ouDWkarv181M
        G2QkPd/+j9jY4K02K+iI7W6RkAJmi2tqHIHm2t7dNya9fuD4Iid9pTkzm4Bwb2WWkuZ/nm0S
        N7xWl3eu1kh5dYJ/+506zq6pWZJKLMUZiYZazEXFiQAGR0t+sgIAAA==
X-CMS-MailID: 20190715124450eucas1p189043d196375aa6adacf898de81bfa9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124450eucas1p189043d196375aa6adacf898de81bfa9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124450eucas1p189043d196375aa6adacf898de81bfa9b
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124450eucas1p189043d196375aa6adacf898de81bfa9b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSYS and FSYS2 buses have similar characteristics and both have max
frequency 240MHz. The old OPP table bus_fsys_apb_opp_table should be used
only to FSYS APB bus because APB max frequency is 200MHz.
The new OPPs for FSYS should increase its performance and related devices.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 941c58bdd809..c7fc4b829b2a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -995,7 +995,7 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_fsys_apb_opp_table>;
+			operating-points-v2 = <&bus_fsys_opp_table>;
 			status = "disabled";
 		};
 
@@ -1003,7 +1003,7 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_fsys2_opp_table>;
+			operating-points-v2 = <&bus_fsys_opp_table>;
 			status = "disabled";
 		};
 
@@ -1157,7 +1157,7 @@
 			};
 		};
 
-		bus_fsys2_opp_table: opp_table5 {
+		bus_fsys_opp_table: opp_table5 {
 			compatible = "operating-points-v2";
 
 			opp00 {
-- 
2.17.1

