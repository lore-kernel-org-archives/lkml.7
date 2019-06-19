Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A24C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B1D21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ORNIL3it"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbfFSKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:17:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38525 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:17:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190619101712euoutp0142bc37e0e9a27b0081c23e34d0d72bd1~pkiSwQ_bu1372613726euoutp01C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 10:17:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190619101712euoutp0142bc37e0e9a27b0081c23e34d0d72bd1~pkiSwQ_bu1372613726euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560939432;
        bh=YXFbvzejdPmbEVrM6cKmXEXnLbPu0ifyzV0x/PWK4Yc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ORNIL3ituEsJTAA4ZzD4vq3otkUjHNcYF4LqXJdR5tiOW28npNNgVwP6IEiLKQ1+L
         6ctdj7NeQY6i9zyC7H/ZvKLVHXs9aAKL/6edr/pi2SVnda4QGgb3oC2XxHzjPjQou8
         IJF7V6BOeIptWbjjksguaMFWusH8ysIphu6hSQFo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190619101710eucas1p23a6c0f7ae8496fd96174a0cd06a44793~pkiRpeZ520319103191eucas1p2F;
        Wed, 19 Jun 2019 10:17:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.86.04377.6AB0A0D5; Wed, 19
        Jun 2019 11:17:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190619101710eucas1p2fba9c19d5d6193c58efccf839da25498~pkiQ5qTg50521905219eucas1p2r;
        Wed, 19 Jun 2019 10:17:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190619101709eusmtrp14208afc034f27f12829fc05749ca1b99~pkiQrWGTa1096410964eusmtrp1m;
        Wed, 19 Jun 2019 10:17:09 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-1a-5d0a0ba6b53e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.41.04140.5AB0A0D5; Wed, 19
        Jun 2019 11:17:09 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190619101708eusmtip2ff459664db2a7db61c34c4f93e840d13~pkiPuqCeG0678306783eusmtip2X;
        Wed, 19 Jun 2019 10:17:08 +0000 (GMT)
Subject: Re: [RFT 01/10] dt-bindings: gpu: mali: Add Samsung compatibles for
 Midgard and Utgard
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fff4b807-e100-9739-0410-4fe10ec61b37@samsung.com>
Date:   Wed, 19 Jun 2019 12:17:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeBBXd2vhBPq6BMzvdRf1_f8d9Pd=_N1X0chHLVbhi0rQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SZ0xTURj1vtVHsc2laPjiTBo1onFgTLzGEU0czx/G9Q8hWvWJRCimT3DF
        EQiCtSpUjVgHBhVMHUhFlCY1yqqKUhGZDjTQAAKBWsSgddA+VP6de8757jlf8vG0Jocbw8fq
        d4sGvS5OyymZoooB14zcYGX07FLTVHKi6hlFfporFKQgK58lPbkmROr72ljyuyiTJtllVSx5
        87WHI+bmDIaY0nwsOdXSSROX666C2FrqWOIxfWBJjf0iR7Jcjyhyvb6aItXPl5Pn9V6OpDrK
        FKS0K40lv+oKGGK1+xDp8DxlloBw6/ItJPz4bkZCT0OqQnD0X2GEYst7hWCzHuOEB/0fWaH5
        uJMS7l07LLx5mswKJwutSPDaJqwdGalcuE2Mi00SDbMWb1buKGi4RO1KDdl7v7eVOYKuqY0o
        iAc8F4xN6ZwRKXkNvoGg+HsX6xc0uA9B+9vxsuBF8KXOzv2dSLnsRrKQh6AxuXZovBuBqzOb
        8rtCsQ68XxwKPx6Fw6H+5zfWb6LxAAfu9tuMX+BwBBi7jYFvVXgxFBc6AtkMngw296cAPxpH
        QdbDNkb2hMCz860BHITXganmaiCMxhPhQfdFWsZh0NTqL6EcrPqOh7KuPIXcexl0dGYO4VD4
        7CwcwuOg8rSJkQdSEHyquq2QHyYENclZSHYtgFJn9WA9fjAiHPLts2R6KTR6rJyfBqyGhu4Q
        uYQazEXnaJlWQfpRjeyeAhbnnX+xT169pjOQ1jJsNcuwdSzD1rH8z72CGCsKExOl+BhRmqMX
        98yUdPFSoj5m5taEeBsavNzKX86+h8ju21KCMI+0I1XYy0drWF2StC++BAFPa0epglOCojWq
        bbp9+0VDwiZDYpwolaCxPKMNUx0Y8XGjBsfodos7RXGXaPirUnzQmCMonD/Y2VE6l3dviKCC
        DetjqvtetixZ4Umjcdvqx82ZQnBH/6XcVdJs9QW1zZVErwyteuGr/ZAult/0ZOhJ45rEnLMJ
        1jjSWvzbV1DWe7XrWOyA2DZp+6HpVo5aa4h8t331POX8sek5J6PC3ZXSAgcqrzzztq623bTI
        3JQ3afJELSPt0EVMow2S7g/DL6kRtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsVy+t/xe7pLubliDbqWm1j0njvJZPF30jF2
        i40z1rNavF/Ww2hx/ctzVov/2yYyW8w/co7V4srX92wWk+5PYLHoaf/DatH/+DWzxfnzG9gt
        Nj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLU5d/8xm0br3CLvF4TftrBb/rm1ksVi1
        6w+jxcuPJ1gcJDzWzFvD6PH71yRGj/c3Wtk99n5bwOKxc9Zddo9NqzrZPLZ/e8Dqcb/7OJPH
        5iX1HldONLF69G1ZxejxeZNcAE+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWR
        qZK+nU1Kak5mWWqRvl2CXsbGG3OZCloFK7Z+eMLSwLiEr4uRk0NCwESied5Txi5GLg4hgaWM
        Egv+T2WGSMhInJzWwAphC0v8udbFBmILCbxmlHj1NhLEFhZIlPj8aS87iC0ioClx/e93sHpm
        gb9sEnM+KkAMXcsksermBSaQBJuAoUTXW4hBvAJ2Eju37AVrYBFQldj09CFYXFQgRmL/wdss
        EDWCEidnPgGzOQUCJXouL2aCWGAmMW/zQ2YIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQt
        s5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iRGYYLYd+7llB2PXu+BDjAIcjEo8vDs+
        cMQKsSaWFVfmHmKU4GBWEuHlbuaMFeJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YPLLK4k3
        NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXA2OF17m/kuwn9eXFfFn6N
        8BHWLr449ytvUNM1n8SW2zO2SMd7MpeuulfvtEtzaUCbXKdr6wHXRqHMSJW3164Y+m/WEe9S
        PewepfZa2S/q1+vb6Uyz7LW3ZHgYvVTlErjG9Cc+NpR592nx1w9P5HcXZS/ZFCOjvE3QJEKq
        rvirmt2hbPdnoeuUWIozEg21mIuKEwHLczsYRgMAAA==
