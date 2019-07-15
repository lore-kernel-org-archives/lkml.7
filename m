Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B150C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8272067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r1tZk9ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfGOMrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60280 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfGOMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124453euoutp01acdf8bdd7d992967c3d200ffd8bec3dc~xlUqu_fuu1972419724euoutp01K
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124453euoutp01acdf8bdd7d992967c3d200ffd8bec3dc~xlUqu_fuu1972419724euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194693;
        bh=rqowIlY4bCNTcr2vXgEl4mHT3UFlQgX6gEZbWnELGdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1tZk9ZKn/kXXzen6C/uTZESRuFix9RQF6XQwHAHJs1qOaRbMZ3FGSGl2mLg4m+Ar
         neqVTfjeIiBvsx5Z8MR5jo5O8kXLLKxAO0EY2T8X+w/eIMLIujUKNJp8Pndx+84BYg
         oVTDmyo78iYohN2Ci2RPVcDE2yJe2r3MjI4/zDEk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124452eucas1p1a90509ba46fb236b751c98063ff13a02~xlUp8XAo53056930569eucas1p1b;
        Mon, 15 Jul 2019 12:44:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.B0.04325.4457C2D5; Mon, 15
        Jul 2019 13:44:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124451eucas1p28ac87fa7bd7e602ffab69a6915f37536~xlUpKVgf92241522415eucas1p2e;
        Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124451eusmtrp1d171d79d6bd8d771eb127a526773c3c9~xlUo8Nl100488104881eusmtrp1H;
        Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-d8-5d2c7544299a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.40.04146.3457C2D5; Mon, 15
        Jul 2019 13:44:51 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124450eusmtip257833d6fe86e20ec790233383714f745~xlUoFFUzM1176011760eusmtip23;
        Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
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
Subject: [PATCH v1 22/50] ARM: dts: exynos: OPPs for bus_disp1 in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:49 +0200
Message-Id: <20190715124417.4787-23-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87oupTqxBp+nKlncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6Mh2dnMRccZq/o2X2BrYHxDWsXIyeH
        hICJxNP1N5i7GLk4hARWMEo0T+pkhXC+MEpsbH3LDuF8ZpTY0/iQCabl4sF9bBCJ5YwSMx50
        ILRMP/kcyOHgYBPQk9ixqhCkQURgCaPEkZ9JIDXMAjeZJPY82Qm2XFjAR2LhnZdgNouAqsS7
        g8tYQGxeAXuJTdf/skNsk5dYveEAM4jNCRT/Oe0C2GYJgXPsElPWH4c6yUVi1c4PUA3CEq+O
        b4GyZSROT+5hgbCLJRp6FzJC2DUSj/vnQtVYSxw+fhHsaGYBTYn1u/RBTAkBR4nmLxYQJp/E
        jbeCIMXMQOakbdOZIcK8Eh1tQhAzNCS29FyAukVMYvmaaVCzPSSuTmuDhs4kRon+B8fZJjDK
        z0LYtYCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgojr97/jXHYz7/iQdYhTgYFTi
        4XVI0Y4VYk0sK67MPcQowcGsJMJr+xUoxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6
        YklqdmpqQWoRTJaJg1OqgdFua+7PlrUfpnz9qxSSKmw4/01X4+8ue91DTYoL5VteLJxTef4K
        W+PiUKmHd/fLnMzwizjcLvZe+xxffVHYVc2pjnWfo6zDVLR1tcL28fCHXox9uSr139zsxWnx
        YqoKH6/ob9+cV1S+7tCtD8+/zYncLP6rLrxZ9oz5jlcTX35Y2p/6PPXuxHolluKMREMt5qLi
        RAC52S0tUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7rOpTqxBit2q1ncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mh2dnMRccZq/o2X2BrYHxDWsXIyeHhICJxMWD+9hAbCGBpYwSu44K
        QcTFJCbt284OYQtL/LnWBVTDBVTziVHiy4r5LF2MHBxsAnoSO1YVgtSICKxglJh8whukhlng
        NZPEkaPvwBYIC/hILLzzEsxmEVCVeHdwGQuIzStgL7Hp+l+oBfISqzccYAaxOYHiP6ddgDrI
        TmLx0Z9MExj5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMnG3Hfm7ewXhpY/AhRgEO
        RiUeXocU7Vgh1sSy4srcQ4wSHMxKIry2X4FCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+M
        6rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwmEx7obg5J6ueK
        W/920z1F0bM/rh9velmm7ph88Pn9WMFT5/hXf2R9tO34jU8vn7928F33eZ+IHyvv4ob93Nrs
        tzIq9px5IJfuz3iy4Gn76lPz2hZvfNKRe38Dw8M/Nx423CkylHkWOjPJ19NH50eMv/SkwPhT
        CWe5d+zJXetvKWPIaijpbiysxFKckWioxVxUnAgAKPVXarICAAA=
X-CMS-MailID: 20190715124451eucas1p28ac87fa7bd7e602ffab69a6915f37536
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124451eucas1p28ac87fa7bd7e602ffab69a6915f37536
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124451eucas1p28ac87fa7bd7e602ffab69a6915f37536
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124451eucas1p28ac87fa7bd7e602ffab69a6915f37536@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bus_disp1 OPPs and add 400MHz which is max frequency for this
bus. The frequencies are aligned to parent clock such that it is not
needed to change the PLL rate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2b36c2f77a10..6e82ffcbeacd 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1305,7 +1305,7 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <120000000>;
+				opp-hz = /bits/ 64 <150000000>;
 			};
 			opp01 {
 				opp-hz = /bits/ 64 <200000000>;
@@ -1313,6 +1313,9 @@
 			opp02 {
 				opp-hz = /bits/ 64 <300000000>;
 			};
+			opp03 {
+				opp-hz = /bits/ 64 <400000000>;
+			};
 		};
 
 		bus_gscl_opp_table: opp_table15 {
-- 
2.17.1

