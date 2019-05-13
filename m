Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B94C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970F520989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jkIHnFAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfEMJIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:08:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51715 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbfEMJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:08:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190513090800euoutp0198fa05a923bf996896b013bccd0b72bd~eMuT6jsmU2036320363euoutp01L
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190513090800euoutp0198fa05a923bf996896b013bccd0b72bd~eMuT6jsmU2036320363euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557738480;
        bh=Fq08IZeMkbWPlHggPgxHGc+e/qdZXUA3mf3ZG0XuWkI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jkIHnFAexvKuKp8u0DETZyiSqPH8eMDqatjvZiLywwkq38OaWlW00gQj/dVQ6+U/6
         qibTop3tozFPUPNdyc2usZOikmVTcfcEM/o6GzCwjisSZCLqgturzNdJ9gwv9yS5GC
         aYpjvAvvL8CCmh8B5DyNlpXJhE9mmlDWF8VaIPFI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190513090759eucas1p1b8c1a2240373ccc6584beb05725a9ed5~eMuTRU8CS0770707707eucas1p1D;
        Mon, 13 May 2019 09:07:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.B8.04377.FE339DC5; Mon, 13
        May 2019 10:07:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190513090758eucas1p191fa38894c793812e5caabb23feb42e1~eMuSfx64v0779207792eucas1p1O;
        Mon, 13 May 2019 09:07:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190513090758eusmtrp2fa3c73a871ce265ffbadd5c29095ada2~eMuSQJAxI1651116511eusmtrp2G;
        Mon, 13 May 2019 09:07:58 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-21-5cd933efd2f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 63.E9.04146.EE339DC5; Mon, 13
        May 2019 10:07:58 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190513090757eusmtip2e80808998a0b027a7785e022a6fb0f8c~eMuRzO_2N3141531415eusmtip2P;
        Mon, 13 May 2019 09:07:57 +0000 (GMT)
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
Message-ID: <3544eb61-2bd8-338d-8d62-d95a775528ef@samsung.com>
Date:   Mon, 13 May 2019 11:07:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5327B425756FA394C51525208B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjt3bfLt+HkdVp70MxaJGg4NYM+MKXIatSf/Cdq1MoPZ7mpm9Os
        H4pm5AjRSLeGpRRorot5ycuS0nlZKc1ygZc0Erzgcl1QytQst0/Lf+d9znnOeQ68JCF6zvEl
        U1SZtFolT5VwBezm3l+2kK8RI4lh0z18qt5Qx6EK7tdxqYGBpzzKbq7gUoaBFyzqXnUhQc12
        LyJqcULPolY+jnEO8WWjY7myBlMRV/byziOebK6/jyer/9LKkhU3mZBsvmHHKV684GASnZqS
        RatDo88KFD8eqtNL8aWKopA8dFeoQ3wS8H5ozB9m6ZCAFOEHCBZ+VrJchAgvIFjJi2OIeQRt
        hUtoY2PZOIMYogZBd37V+roTgaNnyq3yxieg2jbEdWEfHAf61X62S0TgAgJa3ncSLoKLw0Hn
        1LlFQhwNn1cL2S7Mxntg6LtjzZUkt+JEuDe/LvGC17cn3RI+Pg222nKOCxM4AFqcFQSDxTA6
        Wek+CLCNBwPTHwiXD+AYGC9TMA28wWFt4jF4O/xp29AXIJiwPeYxjxsI7PmG9c6R0GV9x3EZ
        ETgI6syhzPgwzI23sxh/Txh2ejE3eMLNZv16rBCuXxMx6kAwWp/8i+18O0iUIIlxUzPjpjbG
        TW2M/3OrENuExLRWo0ymNftUdLZUI1dqtKpk6fk0ZQNa+1L9q9aFVmReOWdBmEQSDyGeGU4U
        ceRZmhylBQFJSHyE8bvWRsIkec5lWp12Rq1NpTUW5EeyJWLhlS2fEkQ4WZ5JX6TpdFq9wbJI
        vm8eCrBcmI6x9+LjpTt1tmf9BlHGyeJXsuaRvuCgN54lZdJjRR1RPNwzGhU7ZKu26LVhVfF7
        zVbz8uC2WUV5+9Tu2DJxnj2pI6Hwt8B54Ghg9i1plLxU3yhQXg3okiz5GXPFzR66lgyHLb+m
        IZIcKq7XfqtVmPz9qSNJ0VMRc4MStkYhDw8m1Br5X0FIjFxOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7rvjG/GGCw9JGqxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gix8PpzNZ/Ll3h9WB0+PWnXqPTas62Tz2z13D
        7vHm9Cl2j43vdjB59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsa31UUFEwUq5nTqNjDO4+1i5OSQEDCR+D3rOWMXIxeHkMBS
        RokrT38yQSRkJE5Oa2CFsIUl/lzrYoMoes0o8fb+GnaQhLCAl8Syc9eBEhwcIgIREnsu5YHU
        MAs0M0vcbGhjh2hYziwx+Vk32CQ2AUOJrrcgkzg5eAXsJF7/a2UBsVkEVCWuf3wFtllUIEbi
        xNQt7BA1ghInZz4Bq+EUiJU4t3Ia2BxmATOJeZsfMkPY8hLb386BssUlbj2ZzzSBUWgWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDI3Hbs5+YdjJc2Bh9iFOBg
        VOLhFXh+I0aINbGsuDL3EKMEB7OSCG+UIlCINyWxsiq1KD++qDQntfgQoynQcxOZpUST84FJ
        I68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6P0T2X+NFW+8l2y
        DPx1ZyUMFm9JdVzVn8Yt/PfWSbvFYvY73kVtKU/Ytkl9XW6D9P/N6VUiFyY1/zXbOSN/2mu7
        Ntn+5FN1u+7oup43NJZNPPTgT+qPM7Z272xde6SuHNyVuvstY/P79db6i3dfaFu26+2yHQfa
        bfU1c5oP64r++dij/8wnZaISS3FGoqEWc1FxIgB8F/r34gIAAA==
