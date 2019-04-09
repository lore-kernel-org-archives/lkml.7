Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C3CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D04F20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SrOtWYJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDIRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:40:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51089 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfDIRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:40:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190409174028euoutp02c9cf9807201732a90267514379cc0f99~T3yDB2ciZ0803508035euoutp027
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 17:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190409174028euoutp02c9cf9807201732a90267514379cc0f99~T3yDB2ciZ0803508035euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554831628;
        bh=q8jCagjOYv74K7t6WXnZE03GFeaMM94qBS/bC02Xc7o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SrOtWYJbPlFmNjEeHi09MgAvyYXm3ej5N0uiJ4RxQRKqzcJCA+p/Y6mKPVlEkvn8R
         SRJkhp+BZD+Q992abE2KLiM3KN940eVDkcPTwT1O6D5jV0yhkt2Uzw02V5EsZNa1Bd
         vFCNQR5LdogAIYYMs/n4IjqiU7ldPgLHQ40lyDeY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190409174026eucas1p1c61f02c183590be2dceaa6ed07ca1bb7~T3yB1l37T1745917459eucas1p1u;
        Tue,  9 Apr 2019 17:40:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.1F.04377.A09DCAC5; Tue,  9
        Apr 2019 18:40:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190409174025eucas1p11004fb0a23e6f806bd53a4f90b1d6ecc~T3yAtpuB90314803148eucas1p1R;
        Tue,  9 Apr 2019 17:40:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190409174025eusmtrp17b7c96f1e155fa4a39df5a3214c6b3f6~T3yAfjtCF3236732367eusmtrp1q;
        Tue,  9 Apr 2019 17:40:25 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-79-5cacd90ac3df
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.DB.04146.909DCAC5; Tue,  9
        Apr 2019 18:40:25 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190409174024eusmtip2485eb068283d601ddb8af09dec50cb9e~T3x-5QHL01772217722eusmtip2v;
        Tue,  9 Apr 2019 17:40:24 +0000 (GMT)
Subject: Re: [PATCH RFC 4/8] soc: samsung: Add Exynos Adaptive Supply
 Voltage driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b64a8475-a31c-ea25-2d8e-4840daa8a54c@samsung.com>
Date:   Tue, 9 Apr 2019 19:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPevELAn6ZQGKwpTOVdvyevzMmPnsO52VvF-MCk=X3Myhg@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b139260eJ3WnmaUDCEMsw/6cbPSAqkRBBUUVoItvVq4Ldlc
        ZUGWlc1ppg3TWWiZ5RorbZqKZYaZ06YuiTL7UnBYTuafBhJ+lPMq+e+c85zDew68DCHtouTM
        KW0Gp9Oq1AqhmGzo+ONeLx6wJ2y8fzucfVZaQ7H9/p8UW9HeS7E3h8cI1u2upVnH8CeK/dB8
        V8iWul8J2Cft32n2YX+fgP162SpkK5/7afZaSzu9U6K0l9uR0mHLFSrrqrKUBfU2pPztWL2f
        OirensypT53hdBtijotP1j7qJNMn1p5ztLykL6GiMBMSMYC3wKOCadKExIwUWxFMeqxCnvgR
        1JSXzJPfCN4Z/cRCpPtX4/yhGkFj9yeCJz4ELYVfhAFXMD4MTR875hIhOAL6pyeogInALgIa
        LUYycBDiTXDjbQEKYAmOgcoe42yYYUgcDp2tuoC8HMfDYEctxVuCoMvimYuK8AGwegYFAUxg
        GWT7H1M8XgONvrtzhQCP0tBztV7A146DYssAyeNg8DrraR6vApc5n+QDVxDkv/hK86QQwaDz
        HuJd2+CNs48KtCNm59Q0b+DlXdBpy0EBGfAy+OwL4kssg1sNJQQvS8CYI+Xd4TBpK5mvI4c8
        z1+yECnKFk0rWzSnbNGcsv/v3kOkDck4g16Tyuk3a7mzUXqVRm/QpkYlndY40OwHc804/U2o
        eepEG8IMUiyVxJfbE6SU6ow+U9OGgCEUIRJR4qwkSVZlnud0pxN1BjWnb0OhDKmQSS4sGTom
        xamqDC6N49I53cJVwIjkl9CeoTR/dNWIpsIcueK1uyciGq9sMkW3pPsMnDflkFMwOhUaW2Xq
        tIqLXJPqmdY79uJqcoVrd8po0hGzXJ6RvSODPcutjRqJyy2yjL9nmayLB5UaL96HxutkRpE5
        9tvWB2ndT1Ouh+0dUXjedHnDEiN/jMWLzabUytK83i+HFaT+pGrTOkKnV/0Dp46gclwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7qcN9fEGNxsELHYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBa3G1ewWSza+oXd
        onXvEXYHXo8189Ywemxa1cnmsXlJvUffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbFh2gqXgu3rFpr172BsYJyp0MXJySAiY
        SJx5sZ2ti5GLQ0hgKaPEpt2vWLsYOYASUhLzW5QgaoQl/lzrYgOxhQReM0q8mekKYgsLhElc
        3dPGDmKLCGhKXP/7nRVkDrPAaWaJ1W+2sUAM7WCSmLD7MwtIFZuAoUTv0T5GEJtXwE5i0dkO
        NpBlLAIqEif2F4GERQUiJM68X8ECUSIocXLmEzCbUyBQYsWT+0wgNrOAusSfeZeYIWxxiaYv
        K1khbHmJ7W/nME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cT
        IzBatx37uXkH46WNwYcYBTgYlXh4A6aviRFiTSwrrsw9xCjBwawkwssZDxTiTUmsrEotyo8v
        Ks1JLT7EaAr020RmKdHkfGAiySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE
        08fEwSnVwOi9PKcxu1H5kYjyzZCPhTvUvohe3PBD4F+w4c8PZneUtt4qnHs35o3Ulu9XTmuv
        Xb59g7rNOUPJN2dSnJzdO+ayTAmzmNN949GvFws+l28QErR45xPcdnnjGeYlsY8DXN66Ce+f
        9nVq8GcHkxQBwwuVrHpzVbZLS13hNDoYZuXwhXva/dmxO94rsRRnJBpqMRcVJwIAIxiREOwC
        AAA=
