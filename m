Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288D7C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01354206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WPx6vc0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfGOMrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49739 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfGOMo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124457euoutp022430d347132c9b04ebd09e474f8d42ec~xlUuAxd7n0726607266euoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124457euoutp022430d347132c9b04ebd09e474f8d42ec~xlUuAxd7n0726607266euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194697;
        bh=/C328aMoysmIEZp3GSYS/KL1xKnPBUTWWcs4F5gZr3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPx6vc0q86WBh4eSj6CMDV1YtKYfvdoRmKr6s/SoUAvjBC1EyW1WHKTp5CjOIjK8Z
         x4pz1XRKxLIO9npJSAoNddRxt1nKxj2kgak91PAjI9nCG8atqL9cLsAF/Lr5kRzV+W
         Io51NQyOlKnPNTWS+Ur9lJBL7ppH3LUx6+DvdWlg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124456eucas1p1629fb92014516835d143045d13d69f84~xlUtMfga_0572305723eucas1p1-;
        Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.B0.04325.7457C2D5; Mon, 15
        Jul 2019 13:44:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c~xlUsY7r3E0570905709eucas1p1P;
        Mon, 15 Jul 2019 12:44:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124455eusmtrp10d90a2658c47e650e948f19c493a8aca~xlUsKq1g50488104881eusmtrp1U;
        Mon, 15 Jul 2019 12:44:55 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-df-5d2c75472596
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.07.04140.7457C2D5; Mon, 15
        Jul 2019 13:44:55 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124454eusmtip26c0d46180abe09d177c99a2677f4c51f~xlUrSOolx1115311153eusmtip2b;
        Mon, 15 Jul 2019 12:44:54 +0000 (GMT)
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
Subject: [PATCH v1 26/50] ARM: dts: exynos: align NOC100 bus OPPs in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:53 +0200
Message-Id: <20190715124417.4787-27-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfyyUcRzH+95zzw+3rh7H8g1LO2r9pOZq34liaT21ZbVqtprq8Az52T2I
        ajma8yOhGK0hLb92rnAkTCYuWpYfMcRS7dqMFIVdEnXnOeu/1+f9eX9+ffelMEkTbkuFRESz
        igh5mJQQCes7Frp3MzG7/PbMOKKRp904qrlfhaOhuXEcPdQZwyz9Vwz19FST6G3SFIlGlPZI
        qx/E0Y+MMRz1NxUQ6H5PiwA90X0gUelQnwD1vTmCRhMrCJT8Qkei9qkUHC0P1gg9rRhNkQYw
        08PJJKNVpxFMbUkC8/J7s4DJrFMDZla76SR5TuQeyIaFxLIKl4OXRMG/O9OIqDIibqBegynB
        jDAdWFCQlsHRynLMxBK6AsCBAgee5wC83eLN8yyAj0tdV/2ZxYuCdCAy6uUA6rtqhHxgLCg0
        FBPpgKII2hk2qK+YCqzpEgB1C/4mD0a/F8DmL424KWFFn4KGn9MrLKS3QH1K1cpGYvoQ1C1O
        YPw0B1hZ3brCFkZ9Ia+XMDWC9DsSlvVrzCd4w9qcz+YCKzjZWUfybA+7cjLMHg4q7zwCPN+A
        +qxCs+cAbO/sw01LY/R2WNXkwste0NC+RJpkSK+Dw98sTTJmxHv1+Rgvi2GqSsK7t8G6jF4B
        zxtguSbP3JyBpTl3Sf557gGYn5dMZgOHB/+HFQOgBjZsDBcexHKuEexVZ04ezsVEBDkHRIZr
        gfFHdS13zjeAlj/+bYCmgHSt2DNwp58El8dy8eFtAFKY1FrsMW+UxIHy+GusIvKiIiaM5dqA
        HSWU2oivr/l0XkIHyaPZUJaNYhWrWQFlYasEr2T+H2+e8Ny4pOuIdHSqSJK6H1soKCSdzsam
        FSXUqdxcQgJd87NjfTRhPuO5o+sTnV4H+zY2c0XPjhtkNU6WPtb7FXYqrnZrrltO6r6/w6T3
        aZVy86/Lh1UB1R6tA5P2mT2MqOVWiixu3Ct01v3M8cQMcNQCZmsnno+pZYYLvlIhFyzfuwNT
        cPJ/6tJiH00DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7rupTqxBtevs1jcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MX8c72QqWsVVc2baGuYHxA0sXIyeHhICJRN+C30xdjFwcQgJLGSWe
        H9gHlRCTmLRvOzuELSzx51oXG0TRJ0aJTWs/MXcxcnCwCehJ7FhVCFIjIrCCUWLyCW+QGmaB
        10wSR46+YwVJCAv4Syw4DbKBk4NFQFXicft6sAW8AvYSR36/ZIZYIC+xesMBMJsTKP5z2gU2
        EFtIwE5i8dGfTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJ1tx35u2cHY9S74
        EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYS
        Tc4HxnVeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGh6Mui0N5
        WX4cUKnybm94KmCac4y97xDvrKLjCz0U/5c/r2R3W1b5zdA5cM83llyzNWcKeSvstK868VfZ
        /O2cXHPPevnPq3snCqQ93RZ2Yl22pdJ7hcevdu46cfmSzKNluXGG7J0zXprrP3rGs85v46PV
        GR2TvldfmFL+9MubewnBcgekW6WOK7EUZyQaajEXFScCAJryo9uzAgAA
X-CMS-MailID: 20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NOC100 has a parent which clock rate is set tot 400MHz. The OPPs which
are not possible to set are removed and new one is added.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 1097fa758d9e..f8c36ff0d4c3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1135,12 +1135,9 @@
 				opp-hz = /bits/ 64 <67000000>;
 			};
 			opp01 {
-				opp-hz = /bits/ 64 <75000000>;
+				opp-hz = /bits/ 64 <80000000>;
 			};
 			opp02 {
-				opp-hz = /bits/ 64 <86000000>;
-			};
-			opp03 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
 		};
-- 
2.17.1

