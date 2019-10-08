Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300F0206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aDHG2U/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJHKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:21:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58985 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfJHKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:21:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191008102103euoutp02bdfd28b39ee09d784b30ec07b9597b9c~LpMWa-fZU2063120631euoutp02F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 10:21:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191008102103euoutp02bdfd28b39ee09d784b30ec07b9597b9c~LpMWa-fZU2063120631euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570530063;
        bh=H/kw4DJsjV6o+Fou4PFGpSHdLnjfelrJIG1q6VWCXCo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aDHG2U/ROaS0gmJ5btjpUc3JM9lbLFY1AUktvjlhaa4jwAuaMzAkdml0HXdnniEle
         XVdfdKCpdxsEJGIL1hAK1tg/1mR2XVcNw92C1RCJ83PXfkfgOTH4IlAtB6TkiIgpgg
         38/6gmRT8pLGkPUQB+taj0cXWpZG1SYdJ8blotOw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191008102103eucas1p2f8e816066d457bfdfad155a023929272~LpMWASsNb0403404034eucas1p24;
        Tue,  8 Oct 2019 10:21:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.C7.04469.F036C9D5; Tue,  8
        Oct 2019 11:21:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191008102102eucas1p1c4bed382d768dbf4f573396be7d7c7ed~LpMVqriML3009830098eucas1p1_;
        Tue,  8 Oct 2019 10:21:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191008102102eusmtrp10c6a09db26174f80b1c35cb53abe54bd~LpMVpyKLu2792727927eusmtrp1i;
        Tue,  8 Oct 2019 10:21:02 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-aa-5d9c630f35a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.05.04117.E036C9D5; Tue,  8
        Oct 2019 11:21:02 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191008102101eusmtip2f43e78fb96e166fe15f5fc269182c3a1~LpMUwx__30418404184eusmtip2d;
        Tue,  8 Oct 2019 10:21:01 +0000 (GMT)
Subject: Re: krzysztof/for-next boot bisection: v5.4-rc1-48-g0bc9c79979ea on
 peach-pi
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b62e8793-a428-6a06-fb30-c0a9c1322fa9@samsung.com>
Date:   Tue, 8 Oct 2019 12:21:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeZQ_hZqUdtFrr-wGiwdM4KVjD_7CArEWhZgo+1EJPqew@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b27uw6n12ntyaxgRNCnSl8vFVZQdCOK6kcfltQtLzPaVLZc
        moH24UfDtLLS1kjNZCFmsszELHJWQ6wtZ01dWZmSWE1JVyZF5bxZ/jvPec7znnPgpQn5iDiU
        Phh/mNfGc2olJSVrnozYFwQeMMVEnCqTYmfHQzG+2NVD4TZvrxgXPbKLccUrK8KfB0sJnPvg
        N8J53Z8IPJJVLcIOR5UEW7pdYtxaZ6JwoeOBCJe1tYhwk9uAcOabAgnOuP9IgnNvOqnVcrbi
        agViB9ozJGxt53XEWspPU2x9nz/72lVPsbevp7EN/fUiNre6HLFDlhlbpNHSlbG8+qCe14ZH
        7ZPGvfx8hkjMC0n+kW0WpaPSQAPyo4FZDOaiTokBSWk5cwOB7esFQhi8CPLvdpPCMISg+HEG
        OX7iuveW8GE5Y0Zwx5gmiDwI3OYfyLcIZnaA58zwmCiE2QZVPx1iHyYYOwk5vcE+TDGRYPAY
        KB+WMVHQ4a4a05PMLPhS3DBmNpmJgTffbYSgCYKmyz1jvB+zFb4YrkqEN2fCXY+JELAC3D1F
        Il8gYMpo6HrqQkLqtZD58DQl4GD4aKuWCDgMmvNzSOHgJIIu+02JMOQgaD1R+Pd6BTTaWkYr
        0KMWc+BWXbhAr4H2+lukjwYmANo9QUKIADhfU0AItAyyM+WCejYYbZX/bBueO4mzSGmcUM04
        oY5xQh3jf99iRJYjBZ+k06h4XWQ8f2ShjtPokuJVCw8kaCxo9EM2/7IN1qKvzv1WxNBI6S9L
        XHAlRi7m9LoUjRUBTShDZDPKCmPkslgu5SivTdirTVLzOiuaRpNKhSx10rvdckbFHeYP8Xwi
        rx3fimi/0HR06WLnte1FLcnrQoMbg0L3Fm/w7tl0tu3DsCrZMnAS31Ns/v5t6pwlbYqd019d
        2ZJvNzffLskujahUL+13nNv4iVt+4v28vjzRMb03latRofnquGWt7cwUU4Ar7HjWi0X6F7uI
        566EafrmZxc61+Pl/dsW72kIryvZ0FPSUdsX7f65Sknq4rjIuYRWx/0BdPAFb4wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4PV2+5DmxBit/61lcunmA1WLqwyds
        Fte/PGe1mH/kHKvFmtuHGC3efFrMbNG37z+jRf/j18wWP9u3MFmcP7+B3WLT42usFpd3zWGz
        mHF+H5PF0usXmSxO3upitGi7N53donXvEXaLvrWX2ByEPNbMW8Po8f5GK7vHjrtLGD02repk
        89jzksfjzrU9bB6bl9R7HHy3h8mjb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaINLYz0DC0t
        9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mq6+6WUu6Bep+N2xnKmBcTF/FyMnh4SAicS1
        3feZuxi5OIQEljJKXPjxjB0iISNxcloDK4QtLPHnWhcbRNFrRomz/SvBioQFwiXe9n5nBrFF
        BIIkOg6sYgOxmQUusEgsm+0PYgsJXGaU6JkAVsMmYCjR9bYLrIZXwE7i5q0NYHEWARWJjwsO
        snQxcnCICsRKbNprBlEiKHFy5hMWEJtTIFDiY9c8dojxZhLzNj9khrDlJba/nQNli0vcejKf
        aQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgelg27GfW3Yw
        dr0LPsQowMGoxMNbqDs7Vog1say4MvcQowQHs5IIr9zSGbFCvCmJlVWpRfnxRaU5qcWHGE2B
        fpvILCWanA9MVXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjX
        nOvNO3ic12ydr+TWo4X+NaF1bdKTfnGmSMteuv46L9OWYfH3HQ87ZhgyCtkvPpLyW7bRdvuq
        pmMhTJwrX1+ZviAuZf20DJXAnN5893Sm5+yh/FxJmxeYWW3c+TXeX6j/xybjL2x1Sj8TeJc1
        MeX++3jlm4sUe9KiiMCb105e1g2UMNjKUanEUpyRaKjFXFScCACSP/8yHQMAAA==
