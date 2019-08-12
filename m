Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58444C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAA520651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eWtIRvBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfHLMPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:15:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56706 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfHLMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:15:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190812121509euoutp01ebe587d09e47c861ef75cde3300fe8dc~6K_sNv0yX0293002930euoutp01s
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:15:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190812121509euoutp01ebe587d09e47c861ef75cde3300fe8dc~6K_sNv0yX0293002930euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565612109;
        bh=0u/y9w2rvvdym5xvaIrY1gwRepAZSskZpLF3d59cS4M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eWtIRvBMqQWjFC4BhJc/UCfEC1snWUoYUtZ/VEeAvY67kqj/RU4cLQGnlWyHJS7+Z
         wOuiPT2TywwBIYTMtl4m3IbwjNbyoDN7OyBVPBuBA4qPKue80SUF9PwYxv0mv0rIOH
         zj3eeBmHeZATQzrG3aLmyg5f/+SxaIw3ZHPHAQFY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190812121507eucas1p1f820f4a0267de436baa908ccf89c48af~6K_rBMefy1201412014eucas1p1e;
        Mon, 12 Aug 2019 12:15:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.96.04469.B48515D5; Mon, 12
        Aug 2019 13:15:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190812121507eucas1p1d1674e81f2a9b98ceb2f258ecdf36333~6K_qWmYz61196911969eucas1p1W;
        Mon, 12 Aug 2019 12:15:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190812121506eusmtrp25153ff64bfcf93589371cc3769f7657a~6K_qIibm22152521525eusmtrp2_;
        Mon, 12 Aug 2019 12:15:06 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-f4-5d51584b595b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.B5.04166.A48515D5; Mon, 12
        Aug 2019 13:15:06 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190812121506eusmtip1b96112f6aa5d802071c73dc0368cda2f~6K_pupoSr3246232462eusmtip1c;
        Mon, 12 Aug 2019 12:15:06 +0000 (GMT)
Subject: Re: [PATCH v4] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <da84c857-2c2d-29ec-5e72-e719277faa2d@samsung.com>
Date:   Mon, 12 Aug 2019 14:15:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <27f3bb2f-e4b8-cfc9-26da-d0984f1bf37b@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju25lnx9HkOA1fTAxnaQVNJaNDpnQxHPSj/JUoolMPTnTTNqeZ
        BMMyRQ0vQcNlKORtVjpMpvMydDOHSYtclkheEpEwzFvDzFseN8l/z/e8z8PzvC8fgfE7XLyJ
        NFk2LZeJMwQ4l60f2rCeuxkTHR88s+tDvZosx6n5iT4W9XzJnxrqmmVRtu4anOpZmkbU94Jl
        FvWiUM25QojM9re4yKCZ5IhsH5Qik7kYiQasViRaa/e9jcdyL6fQGWk5tDwoIpErUfdWoqxf
        xL0t1RSmQna8BLkSQIbCm5FCTgniEnyyGcHslhl3PH4jKP9jcE7WENRNlbEOLA+HZ5yqJgSm
        uUdO1SKC5Y8aNqPyIKPh5VgDh8GepC+sFI4hRoSRegTvRhb2Bzh5CSqLWhCDeWQEfJ3W7vNs
        8hTUm3T7/DEyBqaHdC4OjTsMV8/tBRCEKxkOX8oDGRojvWBirpblwCegc7EGY7KANHGgzrDK
        cdSOhPeNPU7sAQuWDif2gV0DY2YMrQi2i3843Z0Imp7uOO8UBmbLJxcmGSPPQFt3kIO+CsaG
        xv1CQLrB+KK7o4QbVOnVmIPmQfFjvkMdALpGHX4QW2LQYhVIoDm0mebQOppD62j+59Yhdgvy
        opUKaSqtCJHRuUKFWKpQylKFyZnSdrT3l0Z2LKtdyD6aZEIkgQRHebrN2/F8F3GOIk9qQkBg
        Ak9e9vYexUsR592n5ZkJcmUGrTCh4wRb4MXLPzITxydTxdl0Ok1n0fKDKYtw9Vah2opnwmtU
        /jKdbFX5B6ssUTXG2Ls2Y1zoqM1vfuNvUuSujzDqRn+EJIA9u669uLkS1vrEWpocmVBmLPqW
        VltYU9V+x39gHSuYs9f211tiJeH6gcF6orR6PPFzr1y7spp7q/lk22Cfunrnp593W2jTgwvX
        z6cEvj4NMmm6cUAlYCsk4pCzmFwh/gfmwT2zRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7peEYGxButmaFusvtvPZvHs1l4m
        i9nvlS2O7XjEZHF51xw2i93v7zNaPGz6wGQxt3U6uwOHx+Gvm9k8ds66y+5x+Wypx6HDHYwe
        B8+dY/T4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL2P6nomMBe84Kv403GNuYPzK1sXIySEhYCLRfPIBkM3FISSwlFFi3qVfQA4HUEJG
        4vj6MogaYYk/17qgal4zSnT3LmUGSQgLBEosvrqUHcQWEZCT+Nh6lRGkiFlgG6PE12vTGSE6
        FjJJrNh4ghWkik3ASmJi+ypGEJtXwE7i+v2VYN0sAqoSSw5tAIuLCkRInHm/ggWiRlDi5Mwn
        LCAXcQrYSlzrVwcJMwuoS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMQrOQdM9C0jILScssJC0L
        GFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbhtmM/N+9gvLQx+BCjAAejEg/vht8BsUKs
        iWXFlbmHGCU4mJVEeEv+AoV4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5gg8kriDU0NzS0s
        Dc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MPpFXWfXmGwxt+/sUfXaDS4/tWwu
        qkywbGniSt1w7ipv1f9vqwyUov+v7XYpVY1azFDGn8Vme1N/rtpL2wVGitu8fvc9+i/HkTZx
        T5fAz7utPSbNKTOeFT7nnH6hxzJ/1bpl1yqme3CzHpjtUX9m7ew7vFUnVU+7/z46K/9hQ9vy
        qXaHTvOtmqLEUpyRaKjFXFScCADINPD02AIAAA==
X-CMS-MailID: 20190812121507eucas1p1d1674e81f2a9b98ceb2f258ecdf36333
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5
References: <20190811153643.12029-1-max@enpas.org>
        <CGME20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5@epcas1p1.samsung.com>
        <d9fa8aca-62a4-5d4a-b63f-bdd628e6b304@enpas.org>
        <4729c030-549e-8797-f947-1620cd61d516@samsung.com>
        <27f3bb2f-e4b8-cfc9-26da-d0984f1bf37b@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/19 12:55 PM, Max Staudt wrote:
> Hi Bartlomiej,
> 
> Thanks for your feedback!

Hi Max,

> On 08/12/2019 12:42 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> ide/buddha driver cannot be unloaded currently (it lacks module_exit()).
>>
>> [... snip ...]
>>
>> It should work exactly like the old code in case of X-Surf,
>> what do we need to release?
> 
> 
> So what shall I do? Once an X-Surf has been detected, we refuse to
> unload, and therefore we never have to release X-Surf resources?
> That would simplify things a lot.

Yes, it seems to be a simplest solution.

> What's a good way to do that, given that we now have module_exit()> defined and an exit function is void?

What about something like this:

static bool xsurf_present;
...
static int __init pata_buddha_late_init(void)
...
		if (pata_buddha_probe(z, &xsurf_ent) == 0 &&
		    xsurf_present == false)
			xsurf_present = true;
...
static void __exit pata_buddha_exit(void)
...
	if (xsurf_present)
		return -EBUSY;
...

?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