X-CMS-MailID: 20190409174025eucas1p11004fb0a23e6f806bd53a4f90b1d6ecc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8
References: <CGME20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8@epcas2p2.samsung.com>
        <20190404171735.12815-1-s.nawrocki@samsung.com>
        <20190404171735.12815-5-s.nawrocki@samsung.com>
        <CAJKOXPevELAn6ZQGKwpTOVdvyevzMmPnsO52VvF-MCk=X3Myhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 12:24, Krzysztof Kozlowski wrote:
> I have a lot of minor nits all around and few more architecture-like comments.
> 
> I think this should be a driver. You initialize it quite late and it
> is required by other drivers (cpufreq, devfreq), not by core.

Thanks for your comments, it helped me to finally get around and convert
this code to proper driver.  The advantage is that it can be more 
reliably ensured that the ASV driver updates OPPs properly after they
have been parsed from DT by cpufreq-dt or other drivers.  And if we 
add support for the Body Bias through regulator API it would be easier
to acquire the regulator resource, i.e. deferred probing could ensure 
proper driver probe ordering.
 
> I would also prefer it to be slightly more generic. I mean, now you
> get the tables from "samsung,exynos-asv-v1" node and then, depending
> on many different compatibles, you do this or that. If it is
> samsung,exynos5800, you call 542x code. If it is hardkernel, you
> assume it is bin2. This will be not easily portable to other Exynos
> chips and other boards (e.g. you need to update the driver for new
> board which is forced to be in bin2).

The bin2 part for Odroid XU3 Lite is really a hack and I wish it was 
not there. It seems there is not enough data fused in the SoC to 
properly detect chips used on XU3 Lite. 

> Instead all this information should come from chipid and/or DT. I

Perhaps we could try to be more generic but I'm afraid in practice 
we will need to have some logic coded in the driver per each SoC type 
anyway. We could probably add DT property in chipid node to provide 
missing data that is normally read from CHIPID registers. The BIN2
flag is really about forcing specific ASV table. The "special group"
quirk means different thing for each SoC type, in case of exynos5422
it's selecting different method of the ASV group decoding.
It's a bit hard to try to put anything in DT with sparse or missing
documentation of such quirks.

> could imagine that the device binds to ASV node and parses its
> properties. Optionally it could bind to chipid... but then you would

The ASV node on older SoCs doesn't correspond to real hardware so
we shouldn't try to bind drivers to it I'd say. The chipid node 
seems a better alternative to me.
I'm thinking about dropping 'asv' node completely. But then the 
table sub-nodes would need to be put into chipid node.

> have two devices on same node. Then depending on the of_device_id
> match, you have all necessary static configuration data (the same as
> PMU driver or all other typical drivers). Dynamic data you read from
> chip id.

I will post next version of the patch series and we could continue
discussion from there, I have switched to of_device_id matching but
left per SoC init function.

> On Thu, 4 Apr 2019 at 19:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>
>> The Adaptive Supply Voltage (ASV) on Exynos SoCs is a technique of adjusting
>> operating points of devices in order to better match actual capabilities
>> of the hardware and optimize power consumption.
>>
>> This patch adds common code for parsing the ASV tables from devicetree
>> and updating CPU OPPs.
>>
>> Also support for Exynos5422/5800 SoC is added, the Exynos5422 specific part
>> of the patch is partially based on code from
>> https://github.com/hardkernel/linux repository, branch odroidxu4-4.14.y,
>> files: arch/arm/mach-exynos/exynos5422-asv.[ch].
>>
>> Tested on Odroid XU3, XU4, XU3 Lite.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---

>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>> index 2905f5262197..4d121984f71a 100644
>> --- a/drivers/soc/samsung/Kconfig
>> +++ b/drivers/soc/samsung/Kconfig
>> @@ -7,6 +7,17 @@ menuconfig SOC_SAMSUNG
>>
>>  if SOC_SAMSUNG
>>
>> +config EXYNOS_ASV
>> +       bool "Exynos Adaptive Supply Voltage support" if COMPILE_TEST
>> +       depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> 
> Why it cannot be compile tested outside of ARM? The PMU driver has
> this constraint because of asm/cputype.h but you probably do not need
> it.

Yes, it's not needed, I will drop the (ARM || ARM64) part in next iteration. 

>> diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
>> new file mode 100644
>> index 000000000000..60532c7eb3aa
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-asv.c
>> @@ -0,0 +1,279 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018 - 2019 Samsung Electronics Co., Ltd.
> 
> Since it is first publish date, copyright should be only 2019....
> unless this was copied from hardkernel repo but then original
> copyright should be included as well.

I will change it to 2019. I have written code in this file from 
scratch by myself. Some reused code is in exynos5422-asv.c, I will 
copy the original copyright notice there, however it is same 
Samsung's copyright notice, only with 2012 date.

-- 
Regards,
Sylwester
