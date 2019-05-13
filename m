Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E68C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02F2208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QgoxxEUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfEMKDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:03:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36746 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfEMKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:03:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190513100321euoutp02b3bcadaeac957f35581436640f716f7a~eNepcnRsl0579705797euoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:03:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190513100321euoutp02b3bcadaeac957f35581436640f716f7a~eNepcnRsl0579705797euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557741801;
        bh=IVyisuCc+JszPY6NcxfHr7roJU9tFZ+A5xwYyJ4aG68=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QgoxxEUSATFPCiMPyDY/wp+qeqY/UeYzRS8tKXdSlqckvscc/FNMK/UsVPU7lE0uy
         i3AX7aCgKXRWJlEtpcLnj5n549kjhmZLgi7d8Sm3c8E9SlgtRcReVvIcRQezaOfpZ/
         PCbB6oVp0BJn1uPHCCgrd6/rA2+m5j2djo8jp1lw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190513100321eucas1p2ccc4a16258b06ca90cf5e9c805092b50~eNeosycRa3209232092eucas1p2E;
        Mon, 13 May 2019 10:03:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.D2.04377.8E049DC5; Mon, 13
        May 2019 11:03:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190513100320eucas1p1fea0b73bdc12f6a0a9456e967a26331c~eNen0RYM21359213592eucas1p1C;
        Mon, 13 May 2019 10:03:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190513100319eusmtrp2f79d552aabf0abe043af66a88aa2071a~eNenkr2q-1629516295eusmtrp2K;
        Mon, 13 May 2019 10:03:19 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-9a-5cd940e8612e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.A3.04146.7E049DC5; Mon, 13
        May 2019 11:03:19 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190513100319eusmtip160e7839a37e04c81293c187ca4c6619b~eNenHPs5I0239002390eusmtip1G;
        Mon, 13 May 2019 10:03:19 +0000 (GMT)
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
To:     Peter Chen <peter.chen@nxp.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5d0abe9c-613c-d39b-6746-78e5e5c2bbc5@samsung.com>
Date:   Mon, 13 May 2019 12:03:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5327FAC12E4A3D403E8D92128B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfXa3u6s0e9wMD1ZKg4zCl4yQC5UYWV6Kwogo1KilFzXnC7tO
        sz5oimYqIfVBnYampqb5ii/T1NDEVVOXGcxMM0O0zIWvYSEz583y2+/8z/8853/goQhpu8iR
        Co+KZVVRCqWctBE29/4yuH31+RB0cKrYla7PrRXRKSW1JG0w1InpobYCks41dAro4rJUgv7W
        s4LolYkcAb36aVTkY82MjCYyDZX3SObFo2diZlb/RszU/9AKmPuNlYhZbHDyFwfYHA1hleFx
        rMrD+5pNWKUhnYyZld2cqZ4XJqFSnIGsKcCHYUw7IbKwFFcgGDVu53kJQXGdXwayWedFBOXV
        v4WbAxV9bQK+UY7gVX8jyRcmBJnLRRtPyfBpKBswkha2x5chx6wXWkwETiGg5X0XYWmQ2BMy
        TBkbJgn2hrTl2nWmKCHeC2k9agvuwEFQvPjXYQev8yY3QljjKzBsnBZYmMDO0GIqIHh2gJHJ
        wo1wgAfEkN/aSvKpfaGqvpfgWQYzukYxz7tgrXVzIAXBxEC1mC+yEAwl5yLedQRe6gZFlkQE
        3g+1bR68fBxmx9oFFhmwLQyb7PgQtvCgOYfgZQmkp0l5twtodDX/1na9fUdkI7lmy2maLedo
        tpyj+b+3CAkrkQOr5iJDWe5QFBvvzikiOXVUqHtwdGQDWv9TerNuSYvaVq93I0wh+TYJnh4O
        kooUcVxCZDcCipDbSwL2rEuSEEXCLVYVfVWlVrJcN9pJCeUOkttWnwOlOFQRy0awbAyr2uwK
        KGvHJFRo61yR7ev2U1I/r61yihhfS/ba99GxJe9cB+MSYdvsc2Hu/NmalbTU702JCycHA+MT
        WUWm0jXG/c4pVUlW026voS9WZ0qfBD9euEQi/cXnD/1ksj7/BCbAeKMzoWK0AyXqlvuOxZzI
        7zX2I+7uPFdubx6feto052bWLhVqrWblQi5M4XmAUHGKP5/wG0FPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7rPHW7GGHx6pGOxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gix8PpzNZ/Ll3h9WB0+PWnXqPTas62Tz2z13D
        7vHm9Cl2j43vdjB59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsaq8x1sBW+EK16t/cjSwLhEoIuRk0NCwERixZldTF2MXBxC
        AksZJSa+uMsEkZCRODmtgRXCFpb4c62LDaLoNaPE7f9T2EASwgJeEsvOXQeyOThEBCIk9lzK
        A6lhFmhmlrjZ0MYOUiMksJ5FYuMmThCbTcBQouttF1gvr4CdRNvX9WC9LAKqEm1HSkHCogIx
        EiembmGHKBGUODnzCQuIzSkQK3Hj+nOw25gFzCTmbX7IDGHLS2x/OwfKFpe49WQ+0wRGoVlI
        2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNz27Gfm3cwXtoYfIhR
        gINRiYdX4PmNGCHWxLLiytxDjBIczEoivFGKQCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3O
        ByaNvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjJFn+H+Vz5l+
        Qf7VMv9Vma9K6v4X1Uy/dm1fl5Fy+qS7x27VHu6ewrXLV6njzZoU2eY9r03cVvts/Z7e0sQ7
        0Ztzuig7w+SWJKMGFwWT4qq+3tp84xX/p2hyiy9WiY+R+mm8odbRlm3W9XUB0RZ/NgbU/9k3
        K5R5f6Nvpt/ehdLRKvwvs95vVGIpzkg01GIuKk4EAD5aYNbiAgAA