X-CMS-MailID: 20190619101710eucas1p2fba9c19d5d6193c58efccf839da25498
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c
References: <20190618190534.4951-1-krzk@kernel.org>
        <CGME20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c@epcas2p3.samsung.com>
        <20190618190534.4951-2-krzk@kernel.org>
        <9d16d4f7-8353-e0f0-a005-1b04457d70f0@samsung.com>
        <CAJKOXPeBBXd2vhBPq6BMzvdRf1_f8d9Pd=_N1X0chHLVbhi0rQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2019-06-19 12:08, Krzysztof Kozlowski wrote:
> On Wed, 19 Jun 2019 at 12:01, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Hi Krzysztof,
>>
>> On 2019-06-18 21:05, Krzysztof Kozlowski wrote:
>>> Add vendor compatibles for specific implementation of Mali Utgard
>>> (Exynos3250, Exynos4-family) and Midgard (Exynos5433, Exynos7).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>    Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 1 +
>>>    Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt  | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>>> index e5ad3b2afe17..9b298edec5b2 100644
>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>>> @@ -17,6 +17,7 @@ Required properties:
>>>      * which must be preceded by one of the following vendor specifics:
>>>        + "allwinner,sun50i-h6-mali"
>>>        + "amlogic,meson-gxm-mali"
>>> +    + "samsung,exynos5433-mali"
>>>        + "rockchip,rk3288-mali"
>>>        + "rockchip,rk3399-mali"
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> index ae63f09fda7d..519018cb860b 100644
>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> @@ -17,6 +17,7 @@ Required properties:
>>>          + amlogic,meson8b-mali
>>>          + amlogic,meson-gxbb-mali
>>>          + amlogic,meson-gxl-mali
>>> +      + samsung,exynos3250-mali
>> I would prefer 'samsung,exynos4-mali', because historically Exynos4 was
>> the first SoC with Mali400 and such prefix is already used for many hw
>> blocks.
> Then maybe samsung,exynos4210-mali so it will not be confused with Exynos4415?

Fine for me. Exynos4415 also has Mali400, so don't see any issue here.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

