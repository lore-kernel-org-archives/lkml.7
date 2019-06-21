Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0AAC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F7A21530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dZY/zS5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFUMGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:06:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50735 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFUMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:06:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190621120633euoutp02b745dbb774b1f77130b98d517655dc77~qNUV7Tj_u1628716287euoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 12:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190621120633euoutp02b745dbb774b1f77130b98d517655dc77~qNUV7Tj_u1628716287euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561118793;
        bh=wGGB2gDtNWG7yizzChvNAFBQWnf3VqAELSTaAtE7vS4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dZY/zS5xyTSzY4Fw1J6fjICFzrSSXBGkvtiMgbYHPLeP5fQlv23R0afqRQ/cKP4Hc
         DD0TpkZlMPM1qPNX8IGx1EzNR30d2lhnNdtZ551rQCgDDNxc51NlLKaQGGwxJ32Z0c
         WN6+oriMBtb2EW+RuuKRB09vCjd/bMEGvWigavGg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190621120632eucas1p24898bee4b69c79fb4754857af9460303~qNUVWL4Gl1704417044eucas1p2D;
        Fri, 21 Jun 2019 12:06:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 83.21.04325.848CC0D5; Fri, 21
        Jun 2019 13:06:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190621120631eucas1p1e60ddd1453700646cd5047ad827bc4d4~qNUUiC8Qq1150611506eucas1p1m;
        Fri, 21 Jun 2019 12:06:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190621120631eusmtrp223f06cc93abf6e2f27356ccb6bf424ee~qNUUT_oGx0548605486eusmtrp2L;
        Fri, 21 Jun 2019 12:06:31 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-48-5d0cc8480065
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.21.04146.748CC0D5; Fri, 21
        Jun 2019 13:06:31 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190621120631eusmtip2f1b4a55176fe14258383b48918d52a15~qNUT6JzGS0297302973eusmtip2i;
        Fri, 21 Jun 2019 12:06:31 +0000 (GMT)
Subject: Re: [PATCH][next] video: fbdev: atmel_lcdfb: remove redundant
 initialization to variable ret
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Colin King <colin.king@canonical.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <fae5c288-cf9b-5b54-1aeb-06126f140b84@samsung.com>
Date:   Fri, 21 Jun 2019 14:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612141356.riiesqub4zvxafh3@M43218.corp.atmel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7oeJ3hiDZ5OlbZof7eM3eL36l42
        iytf37NZbL0lbbHp8TVWixN9H1gtLu+aw2bxYu11VovtmxcyO3B6zFtT7TGroZfN4373cSaP
        zUvqPe78WMro8XmTXABbFJdNSmpOZllqkb5dAlfG77mzWAtOslX07L7A1sC4nbWLkYNDQsBE
        4tguni5GLg4hgRWMEm2d65kgnC+MErs2v2CDcD4zSvw4upe9i5ETrGP/+mPMEInljBJX+p+x
        QjhvGSW2v/kMViUskC7xet5PFpCEiEAv0Kw/U8AcZoFpzBLtMxewglSxCVhJTGxfxQhi8wrY
        SeydtIENxGYRUJVYcvcXE4gtKhAhcf/YBlaIGkGJkzOfsIDYnAIuEh+n7wKrYRYQl7j1ZD6U
        LS+x/e0csPskBE6xS1x9s4AN4nAXia9XF7JA2MISr45vgXpIRuL/zvlMEA3rGCX+dryA6t7O
        KLF88j+obmuJw8cvggONWUBTYv0ufYiwo8SKU6uYIGHJJ3HjrSDEEXwSk7ZNZ4YI80p0tAlB
        VKtJbFi2gQ1mbdfOlcwTGJVmIXltFpJ3ZiF5ZxbC3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL
        89L1kvNzNzECE9Tpf8e/7mDc9yfpEKMAB6MSD++BWdyxQqyJZcWVuYcYJTiYlUR4eXJ4YoV4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwzo2zuFO8+thT
        2Qurs459TI1a+Ga22BYFSw+GPJ9nOyst94XIVve/Mjq2fMkk175zNn2rwhZZPPqs3rZOtTrx
        ZqDA6csMIsYT1k74JaS/3XTfc1G2TXGxoqrWn+PXH172SP/5jINlXDLS6eLK7kZOjftbV94X
        dcsXSSl6/GK63ML17cyMvTc/KLEUZyQaajEXFScCAB1Prw9MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7ruJ3hiDU7vVbFof7eM3eL36l42
        iytf37NZbL0lbbHp8TVWixN9H1gtLu+aw2bxYu11VovtmxcyO3B6zFtT7TGroZfN4373cSaP
        zUvqPe78WMro8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
        SmpOZllqkb5dgl7G77mzWAtOslX07L7A1sC4nbWLkZNDQsBEYv/6Y8xdjFwcQgJLGSVad39k
        6mLkAErISBxfXwZRIyzx51oXG0TNa0aJ9utr2EASwgLpEq/n/WQBSYgI9DNKTF4yHaqqiUli
        35QnYA6zwDRmiRnLf7CAtLAJWElMbF/FCGLzCthJ7J20AWwUi4CqxJK7v5hAbFGBCIkz71ew
        QNQISpyc+QTM5hRwkfg4fRdYDbOAusSfeZeYIWxxiVtP5kPF5SW2v53DPIFRaBaS9llIWmYh
        aZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwIjcduzn5h2MlzYGH2IU4GBU4uE9
        MIs7Vog1say4MvcQowQHs5IIL08OT6wQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wOTRV5J
        vKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsaOK8nPPCbG7DLUNrQ4
        fvmG6XpRX4s1DoFnFqq3ZUxfs1nb0IqXY57V+7M/FhRvYUo/zGmo0RP1ODYpbaYUzyHBhgKp
        OWuOr/1SElNXJMJ09ag/2xnOU+0uuyd5KFZt0ky5sPiK+sJvmy/XPD7hfHX/V8teByWG9/3b
        /54UzGYqPHU5zTMs9ooSS3FGoqEWc1FxIgBPO8a23gIAAA==
X-CMS-MailID: 20190621120631eucas1p1e60ddd1453700646cd5047ad827bc4d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190612141513epcas2p32873b9574f918732b4cf8a6838cdd54d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190612141513epcas2p32873b9574f918732b4cf8a6838cdd54d
References: <20190611170913.20913-1-colin.king@canonical.com>
        <37ac8530-6601-a1a0-37e0-8c6d5d1702cd@microchip.com>
        <CGME20190612141513epcas2p32873b9574f918732b4cf8a6838cdd54d@epcas2p3.samsung.com>
        <20190612141356.riiesqub4zvxafh3@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/19 4:13 PM, Ludovic Desroches wrote:
> On Wed, Jun 12, 2019 at 09:55:30AM +0200, Nicolas Ferre - M43238 wrote:
>> On 11/06/2019 at 19:09, Colin King wrote:
>>> External E-Mail
>>>
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently variable ret is being initialized with -ENOENT however that
>>> value is never read and ret is being re-assigned later on. Hence this
>>> assignment is redundant and can be removed.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> Indeed:
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
