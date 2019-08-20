Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E564C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29AE22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VbbgXlzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHTJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:55:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50842 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfHTJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:55:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820095544euoutp02646bcabd29cdad15516874d33e0e0dbb~8mPQpcaiP1264112641euoutp024
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:55:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820095544euoutp02646bcabd29cdad15516874d33e0e0dbb~8mPQpcaiP1264112641euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566294944;
        bh=DkMyu5ytkH356rgkNA6a2eG5i/l4vvZSJP25T3d8BqE=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=VbbgXlztjlr/mo9NZu9+ee6xWeD+wHAQIu4gqG7Swhq0Yf/PkabmnLdJITg+RutMF
         IJadRbBhWiufItHm0sv2SJM0iJW5rjWJ375MqRRdczJiqyfGjM4NwgBQ7Z13P362D7
         3QgAp7U0JlN4JVKlkbT4URAbLgFfYMLxjlwIHIuo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190820095544eucas1p115b3b4033a6db13f8318a0ac493378ad~8mPQQFz5f2216722167eucas1p1V;
        Tue, 20 Aug 2019 09:55:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.43.04469.0A3CB5D5; Tue, 20
        Aug 2019 10:55:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820095543eucas1p27be1ddf1a584d7eeb8df65129240ff6d~8mPPhZ8nz0428804288eucas1p2U;
        Tue, 20 Aug 2019 09:55:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820095543eusmtrp1d80cd66855a5c6aa519bae3e91ccca07~8mPPTLoi42992929929eusmtrp1s;
        Tue, 20 Aug 2019 09:55:43 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-be-5d5bc3a0b039
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 19.4A.04117.F93CB5D5; Tue, 20
        Aug 2019 10:55:43 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820095543eusmtip19b2c1fcca1f6f15334a5abb22d0eaf40~8mPPClJCq0394903949eusmtip1I;
        Tue, 20 Aug 2019 09:55:43 +0000 (GMT)
Subject: Re: [PATCH 1/3] video: fbdev: mmp: remove duplicated MMP_DISP
 dependency
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <0534f6bf-cd94-5416-2d4a-5fc9721aa7ed@samsung.com>
Date:   Tue, 20 Aug 2019 11:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101
        Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <eb28587c-4f8f-f044-1b8b-317a8d7967aa@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87oLDkfHGlw5y2mxccZ6VosrX9+z
        WZzo+8BqcXnXHDYHFo/73ceZPPq2rGL0+LxJLoA5issmJTUnsyy1SN8ugStjwodOtoJjvBW7
        Flxka2Ccyd3FyMkhIWAisbN/FjOILSSwglHi4fmYLkYuIPsLo0RD/05GCOczo8Tqc1+ZYDp2
        /P7FCpFYzijRvmodG4TzllGi8/hToCoODmGBYImZr5RB4iICMxglfs3bwwLSzSagKfF38002
        EJtXwE5iy/9FYFNZBFQl3j1+wwpiiwqESaxduJkFokZQ4uTMJ2A2p4C9xKGmZWC3MgvISzRv
        nQ1li0vcejIf6rr/bBJft+ZB2C4SDU8uM0PYwhKvjm9hh7BlJE5P7mGBsOsl7q9oYQY5VEKg
        g1Fi64adUA3WEoePX2QFeYYZ6Oj1u/Qhwo4SDZfvgf0oIcAnceOtIMQJfBKTtk1nhgjzSnS0
        CUFUK0rcP7sVaqC4xNILX9kgbA+J6ec/ME5gVJyF5MlZSB6bheSxWQg3LGBkWcUonlpanJue
        WmyYl1quV5yYW1yal66XnJ+7iRGYTk7/O/5pB+PXS0mHGAU4GJV4eD2mRcUKsSaWFVfmHmKU
        4GBWEuGtmAMU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnV
        wJiuG1GeKc532FdYJ5m9cpe9/yOOltgvzwNTr1td67u4Irp3+tesYrlD/7J0Fuyokw65FdH7
        NEqpQu+ChGDLhTX3NF4Wyhpd7WDUsAj+vOj6ZPYrVj+LJQ/sXn7qlJFwk3w2x5WOQg23gqB6
        nuu/KjZI9kss+5Y4MWLzq9/XAi0W/clOnm3yTYmlOCPRUIu5qDgRAFcTFIcjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7rzD0fHGrzpFLXYOGM9q8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx4UMnW8Ex3opdCy6yNTDO5O5i5OSQEDCR2PH7
        F2sXIxeHkMBSRolj874yQSTEJXbPf8sMYQtL/LnWxQZR9JpR4tXuSyxdjBwcwgLBEjNfKYPE
        RQRmMEo8PL8QatIkRolnZx4ygnSzCWhK/N18kw3E5hWwk9jyfxHYBhYBVYl3j9+wgtiiAmES
        N+7dY4SoEZQ4OfMJC4jNKWAvcahpGdgVzALqEn/mXYKy5SWat86GssUlbj2ZzzSBUXAWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBo2Xbs55YdjF3vgg8xCnAw
        KvHwekyLihViTSwrrsw9xCjBwawkwlsxByjEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cBI
        ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwLhHMO41w6wG7pKa
        eI1y9k0HGPQf3NiYIuoe4cB/R+P8eg/PVz870ye0JRvcuOd4XZh31ZZ+HtH3NqeueSRE2BZM
        +KDqEdcd33/kzLv6NoZFbYod23YJT7unafVnndcdbd9FMW94df88fu79vVOfvb+pkf3pW8tv
        ec76ivuzdOUdP3n8j93YpcRSnJFoqMVcVJwIAPh34RqsAgAA
X-CMS-MailID: 20190820095543eucas1p27be1ddf1a584d7eeb8df65129240ff6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
References: <CGME20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba@eucas1p1.samsung.com>
        <eb28587c-4f8f-f044-1b8b-317a8d7967aa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2019 16:07, Bartlomiej Zolnierkiewicz wrote:
> This dependency is already present in higher level Kconfig file
> (drivers/video/fbdev/mmp/Kconfig).
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> ---
>  drivers/video/fbdev/mmp/fb/Kconfig |    4 ----
>  drivers/video/fbdev/mmp/hw/Kconfig |    4 ----
>  2 files changed, 8 deletions(-)
>
> Index: b/drivers/video/fbdev/mmp/fb/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/mmp/fb/Kconfig
> +++ b/drivers/video/fbdev/mmp/fb/Kconfig
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -if MMP_DISP
> -
>  config MMP_FB
>  	tristate "fb driver for Marvell MMP Display Subsystem"
>  	depends on FB
> @@ -10,5 +8,3 @@ config MMP_FB
>  	default y
>  	help
>  		fb driver for Marvell MMP Display Subsystem
> -
> -endif
> Index: b/drivers/video/fbdev/mmp/hw/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/mmp/hw/Kconfig
> +++ b/drivers/video/fbdev/mmp/hw/Kconfig
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -if MMP_DISP
> -
>  config MMP_DISP_CONTROLLER
>  	bool "mmp display controller hw support"
>  	depends on CPU_PXA910 || CPU_MMP2
> @@ -16,5 +14,3 @@ config MMP_DISP_SPI
>  	help
>  		Marvell MMP display hw controller spi port support
>  		will register as a spi master for panel usage
> -
> -endif
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


