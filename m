Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E08C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3F2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TOs+29rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfGOMqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50009 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbfGOMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124508euoutp023352e4238b3ea859bd8c3773dd2ee646~xlU4WU6p10726607266euoutp02c
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124508euoutp023352e4238b3ea859bd8c3773dd2ee646~xlU4WU6p10726607266euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194708;
        bh=XhUDLyvAYykblA3EHwJ2pxWkkIbmOz+RUrQVAuinKU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOs+29rxkglqUtqTLJwTcZvXXCiIU4WmrsmwXs0WBX9IUxov4gvzfN86OKCVnHEFr
         pb+FLO52uPV7zGqiiVZr6ZPsUOzquAKr2s5yLxVAm+S9FXw8of/sZon+zCWh1M6/TJ
         prYyazKi1uhF348BTEsr5mVuFc0D1n0CJ57xlObM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124507eucas1p1e15d35a3d812d9d6a14333295e4d5a93~xlU3Xaf_h3144231442eucas1p1w;
        Mon, 15 Jul 2019 12:45:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2B.C0.04325.2557C2D5; Mon, 15
        Jul 2019 13:45:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124506eucas1p2b4e906a88978e3edd875e92b1a9fedc4~xlU2mAnTA2241522415eucas1p20;
        Mon, 15 Jul 2019 12:45:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124506eusmtrp1e460a5445e84f362472fb7486559d8ed~xlU2X45sU0488104881eusmtrp1T;
        Mon, 15 Jul 2019 12:45:06 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-09-5d2c7552cfc9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.60.04146.2557C2D5; Mon, 15
        Jul 2019 13:45:06 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124505eusmtip22d9421b51e11d47ede1590ca565c1880~xlU1hDjNR1242312423eusmtip2X;
        Mon, 15 Jul 2019 12:45:05 +0000 (GMT)
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
Subject: [PATCH v1 39/50] ARM: dts: exynos: change parent and rate of
 bus_fsys_acp in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:06 +0200
Message-Id: <20190715124417.4787-40-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7pBpTqxBs8vW1vcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MSzvKC66xV3xYndLAuJeti5GTQ0LA
        ROLk5f1ANheHkMAKRol3jRAJIYEvjBL9jx0gEp8ZJbY9+c8E09F7u4EFIrGcUaLr8WImCAeo
        o6etESjDwcEmoCexY1UhSIOIwBJGiSM/k0BqmAVuMknsebKTFSQhLJAk8fzQdmaQehYBVYnt
        b7xBwrwC9hIHtr1hgVgmL7F6wwFmEJsTKP5z2gWwUyUELrFLXD64gBWiyEVi363n7BC2sMSr
        41ugbBmJ05N7oAYVSzT0LmSEsGskHvfPhaqxljh8/CIryA3MApoS63fpQ4QdJY58gzhNQoBP
        4sZbQZAwM5A5adt0qDCvREebEES1hsSWngvQ4BGTWL5mGtRwD4l9DZuhoTOJUeLS5RtsExjl
        ZyEsW8DIuIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwRZ3+d/zrDsZ9f5IOMQpwMCrx
        8DqkaMcKsSaWFVfmHmKU4GBWEuG1/QoU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9
        sSQ1OzW1ILUIJsvEwSnVwHjrmG7IzKm/Hilyre/Q36IYnrn/199agS/fJFh3Xqs9n9DzM9kj
        +0Ej5/OWt60tZrY6O0O3sBjf0XfsYU6NWbN34e4O65fskTYqb9SjeXYHbDmht61lS3pK0acD
        qi1eDM3+/9SLa//dc5y/5o/fUum0+z4NMZPKLjUwZLQ+qJYULzZVPn9WUomlOCPRUIu5qDgR
        AOpPy4JNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7pBpTqxBv2/WS1urTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7GpR3lBdfYKz6sTmlg3MvWxcjJISFgItF7u4Gli5GLQ0hgKaPE8/Vz
        GCESYhKT9m1nh7CFJf5c62KDKPrEKPFk3xqmLkYODjYBPYkdqwpBakQEVjBKTD7hDVLDLPCa
        SeLI0XesIAlhgQSJz+dPM4LUswioSmx/4w0S5hWwlziw7Q0LxHx5idUbDjCD2JxA8Z/TLoAd
        JyRgJ7H46E+mCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGzbZjPzfvYLy0MfgQ
        owAHoxIPr0OKdqwQa2JZcWXuIUYJDmYlEV7br0Ah3pTEyqrUovz4otKc1OJDjKZAN01klhJN
        zgdGdF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkb2R68/v1vF
        dLVwb9mRtx1aYn+O/nLyOhAyJe7TvbRLWxYbls74kcaom1s03YZxuumT7881GT/WbhIR+XNp
        XR/f+/KnXwQTVHmZC6+oXHvxYicfxzZl8wt6tz71HLm2p/JvfcqC9Act3/+7OG3rVb77OPet
        /79Aa21bs5sbvsuqtG+59un+clcjJZbijERDLeai4kQAv92rQrACAAA=
X-CMS-MailID: 20190715124506eucas1p2b4e906a88978e3edd875e92b1a9fedc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124506eucas1p2b4e906a88978e3edd875e92b1a9fedc4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124506eucas1p2b4e906a88978e3edd875e92b1a9fedc4
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124506eucas1p2b4e906a88978e3edd875e92b1a9fedc4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSYS APB bus OPP table has been aligned to the new parent rate. This
patch sets the proper parent and picks the init frequency before the
devfreq governor starts working. It sets also parent rate (MPLL to
600MHz).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 0e71ba64a4fe..6225d044d01c 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -67,6 +67,11 @@
 
 &bus_fsys_apb {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_PCLK200_FSYS>,
+			  <&clock CLK_DOUT_PCLK200_FSYS>,
+			  <&clock CLK_FOUT_MPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_MPLL>;
+	assigned-clock-rates = <0>, <200000000>,<600000000>;
 	status = "okay";
 };
 
-- 
2.17.1

