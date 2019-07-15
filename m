Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FAC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DA42067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W+uoXlgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfGOMpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60479 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfGOMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:04 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124503euoutp010ac8aaeff5f1dbd0f9ef172c06de805c~xlUzkJ4251972419724euoutp01a
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124503euoutp010ac8aaeff5f1dbd0f9ef172c06de805c~xlUzkJ4251972419724euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194703;
        bh=mU8BAWVoycBCUqWyHydLmeJQHNnHJ75xvo8wMq+ZBMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+uoXlglAaODFSipjSpfx3kWa5RbnPKzmvXYbqIKjMdCcIl+ZoDM7nqhkeTd7pjnb
         soslG7BxeRj50nJ0STedp8zzF3kGGniLmuDmUY8i6DeECKyT18aKu3lXgz+bml5ToS
         pcR4kQeaqPsnVtfd57gMjoMnhNtkFeSassI3MP3A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124502eucas1p1e688f0289c05ec2cfbf40a7a51279b8c~xlUyizFr40154701547eucas1p1X;
        Mon, 15 Jul 2019 12:45:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.C0.04325.D457C2D5; Mon, 15
        Jul 2019 13:45:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124501eucas1p17382ca9cead8bfe1dc938e6fb583b7c5~xlUxuTr8o0147201472eucas1p1O;
        Mon, 15 Jul 2019 12:45:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124500eusmtrp1f47ce207a761510938ec4476b8c5d9ff~xlUxgMlDG0488104881eusmtrp14;
        Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-f9-5d2c754df545
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.17.04140.C457C2D5; Mon, 15
        Jul 2019 13:45:00 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124500eusmtip2da58ad3a0fcfb8fedc0cd9b783e24537~xlUww35co0573605736eusmtip2P;
        Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
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
Subject: [PATCH v1 33/50] ARM: dts: exynos: set parent clocks to UARTs in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:44:00 +0200
Message-Id: <20190715124417.4787-34-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0iTYRTGe/ddtVaf0/LNLGER5CVNrHgpS4Uugyj6y6Kymvqh4n2fs6zA
        ZVkmM0NDV6amWYrXuZY3dJmKhuY9nBlaoBSYznRKTMXa/BT/e87vPM97DoeXxkRNhAMdFhXH
        yqKkEWLSGq9pN/UcOCd3CziYs+KBRip7CFStqiKQfv4XgfLbzGX6+G8M9faqKdSdNEWhEYUj
        0owPEWhWOUagwYaXJFL16gSoom2UQm/0/QLU33kKfbtXQqLkpjYKtU49ItDKUDXuayspzysH
        kpnhZEqiKX1MSt4VJUo+GhoFkifaUiAxavZcoC5bewezEWHxrMzjxA3r0AatioxpEd7KM5aR
        CpCzORVY0ZA5BLMGpslUYE2LmBIAVSoDzhfzAE71fF8rjAC+H39OrEeSPk0SfKMYQJ1esxHp
        zK/DUgFNk4w7rCuNtQTsmCIA20yBFg/GfBXAxon61ZdsGX+oHv1AWjTO7IOLhQWrXMj4wPtv
        VYCf5gTL1M2YRVuZuSmrb3VZyPRQMGW+j+RNJ2HqgHEtYAsnO7QUrx1hV6YS5zUHFWkFa567
        cDw9d81zDLZ29BOWpTHGGVY1ePDYD45OKFYxZLbC4WkbC8bMMqMmG+OxEKY8FPHu/VCr7BPw
        egcsLs+ieIsEplXG8tfJALCvXUk8BU4vNma9AqAU2LNyLjKE5byi2JvunDSSk0eFuAdFR2qA
        +VN1rXQs1AHdcmALYGgg3iL0DXYNEBHSeC4hsgVAGhPbCY8vmJEwWJpwm5VFX5fJI1iuBeyi
        cbG98M6mH1dETIg0jg1n2RhWtt4V0FYOClB7NMI4YyLS2ddeel3uHB5SeNXzbJaferQ+DMwb
        xq4l2pT79Bf+m1Eyrdnb/xDGnCXce7YjoPKIa6FbRdBfw+5Fw2zez8PKGVw9aOjeu5R7Zsr2
        Wf6sCelrT7cmeOb7f/m8bdkZyffgrEvs+QeZzYl6EHYpOvwivtOmZI7FxTgXKvV0wWSc9D9x
        bcChUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7o+pTqxBlNfm1vcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MXVtmsBUc4q2Y93k1WwPjbO4uRk4OCQETiaYTr1hBbCGBpYwSK46J
        QsTFJCbt284OYQtL/LnWxdbFyAVU84lR4tb2DqYuRg4ONgE9iR2rCkFqRARWMEpMPuENUsMs
        8JpJ4sjRd2BDhQVCJPY9ucoMYrMIqEr8WrQQLM4rYC/RvGwGI8QCeYnVGw6A1XACxX9Ou8AG
        cZCdxOKjP5kmMPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERg524793LKDsetd8CFG
        AQ5GJR5ehxTtWCHWxLLiytxDjBIczEoivLZfgUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqc
        D4zqvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjGuecvhqXTgz
        qeLJdTZh+1axS5N/GjXmRukuXLZ4TptZ9EFns6LZRc9vTk4Lqvu5W2/V7+v3nCy5D/xozPuy
        amfQhE1OkvPVZGfIrdNj7z1/Qn6jANcStoT3Pxu02V1N7P+I1K3IE+Wb1DL90lsV/w8/nbmF
        FTceTuktZ+Ex6WULVb1baTBvtxJLcUaioRZzUXEiABEyggSyAgAA
X-CMS-MailID: 20190715124501eucas1p17382ca9cead8bfe1dc938e6fb583b7c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124501eucas1p17382ca9cead8bfe1dc938e6fb583b7c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124501eucas1p17382ca9cead8bfe1dc938e6fb583b7c5
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124501eucas1p17382ca9cead8bfe1dc938e6fb583b7c5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the parents of UART clocks to the CPLL which has 666MHz.
The UARTs' dividers use /10 rate so they would have 66.6MHz.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 18c5273091bd..79f635043247 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1486,6 +1486,8 @@
 &serial_0 {
 	clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
 	clock-names = "uart", "clk_uart_baud0";
+	assigned-clocks = <&clock CLK_MOUT_UART0>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_CPLL>;
 	dmas = <&pdma0 13>, <&pdma0 14>;
 	dma-names = "rx", "tx";
 };
@@ -1493,6 +1495,8 @@
 &serial_1 {
 	clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
 	clock-names = "uart", "clk_uart_baud0";
+	assigned-clocks = <&clock CLK_MOUT_UART1>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_CPLL>;
 	dmas = <&pdma1 15>, <&pdma1 16>;
 	dma-names = "rx", "tx";
 };
@@ -1500,6 +1504,8 @@
 &serial_2 {
 	clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
 	clock-names = "uart", "clk_uart_baud0";
+	assigned-clocks = <&clock CLK_MOUT_UART2>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_CPLL>;
 	dmas = <&pdma0 15>, <&pdma0 16>;
 	dma-names = "rx", "tx";
 };
@@ -1507,6 +1513,8 @@
 &serial_3 {
 	clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
 	clock-names = "uart", "clk_uart_baud0";
+	assigned-clocks = <&clock CLK_MOUT_UART3>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_CPLL>;
 	dmas = <&pdma1 17>, <&pdma1 18>;
 	dma-names = "rx", "tx";
 };
-- 
2.17.1

