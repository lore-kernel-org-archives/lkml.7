Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E21C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0782089E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="reTgVETB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFEIhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:37:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57158 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFEIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:37:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605083710euoutp01684cdf0efa2dbfe71ceba0928c5d1fd6~lQI9Tn8yn0488204882euoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 08:37:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605083710euoutp01684cdf0efa2dbfe71ceba0928c5d1fd6~lQI9Tn8yn0488204882euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559723830;
        bh=5d9vre/u+8Ue1Oq5sNEu3j1dtfI1UWD3yRhtAQoReV8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=reTgVETBhO413BLXRIOTIF3EJgnMRkjzRfdXUs4fsl9hdH/iOO0sRES9npOAMDele
         xkEybs4UTSjNFNLrtMEFBpwgfMo1ca0mXr5A2LYGcj/RH/TRWsCjfLS6aofvINUcSl
         3D1einTRkvf4eGXBIwtWlkuFeXf7uzuefqe9/cmk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605083709eucas1p2080b9e8e66c56972af41af2aee2fb56e~lQI8drSSa0243702437eucas1p2i;
        Wed,  5 Jun 2019 08:37:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 30.0F.04325.53F77FC5; Wed,  5
        Jun 2019 09:37:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605083708eucas1p167717b5e19fb14bfaabc1e251ed78613~lQI7t79_91613516135eucas1p1x;
        Wed,  5 Jun 2019 08:37:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605083708eusmtrp2ba06a775919e67361682344fd61c50d4~lQI7eQwdj0426104261eusmtrp2j;
        Wed,  5 Jun 2019 08:37:08 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-4d-5cf77f35d42c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.65.04140.43F77FC5; Wed,  5
        Jun 2019 09:37:08 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190605083707eusmtip2bc9be5262e4a7e9a5955cf7508308989~lQI68SKaP0912409124eusmtip28;
        Wed,  5 Jun 2019 08:37:07 +0000 (GMT)
Subject: Re: [PATCH 0/5] Exynos EHCI/OHCI: resolve conflict with the generic
 USB device bindings
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <159510e5-5c10-da2e-4999-7387da26be71@samsung.com>
Date:   Wed, 5 Jun 2019 10:37:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yw1x7eaiu5ch.fsf@mansr.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1daYzAzL6qChXXIjVqGhkiWDGQAiiJuOXfPilTXSUEYi0kBbq
        FqNIcKmIyw9QNBCJShCslCWAstVqERMKAmqQPUjcalQWS0CRdkT5O/fcc965J3kMoeiQ+zEJ
        mhRRqxESlZQnWfV80r4l7OxPVfBMIcGV5ZjkXL61Vc6lF5oozm5/RHMdtbcoLsdeL+Pu3Msg
        uI9WJ+Kcg9kybrqvR85l1Flp7vpUGxXlxXf3nOXNxZcpvuF2Cc1/edlC82Vfq2V8Xq8T8VkV
        xYgfNa+OYfZ7RsSKiQl6URsUecgzfsByBSV/WHui9/Jd2TmUvsqAPBjAofC9vwu5sAIXITB/
        EA3IcxaPIcitddDSMIograVKNuf4MfJNJi3uI3BMDhHS4EDQ3FBHuFRL8GF4nJXhftcHh0G1
        sZ1yiQh8l4BraaWUa0HhEDA4DG7M4kjIf9jkNpB4Hfyofubml2IVjDd0EZLGG17kDpMu7IED
        oNs8Sbswgf0hvTKPkLAvdA/nu88D7KDBWZKJpLt3wdCvW387LIFPtgpawithpmbOkI5gsLWU
        loZMBB3nc/66w+GprV1uQMxsRACYaoMkegcUGawyFw14Ebx1eEtHLIKbVdmERLNw6YJCUq8H
        o+3hv9imtlfEdaQ0zqtmnFfHOK+O8X9uASKLka+YqlPHibqtGvF4oE5Q61I1cYFHktRmNPvV
        Xv62jVej+unDFoQZpPRivwkTKoVc0OtOqi0IGELpwwrvxlQKNlY4eUrUJh3UpiaKOgtawZBK
        X/b0goEDChwnpIjHRDFZ1M5tZYyH3zlU/qknd2FNSSds7y8SFXnvTyQuu5PWl/q9Yzf5RL+4
        Fz8Jia5fPpEU+uDMinvhBVetu2K6NpMBG8Ynjq7ZigabI2yWKLuhiNe+9ud5v0udddvkBT/3
        6/FniPGOPqQPrXuj3tPYOBJcszO8fIrdO3VxX2t94A2yku2cMY2m9W20KUldvBCyidDqhD9R
        2TKqZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7om9d9jDL4uErTYOGM9q8X8I+dY
        LZoXr2ezOH9+A7vF5V1z2CxmnN/HZLFoWSuzxcsjPxgtfjyczmTx594dVovWvUfYLSb8vsDm
        wONx6069x6ZVnWwe++euYfd4c/oUu8fGdzuYPGbf/cHo0bdlFaPH501yARxRejZF+aUlqQoZ
        +cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkPDnUzFrxQrrjbuZSp
        gbFZtouRk0NCwETi07MPTF2MXBxCAksZJVoO/mCFSMhInJzWAGULS/y51sUGUfSaUeJ6721m
        kISwQJLE7r5WRhBbRMBUYsesi2BFzALLmSXaN6xjgehoZJKYcfMjC0gVm4ChRNdbkFGcHLwC
        dhLz1x0E62YRUJH4tOMoWFxUIEair3EFC0SNoMTJmU/AbE4BTYlbm36yg9jMAmYS8zY/ZIaw
        5SWat86GssUlbj2ZzzSBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k
        /NxNjMA43nbs55YdjF3vgg8xCnAwKvHwfkj8FiPEmlhWXJl7iFGCg1lJhDfx9pcYId6UxMqq
        1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hppi8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Yklqdmp
        qQWpRTB9TBycUg2Msz+cXvGiief144X+x1uWCWbN+/z/YUaH6v8jNpWM7ueXtvvb3NauONjy
        KNpryaqwq9udH3PXP/L5rnKUyfpunnTS6SPPE024fmtPWrhW23E+01ZrjhKlktzVfUJMaekH
        xL2Tr/+Yw5JYy7k/wYr/xWatW4Iv60O7XENMlmUdLrXjmbJYd7uUEktxRqKhFnNRcSIAMdTA
        ZvkCAAA=
