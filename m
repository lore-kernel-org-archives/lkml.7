Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EBC76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0166A206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gnOQge25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfGOMpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50020 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbfGOMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124514euoutp02dc4bcc609f662bf11f1a27f27ff616cb~xlU_ae_Ea0714907149euoutp02B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124514euoutp02dc4bcc609f662bf11f1a27f27ff616cb~xlU_ae_Ea0714907149euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194714;
        bh=FjmbfDssqB1Pt5EstrFD/CLWu/qb+x06QxtPLMK5QfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnOQge25LU+Z1PAUZeg842LC9nix6uzLNf2JC7uU5E2u8GVYtM/+kOUeLYgEnP+7H
         JNBa7/L+6lySE7J0lYLj7pg/RXhrbzUy2CLBafWgfNxX2ThuMkRGobsFFc7FnvfjYL
         Y7RvSaBLyERzh25bVHmzOdG/bXPs+vGRn1gDcgBQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124514eucas1p1ab4218808c3a1c386d88f954ceef1bed~xlU9qyvx50147201472eucas1p1l;
        Mon, 15 Jul 2019 12:45:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 70.45.04298.9557C2D5; Mon, 15
        Jul 2019 13:45:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124513eucas1p2c30a951141622994d350df5e61fdaed4~xlU84p03j3211032110eucas1p2Z;
        Mon, 15 Jul 2019 12:45:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190715124512eusmtrp254a37a7793c98d1b0bfd479a3396b732~xlU8qY3Uf2735227352eusmtrp2J;
        Mon, 15 Jul 2019 12:45:12 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-0b-5d2c75597d1e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.60.04146.8557C2D5; Mon, 15
        Jul 2019 13:45:12 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124512eusmtip262d35c752c7d48281902dc0616b3d84c~xlU71xqNH1099510995eusmtip25;
        Mon, 15 Jul 2019 12:45:12 +0000 (GMT)
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
Subject: [PATCH v1 47/50] ARM: dts: exynos: change rate of bus_gscl_scaler
 in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:14 +0200
Message-Id: <20190715124417.4787-48-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7qRpTqxBkcbNCxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGz/etbAXNbBXv7v9gb2CcxNrFyMkh
        IWAi8fTIWrYuRi4OIYEVjBKNN/8xQzhfGCWu7jzFCuF8ZpR42f2LCaZlRtNxJojEckaJ5vd3
        WeFavm5cx97FyMHBJqAnsWNVIUiDiMASRokjP5NAapgFbjJJ7HmyE2y5sECUxNO709hBbBYB
        VYmFF2eAxXkF7CXWzl3KCLFNXmL1hgPMIDYnUPzntAtgx0oIXGKX2D5nJjtEkYvEiubPUA3C
        Eq+Ob4GKy0j83zkf6uxiiYbehVA1NRKP++dC1VhLHD5+kRXkaGYBTYn1u/Qhwo4Sny7sYgIJ
        SwjwSdx4KwgSZgYyJ22bzgwR5pXoaBOCqNaQ2NJzAWqRmMTyNdOghntI9Py8Bg3RSYwSz/7t
        YZnAKD8LYdkCRsZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYganq9L/jn3Ywfr2UdIhR
        gINRiYfXIUU7Vog1say4MvcQowQHs5IIr+1XoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH
        0UIC6YklqdmpqQWpRTBZJg5OqQbG7vgNKivPXWm622PW4fxLYLfogTPXH5ydHLbxlbu9L9fF
        D0kpUks+nI9+Zz2lpmz2ywczChj0nbbei7mXbiu1Qa3h6/3s0ibnE/wK62V3vRM+NsPyoXaW
        3rtZQgZl//k8kk79mKx5nFHlut3CPy9/L2X/e3vP10/pyRO+7a59f/ZE0JwlRtmu9kosxRmJ
        hlrMRcWJALx7g0lRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oRpTqxBk9fGFvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mn+9b2Qqa2Sre3f/B3sA4ibWLkZNDQsBEYkbTcaYuRi4OIYGljBI/
        1i9hhkiISUzat50dwhaW+HOtiw3EFhL4xCjx8nN2FyMHB5uAnsSOVYUgYRGBFYwSk094g8xh
        FnjNJHHk6DuwBcICERJLZs9kBLFZBFQlFl6cARbnFbCXWDt3KSPEfHmJ1RsOgO3lBIr/nHYB
        apedxOKjP5kmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERg524793LyD8dLG4EOM
        AhyMSjy8DinasUKsiWXFlbmHGCU4mJVEeG2/AoV4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5
        HxjVeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGHs3n5tnVneO
        QfL5utWbbY5UGfx2COUJ/LBrz5SSq/qLnmz/4jA3LyLcxujpzbTfwaI3gnseXykpNE0/fqsx
        dFLKvuWv+A1nn+O+u0CuuOfp/g36axOWndkYv3t+fp6h7a38f/Ovdqpe9BBmiFkqETPXip+5
        R/6ulll6irjmjOOtf962Pz+QnKzEUpyRaKjFXFScCAAIgydtsgIAAA==
X-CMS-MailID: 20190715124513eucas1p2c30a951141622994d350df5e61fdaed4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124513eucas1p2c30a951141622994d350df5e61fdaed4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124513eucas1p2c30a951141622994d350df5e61fdaed4
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124513eucas1p2c30a951141622994d350df5e61fdaed4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_gscl_scaler OPP table has been aligned to the new parent rate. This
patch sets the proper frequency before the devfreq governor starts working.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index fac5659516ad..d278339f259c 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -158,6 +158,8 @@
 
 &bus_gscl_scaler {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
+	assigned-clock-rates = <300000000>;
 	status = "okay";
 };
 
-- 
2.17.1

