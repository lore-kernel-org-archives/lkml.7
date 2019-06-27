Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E730C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61B52086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nJ9V+QMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfF0LzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:55:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39965 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfF0LzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:55:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627115514euoutp02ba4b78f0e1356a68a95474a5195f3156~sDCLQJG1C1303513035euoutp02h
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:55:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627115514euoutp02ba4b78f0e1356a68a95474a5195f3156~sDCLQJG1C1303513035euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561636514;
        bh=FeZQPqAIyrEaL3SuA1RZalX38vDy0YTh95KqmmaIo+c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nJ9V+QMQAcGxZuQ4ezt2OIUIEJKyV/sPfCDzGRIxfhJipbKtk+4j2omyzNgbKbp3S
         tClx6BMFIMcxDuiTpMdvE1lTOqf3WXqWc49zCbP+jkWvaHxEXZ5fbZCclXqqoTvb99
         p/FJwi5Xr5Oyzh//2OCkFCRu4njA0HhOxAHENIp4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190627115513eucas1p2148bb85cd4267ef45a2e3f940a32a99c~sDCKmImuh0347803478eucas1p2l;
        Thu, 27 Jun 2019 11:55:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3C.CC.04298.1AEA41D5; Thu, 27
        Jun 2019 12:55:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190627115512eucas1p146ab7a53bbaf5c47ed6afa4f42ec697a~sDCJs0-ki0705007050eucas1p1c;
        Thu, 27 Jun 2019 11:55:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190627115512eusmtrp18f320c47b8f02d07b8887fca2acbdee3~sDCJeuobh3136031360eusmtrp1m;
        Thu, 27 Jun 2019 11:55:12 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-d1-5d14aea17fd1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.11.04146.0AEA41D5; Thu, 27
        Jun 2019 12:55:12 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190627115511eusmtip2db30738342a694241f34ee3c0f83d563~sDCI7ma-G0106701067eusmtip2j;
        Thu, 27 Jun 2019 11:55:11 +0000 (GMT)
Subject: Re: [PATCH v6 00/15] tc358767 driver improvements
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d902a0b7-2ac9-96bd-2ff2-e984b4e03bda@samsung.com>
Date:   Thu, 27 Jun 2019 13:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a3fdbb02-586b-66d3-1857-1ed6d90d2537@ti.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87oL14nEGiw5KGzR3GFr0XSogdXi
        x5XDLBYH9xxnsrjy9T2bxYO5N5ksOicuYbe4vGsOm8XdeydYLNbPv8XmwOXxYOp/Jo+ds+6y
        e8zumMnqcb/7OJNH/18Dj+M3tjN5fN4k53Fu6lmmAI4oLpuU1JzMstQifbsErox7dyYwFjxh
        rXjc8pmtgfEISxcjJ4eEgInEjlt72bsYuTiEBFYwSqy+3csK4XxhlOh/uREq85lR4lj/WyaY
        lvc9TVBVyxkltjefYIFw3jJK/Fjfwg5SJSxgJTG5eS4jiC0iUCHx6/o+NpAiZoGFTBJ7rj0C
        284moCnxd/NNNhCbV8BO4vW2/WA2i4CqxIWNb8FqRAUiJL7s3MQIUSMocXLmE7A4J9CCj01f
        wWxmAXmJ7W/nMEPY4hK3nsyHOvUWu8TljYUQtovEivUXGCFsYYlXx7ewQ9gyEqcn90BDo17i
        /ooWZpBDJQQ6GCW2btjJDJGwljh8/CLQzxxACzQl1u/Shwg7Sly6/I4JJCwhwCdx460gxAl8
        EpO2TWeGCPNKdLQJQVQrStw/uxVqoLjE0gtf2SYwKs1C8tgsJM/MQvLMLIS9CxhZVjGKp5YW
        56anFhvmpZbrFSfmFpfmpesl5+duYgQmr9P/jn/awfj1UtIhRgEORiUeXoY9wrFCrIllxZW5
        hxglOJiVRHjzw0RihXhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgsky
        cXBKNTDuuRkYbPelU671RYNP2j3uWUfrGec8Lq7/+XfRheMv5xkXafo5P30R7dARKZ3Ps2Bu
        s7Ypn80HSz6N2VliJ9byfO823KhRPntq8NX2ZyUfQ/PLtvRcWent9GBy0MPsnbyLs7pMhO89
        yxav03nZ5lEr4SGxe9OkJvklp+8tX1l/z431Q3LaTRUlluKMREMt5qLiRABBGWCsWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7oL1onEGhyZJm/R3GFr0XSogdXi
        x5XDLBYH9xxnsrjy9T2bxYO5N5ksOicuYbe4vGsOm8XdeydYLNbPv8XmwOXxYOp/Jo+ds+6y
        e8zumMnqcb/7OJNH/18Dj+M3tjN5fN4k53Fu6lmmAI4oPZui/NKSVIWM/OISW6VoQwsjPUNL
        Cz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYx7dyYwFjxhrXjc8pmtgfEISxcjJ4eEgInE
        +54m1i5GLg4hgaWMEns3TmeHSIhL7J7/lhnCFpb4c62LDaLoNaPEjBkTwYqEBawkJjfPZQSx
        RQQqJE73tDCCFDELLGaS2HFvCQtEx0FGiS1zZrKCVLEJaEr83XyTDcTmFbCTeL1tP5jNIqAq
        cWHjW7CbRAUiJGbvamCBqBGUODnzCZjNCbTtY9NXMJtZQF3iz7xLzBC2vMT2t3OgbHGJW0/m
        M01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBitx37uXkH
        46WNwYcYBTgYlXh4V+wUjhViTSwrrsw9xCjBwawkwpsfJhIrxJuSWFmVWpQfX1Sak1p8iNEU
        6LmJzFKiyfnAZJJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGR
        SX/p+dDPV1zZQwRfdp34fCOnO4Hb7Vwfo0sHQ8KLUL7kwMh+7i2X2TYudyhpm+O4zDajg9X6
        9JSwqLCrE3e++LRvptcS16sXf5SJH7vgo3VbJOjUVLblf54lf5q873Or3folTe8FfhZINRT3
        suYyx4VrzTG1zhDctV1qb05SpaDWsrcPvzQpsRRnJBpqMRcVJwIAAAGKce4CAAA=
X-CMS-MailID: 20190627115512eucas1p146ab7a53bbaf5c47ed6afa4f42ec697a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627102712epcas1p1d6182a13af3efaaaf5d7369f823b0522
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627102712epcas1p1d6182a13af3efaaaf5d7369f823b0522
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
        <CGME20190627102712epcas1p1d6182a13af3efaaaf5d7369f823b0522@epcas1p1.samsung.com>
        <a3fdbb02-586b-66d3-1857-1ed6d90d2537@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2019 12:26, Tomi Valkeinen wrote:
> On 19/06/2019 08:27, Andrey Smirnov wrote:
>> Everyone:
>>
>> This series contains various improvements (at least in my mind) and
>> fixes that I made to tc358767 while working with the code of the
>> driver. Hopefuly each patch is self explanatory.
>>
>> Feedback is welcome!
> I think this looks fine, so:
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
> Unfortunately I don't have my DP equipment for the time being, so I'm 
> not able to test this on our board. I'm fine with merging, as the 
> previous series worked ok after reverting the single regression (which 
> is fixed in this series).
>
>   Tomi
>
Queued to drm-misc-next.


Regards

Andrzej

