Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED28C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0E820B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cqxp1Ob7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfFSKBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:01:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60463 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFSKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:01:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190619100114euoutp0188716ebfb6980cd325e4d41fe4352ae5~pkUXMEd3m0287502875euoutp01c
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 10:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190619100114euoutp0188716ebfb6980cd325e4d41fe4352ae5~pkUXMEd3m0287502875euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560938474;
        bh=+5Aoi9KusrDIevbz701jCID7pa2iYGWJAx0tkxsUsaU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cqxp1Ob7vCTqgYhcChErG/Ouc9Qh2EaLV8Ac0THGlOa7Xj/9q3X+RJu1UxW5mz5yp
         nq09w7x14cBoXGW5TWtaWMCYMau7zy9+GaOppvHjW59fy9KmTWMgKE08e59AyBltjd
         c+jZ/Ti0nNtUzKLI1wb18QX+DqUi6Gm33krWQesQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190619100113eucas1p1685d5fcb85feeb41af812d7b1e65c533~pkUWILYHC0885208852eucas1p17;
        Wed, 19 Jun 2019 10:01:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4E.44.04377.9E70A0D5; Wed, 19
        Jun 2019 11:01:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190619100112eucas1p25eb0476f1b1dc1bb80c3662c3528c254~pkUVTw3YT0942809428eucas1p2d;
        Wed, 19 Jun 2019 10:01:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190619100112eusmtrp1124545bd7f52fa019bebe98b7452f910~pkUVFfwp73261132611eusmtrp15;
        Wed, 19 Jun 2019 10:01:12 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-d7-5d0a07e9a40f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.85.04146.8E70A0D5; Wed, 19
        Jun 2019 11:01:12 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190619100111eusmtip242ed98c0f3f696e11dec29ab5b2bf902~pkUUHPMIF2666626666eusmtip2_;
        Wed, 19 Jun 2019 10:01:11 +0000 (GMT)
