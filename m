Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54CC76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6916F206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uLg4LNhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfGOMpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50020 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbfGOMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124517euoutp0219540eb3f5c4cd91a3db6684c8fa6809~xlVBFgmWY0763707637euoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124517euoutp0219540eb3f5c4cd91a3db6684c8fa6809~xlVBFgmWY0763707637euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194717;
        bh=SlSGrP0biJS3zDm28jQoSzzy5NHzoOLSngg63Rw4Q50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLg4LNhYLTRONvtmFq2gVSn98R37ztNRtB5hBMiD8+aSo/HugLjgJLfqKxlo074/J
         w5YbGS22ldqFt7VRFsTZFCe8hPQEOkGiSjaXk/8Ca+f3meLOZhncl7C4u0gl/tR17I
         gX05uQ7TMo7qpIe/jqT0hEwucXSDzPTYOFvstwF8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124516eucas1p1c35ae1baf457096ce1dfb6d2cf4014bb~xlVADe4cT3144231442eucas1p16;
        Mon, 15 Jul 2019 12:45:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.F1.04377.C557C2D5; Mon, 15
        Jul 2019 13:45:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124515eucas1p240a8c61dd62d56cbbd0e4d313be2273e~xlU-K-MxC0240802408eucas1p2O;
        Mon, 15 Jul 2019 12:45:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124515eusmtrp12a318e65182f0b206d6366f52c851fbd~xlU_81_CM0524305243eusmtrp1f;
        Mon, 15 Jul 2019 12:45:15 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-51-5d2c755cd02f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.27.04140.B557C2D5; Mon, 15
        Jul 2019 13:45:15 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124514eusmtip21d70cd0d4c02b38744c66ad59139b0f8~xlU_KG5Bs1184611846eusmtip2d;
        Mon, 15 Jul 2019 12:45:14 +0000 (GMT)
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
Subject: [PATCH v1 50/50] ARM: dts: exynos: change MMC0 clock parent in
 Exynos5800 Peach Pi
Date:   Mon, 15 Jul 2019 14:44:17 +0200
Message-Id: <20190715124417.4787-51-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0gUURTGvTM7D6WNaQ29vrIWBM3UCpErlZkUDAU9CAoq0zUntXS1HbW0
        xE0yTXyVpmIPFRRt87mJj8EiHykmtamUr5LSUDNNwi1YMmtnx+i/3/m+75xzOVwaV3QQjnSU
        Op7TqFXRStJG1tJreu11JmFb8PbOR3I0Xv+aQE0lDQQaMc4SqKzHXOZNf8WRwdBIoVdpCxQa
        1zoj/fQ7An3PniTQsHCfRCWGZxiq6/lAoaqRQQwNvjyAJq7XkCj9aQ+FuhcyCLT6rkkWaMvW
        PqwF7NJoOsXqdbdI9kllKtv5rQNjc5t1gF3WbzpKnbLZHc5FRyVyGp+AUJvIuvkVEKcjr9xb
        egq0oIXIAjQNGV9YXBqRBWxoBVMD4JxxkZIKI4Bv36eRUrEMoPCiEM8C1pYO3XATJhnVAD7K
        12KiYWnpE/zFsSTjDdt0l0R5I1MJYI8pTMzjzBgGOz63E6JhywTDn38eUyLLGDeYuZRDiixn
        9sKCuklSWuYKHzc+tyy2NuumojeWF0FmiILTptW10H44m/twjW3hfF8zJbEzHCjIlknMQ21O
        BZD4GpzOe7CW2QW7+wYtt8AZD9gg+EjyPjhjFMeIJ1oPRxc3iDJuxjstxbgky2HmTYWUdofN
        2W8wie1gdW3R2nAWztzuB9Kp7gD4STDg+cC19P+ycgB0wJ5L4GMiOH6nmrvszati+AR1hPe5
        2Bg9MP+pgdU+YxsQVsK6AEMD5Tp5YLhnsIJQJfJJMV0A0rhyo3zPD7MkD1clJXOa2BBNQjTH
        dwEnWqa0l1+1+nhawUSo4rmLHBfHaf65GG3tqAVlBn11SnfTChaa435y8IKTnfK815GquxV+
        Qb75h4oFT//yqmO7yyb0LYLg1nowoCNOvaGRZVLak9CJ1s0rU5EOh7dYBfz2uEFPmhyY0N7b
        vcbVwmWXvP7lKzUBlc4uZ+X1QWNz9ou/pqIr/dmsgWS/ECfNl9SljKGU3K7jnbtUShkfqdqx
        Fdfwqr9BJaHWTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7rRpTqxBlNPiFjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mta/+MBasYquY/X4vYwPjNtYuRk4OCQETiVWXNzJ1MXJxCAksZZR4
        P2kiVEJMYtK+7ewQtrDEn2tdbBBFnxglrv/+BpTg4GAT0JPYsaoQpEZEYAWjxOQT3iA1zAKv
        mSSOHH0HNkhYIFpiy5cZbCA2i4CqRMf7XjCbV8BeYvLae2wQC+QlVm84wAxicwLFf067ABYX
        ErCTWHz0J9MERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNn27GfW3Ywdr0LPsQo
        wMGoxMPrkKIdK8SaWFZcmXuIUYKDWUmE1/YrUIg3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPz
        gXGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0di6xtz3YEuF
        ZUuYyDmNuWYbu+/v/ury0/38B6vVaVPvfF13TSjp66RPmwV6KgvezlCe+EVK90OqvXeJpcse
        34RO1QW/P8/4uuPp4a7rWT7cj/bMYMwp3Hijsev+gVv1KfzTtzXcUclMePfHVGvJdM1HE10W
        lk/y3btA6k8A58YjV08GXbq7hF2JpTgj0VCLuag4EQAozPNCswIAAA==
X-CMS-MailID: 20190715124515eucas1p240a8c61dd62d56cbbd0e4d313be2273e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124515eucas1p240a8c61dd62d56cbbd0e4d313be2273e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124515eucas1p240a8c61dd62d56cbbd0e4d313be2273e
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124515eucas1p240a8c61dd62d56cbbd0e4d313be2273e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change MMC0 clock settings and set parent to MOUT_SPLL with proper rate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 38edb00c7f1b..c8e02ecc6627 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -891,6 +891,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
+	assigned-clocks = <&clock CLK_MOUT_MMC0>, <&clock CLK_FOUT_SPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_SPLL>;
+	assigned-clock-rates = <0>, <800000000>;
 };
 
 &nocp_mem0_0 {
-- 
2.17.1

