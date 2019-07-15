Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE91C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1F20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sa2Juxny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfGOMpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60479 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfGOMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124504euoutp0146f599a0f471cb791228d6a9b9553263~xlU09EK_D1972419724euoutp01c
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124504euoutp0146f599a0f471cb791228d6a9b9553263~xlU09EK_D1972419724euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194704;
        bh=T1XbMxdJSXy/jko0p7zCuk+CitX2KHWmq2EdXnF1nsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sa2JuxnyG8nMajoSqcw2WT85fdm7q7LMHBLfqH0tuy9gALnJvV9mDLet3AXW74bXv
         HaAeFbPiMGf4SMSvE9e4Eol5Q7FHKkn/1IDvq6CYQkSZIozFhdTkHMLUxsww4ckwqB
         VxGTwIP3pOP8kPIJIndXvEahXJdsMQCILG0DtgLY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124503eucas1p259c18fc319d64a67c9908325a912bad0~xlU0MhKGq2241922419eucas1p29;
        Mon, 15 Jul 2019 12:45:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.C0.04325.F457C2D5; Mon, 15
        Jul 2019 13:45:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124502eucas1p1b795c100232b405070f4700e3ca6130b~xlUzYdfxY3056930569eucas1p1k;
        Mon, 15 Jul 2019 12:45:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124502eusmtrp17c00525fb22ba0900dd008f7310cf81f~xlUzKP1t10488104881eusmtrp1_;
        Mon, 15 Jul 2019 12:45:02 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-fe-5d2c754fbd2f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.17.04140.E457C2D5; Mon, 15
        Jul 2019 13:45:02 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124501eusmtip2fe8b09249a1b491b97f07079193e7347~xlUyTW3zf0528005280eusmtip20;
        Mon, 15 Jul 2019 12:45:01 +0000 (GMT)
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
Subject: [PATCH v1 35/50] ARM: dts: exynos: change speed and parent of NoC
 clock in Exynos5420
Date:   Mon, 15 Jul 2019 14:44:02 +0200
Message-Id: <20190715124417.4787-36-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87r+pTqxBqfvylrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MyadiC+5xVLRPv8bewLiWvYuRk0NC
        wETi+4ULLCC2kMAKRonDv126GLmA7C+MEje2PmOGcD4zSuzd+YEFpuNM9z5GiMRyRonj308x
        Q7SDtFxz6GLk4GAT0JPYsaoQJCwisIRR4sjPJJB6ZoGbTBJ7nuxkBUkICyRI/Jh0HayXRUBV
        4v/UzWALeAXsJe7P2MUKsUxeYvWGA2A1nEDxn9MusEHEL7FLNL0UhrBdJLZsewFVLyzx6vgW
        qNdkJE5P7oE6uliioXchI4RdI/G4fy5UjbXE4eMXWUFuZhbQlFi/Sx8i7CixduZzZpCwhACf
        xI23giBhZiBz0rbpUGFeiY42IYhqDYktPReYIGwxieVrpkEN95BYu62bBRJSkxglXv87wTaB
        UX4WwrIFjIyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPU6X/Hv+5g3Pcn6RCjAAej
        Eg+vQ4p2rBBrYllxZe4hRgkOZiURXtuvQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE
        0hNLUrNTUwtSi2CyTBycUg2M607s4+VMtDu1ZNfxXYY/bsRM1dR9G2Ndyv/kFJ/ijoyZIp5q
        vxPSnsowqu1/O/PXL9cjXs+FPixu2pKqfin4m2jUpQnMD1PuMaySvu+dsHtXQeS/HwUTvS9N
        afz/+rBUsCPzhEXJvYZOch8lbLcvaeR9GtWrf+308u33zi5hsk8WcgjlOWC2TImlOCPRUIu5
        qDgRAPS7YHxNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7p+pTqxBrumqVrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MyadiC+5xVLRPv8bewLiWvYuRk0NCwETiTPc+RhBbSGApo8TRdxYQ
        cTGJSfu2Q9UIS/y51sXWxcgFVPOJUaL77VmWLkYODjYBPYkdqwpBakQEVjBKTD7hDVLDLPCa
        SeLI0XesIAlhgTiJqQdOMYHYLAKqEv+nbmYBsXkF7CXuz9jFCrFAXmL1hgPMIDYnUPzntAts
        EAfZSSw++pNpAiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFxs+3Yzy07GLveBR9i
        FOBgVOLhdUjRjhViTSwrrsw9xCjBwawkwmv7FSjEm5JYWZValB9fVJqTWnyI0RToqInMUqLJ
        +cCYziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwJj8uevtqdXP
        t1TW7g6buXvx+bm/3GQcnxy878epvLPUo9ec/dE/rpssjU5qyVyLAuayP5RYvfmNobFat8Ll
        VzyX3TeesvRQefTUUeYmy7owz7lPVoeXcf2228V//d7+g4Jflm9mvKkZ8uzUeY5tOTE/tZju
        qhtt+cBVzquRH6XB0v9wk2gdv7wSS3FGoqEWc1FxIgCMVJuvsQIAAA==
X-CMS-MailID: 20190715124502eucas1p1b795c100232b405070f4700e3ca6130b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124502eucas1p1b795c100232b405070f4700e3ca6130b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124502eucas1p1b795c100232b405070f4700e3ca6130b
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124502eucas1p1b795c100232b405070f4700e3ca6130b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes speed and parent of NoC WCORE bus to 400MHz. The clock
is now attached to a branch were the root is the DPLL which speed is set to
1200MHz. The OPPs are aligned to this rate accordingly.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de15c9b..aaf18653d8ac 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -46,6 +46,13 @@
 			<&nocp_mem1_0>, <&nocp_mem1_1>;
 	vdd-supply = <&buck3_reg>;
 	exynos,saturation-ratio = <100>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK400_WCORE>,
+			  <&clock CLK_MOUT_SW_ACLK400_WCORE>,
+			  <&clock CLK_DOUT_ACLK400_WCORE>,
+			  <&clock CLK_FOUT_DPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>,
+				 <&clock CLK_DOUT_ACLK400_WCORE>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <1200000000>;
 	status = "okay";
 };
 
-- 
2.17.1

