Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0767217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i0whF4F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfI0Ggw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:36:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43934 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfI0Ggv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:36:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190927063649euoutp02e53a8a86ab801302dff3f4b085b80a44~IOCblUjux1208212082euoutp02O
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:36:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190927063649euoutp02e53a8a86ab801302dff3f4b085b80a44~IOCblUjux1208212082euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569566209;
        bh=1ndUXvyG/naqx4bDD64mUQ+qbfWxe/FYI+t9bA24Nf0=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=i0whF4F3IhfAOxyGT81YkPZzeDYX08Zj8j5OApNndlgrRpBRhxfptQ/YB52s7ah9t
         eIVkhaIpNlaZyVk1vG8/rTP/KN1tHWqSt4lV6+Mi/fosfLXUaHCi8qJqigA9qJGYg+
         0W0CDUFc4DuFTHZLZSgEnlB1ZOE/aRTnut6a3rbw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190927063649eucas1p2c1c02493b856e394c1c8a44b4e14779b~IOCbAX__J1903919039eucas1p2z;
        Fri, 27 Sep 2019 06:36:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.76.04469.10EAD8D5; Fri, 27
        Sep 2019 07:36:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190927063648eucas1p2e19d5c88d5300b7f6c2ac86144534e0c~IOCasiJR_0925109251eucas1p2v;
        Fri, 27 Sep 2019 06:36:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190927063648eusmtrp268e0857240f5443511ac67d136686427~IOCar2bd60211602116eusmtrp2J;
        Fri, 27 Sep 2019 06:36:48 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-7c-5d8dae01e8a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.D4.04117.00EAD8D5; Fri, 27
        Sep 2019 07:36:48 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190927063648eusmtip17292d6dcec28ac022351e078da49f1fc~IOCaLZ4AD1038210382eusmtip1U;
        Fri, 27 Sep 2019 06:36:48 +0000 (GMT)
Subject: Re: [PATCH] dt-bindings: timer: Use defines instead of numbers in
 Exynos MCT examples
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fc0809b0-1e6a-0564-75d9-0ccb14d2826c@samsung.com>
Date:   Fri, 27 Sep 2019 08:36:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190926183643.7118-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOjsPJcWp7Me0yMDJKE/xxIjGj24js8rPL0qknFd2UzZmX
        IrtSw8okcy51SkYqXmpTU1PDaQ4TZjo0CdE5F6Q2oSzRqGzb0fLf8z7v87zv+3x8BCbo4PgT
        yfIMWiGXpopwHrulb9m8GzXck+yxt3Cp8oVAStdr5lAPpucwanDwBZfST49yKEt7KU5pBrtY
        1LMPQyzqVmcvlzLoi7AonriuvA6J9bV3cfH4aAcunjebuWJD1VXxgn7zKfwsLyKBTk3OpBWh
        kbG8pCb1NXa6Lihr2WhDecgKauRBABkOn3SFuBrxCAFZjaBu6iFiiu8I2kqacZdKQC44OwUs
        NSLcjt9jOYzmOYKX9YZVgwNB9eIScol8yFgofBzu4n3JeRZU2Bcx1yCcDAO1Q+0eyicjoV39
        iO3CbDIIZlfG3NiPlMDEkgljNN7QX2J38x7Oxe1dIxwXxsgt8MpRijFYCB/tOpZrGZBGLnwp
        K0ZMtkPwVaNlMdgHZk1NXAYHwErbmuEGgilzPZcp8hFYrmtW3fugxzTEccXByGBobA9l6AMw
        6ehGzFN4wZjDmznCCwpbijGG5sOd2wJGvR20poZ/a7vfD2MMFsNESxu3AG3TroupXRdNuy6a
        9v8NFYhdi4S0SilLpJVhcvpSiFIqU6rkiSHxaTI9cv6pgT+mb63ox3CcEZEEEnnyNbX5EgFH
        mqnMlhkREJjIlx99xknxE6TZObQiLUahSqWVRrSJYIuE/NwN1nMCMlGaQafQdDqtWOuyCA//
        PLQx+elMFjTvwizoSo8h6nRglclva5/tTU3A4YC3kycH+LO+8RcrJWTwiWHVuxn1wYjqmyky
        5DhedPl+zdxkLGgaG2It1qbcC77jWnbFsbJ6Gx5xZEdn/v6eypjbTwxxcX0jr+0jrUejhaHF
        cT/FnrrPXvpBnWrBdr56b/8v3CpiK5OkYTsxhVL6F4Qi7uVPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7oM63pjDb6907eY91nWYv6Rc6wW
        /Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PF0usXmSxa9x5ht9i8aSqzA5fHmnlrGD02repk
        87hzbQ+bx7tz59g9Ni+p9/i8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEvY0tXI0vBfNWKn4ceMTYwPpDoYuTgkBAwkfh7o6qLkYtDSGAp
        o8TcB7/Yuhg5geIyEienNbBC2MISf651sUEUvWaUWNN5lB2kWVggQWLSNBOQuIjAOyaJN8/X
        skMUtTNKdLcfZwbpZhMwlOh62wU2lVfATmJX1xQWEJtFQFXi1f8bLCCDRAViJTbtNYMoEZQ4
        OfMJWAkn0HG79l0FO4JZwExi3uaHzBC2vMT2t3OgbHGJW0/mM01gFJyFpH0WkpZZSFpmIWlZ
        wMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzD+th37uWUHY9e74EOMAhyMSjy8M1b1xAqx
        JpYVV+YeYpTgYFYS4fWNBArxpiRWVqUW5ccXleakFh9iNAX6bSKzlGhyPjA15JXEG5oamltY
        GpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYLT+uvp65tuEKV8+ZH38lN+58tI3
        jdMlRgU3N8a3n/z29ens/z03f4mkh7Qud9w1P3f/bL2UBSenn6gLfV/W3LD1VWMwa/bqSacf
        PHp3bufZmzG8ykkW5/6pece9Fv+WOCN5NbvKwjnCJw279F5tY0kwjOmviHDwsq06kDjd0HxK
        4q1NXw/Y6wYrsRRnJBpqMRcVJwIAF+K3JdUCAAA=
