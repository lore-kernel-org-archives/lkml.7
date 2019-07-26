Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FD9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225420651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FoU0i5Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfGZOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:42:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34131 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbfGZOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:42:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190726144205euoutp013ef0fce0479f39bc9f04793622583d2c~0-BIQxsSf1836518365euoutp01g
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:42:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190726144205euoutp013ef0fce0479f39bc9f04793622583d2c~0-BIQxsSf1836518365euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564152125;
        bh=ZblZaWTmY5WlSFF9U+AKvrQQItNw1TLlK3jegZrPviw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FoU0i5SaH0F0MhvNlL07ROEMeD5P1YHyodOno+FTGXx+XZeBxEb4vy6Ijf+Xw1CZI
         BEWu1z26ROrWBe671QmGCOkPxAlDC6Jb5/XtU4ANC5SAD1ISQ57VvnPofrZ57ykZ4p
         +s/bRZahOfND1kTkFc/y3CqsrkSlr7Er7KASPTL4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190726144204eucas1p29fdfca908afd99f7e8122089ef89dd25~0-BHZqdiu2930529305eucas1p2u;
        Fri, 26 Jul 2019 14:42:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D5.DD.04325.B311B3D5; Fri, 26
        Jul 2019 15:42:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190726144203eucas1p26523f3c212d09825cd4acbd75cc58a5f~0-BGqN2Z92930529305eucas1p2s;
        Fri, 26 Jul 2019 14:42:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190726144203eusmtrp10abf6250d4d73a795302e4390471a3df~0-BGcAggM0432204322eusmtrp1O;
        Fri, 26 Jul 2019 14:42:03 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-90-5d3b113b644c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.1A.04146.B311B3D5; Fri, 26
        Jul 2019 15:42:03 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726144202eusmtip204104652d00728c2685c814d2d167fe2~0-BF5Hisb1184011840eusmtip2b;
        Fri, 26 Jul 2019 14:42:02 +0000 (GMT)
Subject: Re: [PATCH 0/4] video: of: display_timing: Adjust err printing of
 of_get_display_timing()
To:     Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3fe0fa09-5e7f-158e-7551-e15f5c05ddc0@samsung.com>
Date:   Fri, 26 Jul 2019 16:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190723083847.GA32268@ravnborg.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbSyVYRjHu8/z4mGObofmGo11ttqUt+TD4yW9zIdntUqtTWlWR55hHOwc
        Emo7+iCUIlSO9zlzJCLFwRIdco55yZmYKdXKh9RMK7SzUI6H5dvvvq7rf13//3YzhGSWcmZi
        E5J5RYIsXkrbkG395hHPQPvACJ9MFcvmjQyI2L9tBQQ7XPuKZt8uztNsToHGii1a1opY450f
        FDvWWUaz+uIuxE5/MJJsnbkVsebOCpJtqpyiD4u5sQkTwZWqTCTXtVRFch3qaSuuNLuE4t5P
        vKA53dInivt4yyDi7q74cJr74zRnmNSJuF8trqG24TZBUXx87BVe4R18ySZmuLyaTsrBV2vN
        uSIVWrHNRdYMYD8YejwmsrAE1yFofeqZi2zWeAFB3btRUnj8QtBk7kWbimfdQ1aCQotg4U+Q
        MDSHIPOnlrA0HHAUjH4uWmdHfAp6ykbXmcCNBJgq3CxM4wAouFm/tpRhxDgYNEWRljKJd8P3
        htn1WzvwOfjY30xZWIztYaBkhrSwNfaFxfzfGyudYGqmUiSwG+jmygiLH8DFDNzomLYSTIdA
        j7GPEtgBvhmeb9R3wmDhbVIQPEGwkv11Q61DoC1cpYWpQOg1mCiLUwK7Q1Ont1A+AoU5pesB
        ANvB5Jy9YMIO7rU9IISyGLKzJML0HmiubaY3z+Z2PCLykVS9JZp6Sxz1ljjq/3erEFmPnPgU
        pTyaVx5I4FO9lDK5MiUh2utyorwFrX3AwVXDYjt6uRypR5hBUltxqDkgQkLJrijT5HoEDCF1
        FLe2+0dIxFGytHRekXhRkRLPK/XIhSGlTuKMbZ8uSHC0LJmP4/kkXrHZFTHWzirUWBzel3J+
        lyY11cNe29AVMFJKHyOdWiRhaboLbnHqwflqPyKVGg45N/Amw7fEdCbUzeVpvX/G5/DK7ooa
        o97Ow6gJSww7GYxyzuYdvXZc5V6XnjWUFeB3LX9f/umHpLvqule415GDe8qP9p9YHpLXjC85
        1rhmL7y2bVk5FPMFbZeSyhjZ/r2EQin7B4GpE6d8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7rWgtaxBu8bOS16z51ksvi/bSKz
        xdllB9ksrnx9z2bROXEJu8WUP8uZLE70fWC1uLxrDpvFoal7GS3u3jvBYrHi51ZGi5+75rFY
        rJ9/i82B1+PytYvMHrMbLrJ47P22gMVj56y77B6zO2ayety5tofNY/u3B6we97uPM3n0/zXw
        WDLtKpvH8RvbmTw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQyzg7dyFbQadAxbKfXUwNjH95uhg5OSQETCQ27z/D3sXIxSEksJRRYmfH
        X9YuRg6ghIzE8fVlEDXCEn+udbFB1LxmlNjz9hIbSEJYIEXiwqMpzCC2iICvxJaGLywgNrPA
        WmaJnvUSEA3bGCVuH3nJCJJgE7CSmNi+ihFkAa+AncSSKUkgYRYBVYnXayBKRAUiJM68XwE2
        h1dAUOLkzCdgNqeAkcTXCd+ZIearS/yZdwnKFpe49WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJ
        yywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExvy2Yz8372C8tDH4EKMAB6MSD2/A
        T6tYIdbEsuLK3EOMEhzMSiK8W3dYxgrxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAd5ZXE
        G5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYAxwcXI3zvuy8thU9s9u
        n5gqKn28pnPcsvzawXj4/iObmQtUZh31WyfLb/N4yvVHvR0n5vjZXVzTxsqveGWW9ax/XlK+
        Ldrecx49FH/4XbDoVVLSqRI3Xy2WG2867b/IhV827VttnTu14/+l3UUZWds5dwfvqz9wVzNz
        Y8nKiflnWGWqz3pnXFViKc5INNRiLipOBAA7VTcoDwMAAA==
