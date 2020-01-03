Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796D1C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4311E206DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GVz1q89G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgACLzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:55:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49508 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:55:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103115546euoutp024971cb1e43605f6c2231b3748172a90a~mXm48Fdid0793407934euoutp02d
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 11:55:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103115546euoutp024971cb1e43605f6c2231b3748172a90a~mXm48Fdid0793407934euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578052547;
        bh=lEKW45zmvnRN0vF53EoEcDpmZafzTqHkiGrjf7zgl9w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GVz1q89GlzWXHqEE+v9uA1KiX1fVhaynsRulZicOaqp/WH91VYS1DmukEJajRYEg0
         oZ0B1l7wUwH//3VBNHxYKZxnznCzkeGyrNygDfSokicPP1uSOiI0f8kwqwtl+yca7c
         uFcCXmBExjxby90I1tl8YRJWJQwSDWrWy3Sqh3ek=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103115546eucas1p20ee271b3660224259fd7bec0bbbb1ff8~mXm4fQDb20639906399eucas1p2D;
        Fri,  3 Jan 2020 11:55:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.18.61286.2CB2F0E5; Fri,  3
        Jan 2020 11:55:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103115545eucas1p168a060a62814c15b9601828d73c198e0~mXm3_CWoN2845928459eucas1p19;
        Fri,  3 Jan 2020 11:55:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103115545eusmtrp29cb448521fdc6bb7c6e4a46b70d267cc~mXm39aYjb1423314233eusmtrp2E;
        Fri,  3 Jan 2020 11:55:45 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-3f-5e0f2bc24421
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.82.08375.1CB2F0E5; Fri,  3
        Jan 2020 11:55:45 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103115545eusmtip14000199567ee48d8f534f8bb71e8e436~mXm3QkXCw2310523105eusmtip1L;
        Fri,  3 Jan 2020 11:55:45 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] fbdev: fbmem: avoid exporting fb_center_logo
To:     Peter Rosin <peda@axentia.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f248b742-37c8-356f-3128-628b578e896e@samsung.com>
Date:   Fri, 3 Jan 2020 12:55:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6cb5ec1b-ae60-5ca4-f0d9-1414f52fed73@axentia.se>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87qHtPnjDB7MFbd4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/R4vePOWwOHB7TDsxm99i8Qsvj0OEORo/73ceZ
        PBb3TWb1+LxJLoAtissmJTUnsyy1SN8ugSuj6ewiloJ+7opvs9cwNjA2cXYxcnJICJhI9C2f
        yd7FyMUhJLCCUWLCi3NQzhdGif7tXYwQzmdGiaYvR4EcDrCWX1OcIOLLGSWur7jJAuG8ZZTY
        MH0FM8hcYQEPif/nZrCC2CICPhIPnv1gAyliFjjDJNF48ioTSIJNwEpiYvsqRhCbV8BO4vCh
        NnYQm0VARWLKsT9gtqhAhMSnB4dZIWoEJU7OfMICYnMC1R9bvgFsGbOAuMStJ/OZIGx5ie1v
        5zCDLJMQOMQucWTSJjaIT10kZvybD2ULS7w6voUdwpaR+L8TpBmkYR2jxN+OF1Dd2xkllk/+
        B9VhLXHn3C82UAAwC2hKrN+lDxF2lJjZ94YZEi58EjfeCkIcwScxadt0qDCvREebEES1msSG
        ZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85
        P3cTIzAxnf53/NMOxq+Xkg4xCnAwKvHwJijzxwmxJpYVV+YeYpTgYFYS4S0P5I0T4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgdH23a+jPV8XuZX5fUhK
        nW64wW1L56HumUmbG6zr3vVZzXT8P7NI0DRE8ohZ3Db+aY7PZ50qYqnsXDAzuJNjylndeZuS
        RNdE3f/+9clB7h8zD757qaJ67LXQnWa1A7P/r1YNnPbJw2VTVjtTqVr4w1mMx0ouV01uNrcU
        fNk08fqtr78WamzZcrpWiaU4I9FQi7moOBEAkVVKBkgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7oHtfnjDLY+Mrd4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/R4vePOWwOHB7TDsxm99i8Qsvj0OEORo/73ceZ
        PBb3TWb1+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUn
        syy1SN8uQS+j6ewiloJ+7opvs9cwNjA2cXYxcnBICJhI/Jri1MXIySEksJRR4vbsIIiwjMTx
        9WUgYQkBYYk/17rYuhi5gEpeM0r8O9nPDJIQFvCQ+H9uBiuILSLgI/Hg2Q+wImaBc0wSe0+0
        QXWsY5I4uWoBO0gVm4CVxMT2VYwgNq+AncThQ21gcRYBFYkpx/6A2aICERKHd8yCqhGUODnz
        CQuIzQlUf2z5BrDNzALqEn/mXYKyxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJG
        llWMIqmlxbnpucWGesWJucWleel6yfm5mxiBUbjt2M/NOxgvbQw+xCjAwajEw5ugzB8nxJpY
        VlyZe4hRgoNZSYS3PJA3Tog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgQkiryTe0NTQ3MLS
        0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo6T6h6B1HcesIjzmfJF32nb0ca/n
        o45p7qzPIow3sV9exVmWd9A2eePNjnu9PzUFjRariHx/WrQzbYNYyeE+7b2MfIsd9oXsO9I0
        fdMzkbxjDz/FHzrUpt5RsfuKiI6D5L4XrM9mzFTz7fx298qizJXXrj1/lqPylLVQX9K+6dST
        pJa/nMv3+iixFGckGmoxFxUnAgBcKJ5A2AIAAA==
X-CMS-MailID: 20200103115545eucas1p168a060a62814c15b9601828d73c198e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829070834epcas1p2dbdbae4159daba3c62057effa46bb4ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829070834epcas1p2dbdbae4159daba3c62057effa46bb4ab
References: <20190827110854.12574-1-peda@axentia.se>
        <20190827110854.12574-4-peda@axentia.se>
        <CAMuHMdVkqX7x_D5nf01s-kE=o+y5OLM-5fd3q=2RDKGTcpCfHg@mail.gmail.com>
        <CGME20190829070834epcas1p2dbdbae4159daba3c62057effa46bb4ab@epcas1p2.samsung.com>
        <6cb5ec1b-ae60-5ca4-f0d9-1414f52fed73@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/19 9:08 AM, Peter Rosin wrote:
> On 2019-08-27 13:35, Geert Uytterhoeven wrote:
>> Hi Peter,
>>
>> On Tue, Aug 27, 2019 at 1:09 PM Peter Rosin <peda@axentia.se> wrote:
>>> The variable is only ever used from fbcon.c which is linked into the
>>> same module. Therefore, the export is not needed.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, patch queued for v5.6 (also sorry for the delay).

>> But note that the same is true for fb_class, so perhaps it can be added
>> (or better, removed ;-)?
> 
> Right. Someone please let me know if 3/3 needs to be extended. I'm also
> happy to just drop it...

Please send incremental patch for fb_class. 

>> Once drivers/staging/olpc_dcon/olpc_dcon.c stops abusing registered_fb[]
>> and num_registered_fb, those can go, too.
>>
>> Does anyone remembe why au1200fb calls fb_prepare_logo() and fb_show_logo()
>> itself?
> 
> Maybe there should be a small drivers/video/fbdev/core/fbmem.h file (or
> something) with these "internal" declarations, to hide some clutter currently
> in include/linux/fb.h?

Sounds like a good idea.

> Feels like that could be done later, after these other cleanups you mention,
> so that the new file has a few more things to declare.
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