X-CMS-MailID: 20190513100320eucas1p1fea0b73bdc12f6a0a9456e967a26331c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>
        <yw1xlfzfv4ol.fsf@mansr.com>
        <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
        <VI1PR04MB5327B425756FA394C51525208B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <3544eb61-2bd8-338d-8d62-d95a775528ef@samsung.com>
        <VI1PR04MB5327FAC12E4A3D403E8D92128B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2019-05-13 11:23, Peter Chen wrote:
>> On 2019-05-13 11:00, Peter Chen wrote:
>>>> On 2019-05-10 05:10, Peter Chen wrote:
>>>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>>>>>> added support for attaching devicetree node for USB devices. The
>>>>>>> mentioned commit however identifies the given USB device node only
>>>>>>> by the
>>>> 'reg'
>>>>>>> property in the host controller children nodes. The USB device
>>>>>>> node however also has to have a 'compatible' property as described
>>>>>>> in Documentation/devicetree/bindings/usb/usb-device.txt. Lack for
>>>>>>> the 'compatible' property check might result in assigning a
>>>>>>> devicetree node, which is not intended to be the proper node for the given
>> USB device.
>>>>>>> This is important especially when USB host controller has
>>>>>>> child-nodes for other purposes. For example, Exynos EHCI and OHCI
>>>>>>> drivers already define child-nodes for each physical root hub port
>>>>>>> and assigns respective PHY controller and parameters for them.
>>>>>>> Those binding predates support for USB devicetree nodes.
>>>>>>>
>>>>>>> Checking for the proper compatibility string allows to mitigate
>>>>>>> the conflict between USB device devicetree nodes and the bindings
>>>>>>> for USB controllers with child nodes. It also fixes the
>>>>>>> side-effect of the other commits, like 01fdf179f4b0 ("usb: core:
>>>>>>> skip interfaces disabled in devicetree"), which incorrectly
>>>>>>> disables some devices on Exynos based boards.
>>>>> Hi Marek,
>>>>>
>>>>> The purpose of your patch is do not set of_node for device under USB
>>>>> controller,
>>>> right?
>>>>
>>>> Right.
>>>>
>>> Do you mind doing it at function exynos_ehci_get_phy of ehci-exynos.c?
>> I don't mind fixing it in ehci-exynos, but frankly so far I have no idea how to do it.
>> The problem is that newly created USB devices get of-node pointer pointing to a
>> node which if not intended for them. How this can be fixed in ehci-exynos?
>>
>   
> Can't be workaround by setting of_node as NULL for EHCI controller or for PHY node at
> exynos_ehci_get_phy?

Ah, such workaround? I will check, but this will need to be done with 
care, because have a side effect for other subsystems like regulators or 
clocks.

BTW, What's wrong with proper, full verification of USB device nodes?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

