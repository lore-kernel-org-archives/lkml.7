Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D7B2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SPwWjrMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfGOMrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49766 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfGOMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124454euoutp0265a5d2d611df6bf56034c9225a932847~xlUreydHQ0714907149euoutp02d
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124454euoutp0265a5d2d611df6bf56034c9225a932847~xlUreydHQ0714907149euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194694;
        bh=H5FVYw5kDy2QEFgac82jkZu5q4Az1Wq5jvWX7kVAaZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPwWjrMVuRp9VVU3ZEBZAPM1ZNR4NRtosEOYfCO6XQbR2kRySUCBDjmltm6De2XRm
         mHpAIz2gCX0VIk0l+3FC+nhFaQbcP87/Tvezg09qIdv+cLF0OFXszAFT4reNzDm3k3
         rR34pSux5+joJgWKzD1ZyeGvh1xqamtZ0QGfzmgg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124453eucas1p29891e3f05d4832717eabbeba61a92b25~xlUqqCckh2241922419eucas1p2o;
        Mon, 15 Jul 2019 12:44:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 64.E1.04377.5457C2D5; Mon, 15
        Jul 2019 13:44:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124452eucas1p294d89255359b2036b19213427f558dbf~xlUp6KIfy2439124391eucas1p2Y;
        Mon, 15 Jul 2019 12:44:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124452eusmtrp1135aca85474ff92cdbb5e8751a410792~xlUpr-WON0488104881eusmtrp1K;
        Mon, 15 Jul 2019 12:44:52 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-ff-5d2c75452282
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.50.04146.4457C2D5; Mon, 15
        Jul 2019 13:44:52 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124451eusmtip2df42500a43de8e60764c8c0afffa08c9~xlUo3QT061115211152eusmtip2P;
        Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
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
Subject: [PATCH v1 23/50] ARM: dts: exynos: change lowest OPP in
 bus_disp1_fimd in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:50 +0200
Message-Id: <20190715124417.4787-24-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzHfX/Pd+vyc2f6rpo4McKR+eOLSm0ebrNZHmZCy6Wfaq4r9+tB
        sTkUaUeGpTxUOGrn6MFJXQ+oOLTuykMlK201GgmrVJs19/M7/Pf6vD/vz8M++zC4vJb0ZuJ1
        yZxep9EqKSlR9WzSsXR9ypLI5Q3DLOq+5yBRRX4ZiTpHP5GoqNkV5vZ/wZHTWU6j1uNDNOo2
        +KLK/g4S/TD2kui17SqF8p0NGLrb3EOjW53tGGp/uR69P1ZKoaz6Zho1DZ0i0VRHBRGqUFsK
        LUD9rSuLVleaT1Pq+6aj6ifDdZj6rNUM1COVs8PpXdKgGE4bn8rpl4XslcaZpp6ApEHykGWg
        CDeALiIHMAxkV0L70+k5QMrI2VIAWw3jQAxGAaxzdmA5QOIKRgBsfE4JLBTcrjcQol4C4OR4
        xL+CwSETELpSrApWmw8KnpmsCcDmyWjBg7PvMFg3UEMKCQUbBfusTUBggp0Pr/QO4ALL2LUw
        t6IYE4f5wTvlj//oEpc+mddGCY0g66Bha+sIEE3r4HfLAzcr4Ge7lRbZF7ZcMBIi89Bw5rrb
        cwT2515ze9bAJns7KSyNs4tgmW2ZKIdBQ+09TLyQJ+z6OkOQcReer7qEi7IMZp+Ui+6F0Gps
        c288C5ZY8tzN1bDszAf3Pc8D+KjNRp4Dfpf/DysGwAy8uBQ+IZbjV+i4NBWvSeBTdLGqfYkJ
        lcD1Ui1T9tFqYPsV3QhYBig9ZKExiyPlpCaVT09oBJDBlTNlwWMuSRajSc/g9IlR+hQtxzcC
        H4ZQeskOT+vbLWdjNcncAY5L4vR/sxgj8TYAH+Jspn/3iwBK5fj5/NfOtx/5Gi5wi0TWE/Kw
        cNU57QbyoyW29OZWj1oVOpb7JmlT0raujT0xO+iMPXMlYQFzi8f6JnbN8Y9MnXfjovaCaaJp
        rOBVsCFteL85bvP19ExZfOKJCOMKi6Phhf/q+jtBz3zCXxfobuYpsp2e2wM3LGCClAQfpwkM
        wPW85jcXYQvJTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oupTqxBvtnyVrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MJf8OMha8YK1Y82Q+cwPjDZYuRk4OCQETiWV7G8BsIYGljBJz7pVA
        xMUkJu3bzg5hC0v8udbF1sXIBVTziVHi9JeLrF2MHBxsAnoSO1YVgtSICKxglJh8whukhlng
        NZPEkaPvWEESwgKxEucW/GQGsVkEVCVm33sCZvMK2Ev0b1zABLFAXmL1hgNgcU6g+M9pF9gg
        DrKTWHz0J9MERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNn27Gfm3cwXtoYfIhR
        gINRiYfXIUU7Vog1say4MvcQowQHs5IIr+1XoBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbn
        A6M6ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo9rCDzdc0jrz
        /xlN6ksRm/z0zJHN62xWX/FU9350KHCN/TuRmzMjdF0V680Ek083H9NVOSf7mvO9wurKKKUv
        Mf9/nOnVSue5Jcr07rL/VonTUsrcHS1OWQ8NzO2ZL+94ru8nwGBbWlCqfOJz3tf+YPvo6+1L
        P7J1/nD48C92819HvYnzFr5Zo8RSnJFoqMVcVJwIAEaGtX2yAgAA
X-CMS-MailID: 20190715124452eucas1p294d89255359b2036b19213427f558dbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124452eucas1p294d89255359b2036b19213427f558dbf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124452eucas1p294d89255359b2036b19213427f558dbf
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124452eucas1p294d89255359b2036b19213427f558dbf@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest OPP must be aligned to possible value after division of parent
clock rate. Thus, change it to the value which is true for clock 1200MHz.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 6e82ffcbeacd..0739e7bd4628 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1294,7 +1294,7 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <120000000>;
+				opp-hz = /bits/ 64 <150000000>;
 			};
 			opp01 {
 				opp-hz = /bits/ 64 <200000000>;
-- 
2.17.1

