Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150FDC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B062054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QzxWmIPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfIXG6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:58:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46761 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388503AbfIXG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:58:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190924065804euoutp021124ec685ff27af29c3dcb6f9ae6c8bc~HTZHsrvky1696116961euoutp02r
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 06:58:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190924065804euoutp021124ec685ff27af29c3dcb6f9ae6c8bc~HTZHsrvky1696116961euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569308284;
        bh=OP+dm40ZG5SXMwCkJ0CZwjYwFavtC+VUBZmrccbEErs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QzxWmIPanTOyKmdIuIwWCrdjRYAzaM4i+ORzlB+2Bn808Dw/v6Dg8+yokeyJm+7of
         5hdQaq3Ezf0w4WU4pW2Y819CeN64IGdPsD7VjWMOcTRTa4mUht0ccaexbLj6EbNMej
         zrt7ApimceKHttRZTy6uPUzTGsk5E0jO5s4zNX4s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190924065803eucas1p1dbdff06623fcff1bac8ab4c717640b01~HTZHW3yez1837518375eucas1p1R;
        Tue, 24 Sep 2019 06:58:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.CF.04374.B7EB98D5; Tue, 24
        Sep 2019 07:58:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190924065803eucas1p21c6e8c7105a20687e10a90fd8db080b4~HTZHCx3DD3200032000eucas1p2U;
        Tue, 24 Sep 2019 06:58:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190924065803eusmtrp26ba253e3b3965cd68a5a1cc41fcfd8b8~HTZHB9vCY2593925939eusmtrp2e;
        Tue, 24 Sep 2019 06:58:03 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-dc-5d89be7b4602
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.C7.04166.B7EB98D5; Tue, 24
        Sep 2019 07:58:03 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924065802eusmtip2c9064db0f375185d24928d292c876fc3~HTZGTuqUK1018710187eusmtip2h;
        Tue, 24 Sep 2019 06:58:02 +0000 (GMT)
Subject: Re: [RFT v4 6/8] ARM: dts: exynos: Remove MCT subnode for interrupt
 map on Exynos5250
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7ad1898d-3aa7-db49-78c1-c42b34568c60@samsung.com>
Date:   Tue, 24 Sep 2019 08:58:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923161411.9236-6-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7rV+zpjDRpaTCxurTvHajHvs6zF
        /CNARv/j18wW589vYLfY9Pgaq8XlXXPYLGac38dksfT6RSaL1r1H2C3an75ktti8aSqzA4/H
        mnlrGD02repk87hzbQ+bx7tz59g9Ni+p9+jbsorR4/MmuQD2KC6blNSczLLUIn27BK6MdRO+
        sBd0CVQ0bbnD0sDYytPFyMkhIWAicbJlB0sXIxeHkMAKRonFi1+wQzhfGCVeHXvCAlIlJPCZ
        UWLpIXmYjiPTzjNBFC1nlFh25BUbhPOWUeLCpjdMIFXCAgkSk55cYwRJiAhMZpbYf3glG0iC
        WUBXYvq7N8wgNpuAoUTX2y6wOK+AncTTi/sYQWwWAVWJJfN/gK0WFYiVuPfjODNEjaDEyZkQ
        J3ECnXHjSTMzxEx5ie1v50DZ4hK3nswHO09C4B67xNMVnawQd7tIvPx4mRHCFpZ4dXwLO4Qt
        I/F/J0xDM6PEw3Nr2SGcHkaJy00zoDqsJQ4fvwg0iQNohabE+l36EGFHiR99vUwgYQkBPokb
        bwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWktdmIXlnFpJ3ZiHsXcDIsopR
        PLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwkZ3+d/zrDsZ9f5IOMQpwMCrx8Eps64gVYk0s
        K67MPcQowcGsJMK7SastVog3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILU
        IpgsEwenVANj4MPIU8HSbzRLVNQkHN87ek7wvRTsxvtDvrN17lqG8B952ReFGicHJpteUZh0
        Okb5v9O0SMHZyxbX8ap8Enx4Y/+nI+uUOp/V/dssz62qalHicV8ooag8T8TW+dBMsZp/+irs
        roGRbz5e2H0isbGzKclBcObVsCu1MVK1XDLnjZzO//yt3qvEUpyRaKjFXFScCAA33H4HYAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7rV+zpjDZ7fUbS4te4cq8W8z7IW
        848AGf2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TxdLrF5ksWvceYbdof/qS2WLzpqnMDjwe
        a+atYfTYtKqTzePOtT1sHu/OnWP32Lyk3qNvyypGj8+b5ALYo/RsivJLS1IVMvKLS2yVog0t
        jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy1k34wl7QJVDRtOUOSwNjK08XIyeH
        hICJxJFp55m6GLk4hASWMkq0d+5nhUjISJyc1gBlC0v8udbFBlH0mlGi7/VjRpCEsECCxKQn
        18BsEYGpzBI3L9WC2MwCuhLT371hhmjYyCjx6k4zO0iCTcBQoustyCRODl4BO4mnF/eBNbMI
        qEosmf+DpYuRg0NUIFZi014ziBJBiZMzn7CA2JxAl9540swMMd9MYt7mh1C2vMT2t3OgbHGJ
        W0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzButx37
        uXkH46WNwYcYBTgYlXh4JbZ1xAqxJpYVV+YeYpTgYFYS4d2k1RYrxJuSWFmVWpQfX1Sak1p8
        iNEU6LeJzFKiyfnAlJJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNT
        qoGRM8iGNeP0z+JPt7V2v/lcXX9Cyl/S4n6e6DIT2YaWP9tv5HH7L9PO/fAvMDG+f+2a306H
        Hics3fn6+6ttT6bcfs2RsP2bGxv/BcuD6xvZfCxZM9vDw6bPvWp+sbE36pFkyD7HmQvulrYm
        dR66u/h8J7fiPAWXpGul7+X+fSjpulHK2TK7xyZZiaU4I9FQi7moOBEA7VA+AvECAAA=
