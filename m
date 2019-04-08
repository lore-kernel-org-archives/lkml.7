Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A34C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712A7214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NFb/unR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDHNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:45:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37379 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:45:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so16503019wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RtWYnyl4AamMiOm/8XsxZRnhuOGYgBcAKBQFwoyGdng=;
        b=NFb/unR5T5u49EqhbbwZfvEm1E/DNKCVEEjmaQSeskklLHhkxA+nJOH8ZmtIHjPZGO
         ZMp1t496Fe5YprzBiuEL2vEBqF6X0r3foZ+/blOkOZ70bMzOov1BFX3ShH0978vOVdN6
         wu/M7lefHdF13/R4HQTaD0WiKYFuJ/B+6v1srxpQpVPEQN/4YekKecUQuQXrrQAkT/6r
         etueJin6q98peLYkWVM3xWWKtxv2+aiTJkYwMTOr69KtQs8h+3cSUM78+Cfk5W696zPm
         T+0yCuNDQIKOIXityNU3tfOacW3neRwfxpGQNF0Oqq/W2rcGkmJ7IxFO7qBy/3BQ7fee
         24aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RtWYnyl4AamMiOm/8XsxZRnhuOGYgBcAKBQFwoyGdng=;
        b=KIejcE6hnYpfiUsbdPfYIS8Z98AjkRF8PvBwXvmNM4J760sIYfB/K4QsTVZAq2cN2P
         WigR4wIPwhKFeiWQ7zBVs/BvH68gZUeeSXkzdHSBr9gNQH54o1YmxVspJwtM6D2t+zm/
         1PbZwWNZh9ieBaHPQ/wk/Lw/K3aeQwHRanKakHsHiofq1QEnx3EcGMtEOmyHHb0oCZRP
         hlg6KC/YceZAsNLx/np6mS0T44Tqkz5cyCVCYWrilSlGPfnN6nIvBz1bgqwnVkqyEsKr
         tK+sTJh1kHLcgfCbah8zXHd14Wbzp3Ho3LSXprpYM8arigv5AWRkKm9EC3/g86swbUJr
         3lkQ==
X-Gm-Message-State: APjAAAU+gxQ0oJRNUKWEMF5bWfuTgUPGowOT5HRir7UbpPN2+fK5w3kr
        UW/UXlEwH5gPcyFCg8xF/ht7qg==
X-Google-Smtp-Source: APXvYqzgipnytd7XMmdeahPN5MVmp89wgZ5kGT61qBhZY4PptN85A/OIUhc2Lg0FfEVZeKDp4D5Lgw==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr19135406wrj.134.1554731155232;
        Mon, 08 Apr 2019 06:45:55 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w130sm15722857wma.36.2019.04.08.06.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 06:45:54 -0700 (PDT)
Subject: Re: [Lima] [PATCH -next] MAINTAINERS: mark lima mailing list as
 moderated
To:     Qiang Yu <yuq825@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lima@lists.freedesktop.org
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
 <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
 <054b9d43-cf4e-057d-132d-7c1758956595@baylibre.com>
 <CAKGbVbtok8RUzDqw=WShAHoiLqWLaKA8coKhcW5EPrsHCO89pA@mail.gmail.com>
 <CAKGbVbtpNKxUDRM9nE05gBuS5jwO68wHh0Uq2NsdYX6pdFtxYw@mail.gmail.com>
 <CAKGbVbuT84tS=H9BeOC7OQ8usopqcYjBy5hoMDTzJbCy7KJStw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <763785ea-ab9d-8135-be8d-a9fb8c92884b@baylibre.com>
Date:   Mon, 8 Apr 2019 15:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKGbVbuT84tS=H9BeOC7OQ8usopqcYjBy5hoMDTzJbCy7KJStw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/04/2019 15:19, Qiang Yu wrote:
> Oh, I'm really sorry if I did something wrong to use:
> dim push-branch drm-misc-next
> (Should the committer just use "git push" not the "dim push-branch
> drm-misc-next"?)

I can see your commit just fine on drm-misc-next :

commit 6f61a82507c95f146c4e529d28ef7e5ac93242c9 (HEAD -> drm-misc-next, narmstrong/for-linux-next, narmstrong/drm-misc-next)
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Sun Apr 7 12:12:10 2019 -0700

    MAINTAINERS: mark lima mailing list as moderated

    Note that the lima mailing list is moderated.

    Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
    Cc: Qiang Yu <yuq825@gmail.com>
    Cc: dri-devel@lists.freedesktop.org
    Cc: lima@lists.freedesktop.org
    Signed-off-by: Qiang Yu <yuq825@gmail.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org
    Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

> 
> Because I found the drm-tip repo has been updated also with
> a few commits that I can't find similar ones in the history.
> 
> Could any maintainer help with this?

I also usually use "dim push-branch drm-misc-next", it would not accept
the push if HEAD changed upstream anyway.

Neil

> 
> Thanks,
> Qiang
> 
> On Mon, Apr 8, 2019 at 8:40 PM Qiang Yu <yuq825@gmail.com> wrote:
>>
>> Here's a question first time I use command:
>> dim push-branch drm-misc-next
>>
>> I see it updates both drm-misc-next and for-linux-next branch, is this
>> expected? What's the difference between drm-misc-next/drm-misc-next-fixes
>> and for-linux-next/for-linux-next-fixes?
>>
>> Thanks,
>> Qiang
>>
>> On Mon, Apr 8, 2019 at 8:26 PM Qiang Yu <yuq825@gmail.com> wrote:
>>>
>>> On Mon, Apr 8, 2019 at 8:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> On 08/04/2019 03:37, Qiang Yu wrote:
>>>>> Looks good for me, patch is:
>>>>> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>>>>
>>>> Also:
>>>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>
>>>>>
>>>>> Should I apply this patch to drm-misc in this case? Or this patch will be
>>>>> submitted in other kernel tree and back merged to drm-misc?
>>>>
>>>> You can push it yourself on the drm-misc-next branch now.
>>>>
>>>> (Then you can reply to the original patch when you applied it)
>>>
>>> Thanks for the guidance. I'll push it soon.
>>>
>>> Regards,
>>> Qiang
>>>
>>>>
>>>> Neil
>>>>
>>>>>
>>>>> Regards,
>>>>> Qiang
>>>>>
>>>>> On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>>>
>>>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>>>
>>>>>> Note that the lima mailing list is moderated.
>>>>>>
>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>> Cc: Qiang Yu <yuq825@gmail.com>
>>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>>> Cc: lima@lists.freedesktop.org
>>>>>> ---
>>>>>>  MAINTAINERS |    2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> --- mmotm-2019-0405-1828.orig/MAINTAINERS
>>>>>> +++ mmotm-2019-0405-1828/MAINTAINERS
>>>>>> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
>>>>>>  DRM DRIVERS FOR LIMA
>>>>>>  M:     Qiang Yu <yuq825@gmail.com>
>>>>>>  L:     dri-devel@lists.freedesktop.org
>>>>>> -L:     lima@lists.freedesktop.org
>>>>>> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
>>>>>>  S:     Maintained
>>>>>>  F:     drivers/gpu/drm/lima/
>>>>>>  F:     include/uapi/drm/lima_drm.h
>>>>>>
>>>>>>
>>>>> _______________________________________________
>>>>> lima mailing list
>>>>> lima@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/lima
>>>>>
>>>>

