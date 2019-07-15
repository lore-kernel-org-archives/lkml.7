Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C97C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4AB2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WFrqWCge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfGOMqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49934 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbfGOMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124505euoutp02c5cf0993997ebcadbeda82b1fef78c04~xlU1wpWkb0715707157euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124505euoutp02c5cf0993997ebcadbeda82b1fef78c04~xlU1wpWkb0715707157euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194705;
        bh=bIsmRuRdvJ8EbuC+n2fz8iI0NHVPMowCRF1Znsiftpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFrqWCgeMZP9prj997TOoqJ87729eo3Kg56nAhp5Shw26hH10ipbyXWEV5Y4CbbjI
         eNK03BQc2ZGo6K5ROt0Ij4mIO2jaSHWJQQJJm1380jyY3hWqbM08A6bYWM5AceuVUg
         FiMvCmTVr8wiKzQMvnQ06qAT7dXCa99619IHhxWI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124504eucas1p19e1d3ccaee92e9d0e5b1154e36b05818~xlU0__aE40156501565eucas1p1d;
        Mon, 15 Jul 2019 12:45:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.E1.04377.0557C2D5; Mon, 15
        Jul 2019 13:45:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124503eucas1p1d41112e5c10c4fd21c7aada7bdf8e513~xlU0LFWeB3191231912eucas1p1w;
        Mon, 15 Jul 2019 12:45:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124503eusmtrp197ef79627a7a52201423ca507d63adab~xlUz81pvz0488104881eusmtrp1C;
        Mon, 15 Jul 2019 12:45:03 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-20-5d2c75502339
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.50.04146.F457C2D5; Mon, 15
        Jul 2019 13:45:03 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124502eusmtip2937b99c3cde708c7bc721964cc3e63c5~xlUzFewR11101111011eusmtip2U;
        Mon, 15 Jul 2019 12:45:02 +0000 (GMT)
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
Subject: [PATCH v1 36/50] ARM: dts: exynos: change ACLK100_NOC config in
 Exynos5422
Date:   Mon, 15 Jul 2019 14:44:03 +0200
Message-Id: <20190715124417.4787-37-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87oBpTqxBnPPiVvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6Mf90nWApOsVV8evGOuYHxFGsXIyeH
        hICJxKzF34BsLg4hgRWMEhd/rGeCcL4wSiz5NpcRwvnMKHHu5TF2mJYz95YxQySWM0o83zOb
        Ga6lpWki0DAODjYBPYkdqwpBGkQEljBKHPmZBFLDLHCTSWLPk51gy4UFQiXmTz3JBGKzCKhK
        3D55gaWLkZ2DV8Be4kYNxC55idUbDjCD2JxA0Z/TLrCBjJEQuMQu8b3jF9RBLhJ9S99B2cIS
        r45vgbJlJE5P7mGBsIslGnoXMkLYNRKP++dC1VhLHD5+EexkZgFNifW79CHCjhKXz59hBwlL
        CPBJ3HgrCBJmBjInbZvODBHmlehoE4Ko1pDY0nOBCcIWk1i+ZhrUcA+J/XPesUECZxKjxIKL
        15knMMrPQli2gJFxFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCaOv3v+JcdjLv+JB1i
        FOBgVOLhdUjRjhViTSwrrsw9xCjBwawkwmv7FSjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rh
        QbSQQHpiSWp2ampBahFMlomDU6qBUSjc2zviSdm6I8v3ac9v1kpw+BKTHZXhX5JTWbCet+ve
        Nk7xPUtqP+qZ7uDt+y1aN3uxotIce9c5r/Zb3WPeOe3kjkLdW14LnI1OH3mwu3Ofp4JLlN6l
        zhMPy/Ls8xfJ/rmrliBx+/LS07O4Wid9vbOjXnpCVUv66ZcruDylne49K/+TvPfjXiWW4oxE
        Qy3mouJEAGR+od9PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7r+pTqxBhenyFjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mf90nWApOsVV8evGOuYHxFGsXIyeHhICJxJl7y5i7GLk4hASWMkr8
        2bCXDSIhJjFp33Z2CFtY4s+1LjaIok+MEu8nNAJ1c3CwCehJ7FhVCFIjIrCCUWLyCW+QGmaB
        10wSR46+A9sgLBAscf3tWhYQm0VAVeL2yQtANjsHr4C9xI0aiPHyEqs3HGAGsTmBoj+nXQA7
        QUjATmLx0Z9MExj5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMm23Hfm7ewXhpY/Ah
        RgEORiUeXocU7Vgh1sSy4srcQ4wSHMxKIry2X4FCvCmJlVWpRfnxRaU5qcWHGE2BTprILCWa
        nA+M6bySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwR+U8YeeWT
        FvjzrXg4+VztuRLFrb/tS561/GWq1Nr77PquXZsXNrR5lJ3hiAwM0Lu5UrIzgv+P6X5vjXgV
        5ZfmKWelP3seVZmddnWSoIz2tODqCaINF6+vPHFlZlrv6xmt+abLf4gHtM+u1W1eHzwn6+8z
        r5OW79IMtt+RnPWyWanl37yJKROVWIozEg21mIuKEwFtIRqXsQIAAA==
X-CMS-MailID: 20190715124503eucas1p1d41112e5c10c4fd21c7aada7bdf8e513
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124503eucas1p1d41112e5c10c4fd21c7aada7bdf8e513
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124503eucas1p1d41112e5c10c4fd21c7aada7bdf8e513
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124503eucas1p1d41112e5c10c4fd21c7aada7bdf8e513@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes NOC100 bus to proper parent and proper rate. The OPPs
have been align to reflect this parent and its clock rate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index aaf18653d8ac..d460041f716c 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -58,6 +58,10 @@
 
 &bus_noc {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK100_NOC>,
+			  <&clock CLK_DOUT_ACLK100_NOC>;
+	assigned-clock-parents = <&clock CLK_FF_DOUT_SPLL2>;
+	assigned-clock-rates = <0>, <100000000>;
 	status = "okay";
 };
 
-- 
2.17.1

