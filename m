Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F6DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289832067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H6Koa0Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfGOMpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50030 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbfGOMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124511euoutp02f6c427df68ab3f35ef77eaadec4056b2~xlU7gckNZ0715707157euoutp022
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124511euoutp02f6c427df68ab3f35ef77eaadec4056b2~xlU7gckNZ0715707157euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194711;
        bh=JNlU+ZmxnzoctgxAgCVPM/SH+VMb8GGroKMeCa1CTrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6Koa0Aqf/0ypQOLwVQpUk7/HEj37HLQfBhno3YAtxXlf9mISJZe7rA/C1/w3iFpd
         hyyK7vYgLrkJLDaoGyi2+Btl+atFwPEcohzr2Nd0Px5WXcOhK2JGily6Ro/uoahzUm
         0T/YggpgvT+RewGOH9H7wyZFz+/YUdURnxSKDVYA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124510eucas1p2e1c21a165239ac044c2f9d89ed708ddf~xlU6oH_2f2242322423eucas1p2s;
        Mon, 15 Jul 2019 12:45:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1F.C0.04325.6557C2D5; Mon, 15
        Jul 2019 13:45:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124509eucas1p1f2e44af951158fbef1a245467956ef93~xlU5uAkea0154701547eucas1p1j;
        Mon, 15 Jul 2019 12:45:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124509eusmtrp1769b02b2087539853d553f6ca8e60e5b~xlU5f0Efw0524305243eusmtrp1E;
        Mon, 15 Jul 2019 12:45:09 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-15-5d2c75561d7d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.27.04140.5557C2D5; Mon, 15
        Jul 2019 13:45:09 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124508eusmtip2cf2dc22aa7f72b1418ad8ca53e849f1f~xlU4t1x3h1173411734eusmtip20;
        Mon, 15 Jul 2019 12:45:08 +0000 (GMT)
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
Subject: [PATCH v1 43/50] ARM: dts: exynos: add bus_isp in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:10 +0200
Message-Id: <20190715124417.4787-44-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzHfe+558fF2eNCX2lubmyECv3xnd+2Ws8YozazYrlzj6u5u3RP
        RdFcmX7cImJJ86Om1rnuqjslrljO0QhXIakVlmklTpM/wuKePRf/vT7v9/vzY999KUx2Dw+m
        kvVprEGv1CqIAPHtx5OeVXvSV+6PGChYgPrqXuDIXlaPozcTwzi67vaVxUOfMeTxNJDoee4Y
        ifqMIcgx1IOj8aJBHL10XiFQmee+CNncAySqftMlQl1Po1F/jplAp++5SfRwLB9HUz128ZZA
        xnrNChhv72mScVgKCeZW1UnmwddWEXO20QKY745Fu8j4gA1qVpucwRrCNx0ISBp5NCw6Mig5
        Nuj8hhnBRcoEJBSkI6H39ZiYZxltBvD64ygTCPDxBICOAismFN8BtFnN5HTH15ZRv1EDYH7L
        O/JfS163Q2QCFEXQYfCOJZVvmEtXAeieVPEZjH4rgq0f7+K8EUhHw495xQTPYnopbCseAzxL
        6c3w2ZVaIGyTw9qGNoxniU+fLO0k+EGQ7iZhk/MUJoSi4E/HKVzgQDja3ug/NQR2XCgSC8xB
        45lK/9ATcKj4qj+zHj5s78L5ozF6Oax3hgvyVvih+hPBy5CeDXu/zOFlzIclty9hgiyFBXky
        Ib0MNhZ1igSeD2uspf7hDPx0s0IsPE8JgOU/H+DngLz8/7IKACwgiE3ndBqWW6tnj4ZxSh2X
        rteEHUzROYDvU3VMtf+4A+7/VrkATQHFLOkW9Yr9MlyZwWXqXABSmGKudOMPnyRVKzOzWENK
        oiFdy3IusJASK4Kkx2e8T5DRGmUae5hlj7CGaVdESYKNYJtEpaq7nNxAJ2SVGU3hwbonnYUh
        N+SeJTEtx93jOXE2r2odIc8ODlq8ZnPjrmptLM7aC3ebByLjYyvVfXGSX6P2vUzFzJRmQ2pr
        jQ6y/ezVP6Y/TVp24aNDr+ZFNBG27dU7vHRMYnNnxj5dszN7xHUoKDc0uX6npk17PsqoEHNJ
        ytWhmIFT/gVQBGnnUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7qhpTqxBpf/SFvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Ml0efMxXc46y4t+sDcwPjFI4uRk4OCQETiXe7XzF3MXJxCAksZZRY
        /e4/C0RCTGLSvu3sELawxJ9rXWwQRZ8YJRo+9zF1MXJwsAnoSexYVQhSIyKwglFi8glvkBpm
        gddMEkeOvmMFSQgLuEo8aetnA7FZBFQlDvS/YQSxeQXsJc7MWc0IsUBeYvWGA8wgNidQ/Oe0
        C2D1QgJ2EouP/mSawMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmDsbDv2c8sOxq53
        wYcYBTgYlXh4HVK0Y4VYE8uKK3MPMUpwMCuJ8Np+BQrxpiRWVqUW5ccXleakFh9iNAU6aiKz
        lGhyPjCu80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOoFuVcV
        KPJ/Pve54FrZVv5bvX0Hnlxb8d3q1PQpPduenUuV39+U91Zo+vI/lzoOmz5UjMzpnql2O62m
        b1L3P/2FVg5rufqaCrfmWOaa3i0q2cflO/1vYspvA2HD5363tCX/b+1Ste1UNu3uUlfRCjDw
        db7FlxL0IOaVi+vZg4lz17F2+6z+ocRSnJFoqMVcVJwIADf5qXizAgAA
X-CMS-MailID: 20190715124509eucas1p1f2e44af951158fbef1a245467956ef93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124509eucas1p1f2e44af951158fbef1a245467956ef93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124509eucas1p1f2e44af951158fbef1a245467956ef93
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124509eucas1p1f2e44af951158fbef1a245467956ef93@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bus_isp which changes ACLK400_ISP clock speed according to the bus
documentation in the documentation. The bus_isp OPP table has been
aligned to the new parent rate. This patch sets the proper parent and
picks the init frequency before the devfreq governor starts working.
It sets also parent rate (DPLL to 1200MHz).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 990fe03fce75..852cb3dd495d 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -166,6 +166,18 @@
 	status = "okay";
 };
 
+&bus_isp {
+	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK400_ISP>,
+			  <&clock CLK_MOUT_SW_ACLK400_ISP>,
+			  <&clock CLK_DOUT_ACLK400_ISP>,
+			  <&clock CLK_FOUT_DPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>,
+				 <&clock CLK_DOUT_ACLK400_ISP>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <1200000000>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&buck6_reg>;
 };
-- 
2.17.1