X-CMS-MailID: 20190924065803eucas1p21c6e8c7105a20687e10a90fd8db080b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190923161450epcas4p32dfa1273d244c1392c7bfb4c352f2d3e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190923161450epcas4p32dfa1273d244c1392c7bfb4c352f2d3e
References: <20190923161411.9236-1-krzk@kernel.org>
        <CGME20190923161450epcas4p32dfa1273d244c1392c7bfb4c352f2d3e@epcas4p3.samsung.com>
        <20190923161411.9236-6-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.09.2019 18:14, Krzysztof Kozlowski wrote:
> Multi Core Timer node has interrupts routed to two different parents -
> GIC and combiner.  This was modeled with a interrupt-map within a
> subnode but can be expressed in an easier and more common way, directly
> in the node itself.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine on Arndale and Snow boards.

>
> ---
>
> Not tested.
>
> Changes since v3:
> 1. Use interrupts-extended instead of interrupts-map.
> ---
>   arch/arm/boot/dts/exynos5250.dtsi | 23 ++++++-----------------
>   1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 7a01349317a3..a549eafd2c64 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -236,25 +236,14 @@
>   		timer@101c0000 {
>   			compatible = "samsung,exynos4210-mct";
>   			reg = <0x101C0000 0x800>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			interrupt-parent = <&mct_map>;
> -			interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
> -				     <4 0>, <5 0>;
>   			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
>   			clock-names = "fin_pll", "mct";
> -
> -			mct_map: mct-map {
> -				#interrupt-cells = <2>;
> -				#address-cells = <0>;
> -				#size-cells = <0>;
> -				interrupt-map = <0x0 0 &combiner 23 3>,
> -						<0x1 0 &combiner 23 4>,
> -						<0x2 0 &combiner 25 2>,
> -						<0x3 0 &combiner 25 3>,
> -						<0x4 0 &gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
> -						<0x5 0 &gic 0 121 IRQ_TYPE_LEVEL_HIGH>;
> -			};
> +			interrupts-extended = <&combiner 23 3>,
> +					      <&combiner 23 4>,
> +					      <&combiner 25 2>,
> +					      <&combiner 25 3>,
> +					      <&gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&gic 0 121 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		pinctrl_0: pinctrl@11400000 {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

