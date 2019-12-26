Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 00:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4112B2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 00:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v55O8BmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLZAG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 19:06:58 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40711 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfLZAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 19:06:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so2746494pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 16:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/FW3kEACozvgKmBcos25096FNZIjXneZXPW4dOBNTlA=;
        b=v55O8BmSyuzFp6/zBFvfeg0VpVxbp5G4NMcq2POWBozmlsHuhqf4y3rgbigV36tWX8
         vGGHUQ/cGkmY0+9IqyI4wvLaYQh6GbD/aJRs7zwK+v2QUEJU3/QxtknbAp6IJ4EV6dXb
         ukIjoA+vjPBOXWCByRhgAwl874IgNm81xAp3owhFxjUJRgVSp15lgZQf+2XRGS+1PLDy
         U6g/5eCDwyJQwrq3VkvEecTJsscQLqwy3QdH9HKwg2JhUmBZtrMfwORbfQFLLsXxDVww
         3qrK4/mFQ2YSXZ2jqhNTD6xiKGcZ5M9AYsIvlgUmPe4ch+o1D9bfENEBgorlgQ/5SHfW
         0Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FW3kEACozvgKmBcos25096FNZIjXneZXPW4dOBNTlA=;
        b=CrVtLi91XjRzbp0eDeUeTADLyt9CwqvuCGZSpj7Sm8O9UXnQjfYbXzl51h0C7zxwX8
         tgZm4brIh28mXwu8CPNH2ypiSxO0pkTbVo9ZcX1X5hVVlG4omahuhltEIvhS8dwAF9V1
         a1VcPV9wzONN9dk2w2zEE1HTYdzZ8pxObw1vXnGwXBqg7uWWpixAUkgen4xkEP0FHzBv
         JfzivcimI44jQyGmr/ljaYJ4438PkDWzUb6TDcR3PQ1i1Kq5mBBW8I06GVpfNesGKWm8
         D8jBGJ0LEKbNoIIGcBfRjQ4A9YxiTcI04PJVNU0JjKlmcdp1qGW7UZ555C+OqtgkjTTK
         C0WQ==
X-Gm-Message-State: APjAAAW3U2Hl/IqZiNT5UDDard9OE7P2+86Q6ropv2iUYfErNg5C+tt1
        hALnsn1Snsp278W9NR3V2UXhVA==
X-Google-Smtp-Source: APXvYqxyQe1HAFi8il8420J73gIndj9ejF7wX+TAiHVKpl8Lc8Mt+tKxZuZj8X5sos+cNbKod7EHiw==
X-Received: by 2002:a17:90a:21d1:: with SMTP id q75mr16630643pjc.0.1577318817475;
        Wed, 25 Dec 2019 16:06:57 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b17sm21678657pfb.146.2019.12.25.16.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 16:06:56 -0800 (PST)
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <ad600bac-fd26-2d6b-85e6-372c072be9f5@kernel.dk>
 <20191225183601.mh4doqri6teuf2am@pali>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa5da0c8-a05d-a66f-a629-29cb77417c13@kernel.dk>
Date:   Wed, 25 Dec 2019 17:06:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191225183601.mh4doqri6teuf2am@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/19 11:36 AM, Pali Rohár wrote:
> On Wednesday 25 December 2019 11:26:47 Jens Axboe wrote:
>> On 12/25/19 11:18 AM, Pali Rohár wrote:
>>> Hello Sascha!
>>>
>>> On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
>>>> ata_qc_complete_multiple() is called with a mask of the still active
>>>> tags.
>>>>
>>>> mv_sata doesn't have this information directly and instead calculates
>>>> the still active tags from the started tags (ap->qc_active) and the
>>>> finished tags as (ap->qc_active ^ done_mask)
>>>>
>>>> Since 28361c40368 the hw_tag and tag are no longer the same and the
>>>> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
>>>> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
>>>> started and this will be in done_mask on completion. ap->qc_active ^
>>>> done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
>>>> the internal tag will never be reported as completed.
>>>>
>>>> This is fixed by introducing ata_qc_get_active() which returns the
>>>> active hardware tags and calling it where appropriate.
>>>>
>>>> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
>>>> problem. There is another case in sata_nv that most likely needs fixing
>>>> as well, but this looks a little different, so I wasn't confident enough
>>>> to change that.
>>>
>>> I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
>>> version correctly. More details are in email:
>>>
>>> https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/
>>>
>>> I tried this patch and it fixed above problems with sata_nv.ko. It just
>>> needs small modification (see below).
>>>
>>> So you can add my:
>>>
>>> Tested-by: Pali Rohár <pali.rohar@gmail.com>
>>>
>>> And I hope that patch would be backported to 4.18 and 4.19 stable
>>> branches soon as distributions kernels are broken for machines with
>>> these nvidia sata controllers.
>>>
>>> Anyway, what is that another case in sata_nv which needs to be fixed
>>> too?
>>
>> Thanks for testing, I've applied this for 5.5 and marked it for stable.
> 
> It is this one?
> https://git.kernel.dk/cgit/linux-block/commit/?h=libata-5.5&id=d80f359d0ebddb3ab3e9cc3fe96f244827ae7b09
> 
> Because there is missing EXPORT_SYMBOL_GPL for ata_qc_get_active()
> function as I wrote in previous email.

I missed that, I'll add it. Thanks!

-- 
Jens Axboe

