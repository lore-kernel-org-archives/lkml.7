Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E17FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F798206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sRJh8JNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfGOMqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60313 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfGOMo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124457euoutp01369fb93b0fe0b247662729a69cc04972~xlUumsYi61972419724euoutp01S
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124457euoutp01369fb93b0fe0b247662729a69cc04972~xlUumsYi61972419724euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194697;
        bh=kj3mAoTibXuXqP7RtEEJ98wUQnanVJPJVicA1HV43MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRJh8JNwlPL5lAlWJFWpH18BE095zmkxQ8nEKS4EIrRCS4qrxc/6f8i6A6w38xd9F
         LjwADpkdOzGrvKGHQnHBsybkQVs7Lm0avrpHHGbQkP87ClZoZRgI665mz7JA7VpuaB
         Pgfyy3SUMEREy80G75Qg8Aj7MOy+DunQ0jGqZ514=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124456eucas1p1f99829193ba832bd2e59a205828f76a6~xlUtw49YN0154001540eucas1p1M;
        Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.B0.04325.8457C2D5; Mon, 15
        Jul 2019 13:44:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f~xlUs7DUvv0800208002eucas1p2n;
        Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124456eusmtrp17476f77b4fab1799e2326d2805ff5c7f~xlUs6cWlj0488104881eusmtrp1b;
        Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-e5-5d2c7548549e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.07.04140.7457C2D5; Mon, 15
        Jul 2019 13:44:55 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124455eusmtip254a7da76ff3fdd558aa332875e37ed99~xlUsEoy4D1115211152eusmtip2R;
        Mon, 15 Jul 2019 12:44:55 +0000 (GMT)
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
Subject: [PATCH v1 27/50] ARM: dts: exynos: align bus_wcore OPPs in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:54 +0200
Message-Id: <20190715124417.4787-28-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG/c7Z2Y6jyWlqfpokLKSyUruAn2SmkHAgMv+SqKRmHlSatx21
        LPESeGWpqJmEl0TFNc17tkxFpzlSy1upTdRKQTErzOtIRptn1n+/93ney8PHR+LiTsKBDI+M
        ZeSRUpmEL+S19euHT9JxJ4Lcd74eQbr6DwRqKm4g0OT6IoHK+4xl7vx3HA0PNwrQ+4crAqRL
        cUTN8xMEWlXMEmi8vYSPioe7MPSib0aAqidHMTQ64IemU5V8lNbZJ0C9KxkEMkw08Xys6bqy
        OkD/mkoT0M2qLD7dUpVM9/zswOicVhWg15oPBQiuCb1CGFl4PCN3874lDFO8GeFHD4jvLW8v
        Eylg0CobWJKQOgs3Mof42UBIiiklgFv1CxhXrAOom3xpdtYAXMxd5e2NpGaNAc6oAbDyUzr+
        b0RbMERkA5LkU65QrYoxDdhQVQD26YNNPTj1GYMdC68Jk2FNBcDpV5O7W3mUM0zdLsZMLKIu
        wDbtEs5dc4K1jd27bGnU9UUjfE4fE8BpfTLHF+Hit1GMY2u4rG0VcOwIBwsU5tQsTHlUAThO
        hPO5peaec7BXO7qbGaeOwYZ2N072hQ3KLcwkQ8oKTv3Yb5JxI+a3PcE5WQQz08Vc91HYqhgx
        BzgAa+qKzMtp2DNkYtPr5ANYu5jKywNOT/8fewaACtgxcWxEKMOeiWTuurLSCDYuMtT1dlRE
        MzB+qkGDdkMNunaCNYAigWSfyCfkeJCYkMazCREaAElcYiM6v2GURCHShPuMPOqmPE7GsBpw
        kORJ7EQPLL5cF1Oh0ljmDsNEM/I9FyMtHVKAuuZSpZ1/4O+lzY8GT7lt4BWlvjDLR53kZ1Wx
        fNpipgREF246OMn++GoM692aVfus/rDwRKvnK8nqrQL/6saw9DqN+qpLWnjeu1LblsvuBpc5
        b1JZWqM6XO4LdVeSemct7WzHkzLmFO0esjHnfr8yjxv2zl5vY1oKtY9zSJ2nhMeGSU+54HJW
        +hcp3mxHUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7rupTqxBit/mlncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mnt0X2ApOCVW8+vGKtYHxNF8XIyeHhICJRGPnJcYuRi4OIYGljBKn
        Wj6wQCTEJCbt284OYQtL/LnWxQZR9IlRoufsa6YuRg4ONgE9iR2rCkFqRARWMEpMPuENUsMs
        8JpJ4sjRd6wgNcICfhKfV1aB1LAIqEo0/pjBBGLzCthLbDv+ghlivrzE6g0HwGxOoPjPaRfY
        QGwhATuJxUd/Mk1g5FvAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMHK2Hfu5ZQdj17vg
        Q4wCHIxKPLwOKdqxQqyJZcWVuYcYJTiYlUR4bb8ChXhTEiurUovy44tKc1KLDzGaAh01kVlK
        NDkfGNV5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYdygzR/cd
        qKqabrBWItnguOA7TTnWfQ/+JhgIvN4ws3DCkdv39ol8+3P12O2HJ4NtY+RqBfkTeGZ/3+77
        13E5x+NffZ8PhSzKCTrmILF7hmHd3CmmDtHFXwUlbmU6TLhlHGt38TfbysTksydSdEvfu63U
        EGfY/k9ms8G9mQsOKn1dozb54ZNN05RYijMSDbWYi4oTAePgB9OyAgAA
X-CMS-MailID: 20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the most important bus in the Exynos5x SoC. The whole communication
inside SoC does through that bus (apart from direct requests from CCI to
DRAM controller). It is also modeled as a master bus in devfreq framework.
It is also the only one OPP table throughout other buses which has voltage
values. The devfreq software controls the speed of that bus and other
buses. The other buses follows the rate of the master. There is only one
regulator. The old lowest OPP had pair 925mV, 84MHz which is enough for
this frequency. However, due to the fact that the other buses follows the
WCORE bus by taking the OPP from their table with the same id, e.g. opp02,
the children frequency should be stable with the set voltage.
It could cause random faults very hard to debug.
Thus, the patch removes the lowest OPP to make other buses' lowest OPPs
working. The new lowest OPP has voltage high enough for buses working up
to 333MHz. It also changes the frequencies of the OPPs to align them to
PLL value such that it is possible to set them using only a divider without
reprogramming OPP. Reprogramming the PLL was not set, so the real frequency
values were not the one from the OPP table, which could confuse the
governor algorithms which relay on OPP speed values making the system to
behave weird.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f8c36ff0d4c3..a355c76af5a5 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1107,22 +1107,18 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <84000000>;
-				opp-microvolt = <925000>;
+				opp-hz = /bits/ 64 <150000000>;
+				opp-microvolt = <950000>;
 			};
 			opp01 {
-				opp-hz = /bits/ 64 <111000000>;
+				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <950000>;
 			};
 			opp02 {
-				opp-hz = /bits/ 64 <222000000>;
+				opp-hz = /bits/ 64 <300000000>;
 				opp-microvolt = <950000>;
 			};
 			opp03 {
-				opp-hz = /bits/ 64 <333000000>;
-				opp-microvolt = <950000>;
-			};
-			opp04 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <987500>;
 			};
-- 
2.17.1

