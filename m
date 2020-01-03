Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60119C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E3721835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mtsNyc5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgACLiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:38:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45330 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACLiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:38:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103113817euoutp02548e749cb5e5e2e7ed9fefc4302ed03b~mXXnoVACP3129231292euoutp02_
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 11:38:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103113817euoutp02548e749cb5e5e2e7ed9fefc4302ed03b~mXXnoVACP3129231292euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578051497;
        bh=3wVrJk58ujYcC0SWAZQq7JaJrJKFI/5RdfelRon5h8w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mtsNyc5St3E1zv1zj8VpXr7jwy7/z7RjD/9xOZrTBxTUNJ5OOUvI12Wn8WJv6XEJL
         M/JBHajqLk1MhU0OJ7MSaWIMYEVqssQW9F9kHmSsGQNPDebfhjXB8RCzvpEiRcXA0i
         gPVzaQ1QJFSI+HGT8owj8RZtiAt0dMokJaDmh9Rc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200103113817eucas1p101992b02a77358fad7b87f37357d674b~mXXnYKx942509925099eucas1p1E;
        Fri,  3 Jan 2020 11:38:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.D6.61286.9A72F0E5; Fri,  3
        Jan 2020 11:38:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103113816eucas1p1e7b66948c1906507f40b8654d95c341d~mXXnBqWNW2503625036eucas1p1U;
        Fri,  3 Jan 2020 11:38:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103113816eusmtrp2e634830fa606e0348dbc7ec2e41b7a17~mXXnBGtbL0328203282eusmtrp2g;
        Fri,  3 Jan 2020 11:38:16 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-d5-5e0f27a9d2d2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.41.08375.8A72F0E5; Fri,  3
        Jan 2020 11:38:16 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103113816eusmtip1de5bf92e0be7914a8d511a28470a328f~mXXmsOvhe1193211932eusmtip1T;
        Fri,  3 Jan 2020 11:38:16 +0000 (GMT)
Subject: Re: [PATCH 1/3] video: fbdev: mmp: remove duplicated MMP_DISP
 dependency
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <633e4795-b914-e5ff-7121-7339a936e8ba@samsung.com>
Date:   Fri, 3 Jan 2020 12:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0534f6bf-cd94-5416-2d4a-5fc9721aa7ed@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd2V6vxxBtdWC1ncWneO1eLK1/ds
        Fif6PrBaXN41h82BxeN+93Emj74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mpoboko2Mdf8fXx
        XpYGxmc8XYwcHBICJhKfn4d3MXJxCAmsYJTYd3UGM4TzhVFiwfN2VgjnM6PEtZMX2boYOcE6
        Fs+Zzw6RWM4o8WDXVmaQhJDAW0aJ8z/qQcYKCwRLzHylDBIWEVCXmH3yDlgJs0CCxJebn8Fs
        NgEriYntqxhBbF4BO4k103pZQGwWARWJy01TwOKiAhESnx4cZoWoEZQ4OfMJC8h4TgF7if3H
        CiBGikvcejKfCcKWl2jeOhvsAQmBbnaJlxtnQN3sIjF9wwtWCFtY4tXxLewQtozE/50gzSAN
        6xgl/na8gOreziixfPI/qG5riTvnfrGBbGYW0JRYv0sfIuwo0XD5HhMkGPkkbrwVhDiCT2LS
        tunMEGFeiY42IYhqNYkNyzawwazt2rmSeQKj0iwkn81C8s4sJO/MQti7gJFlFaN4amlxbnpq
        sWFearlecWJucWleul5yfu4mRmAqOf3v+KcdjF8vJR1iFOBgVOLhTVDmjxNiTSwrrsw9xCjB
        wawkwlseyBsnxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dU
        A+N6znqGW6nfuBMcz/QdWLRJ5A53SdWBQ5FT1thqya7Ik0g31v+o++n02svF2U+Dny/N0TW8
        2fVx0dsN0yM6X2t3tir4ZVisE/VdEOWiFF7B9v/B3ib1vL1nbM6/nRf1X+jP/fu9YW+mHOx4
        ocyk8veApfB7m4tGTEUHvvY6cP1bZvz2ka7s1PNKLMUZiYZazEXFiQBPpBFfIQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xu7or1PnjDFp+G1vcWneO1eLK1/ds
        Fif6PrBaXN41h82BxeN+93Emj74tqxg9Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mtoboko2Mdf8fXxXpYGxmc8XYycHBICJhKL58xn
        B7GFBJYySuy+zNLFyAEUl5E4vr4MokRY4s+1LrYuRi6gkteMEr/3L2YGqREWCJaY+UoZpEZE
        QF1i9sk7zBA1xxkldp5+CzaTWSBBYtP9qWwgNpuAlcTE9lWMIDavgJ3Emmm9LCA2i4CKxOWm
        KWBxUYEIicM7ZkHVCEqcnPkE7B5OAXuJ/ccKIEaqS/yZd4kZwhaXuPVkPhOELS/RvHU28wRG
        oVlIumchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNn27Gfm3cwXtoY
        fIhRgINRiYc3QZk/Tog1say4MvcQowQHs5IIb3kgb5wQb0piZVVqUX58UWlOavEhRlOg3yYy
        S4km5wPjOq8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2PVyk3n
        DJh4L268K+YukNXiOqX6elShV5KCsfOKZ6rHmPfPLzzx++Wio/sU2DlzdzFP0Lusy5gi5CJs
        s+/jJnvFCUcXJrld8RCqF/qwxWXz3NID0VKX+Ke5h+lVeexw67Zbts3l154HD464OZ5dZPtN
        VPD41UeKzRdZCiW/arje/3H+iFb426dKLMUZiYZazEXFiQAy8NZyswIAAA==
