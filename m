Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77472C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0F12067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vps+r5gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfGOMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60561 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbfGOMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124515euoutp019a884ceee7904283d7d78364523eba89~xlU-Lzl_Y1972419724euoutp01s
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124515euoutp019a884ceee7904283d7d78364523eba89~xlU-Lzl_Y1972419724euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194715;
        bh=+y97K1qUSQhqt3rK3hQzR4lKeiVtsP9SfytOcS6HUUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vps+r5gbL9U74IaIvaGLfXqgyGRYnjxN8BpUCExnvM7gNjv+/bgArw9TO4Mzs+f0s
         RotAOtXgJNwsueP9QRzko/ZmhVGdWod0aMjmew9FW5UwmuqlIUNqe0BjLGOGKbBlsR
         hoqaFNFK383vBcb/+yTHN7ZOCBiWbwJuXvTwf3UA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124514eucas1p1ad1189121ecc539717d054628d2ddb56~xlU_akhC80573705737eucas1p1S;
        Mon, 15 Jul 2019 12:45:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F1.45.04298.A557C2D5; Mon, 15
        Jul 2019 13:45:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124514eucas1p1531a88cfb9b4e2fdb801074963372688~xlU9rcF3m0571105711eucas1p1Y;
        Mon, 15 Jul 2019 12:45:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124513eusmtrp126716a1cae719af372f069afa1d1af00~xlU9dV1ij0524305243eusmtrp1d;
        Mon, 15 Jul 2019 12:45:13 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-0d-5d2c755ada2f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.27.04140.9557C2D5; Mon, 15
        Jul 2019 13:45:13 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124512eusmtip20ee5b5360fdc63f8b013184c7afedd87~xlU8okb3D1173411734eusmtip24;
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
Subject: [PATCH v1 48/50] ARM: dts: exynos: set proper parents to bus_isp266
 Exynos5422
Date:   Mon, 15 Jul 2019 14:44:15 +0200
Message-Id: <20190715124417.4787-49-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7pRpTqxBodWyVvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6M9z/mMRZ84qq4smkVawNjJ2cXIyeH
        hICJxOIZZ1m7GLk4hARWMEocOHaFEcL5wigx7XczE4TzmVHid9crIIcDrOVGOz9EfDmjxKsl
        f9jhOm7P6AQrYhPQk9ixqhBkhYjAEkaJIz+TQGqYBW4ySex5spMVJCEsECnx5NA/JhCbRUBV
        YveEL2C9vAL2Eo/uc0OcJy+xesMBZhCbEyj8c9oFNpA5EgKX2CWauxezQxS5SJyb9YgJwhaW
        eHV8C1RcRuL05B4WCLtYoqF3ISOEXSPxuH8uVI21xOHjF1lB9jILaEqs36UPEXaUaFt/mhHi
        Xz6JG28FQcLMQOakbdOZIcK8Eh1tQhDVGhJbei5AHSAmsXzNNKjhHhL3t75ngYTOJEaJ7Y+f
        sE5glJ+FsGwBI+MqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwDR1+t/xTzsYv15KOsQo
        wMGoxMPrkKIdK8SaWFZcmXuIUYKDWUmE1/YrUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcOD
        aCGB9MSS1OzU1ILUIpgsEwenVAPjVkWhJaecpP95/9A83lU7K3dXkLT9MU1Z0bTUv1+mO6Yb
        7vriXXvs/Jrs/290zZemuLX9sLuYE7qpgy9LY3Kno2n0nG2KeyP0J2pl7yozYphppuS2azdP
        DpP+HBeZ1P6Qaep7PgqEBK70OLrhSRj75LSqC7aW4TuV+Fo/iiT82cDLfGDCzfVKLMUZiYZa
        zEXFiQDXfi1BTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7qRpTqxBnfnaFjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M9z/mMRZ84qq4smkVawNjJ2cXIweHhICJxI12/i5GLg4hgaWMElu2
        NLB1MXICxcUkJu3bzg5hC0v8udbFBlH0iVFi/cGfbCDNbAJ6EjtWFYLUiAisYJSYfMIbpIZZ
        4DWTxJGj71hBaoQFwiX23ckCqWERUJXYPeELE0iYV8Be4tF9bojx8hKrNxxgBrE5gcI/p10A
        O0FIwE5i8dGfTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJptx35u2cHY9S74
        EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYS
        Tc4HRnReSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGTUXpwIw/
        xX+Fd0YWVnioSQX/6+9gte2TqxZduurDqX7xzwk1TdV/n9v8nbnvjfLKzfd07x5p+z/9gGZK
        S7F/14GLefoLkyfmJPNLOB6rc/+77sO2W6cyLR9e9jFr+Pzxhe+uE4E/ZL9evujiNifuytJt
        h//FXyjJndMrufX2hl//1hszP+VJVWIpzkg01GIuKk4EABye/BuwAgAA
X-CMS-MailID: 20190715124514eucas1p1531a88cfb9b4e2fdb801074963372688
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124514eucas1p1531a88cfb9b4e2fdb801074963372688
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124514eucas1p1531a88cfb9b4e2fdb801074963372688
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124514eucas1p1531a88cfb9b4e2fdb801074963372688@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Exynos5422 there is a dedicated clock hierarchy for ACLK_266_ISP which
should be set to proper values to fully use the HW performance.
The old settings left after boot set minimal values to this bus.
In the Exynos5420 the bus is connected to ACLK_266 so there is no need for
aligning the values. In the Exynos5422 the proper hierarchy of these
clocks should be model in the software to use the full HW feature set.
The patch sets proper parent (MPLL) and initial frequency to the bus also
enabling it.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index d278339f259c..c770d17141e8 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -187,6 +187,17 @@
 	status = "okay";
 };
 
+&bus_isp266 {
+	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK266_ISP>,
+			  <&clock CLK_MOUT_USER_ACLK266_ISP>,
+			  <&clock CLK_DOUT_ACLK266_ISP>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_MPLL>,
+				 <&clock CLK_MOUT_SW_ACLK266_ISP>;
+	assigned-clock-rates = <0>, <0>,<300000000>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&buck6_reg>;
 };
-- 
2.17.1

