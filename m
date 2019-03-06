Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DCB20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MQJLkc9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfCFNot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:44:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:43899 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCFNos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:44:48 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190306134445epoutp013ac6c7c97cd6854b7f5e117df4225cff~JYoiEygeg1082310823epoutp01T;
        Wed,  6 Mar 2019 13:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190306134445epoutp013ac6c7c97cd6854b7f5e117df4225cff~JYoiEygeg1082310823epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551879885;
        bh=6duZa4a6laUJqISW9VdHFj6EKyGAejKTKO9V5iOBXqA=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=MQJLkc9TUzj5J+kFNcgvtlydf+pbEKUFVDlzb42Xoh6ppVMkWpPKMS1de36ZPShXV
         qoPwy8tiLXk8ISa53tcWAo4/FMKFOjYNOtByUNetOQFHCG5IuasnLpTZn6aiikrRn5
         zflcixEfBGpt64ZLpK5hTZjuAOGwC5AUazoDK908=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190306134444epcas1p4de505f8c84114b7fe63aba95433e12af~JYohUJD2g2683826838epcas1p4Z;
        Wed,  6 Mar 2019 13:44:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.9F.04206.CCECF7C5; Wed,  6 Mar 2019 22:44:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190306134443epcas1p3369ab4d36dfdf57bab174a23a65ae21b~JYohBoOg01336913369epcas1p39;
        Wed,  6 Mar 2019 13:44:43 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-8a-5c7fcecc8cfd
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.87.04015.BCECF7C5; Wed,  6 Mar 2019 22:44:43 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PNY006UL6656Y20@mmp1.samsung.com>; Wed, 06 Mar 2019 22:44:43 +0900 (KST)
Subject: Re: [PATCH v4 4/8] drivers: devfreq: add DMC driver for Exynos5422
To:     cwchoi00@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
Date:   Wed, 06 Mar 2019 14:44:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
In-reply-to: <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7bCmvu6Zc/UxBssXcVpsnLGe1eL6l+es
        Fs+OalvMP3KO1aL/8Wtmi/PnN7BbnG16w25xq0HGYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP
        3GW3uN24gs2Bz2PnrLvsHptWdbJ5bF5S73Hw3R4mj74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL
        4MponfWXqaBNqGLa4assDYx/eLsYOTkkBEwkWrecZO1i5OIQEtjBKPG85wgzhPOdUeLr60YW
        mKrzs/9AJXYzSkz98oodJMErICjxY/I9sCJmAU2JF18msUAU3WeUeLn0BTNIQljAW2Jtx3Iw
        W0TAQaK34QAbSBGzwFIWiflLt7KBJNgEDCV6j/YxdjFyAE21kzi1gxUkzCKgKjHj4QJGEFtU
        IELi/dPdYMs4BYIlJv7qZYJYLC5x7P5NRghbXuLgledQV/ezSyxcagBhuwB9cxtsvISAtMSl
        o7YQ4WqJXdu7wR6TEOhglGi5sJ0ZImEtcfj4RVaImXwS7772sEL08kp0tAlBmB4Sp/amQLy7
        jEni89bvbBMYZWYhBcsspGCZheTSWUguXcDIsopRLLWgODc9tdiwwFSvODG3uDQvXS85P3cT
        IzjZaFnuYDx2zucQowAHoxIP74TWuhgh1sSy4srcQ4wSHMxKIrzua+pjhHhTEiurUovy44tK
        c1KLDzFKc7AoifOud3COERJITyxJzU5NLUgtgskycXBKNTBmam5hm3tJp/7SSdO9XteWWAdW
        3c5lYRcUq1FrOuykI39zp4DWj+0fn4U/yX0/RYfzhA3njQ0tLsrFPkrhL1vue60JuOVSZLTV
        g+uE4NYvzkoF3UyTdC8Er5o4qePI18layRuuSepPvRp72tPluv8T/xnXLnTfP2qhsuuyqnGu
        2qu8vTcuF15SYinOSDTUYi4qTgQAGo3RHTIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t9jAd3T5+pjDCattLDYOGM9q8X1L89Z
        LZ4d1baYf+Qcq0X/49fMFufPb2C3ONv0ht3iVoOMxabH11gtLu+aw2bxufcIo8WM8/uYLNYe
        uctucbtxBZsDn8fOWXfZPTat6mTz2Lyk3uPguz1MHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+X
        wJXROusvU0GbUMW0w1dZGhj/8HYxcnJICJhInJ/9h7mLkYtDSGAno8Tmt+vYQBK8AoISPybf
        Y+li5OBgFlCXmDIlF6LmIaPEwtbNjCA1wgLeEms7ljOD2CICDhK9DQfYQIqYBVaySGxpWM4G
        0bGCSeLS/gcsIFVsAoYSvUf7GEGm8grYSZzawQoSZhFQlZjxcAHYUFGBCIm7F1+AlXMKBEtM
        Xj2BCcRmFhCXOHb/JiOELS9x8MpzlgmMArOQ3DoL4dZZSDpmIelYwMiyilEytaA4Nz232KjA
        MC+1XK84Mbe4NC9dLzk/dxMjMJ62Hdbq28F4f0n8IUYBDkYlHt4JrXUxQqyJZcWVuYcYJTiY
        lUR43dfUxwjxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7NbUgtQgmy8TBKdXA
        mCIrq9sifX43p+uv86KdWXt7RMsqCrdc3fpc8Jz3nGvb53EIX3OaH3Xw7K1Fi6vCs4+nNV++
        wNHb3fc984ba+SkbhOxe3LyUW9i/Yn1G6tP5zws+bPfeWK6ju+CtdHFy2OE9bSrTrqt+zvnp
        /qUnOyK/emFvBrve6V2hDY0uV5bP/TYz/J7hOiWW4oxEQy3mouJEAOROfCejAgAA
