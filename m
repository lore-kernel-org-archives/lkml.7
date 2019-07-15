Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB76C76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391DC2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AUSnw1qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfGOMp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50041 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbfGOMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124510euoutp02730cf27c547f26d87aa477862b7e4ec3~xlU6lgnjw0722707227euoutp02q
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124510euoutp02730cf27c547f26d87aa477862b7e4ec3~xlU6lgnjw0722707227euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194710;
        bh=dWEd0/DZ+13JAJ+RMOvQKrkdBKE1toKGyUC8I38ocEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUSnw1qQ14scOap3lTRxUblLX66EO/kcGoEUxwTCSM0Y+XddSa+SN3r86OwQVjWoP
         NaMDpChSV/phurZsRHh7icWaM7PnlK2kN91FZu3SrM1dzKvuR4nlhjCGfbIp1nMfGN
         2+3npX1Fr3jkLnY2XUaTGo977rv20iMTVJe3rVkQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124509eucas1p2ab93d8b09ab3547efb0799d596495831~xlU5zNXw93211132111eucas1p2j;
        Mon, 15 Jul 2019 12:45:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 63.F1.04377.5557C2D5; Mon, 15
        Jul 2019 13:45:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124508eucas1p2f2e09e296dd4ad97a52a2023ede8ae98~xlU462H3e1859018590eucas1p2S;
        Mon, 15 Jul 2019 12:45:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124508eusmtrp146c0c5bb31a6a5b68d6f832e0206ba56~xlU4swOzv0488104881eusmtrp1k;
        Mon, 15 Jul 2019 12:45:08 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-34-5d2c75551239
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.27.04140.4557C2D5; Mon, 15
        Jul 2019 13:45:08 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124507eusmtip2931182578dc8771e17aa1a6eee51acd3~xlU39DPDc1172811728eusmtip2p;
        Mon, 15 Jul 2019 12:45:07 +0000 (GMT)
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
Subject: [PATCH v1 42/50] ARM: dts: exynos: change parent and rate of
 bus_mscl in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:09 +0200
Message-Id: <20190715124417.4787-43-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7qhpTqxBtseKVrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6M3/tnMBXs5a7YffgmewPjKc4uRg4O
        CQETiSePDboYuTiEBFYwSuyYepYRwvnCKNHefpEFwvnMKPF27h9WmI453yq6GDmB4ssZJWYd
        jIdrmPTyMRNIDZuAnsSOVYUgNSICSxgljvxMAqlhFrjJJLHnyU5WkISwQJzEktbZ7CA2i4Cq
        xPkde8Hm8wrYS8z7mwUSlhCQl1i94QAziM0JFP457QIbyBwJgXPsEt/n9TNDFLlIdK2+xA5h
        C0u8Or4FypaROD25hwXCLpZo6F3ICGHXSDzunwtVYy1x+PhFsL3MApoS63fpQ7zoKLFuhjeE
        ySdx460gSDEzkDlp23RmiDCvREebEMQMDYktPReYIGwxieVrpkHN9pC49aeFFRI4kxgl7rxd
        xDSBUX4Wwq4FjIyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPU6X/Hv+xg3PUn6RCj
        AAejEg+vQ4p2rBBrYllxZe4hRgkOZiURXtuvQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwP
        ooUE0hNLUrNTUwtSi2CyTBycUg2Mwool93umdDQsN6w7tubH2f+fGX+0yWnM2jon9GTlL+vF
        037GFXRLs5wqjEz6v+3BsWjB42J8eapbzdmEA89yeH1nP7ZXS7eA1aX9efdkla55he/ym7Ks
        Am4c8r7oM+fe208cO0Sdt7Ae3PTycHlJL+/DtoVvOGteC1UsjpN6d0/zxaRY89NSSizFGYmG
        WsxFxYkA4jj4T0wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7ohpTqxBgunqVvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M3/tnMBXs5a7YffgmewPjKc4uRg4OCQETiTnfKroYuTiEBJYySix7
        voGpi5ETKC4mMWnfdnYIW1jiz7UuNhBbSOATo8SraeIgvWwCehI7VhWChEUEVjBKTD7hDTKH
        WeA1k8SRo+9YQWqEBWIkpu1TAqlhEVCVOL9jL1iYV8BeYt7fLIjp8hKrNxxgBrE5gcI/p12A
        2mQnsfjoT6YJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbMtmM/t+xg7HoXfIhR
        gINRiYfXIUU7Vog1say4MvcQowQHs5IIr+1XoBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbn
        A+M5ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD48SE2oz5c35X
        7f55k9fiIMuTcq7wkv8uJl1POPTM14Xva23M1gkKnLlBsN7kh/gR66QM+caZSw5ZzrhqwHVH
        MLX1kGMya5WlsO3G5dNyQ10VhEUFZtrwJ8z/6Wol9sMoRSxzf8wNz4UC3ov/+G/hylj0lEP5
        Q/aEr2EnHuxYkuoza+UVRTdDJZbijERDLeai4kQAV54j+68CAAA=
X-CMS-MailID: 20190715124508eucas1p2f2e09e296dd4ad97a52a2023ede8ae98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124508eucas1p2f2e09e296dd4ad97a52a2023ede8ae98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124508eucas1p2f2e09e296dd4ad97a52a2023ede8ae98
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124508eucas1p2f2e09e296dd4ad97a52a2023ede8ae98@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_mscl OPP table has been aligned to the new parent rate. This patch
sets the proper parents in the clock tree and picks the init frequency
before the devfreq governor starts working. It sets also parent rate (MPLL
to 600MHz).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 198e33cf115f..990fe03fce75 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -103,7 +103,8 @@
 &bus_gen {
 	devfreq = <&bus_wcore>;
 	assigned-clocks = <&clock CLK_MOUT_ACLK266>,
-			  <&clock CLK_DOUT_ACLK266>, <&clock CLK_FOUT_MPLL>;
+			  <&clock CLK_DOUT_ACLK266>,
+			  <&clock CLK_FOUT_MPLL>;
 	assigned-clock-parents = <&clock CLK_MOUT_SCLK_MPLL>;
 	assigned-clock-rates = <0>, <300000000>,<600000000>;
 	status = "okay";
@@ -155,6 +156,13 @@
 
 &bus_mscl {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK400_MSCL>,
+			  <&clock CLK_MOUT_SW_ACLK400_MSCL>,
+			  <&clock CLK_DOUT_ACLK400_MSCL>,
+			  <&clock CLK_FOUT_DPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>,
+				 <&clock CLK_DOUT_ACLK400_MSCL>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <1200000000>;
 	status = "okay";
 };
 
-- 
2.17.1

