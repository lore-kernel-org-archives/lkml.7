Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF85C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1495920856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bqksdZA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfCZO4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:56:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54631 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbfCZO4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:56:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190326145634euoutp028d4c42d75175d0ce2fa06b90d8a4021b~Pig8ncQ6v2064020640euoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 14:56:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190326145634euoutp028d4c42d75175d0ce2fa06b90d8a4021b~Pig8ncQ6v2064020640euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553612194;
        bh=ML268ItVOEFVucbL4uvAsP7Wz/JvcbM35hNJP3d7Kdc=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=bqksdZA0CM/1nnvCclGyFesWMK4+pakV/3nVrvHcz51FCPCYsRlLMZMAkPRJ01t5H
         417+RDIe/6ahgxTVdj0XdraGPO7GTga1sQk3iYUuaTLgUwtub03KUvawCNYO1mDfW3
         sTJUt0K/EGYTfeYlikv4buG9k9f6iIuqy9/riY2E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190326145633eucas1p2522b726f7db56d8b301e07c6965ab084~Pig7v9rDH0696206962eucas1p2a;
        Tue, 26 Mar 2019 14:56:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DB.CB.04325.0AD3A9C5; Tue, 26
        Mar 2019 14:56:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190326145632eucas1p2a5740d85b87a62f2301fa50319e3371d~Pig7GvLbc3116831168eucas1p23;
        Tue, 26 Mar 2019 14:56:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190326145632eusmtrp156e410099cca81b641aa97ac85815fd6~Pig64p2Pn2793827938eusmtrp1G;
        Tue, 26 Mar 2019 14:56:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-68-5c9a3da0eb51
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.3B.04146.0AD3A9C5; Tue, 26
        Mar 2019 14:56:32 +0000 (GMT)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190326145631eusmtip21337015e0b9eed4d16122531645196bc~Pig5-ORmT2932329323eusmtip2F;
        Tue, 26 Mar 2019 14:56:31 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 0/4] clk/ARM: exynos: Add ADC to Exynos5410 (Odroid XU)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-ID: <f5892978-1cbf-7a79-4036-a34133380137@samsung.com>
Date:   Tue, 26 Mar 2019 15:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-1-krzk@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fO2TmKk+NUfDCpWBc0yKn54YglWQ0GRQX1oVSwmYdpbl42
        NU0ozRQz89bFOaIWluk0TBPTzUuZuVTQ7KKCaYGmZCzvaWma20ny2+95n//z/v8PPBQm7CVc
        qcjoeFYVLVOI+LZ4Xfuv7j26/doQr0WjP9M/N04w99u6CSZv5DvG9PQ8JZmakT6Cmc4ZJpj3
        hrt8RtPTzGMe9ffymN5OCZPR1EYyK33VOKM3LKMDAmnlvUoknRzIIKUN2iFSWqO/xpc+e3hZ
        mlurR9LZmi0nyCDbfeGsIjKRVYkDztpGpJtWydhJPGlx7AWRisxYNrKhgPaFKs08yka2lJAu
        Q1BZVsLnijkED9rKcYtKSM8i6GvwWZ/IrpjCONFjBNUF7QRXmBFoWt4ii4pPe8ON17lWdqSP
        QPGCgW9hJ9oD+v8sWAcwuhyDptYxnqUhoAOgbz7PKsLpnZDWWEta2Jk+DZNfjTincYCO4lEr
        26zFGPw2YzXAaBe4MldOcLwVnpvvWuMBbSah3mzic7kPw8SnCpJjR5gw1f5jN+i6mYNzA+kI
        coyDJFfkI/hs0iFO5Q+vTL1rFtSahQdUGcQWBDoQrnYqOLSHAbMDl8EeCuuKMO5ZAFmZQu6P
        HbCkL+Jx7ArXR1fxfCTSbthMu2Eb7YZttP9tdQjXIxc2Qa2Us+q90ewFT7VMqU6Ilnuei1HW
        oLVD61oxzdej5uWwVkRTSGQnmAJtiJCQJaqTla0IKEzkJBh11oQIBeGy5IusKiZUlaBg1a1o
        M4WLXAQpm74EC2m5LJ6NYtlYVrXe5VE2rqnojeedH6RvXGKcscTRPfTdk3yx3+iQQllg/1Pi
        Hty95HX+0NTBW0uGXP+scT/jgD+vLKilIqyuKCr+w5npkx/djpc6s6fGfSpddtkFaRrEL7Wa
        bcmSqoQUpY5HSCTbDUnFqhlR2u2OxmOl3ZfosaMOyqz2336FbXLh7HC5JtAxU4SrI2TeuzGV
        WvYXnzYPfGQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7oLbGfFGPw9y29x/ctzVov5R86x
        WvQ/fs1scf78BnaLTY+vsVp87LnHanF51xw2ixnn9zFZLL1+kcni4ilXi9a9R9gt/l3byGKx
        atcfRgdejzXz1jB6vL/Ryu6xc9Zddo9NqzrZPDYvqffo27KK0ePzJrkA9ig9m6L80pJUhYz8
        4hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jObj/9kL3rNU/Hh2gLWB
        8S1zFyMnh4SAiUTX6g9ANheHkMBSRom1K16wdjFyACWkJOa3KEHUCEv8udbFBlHzmlHiYtNz
        NpAEm4ChRO/RPkYQW1jAW2Lm911gcREBTYnrf7+zgjQwC6xmlpg4bzITRHc7o0TnkwtgVbwC
        dhLXvvaD2SwCqhKNe7awg9iiAhESdy++YIGoEZQ4OfMJmM0JdOrtl5/AtjELqEv8mXeJGcIW
        l2j6spIVwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS
        83M3MQJjeNuxn5t3MF7aGHyIUYCDUYmH10N6VowQa2JZcWXuIUYJDmYlEd4nojNihHhTEiur
        Uovy44tKc1KLDzGaAj03kVlKNDkfmF7ySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGan
        phakFsH0MXFwSjUwSs5aW1z95uSnW8UCm1XYgqb/fW/nKyZVYpIpNJNrc67WqxaGrfOPPH8b
        nWzGJuPCG+/o4H7mZPD8mMO3eF0WXb64Z0fvo3kRPz0+dVaGdNQfF/vZZrPnIeMRvaANRhe0
        DfvnOn78x7o/LrVqkjpbZdPhBTMXi35avdnOuKvV6/uardPVnzzYqMRSnJFoqMVcVJwIAIsi
        45n3AgAA
X-CMS-MailID: 20190326145632eucas1p2a5740d85b87a62f2301fa50319e3371d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212175145epcas4p1760db3c6a3e2497528925d081c12cecc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212175145epcas4p1760db3c6a3e2497528925d081c12cecc
References: <CGME20190212175145epcas4p1760db3c6a3e2497528925d081c12cecc@epcas4p1.samsung.com>
        <20190212175052.6310-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 18:50, Krzysztof Kozlowski wrote:

> The DTS patch depends on bindings header with clock ID.  I will take it
> through samsung-soc for consecutive release.

> Krzysztof Kozlowski (4):
>   dt-bindings: clock: exynos: Put CLK_UART3 in order
>   dt-bindings: clock: exynos: Add ADC clock ID to Exynos5410
>   clk: samsung: exynos5410: Add gate clock for ADC
>   ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU

I have applied first 3 patches to clk/samsung tree, thanks!
With prefix in summary line of the first 2 commits changed to
"clk: samsung: dt-bindings:".

-- 
Regards
Sylwester