X-CMS-MailID: 20190726144203eucas1p26523f3c212d09825cd4acbd75cc58a5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723084201epcas2p49dff78d4666e1451303afcf8163b2061
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723084201epcas2p49dff78d4666e1451303afcf8163b2061
References: <20190722182439.44844-1-dianders@chromium.org>
        <CGME20190723084201epcas2p49dff78d4666e1451303afcf8163b2061@epcas2p4.samsung.com>
        <20190723083847.GA32268@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 7/23/19 10:38 AM, Sam Ravnborg wrote:
> Hi Dough.
> 
> On Mon, Jul 22, 2019 at 11:24:35AM -0700, Douglas Anderson wrote:
>> As reported by Sam Ravnborg [1], after commit b8a2948fa2b3
>> ("drm/panel: simple: Add ability to override typical timing") we now
>> see a pointless error message printed on every boot for many systems.
>> Let's fix that by adjusting who is responsible for printing error
>> messages when of_get_display_timing() is used.
>>
>> Most certainly we can bikeshed the topic about whether this is the
>> right fix or we should instead add logic to panel_simple_probe() to
>> avoid calling of_get_display_timing() in the case where there is no
>> "panel-timing" sub-node.  If there is consensus that I should move the
>> fix to panel_simple_probe() I'm happy to spin this series.  In that
>> case we probably should _remove_ the extra prints that were already
>> present in the other two callers of of_get_display_timing().
>>
>> While at it, fix a missing of_node_put() found by code inspection.
>>
>> NOTE: amba-clcd and panel-lvds were only compile-tested.
>>
>> [1] https://lkml.kernel.org/r/20190721093815.GA4375@ravnborg.org
>>
>>
>> Douglas Anderson (4):
>>   video: of: display_timing: Add of_node_put() in
>>     of_get_display_timing()
>>   video: of: display_timing: Don't yell if no timing node is present
>>   drm: panel-lvds: Spout an error if of_get_display_timing() gives an
>>     error
>>   video: amba-clcd: Spout an error if of_get_display_timing() gives an
>>     error
> 
> Series looks good - thanks.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> You could consider silencing display_timing as the last patch, but thats
> a very small detail.
> 
> How do we apply these fixes - to drm-misc-next? Bartlomiej?
> 
> No need to go in via drm-misc-fixes as the offending commit is only in
> drm-misc-next.
I've merged the whole series to drm-misc-next, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