X-CMS-MailID: 20191008102102eucas1p1c4bed382d768dbf4f573396be7d7c7ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191007170946epcas3p2e91287115265a9efc7038b762cc8e17e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191007170946epcas3p2e91287115265a9efc7038b762cc8e17e
References: <5d9a8a3c.1c69fb81.14b6f.10d1@mx.google.com>
        <CGME20191007170946epcas3p2e91287115265a9efc7038b762cc8e17e@epcas3p2.samsung.com>
        <CAJKOXPeZQ_hZqUdtFrr-wGiwdM4KVjD_7CArEWhZgo+1EJPqew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 07.10.2019 19:09, Krzysztof Kozlowski wrote:
> On Mon, 7 Oct 2019 at 02:43, kernelci.org bot <bot@kernelci.org> wrote:
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> krzysztof/for-next boot bisection: v5.4-rc1-48-g0bc9c79979ea on peach-pi
>>
>> Summary:
>>    Start:      0bc9c79979ea Merge branch 'for-v5.5/memory-samsung-dmc-dt' into for-next
>>    Details:    https://protect2.fireeye.com/url?k=57d30a4c-0ab44e6a-57d28103-0cc47a31384a-5c0d93fa4eb95f2e&u=https://kernelci.org/boot/id/5d9a50af59b5141ce5857c07
>>    Plain log:  https://protect2.fireeye.com/url?k=7e18d090-237f94b6-7e195bdf-0cc47a31384a-b693d6da384e8a14&u=https://storage.kernelci.org//krzysztof/for-next/v5.4-rc1-48-g0bc9c79979ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.txt
>>    HTML log:   https://protect2.fireeye.com/url?k=e9c39b5b-b4a4df7d-e9c21014-0cc47a31384a-5f31e671f969cef8&u=https://storage.kernelci.org//krzysztof/for-next/v5.4-rc1-48-g0bc9c79979ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.html
>>    Result:     0899a480ac65 ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800
> Thanks for the report. Marek Szyprowski reported it on last Friday. I
> dropped the patch as of now as it exposes some deadlock in regulator
> code.

Thanks for dropping this patch.

This turned out to be an issue in the regulator core logic, not the 
deadlock as I initially suspected. See 
https://lkml.org/lkml/2019/10/8/265 for more details.

I will send an updated version of this patch, because it turned out that 
the v7 had incorrectly resolved conflicts and in case of Odroids 
coupling were added to wrong regulators, what hide the issue in my 
initial tests on Odroid XU4.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

