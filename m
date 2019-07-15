Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEEBC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979A12067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n2aHK+vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfGOMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60212 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfGOMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124444euoutp01a941a86c3a9fcc10b4fdcda9654276ee~xlUiX8I5V1950319503euoutp01h
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124444euoutp01a941a86c3a9fcc10b4fdcda9654276ee~xlUiX8I5V1950319503euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194684;
        bh=hJvLE4/1zHLBMBiw9JWZYJYoJ7BCSK7oKsNEylp/Y0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2aHK+vKY2TTNFscJx7qYNQEjHomzLtWKUTj1KUDsa/MFgUmljrsTu6b86+ot07xd
         R2WhTxPTA22IfBzFe+7GfDrR03OsQDmVaH7jVGoXY3SPvyYDIcvhKUD5UrcXCkt80G
         LJw9la3Y3ReZDLZjQ2udZ0Iar9FeYZJrm6eydlRI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124443eucas1p1ca94b9f118a63ae32468976857d9e834~xlUhbRrpE3191231912eucas1p1T;
        Mon, 15 Jul 2019 12:44:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 34.25.04298.B357C2D5; Mon, 15
        Jul 2019 13:44:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124442eucas1p197b23d50f6986477467d23f53b84d187~xlUgke1OZ0153601536eucas1p16;
        Mon, 15 Jul 2019 12:44:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124442eusmtrp1bec50f776fb0c84a8ad1c48eef097a93~xlUgWYVDF0462004620eusmtrp1E;
        Mon, 15 Jul 2019 12:44:42 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-a6-5d2c753bbe0d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.F6.04140.A357C2D5; Mon, 15
        Jul 2019 13:44:42 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124441eusmtip24fa6eb4ab2197d7b9ce1b806ed2bc69b~xlUfkQa7l0518605186eusmtip2h;
        Mon, 15 Jul 2019 12:44:41 +0000 (GMT)
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
Subject: [PATCH v1 11/50] clk: samsung: add IDs to UART clocks in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:38 +0200
Message-Id: <20190715124417.4787-12-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0xSYRju43A4Rwo7Qat36bLRZaUlNf3xmVa21cZabf1qrWaFevKSIHEk
        s1qREy2jy9CMXPfRNKIMdE5Nu4ilZSqUXbRZLlulWa3UmuUk8ND697zP5b18+2hCWk/OotM0
        WaxOo8qQi8TC6oej7Uti9YsTlh57MAN332wnscNSQeKXwx9JfLHJV57s+0zgjo5bFG7LHaRw
        tyEUO/tekPi76Q2Jn9WdE2FLxx0BvtHUQ+GrLz0C7Hm8Fr8+XC7CxoYmCrsGC0g8/sIhjJcp
        7RfsSPntlZFSOm1HRcpK6yHl/a/1AuWJKhtSDjlnb6S2iOOS2Yy0PaxOsXKHOPWJaa62UrzX
        0lJEGtAYXYiCaGCi4ZrnvKgQiWkpU47g7qcRyi9ImWEE1tZ0XhhCcOX2L/QvcfWHBfFCGYIu
        e36g8CVKbNcEhYimRUwk1Nh2+wPTGSuCptFEv4dgugRQ/76W9AsyZj2c7X090VXIzIc/Y+8I
        P5Ywq8Bs9FL8tDC4fuveBB/k40dL3BO7AtNOwfDxPBFvWgN2b0MgIIOB5qoADoXWIpOQxxwY
        jl8OnHAA+k6eD3hiwdXsIf1LE8wiqKhT8PRqcNjuCf00MMHw6ss0P034oLn6DMHTEjiSL+Xd
        C6HK5BbweAaU2UsCzZUwnOei+OcxI3judVCnUFjp/2GXELKhmayeU6ew3DINmx3JqdScXpMS
        mZSpdiLfn2odb/5Rg0aeJjYihkbyKZL45IgEKanaw+WoGxHQhHy6ZMWIj5Ikq3L2sbrM7Tp9
        Bss1ohBaKJ8p2T+pd6uUSVFlsbtYVsvq/qkCOmiWAWVpnaM/Y5l4Y45Mm6cIjy7tizdEHOwJ
        NcfNO52/ub+2bZ67YFtwteI3rFblhxcL06Mmu2H2wLNKzwLaXVEUbHUcHAu570poEVfnnskV
        y3TZXR86yzZNjToSk5TeOaXf6+ot1yzPeuQgrNzWUEVM+Ok52ze4it/Ob6mbXLluZ4VcyKWq
        loUTOk71F0cZRE1PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7pWpTqxBj+nyFrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MMz3KBZu5KmacmMzawPiHo4uRk0NCwERi6acZjF2MXBxCAksZJb6t
        W8wMkRCTmLRvOzuELSzx51oXG0TRJ0aJratfAiU4ONgE9CR2rCoEqRERWMEoMfmEN0gNs8Br
        JokjR9+xgiSEBXwkZj64zQhiswioSvz+8whsAa+AvcSk1v9QC+QlVm84ABbnBIr/nHaBDcQW
        ErCTWHz0J9MERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiNn27GfW3Ywdr0LPsQo
        wMGoxMPrkKIdK8SaWFZcmXuIUYKDWUmE1/YrUIg3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPz
        gVGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0WzL2hXTI25t
        vXYhVJ/l6joWrhffjHKVufKev53/pS9sXYjYn/uq25cpFW2/rx116kCH09Vj1vv58g+JxDez
        O1gI3DghrCqaHXR2keyUV/sytHoi9rPm3ZD5G6G4b13Bd/+a3LLqox9nSr/6E3Q4ecqb2Ol3
        enxDT/1P1XVx9HDkD77jrHwqXYmlOCPRUIu5qDgRAM1l+BKyAgAA
X-CMS-MailID: 20190715124442eucas1p197b23d50f6986477467d23f53b84d187
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124442eucas1p197b23d50f6986477467d23f53b84d187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124442eucas1p197b23d50f6986477467d23f53b84d187
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124442eucas1p197b23d50f6986477467d23f53b84d187@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IDs to MUXes for UART to manage them from DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index c13f34d3d9a1..7bf74401c4e7 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -768,10 +768,10 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(0, "mout_mphy_refclk", mout_group2_p, SRC_FSYS, 28, 3),
 
 	/* PERIC Block */
-	MUX(0, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
-	MUX(0, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
-	MUX(0, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
-	MUX(0, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
+	MUX(CLK_MOUT_UART0, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
+	MUX(CLK_MOUT_UART1, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
+	MUX(CLK_MOUT_UART2, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
+	MUX(CLK_MOUT_UART3, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
 	MUX(0, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
 	MUX(0, "mout_spdif", mout_spdif_p, SRC_PERIC0, 28, 3),
 	MUX(0, "mout_audio0", mout_audio0_p, SRC_PERIC1, 8, 3),
-- 
2.17.1

