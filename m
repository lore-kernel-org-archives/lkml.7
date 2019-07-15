Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10154C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE0320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QJ6fmG+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfGOMpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50059 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfGOMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124511euoutp02e57b4800a21ea442fcd680b166c128d5~xlU7yRD0w0715707157euoutp023
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124511euoutp02e57b4800a21ea442fcd680b166c128d5~xlU7yRD0w0715707157euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194712;
        bh=DEJi1afhOcMSvTeqvKmCvnJ8BWJtbxFkYMOBNRRsFsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ6fmG+ohum6z5MvxCtlHe/ExvHzAfBN3tQt+kfRwLcy4dmKEzdl/hg7VAAZvG1OI
         /pASitmRSvugGUF+rQLuKM44I6Ht32EEbSoanc+GbZGlDnYSsSw0Yzalwwj30qV6hm
         JU8FzxAdSl5CHuH6ei1KwkRKzI0dZKOLyg1fbMhw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124511eucas1p2fd300f330ed4de52c0de1b772054abfb~xlU7Dcbt61849318493eucas1p2R;
        Mon, 15 Jul 2019 12:45:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EB.35.04298.6557C2D5; Mon, 15
        Jul 2019 13:45:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124510eucas1p1a88fcaa3b6175a5dae69e6879a534746~xlU6P53aX3125231252eucas1p1M;
        Mon, 15 Jul 2019 12:45:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124510eusmtrp14e6f1d254f3d3c5c9dc2c48a8bcf35f3~xlU6PVVwz0524305243eusmtrp1N;
        Mon, 15 Jul 2019 12:45:10 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-ff-5d2c75564a3c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.60.04146.6557C2D5; Mon, 15
        Jul 2019 13:45:10 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124509eusmtip2d50191a3bdce94faca15f26bfd4d038b~xlU5d6xZe0528005280eusmtip26;
        Mon, 15 Jul 2019 12:45:09 +0000 (GMT)
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
Subject: [PATCH v1 44/50] ARM: dts: exynos: change rate of bus_jpeg in
 Exynos5422
Date:   Mon, 15 Jul 2019 14:44:11 +0200
Message-Id: <20190715124417.4787-45-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUhUURiGO3PXGZq8jVMeNDSGpEXTJMlDZdkm4w8pEvpRSI56UXNtrmsF
        joKaMmoYjRouZYajaS6JqKm4oaG5FbhFUrnmXu4a2oxX69/7vt/z8b0cDo1Jaghj2icgmFUG
        KPxkpAivaFnrOnkrxNL1VPYfOzT4tpNApWnFBOpbHCdQdrPOJg9PYairq4RCHdHTFBpUHUJl
        w70E+qUeItDn6gwSpXXVCVBR81cKve7rEaCetmvoS5SWRDG1zRRqmo4j0GZvKe5gKC/MKgTy
        uf4YSl5WEE/K3+VGyhtmawTypPICIF8oM71B3Rad92T9fEJZpfUFN5H3StQ8FrRKhI83pGIq
        EEckACENGVu4sbyKJQARLWG0AKbn5wl4swjgdEcFwZsFAJfTu8ndlfr5SZIf5AGYvJGD/Vv5
        UJeKJwCaJhkrWFlwX78gZXIBbF5z1zMYMyCANSNVhJ4xZFygZuKInsEZc/h9ZprSazFzEZbW
        xu70M4NvSuoxvRbq8jVN9/ZhyHRSMHlSjfPQVTiXnb/TzhBOtpZTvD4E25/uMhxUJb4EvH4E
        h5Mzd5hzsKm1Z7sPxhyHxdXWfHwJlo+tkvoYMvtg/8x+fYzpZEpFKsbHYvg4VsLTx2C5ulvA
        64Mwr1BD8YgcNg3vvFQKgNF1P4gnwOz5/1svACgARmwI5+/FcjYBbJgVp/DnQgK8rDwC/cuA
        7k+1b7b+rgRLn9wbAUMD2V6xg6eFq4RQhHIR/o0A0phMKrZf0kViT0XEA1YZeFcZ4sdyjcCE
        xmVG4od7vt2RMF6KYNaXZYNY5e5UQAuNVcAXRLpFy3zex44dDY3Nst8aSlRfqZhVLTquBJqG
        3RQbaA94JrmPeNRoilSj4ZYmatuMrY8OifhGVNize/OWAxOHq1+dnpHmVrXkOF+WWuQLfzpl
        UvHrm+vOA0NT6WfqZ7UGwjgkisp0Nnc/C2dc3RzHzJiGNieOdLk+alfZIJThnLfC5gSm5BR/
        AUnw53ZPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7phpTqxBqdmC1ncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M740fmAt+sFY8PziduYGxnbWLkZNDQsBE4sCHV2wgtpDAUkaJc6sK
        IOJiEpP2bWeHsIUl/lzrAqrhAqr5xChx98Jrli5GDg42AT2JHasKQWpEBFYwSkw+4Q1Swyzw
        mkniyNF3YAuEBQIl7r/4CbaARUBV4uHbN2BDeQXsJTbubYM6Ql5i9YYDzCA2J1D857QLUAfZ
        SSw++pNpAiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGRs+3Yz807GC9tDD7EKMDB
        qMTD65CiHSvEmlhWXJl7iFGCg1lJhNf2K1CINyWxsiq1KD++qDQntfgQoynQUROZpUST84FR
        nVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTFl4+KjiyOD8j+E
        RGqpy9mWK+54vdPU7sjayX531M68enCz2clGkn+18JzivUHbVa5eOPrtiuO91XUZMwIWSS3c
        GdLAe+r2t7YHElZvJ1bq1c2W+Ll3AXtRTcTvo4wFDwtmNXIFtMYF3XiT2OF7qMY8/uO8S+uZ
        mSQf3JvMHOYSzChuNJvN5YsSS3FGoqEWc1FxIgCyR8ZpsgIAAA==
X-CMS-MailID: 20190715124510eucas1p1a88fcaa3b6175a5dae69e6879a534746
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124510eucas1p1a88fcaa3b6175a5dae69e6879a534746
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124510eucas1p1a88fcaa3b6175a5dae69e6879a534746
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124510eucas1p1a88fcaa3b6175a5dae69e6879a534746@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_gen OPP table has been aligned to the parent rate. This patch sets
the proper initial frequency before the devfreq governor starts working.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 852cb3dd495d..27f6ed323ba1 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -131,6 +131,8 @@
 
 &bus_jpeg {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
+	assigned-clock-rates = <300000000>;
 	status = "okay";
 };
 
-- 
2.17.1