X-CMS-MailID: 20190927063648eucas1p2e19d5c88d5300b7f6c2ac86144534e0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190926183707epcas3p350fe17bc738540b37f1130d967c31a62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190926183707epcas3p350fe17bc738540b37f1130d967c31a62
References: <CGME20190926183707epcas3p350fe17bc738540b37f1130d967c31a62@epcas3p3.samsung.com>
        <20190926183643.7118-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 26.09.2019 20:36, Krzysztof Kozlowski wrote:
> Make the examples in Exynos Multi Core Timer bindings more readable and
> bring them closer to real DTS by using defines for interrupt flags.
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Rebased on top of:
> https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=177667&state=*
> ---
>   .../timer/samsung,exynos4210-mct.yaml         | 37 ++++++++++++++-----
>   1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> index bff3f54a398f..c4d152009f76 100644
> --- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> +++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> @@ -75,51 +75,68 @@ examples:
>       // In this example, the IP contains two local timers, using separate
>       // interrupts, so two local timer interrupts have been specified,
>       // in addition to four global timer interrupts.
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>   
>       timer@10050000 {
>           compatible = "samsung,exynos4210-mct";
>           reg = <0x10050000 0x800>;
> -        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> -                     <0 42 0>, <0 48 0>;
> +        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>       };
>   
>     - |
>       // In this example, the timer interrupts are connected to two separate
>       // interrupt controllers. Hence, an interrupts-extended is needed.
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>   
>       timer@101c0000 {
>           compatible = "samsung,exynos4210-mct";
>           reg = <0x101C0000 0x800>;
> -        interrupts-extended = <&gic 0 57 0>,
> -                              <&gic 0 69 0>,
> +        interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
>                                 <&combiner 12 6>,
>                                 <&combiner 12 7>,
> -                              <&gic 0 42 0>,
> -                              <&gic 0 48 0>;
> +                              <&gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&gic GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>       };
>   
>     - |
>       // In this example, the IP contains four local timers, but using
>       // a per-processor interrupt to handle them. Only one first local
>       // interrupt is specified.
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>   
>       timer@10050000 {
>           compatible = "samsung,exynos4412-mct";
>           reg = <0x10050000 0x800>;
>   
> -        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> -                     <0 42 0>;
> +        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;

the last one should be GIC_PPI

>       };
>   
>     - |
>       // In this example, the IP contains four local timers, but using
>       // a per-processor interrupt to handle them. All the local timer
>       // interrupts are specified.
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>   
>       timer@10050000 {
>           compatible = "samsung,exynos4412-mct";
>           reg = <0x10050000 0x800>;
>   
> -        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> -                     <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
> +        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;

again, last 4 entries should use GIC_PPI


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