X-CMS-MailID: 20190513090758eucas1p191fa38894c793812e5caabb23feb42e1
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2019-05-13 11:00, Peter Chen wrote:
>> On 2019-05-10 05:10, Peter Chen wrote:
>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>>>> added support for attaching devicetree node for USB devices. The
>>>>> mentioned commit however identifies the given USB device node only by the
>> 'reg'
>>>>> property in the host controller children nodes. The USB device node
>>>>> however also has to have a 'compatible' property as described in
>>>>> Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
>>>>> 'compatible' property check might result in assigning a devicetree
>>>>> node, which is not intended to be the proper node for the given USB device.
>>>>>
>>>>> This is important especially when USB host controller has
>>>>> child-nodes for other purposes. For example, Exynos EHCI and OHCI
>>>>> drivers already define child-nodes for each physical root hub port
>>>>> and assigns respective PHY controller and parameters for them. Those
>>>>> binding predates support for USB devicetree nodes.
>>>>>
>>>>> Checking for the proper compatibility string allows to mitigate the
>>>>> conflict between USB device devicetree nodes and the bindings for
>>>>> USB controllers with child nodes. It also fixes the side-effect of
>>>>> the other commits, like 01fdf179f4b0 ("usb: core: skip interfaces
>>>>> disabled in devicetree"), which incorrectly disables some devices on
>>>>> Exynos based boards.
>>> Hi Marek,
>>>
>>> The purpose of your patch is do not set of_node for device under USB controller,
>> right?
>>
>> Right.
>>
> Do you mind doing it at function exynos_ehci_get_phy of ehci-exynos.c?

I don't mind fixing it in ehci-exynos, but frankly so far I have no idea 
how to do it. The problem is that newly created USB devices get of-node 
pointer pointing to a node which if not intended for them. How this can 
be fixed in ehci-exynos?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