X-CMS-MailID: 20190605083708eucas1p167717b5e19fb14bfaabc1e251ed78613
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12
References: <CGME20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12@eucas1p1.samsung.com>
        <20190521115849.9882-1-m.szyprowski@samsung.com>
        <yw1xk1ekszo9.fsf@mansr.com>
        <ff3f4b25-cbc0-4195-79b2-c00633f0c79c@samsung.com>
        <yw1x7eaiu5ch.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Måns,

On 2019-05-22 12:54, Måns Rullgård wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> On 2019-05-21 15:30, Måns Rullgård wrote:
>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>> Commit 69bec7259853 ("USB: core: let USB device know device node") added
>>>> support for attaching devicetree node for USB devices. Those nodes are
>>>> children of their USB host controller. However Exynos EHCI and OHCI
>>>> driver bindings already define child-nodes for each physical root hub
>>>> port and assigns respective PHY controller and parameters to them. This
>>>> leads to the conflict. A workaround for it has been merged as commit
>>>> 01d4071486fe ("usb: exynos: add workaround for the USB device bindings
>>>> conflict"), but it disabled support for USB device binding for Exynos
>>>> EHCI/OHCI controllers.
>>>>
>>>> This patchset tries to resolve this binding conflict by changing Exynos
>>>> EHCI/OHCI bindings: PHYs are moved from the sub-nodes to a standard array
>>>> under the 'phys' property. Such solution has been suggested by Måns
>>>> Rullgård in the following thread: https://lkml.org/lkml/2019/5/13/228
>>>>
>>>> To keep everything working during the transitional time, the changes has
>>>> been split into 2 steps. First step (patches 1-3) need to be merged before
>>>> the second one (patches 4-5). Patches from each step can be merged to
>>>> respective trees without any dependencies - the only requirement is that
>>>> second step has to be merged after merging all patches from the first one.
>>>>
>>>> This patchset has been tested on various Exynos4 boards with different
>>>> USB host controller configurations (Odroids family: X2, U3, XU3).
>>>>
>>>> Best regards
>>>> Marek Szyprowski
>>>> Samsung R&D Institute Poland
>>>>
>>>> Marek Szyprowski (5):
>>>>     dt-bindings: switch Exynos EHCI/OHCI bindings to use array of generic
>>>>       PHYs
>>>>     ARM: dts: exynos: Add array of generic PHYs to EHCI/OHCI devices
>>>>     usb: exynos: add support for getting PHYs from the standard dt array
>>>>     ARM: dts: exynos: Remove obsolete port sub-nodes from EHCI/OHCI
>>>>       devices
>>>>     usb: exynos: Remove support for legacy PHY bindings
>>> You could retain compatibility with old devicetrees (which may be
>>> useful) by using the "phys" property if it exists and falling back
>>> on the old method if it doesn't.  Then you would get this sequence
>>> of changes:
>>>
>>> 1. Update binding definition.
>>> 2. Support new binding in driver, with fallback to old.
>>> 3. Switch dts files to new binding.
>> This is exactly what I did in this patchset. Until Patch #5 is applied,
>> Exynos EHCI/OHCI drivers supports both ways of getting PHYs and is fully
>> compatible with existing DTBs. This last patch should be applied at
>> least one release later that the first 3 patches to keep everything
>> working during the -rcX time.
> I'm suggesting you keep the fallback in the driver.  It does no harm,
> and it's contained in one place.
>
> On the dts side, you're adding the new phys property without removing
> the old-style nodes at first.  If you put the driver change first, the
> dts could be switched to the new style in one patch without a confusing
> hybrid ever existing.

This was just a proposed way of applying the patches. We can change the 
order and apply patch #3 first, then in the next kernel release, apply 
patch #2 and #4 together, and the last step, 2 releases later, apply the 
last one. In my proposed approach (apply #2 and #3 together to the 
respective kernel trees for the next release), the final result is 
applied a release earlier.

>> Compatibility with so called old DTBs is not so important, because there
>> are no boards with Exynos4 and Exynos5 SoCs, which would not update DTB
>> together with the kernel zImage. There have been already some
>> significant compatibility breaks related to those SoCs during last years.
> You can't possibly know what's out there.  Besides, isn't the general
> policy to not break compatibility without a very good reason?

There have been already some significant changes and compatibility 
breaks in Exynos DTB ABI and noone complained. We can also ignore 
completely this patchset and keep compatibility with old DTBs just with 
the workaround merged in commit 01d4071486fe18ec91f78725d81c7e46557c629a 
("usb: exynos: add workaround for the USB device bindings conflict")...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