Subject: Re: [RFT 01/10] dt-bindings: gpu: mali: Add Samsung compatibles for
 Midgard and Utgard
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9d16d4f7-8353-e0f0-a005-1b04457d70f0@samsung.com>
Date:   Wed, 19 Jun 2019 12:01:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618190534.4951-2-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1zU6lOBaVG9xLNGoUxfUZl7gmY9RojB9GJDrKBIxs6YDrhwuu
        pW74AVaQiqKmqSAVATFFi0BFkyJCBDQKCkhcCEIrLlSRMqj8nXPuue+cmzyO1FxlArmdMfGS
        LkaM0jIqKr/8h3PaB1YVNiPRHoBPOysI/Cu5nMW5qTk0br9uQLjW3UrjnvzzJM4oddK45ms7
        g5MbzlHYcMJD47NNn0hcWXmbxdamFzTuMLyhcXVRGoNTK4sJnFVbReCqJyvxk1oXg4/ZSln8
        6PMJGv9+kUthc5EH4Q8dj6klIFguW5DQ/TMZCe11x1jB1mWihHvG16xgNZ9ihIKuRlpoSHIQ
        wp1rB4Wax0do4UyeGQku65j1vptVC8OlqJ27Jd30xdtUkfU2OxX33m9v+c8k4hDK9NUjHw74
        2WA4+x7pkYrT8DcRvGp5TSvEjSC3uZhUiAvB97yjzN+VmsIkShncQJDjcfaTNgSZZXba6/Ln
        RXB12ljvYBhfT0OBNbHPRfJXETy9cLjvLYYPAX2bvg+r+cXw5WEFoUccR/ETwH0qzisP57dA
        amErpViGQsXF5j7s01ujx9lJeDHJj4WCtjRSwQHwsjmD8GYB38jB+eff+nuvgJS6DFbB/vDR
        kdePR/X2MVDKQiKCt85brEIMCKqPpCLFtQAeOapobzuSnww5RdMVeSnUd5gZrwy8H9S1DVVK
        +EFyfgqpyGo4eVyjuCeC0ZH9L9b+7Dl5DmmNA04zDjjHOOAc4/9cE6LMKEBKkKMjJHlmjLQn
        WBaj5YSYiOAdsdFW1Pt1n/52uAtRkWd7CeI5pPVV8y4uTEOLu+V90SUIOFI7TD040SdMow4X
        9+2XdLFbdQlRklyCRnKUNkB9YFBjqIaPEOOlXZIUJ+n+TgnOJ/AQmjvi22hPaJch1HJ3FYR0
        7yFbUsYvlS7pMyoMl8zy+Enpsya0N4R3L1MV7xoXu/bCZHHWukrLopsH7Ku3nJmXeSX9flm8
        /+E12ZM2NQzpKU3PCeo8Onx+1wbLjaypJtW86rQVp3W27JGDjrsfBJqso5cHLTDdamqZc3l9
        3Meywe/Sv7du1FJypBgyhdTJ4h+XsRu4tgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89lO1MXp9PEF0mtRQRdVmdqvqYuPxgcqCioKErTpQcnuR3b
        mXb70DDE3Kx0H8KGaBeNGEFNy1JYpZW3SJuZpl2s7KKoWXkBL2lbK/Db732e/+/heeGhcOYu
        GUxlGEy80aDNVEr8iGdzTe/XD0j9kjbaukLRubYWDP22NUqRs+QWiUavFwLUPf6NRPM1xTgq
        f9JGos6JUQmy9RURqDB/lkQX+odw1N5+W4qq+rtI9LPwPYle1pVKUEn7AwxVdrsx5G7dilq7
        xyQoz/VEih4P55NorstJIEfdLECDP5uJeMjdLLsJuJlpG+BGX+dJOdfkZYKrtb+TclWOAgl3
        b/IDyfVZmzCuuuI019mcS3Ln7zgAN1YVuivggCrWKGSb+OU6QTTFKQ+ySK1io5FKHRGtYsOj
        kjarI5UbNLFpfGZGDm/coElR6Xpc9UTW18XHG6etmBlcDbAAGQXpCNh530pYgB/F0JUAzj19
        CHyNZbDlopn08VI422WR+EJDAHa4S/+GltJaOPbLJfU2FHQPCXsrhnDvA6evAdhjLZf6FKdH
        cbpwryKhWWgZ8c6SUXJaA388asEsgKIIehUcL8jylgPpRPiw/g3hiyyBLZc+/2WZZ9f5tl+Y
        l3F6Eyyr/oj7OAzeGyn9x0Gw93M5VgQY+wLdvkCxL1DsC5TLgHAABZ8t6tP1IqsStXox25Cu
        ShX0VcBzMjWNU9X3QYdzdwOgKaAMkOsmqCSG1OaIJ/QNAFK4UiH3PyNLYuRp2hMneaOQbMzO
        5MUGEOn5WzEeHJgqeA7QYEpmI9koFM1GhUeFb0LKIPlZuj6RodO1Jv4Iz2fxxv8eRsmCzSDh
        hrWOKDJMr9MNpsYrruwwzwSl0+I2NDUY96X/mIrCE2pt/st3L4p8e8vY/DVgS5h72LFz+9qI
        8AGBeZV79G2ikMgcnq0dOci8WM24zcK+45oVCUWHavwqhOcxIEuREzKgDklNiWj6fqo4c2+f
        Rv2GjLE+/zQyvPI6t2e/o1xJiDotuwY3ito/yg4JmkgDAAA=
X-CMS-MailID: 20190619100112eucas1p25eb0476f1b1dc1bb80c3662c3528c254
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c
References: <20190618190534.4951-1-krzk@kernel.org>
        <CGME20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c@epcas2p3.samsung.com>
        <20190618190534.4951-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2019-06-18 21:05, Krzysztof Kozlowski wrote:
> Add vendor compatibles for specific implementation of Mali Utgard
> (Exynos3250, Exynos4-family) and Midgard (Exynos5433, Exynos7).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 1 +
>   Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt  | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index e5ad3b2afe17..9b298edec5b2 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -17,6 +17,7 @@ Required properties:
>     * which must be preceded by one of the following vendor specifics:
>       + "allwinner,sun50i-h6-mali"
>       + "amlogic,meson-gxm-mali"
> +    + "samsung,exynos5433-mali"
>       + "rockchip,rk3288-mali"
>       + "rockchip,rk3399-mali"
>   
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index ae63f09fda7d..519018cb860b 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -17,6 +17,7 @@ Required properties:
>         + amlogic,meson8b-mali
>         + amlogic,meson-gxbb-mali
>         + amlogic,meson-gxl-mali
> +      + samsung,exynos3250-mali
I would prefer 'samsung,exynos4-mali', because historically Exynos4 was 
the first SoC with Mali400 and such prefix is already used for many hw 
blocks.
>         + rockchip,rk3036-mali
>         + rockchip,rk3066-mali
>         + rockchip,rk3188-mali

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