X-CMS-MailID: 20200103113816eucas1p1e7b66948c1906507f40b8654d95c341d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
References: <CGME20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba@eucas1p1.samsung.com>
        <eb28587c-4f8f-f044-1b8b-317a8d7967aa@samsung.com>
        <0534f6bf-cd94-5416-2d4a-5fc9721aa7ed@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 11:55 AM, Andrzej Hajda wrote:
> On 27.06.2019 16:07, Bartlomiej Zolnierkiewicz wrote:
>> This dependency is already present in higher level Kconfig file
>> (drivers/video/fbdev/mmp/Kconfig).
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, I've queued the patch for v5.6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  --
> Regards
> Andrzej
> 
> 
>> ---
>>  drivers/video/fbdev/mmp/fb/Kconfig |    4 ----
>>  drivers/video/fbdev/mmp/hw/Kconfig |    4 ----
>>  2 files changed, 8 deletions(-)
>>
>> Index: b/drivers/video/fbdev/mmp/fb/Kconfig
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/fb/Kconfig
>> +++ b/drivers/video/fbdev/mmp/fb/Kconfig
>> @@ -1,6 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -if MMP_DISP
>> -
>>  config MMP_FB
>>  	tristate "fb driver for Marvell MMP Display Subsystem"
>>  	depends on FB
>> @@ -10,5 +8,3 @@ config MMP_FB
>>  	default y
>>  	help
>>  		fb driver for Marvell MMP Display Subsystem
>> -
>> -endif
>> Index: b/drivers/video/fbdev/mmp/hw/Kconfig
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/hw/Kconfig
>> +++ b/drivers/video/fbdev/mmp/hw/Kconfig
>> @@ -1,6 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -if MMP_DISP
>> -
>>  config MMP_DISP_CONTROLLER
>>  	bool "mmp display controller hw support"
>>  	depends on CPU_PXA910 || CPU_MMP2
>> @@ -16,5 +14,3 @@ config MMP_DISP_SPI
>>  	help
>>  		Marvell MMP display hw controller spi port support
>>  		will register as a spi master for panel usage
>> -
>> -endif
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