X-CMS-MailID: 20190306134443epcas1p3369ab4d36dfdf57bab174a23a65ae21b
CMS-TYPE: 101P
X-CMS-RootMailID: 20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc
References: <CGME20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc@eucas1p1.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/3/19 13:23, Chanwoo Choi wrote:

> 2019년 2월 2일 (토) 오전 2:42, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:

>> +/**
>> + * exynos5_dmc_pause_on_switching() - Controls a pause feature in DMC
>> + * @dmc:       device which is used for changing this feature
>> + * @set:       a boolean state passing enable/disable request
>> + *
>> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
>> + * changes its configuration. In such situation access to the memory is blocked
>> + * in DMC automatically. This feature is used when clock frequency change
>> + * request appears and touches clock tree.
>> + */
>> +static int exynos5_dmc_pause_on_switching(struct exynos5_dmc *dmc, bool set)
> 
> Don't need to make it as the separate function. It is only used on
> probe() function.

It seems fine to me to have this functionality in a separate function, 
it's self-contained and it's now pretty well documented.

>> +{
>> +       unsigned int val;
>> +
>> +       val = readl(dmc->base_clk + DMC_PAUSE_CTRL);
>> +       if (set)
>> +               val |= DMC_PAUSE_ENABLE;
>> +       else
>> +               val &= ~DMC_PAUSE_ENABLE;
>> +       writel(val, dmc->base_clk + DMC_PAUSE_CTRL);
> 
> The dt-binding file doesn't explain the 'reg' property for 'base_clk'.
> You are missing.
> When I tried to find what are the base address, it is the register map
> of clock-controller.
> This driver accesed the register of clock controller without any
> functions of CCF
> (common clock framework). It is wrong.
> 
> If you need to get the some information of clock, must have to use the CCF.
We talked a little about this issue with Lukasz in person and it looks
like there are some DMC related registers in the clock controller register 
region, I'd say those registers are better handled by the DMC driver rather
than the clocks controller driver. Moreover, we should avoid abusing clk API
for not strictly clocks related functionality as it appears to be above.
It might be more appropriate to add in the dmc DT node a phandle to a regmap
exposed by the clock-controller node. It seems there will be even no single
register that would be shared between the DMC and the clock controller.

-- 
Regards,
Sylwester
