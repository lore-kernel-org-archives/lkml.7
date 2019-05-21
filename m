Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D580C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B7217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD//WTrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfEUI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:59:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:59:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so2066069wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rM29GR+GLJBGbe/X4l+o5HboBDmZQ0NCAg2bSni71Wg=;
        b=XD//WTrHKOB3LOnuShkRM8SfrtkoNTpat43ssMyrfZEqXb+aSoswSAMVJgoOq3NZf4
         aYxhlBupBmACwpwe78IYv67mfL6KKwRasgJU2N2hR1yPkdr1rMIy3r65d/SCBh/XVJ6N
         oeG+C687IwMNUbzXQct4nB7IqEQkAEUY73ii/pFuiaBdRL4C/CQqNdokRcGgR5twcAm+
         0mOE11gu6+MFN0NnsAU33cn3noGlbdIHNFJLBiXAvprf50DcQyTxr6Zy8L4R79Tqw+1w
         ds1vJG4V6LKijZAnRmi98jBqWCTuNRslvvDHTIXE1j8WnH0rD/4hSBRK7yeoYfbelq69
         Jq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=rM29GR+GLJBGbe/X4l+o5HboBDmZQ0NCAg2bSni71Wg=;
        b=MgRYSksm+e3bJcTBS4so5wNvCxAp3657vg26xm1DQMawypcWOuRyrGp3yUr+iVMJDK
         aXaZJJWv4kvtrPn8MZMPVgy1nTvcuC5LIycz7/h2LR+NaEkw2UOc/ql5i102rMLUAjUy
         uq0VfwVpc4blzbffDdo0WXDiN9cxFUlTAdzmDlnkwp4Co+CKSS0ITFhRcHM0piCOBtHm
         PvrFi0hFox/dFwV9isRumlrOO/QEJRiIZyqfkBp6QchVzR/WrkeowoWI8OZBAm51y98M
         OceVC7c6xcKzwr0+EHQ+Kp626S2CMMZDBljHSoENxXgXezeFk4D8jZShpXV26c5kzRAw
         csxA==
X-Gm-Message-State: APjAAAX92zhpwKtYOR1cqqQjNhbVQoTAyEMw9nNKp9kICp005o4xVjkH
        6a1/hN16pk+NUQmRRaVU8m0=
X-Google-Smtp-Source: APXvYqxpI7tzkLKspuFLCiRW/leKiX1O+difohz9rQxKEyaYMt80NYvjUP0bKgL4TGpNJShW7HOEZg==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr2406208wmf.34.1558429149384;
        Tue, 21 May 2019 01:59:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id f20sm2188461wmh.22.2019.05.21.01.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:59:08 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
To:     Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        xiaolinkui <xiaolinkui@kylinos.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190520162807.GE21222@phenom.ffwll.local>
 <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
 <CADnq5_O=PAK3qZJ-kHUX9jQDkmEYOX+iOhOX7gNaaXp+tC7nUg@mail.gmail.com>
 <CAKMK7uHS837L9Ze_K5q-AsFgOtAMD+n_i_Y404BX-_CwJeP08Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <36de7e05-9055-6d8b-fb2c-fa5a4e94274b@gmail.com>
Date:   Tue, 21 May 2019 10:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHS837L9Ze_K5q-AsFgOtAMD+n_i_Y404BX-_CwJeP08Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.05.19 um 09:23 schrieb Daniel Vetter:
> On Tue, May 21, 2019 at 4:33 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Mon, May 20, 2019 at 7:19 PM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
>>> Daniel, what you are talking about is totally wrong.
>>> 1) AFAIK, only one zero-size array can be in the end of a struct.
>>> 2) two struct_size will add up struct itself twice. the sum is wrong then.
>>>
>>> No offense. I can't help feeling lucky that you are in intel.
>> Xinhui,
>>
>> Please keep things civil.  There is no need for comments like this.
> Yeah, this was over the line, thanks Alex for already taking care of
> this. Please note that fd.o mailing lists operate under a CoC:
>
> https://www.freedesktop.org/wiki/CodeOfConduct/

Seconded. I also enjoy the humiliation of other in email, but it doesn't 
helps us getting code written and problems solved in a professional 
environment.

> Wrt the technical comment: I know that you can only do one variable
> sized array, and it must be at the end. But you can put multiple
> structures all within the same allocation. Which is what I thought you
> wanted to do. And my sketch would allow you to do that even if you
> have multiple variable length structures you want to allocate. There's
> plenty examples of this (but open-coded ones) in the kernel.

BTW: Is there actually good documentation how to correctly do the 
variable length array at end of structure thing in the kernel?

I do know that I've seen a lot of different variants like array[] 
array[0] or array[1] and I have also seen a bunch of gcc versions 
failing to generate correct code for some of them.

So we should probably nail down how to do things correctly.

> Except in really hot paths I personally think that that kind of
> trickery isn't worth it.

Well for kmalloc() it's not that much overhead, but with vmalloc that is 
a completely different picture.

Christian.

>
> Cheers, Daniel
>
>> Alex
>>
>>>
>>> 发件人: Daniel Vetter <daniel.vetter@ffwll.ch> 代表 Daniel Vetter <daniel@ffwll.ch>
>>> 发送时间: 2019年5月21日 0:28
>>> 收件人: Pan, Xinhui
>>> 抄送: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airlied@linux.ie; daniel@ffwll.ch; Quan, Evan; xiaolinkui; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
>>> 主题: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
>>>
>>> [CAUTION: External Email]
>>>
>>> On Fri, May 17, 2019 at 04:44:30PM +0000, Pan, Xinhui wrote:
>>>> I am going to put more members which are also array after this struct,
>>>> not only obj[].  Looks like this struct_size did not help on multiple
>>>> array case. Thanks anyway.  ________________________________
>>> You can then add them up, e.g. kmalloc(struct_size()+struct_size(),
>>> GFP_KERNEL), so this patch here still looks like a good idea.
>>>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>
>>> Cheers, Daniel
>>>
>>>> From: xiaolinkui <xiaolinkui@kylinos.cn>
>>>> Sent: Friday, May 17, 2019 4:46:00 PM
>>>> To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airlied@linux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan
>>>> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; xiaolinkui@kylinos.cn
>>>> Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
>>>>
>>>> [CAUTION: External Email]
>>>>
>>>> Use struct_size() helper to keep code simple.
>>>>
>>>> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> index 22bd21e..4717a64 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>>>>          if (con)
>>>>                  return 0;
>>>>
>>>> -       con = kmalloc(sizeof(struct amdgpu_ras) +
>>>> -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT,
>>>> +       con = kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
>>>>                          GFP_KERNEL|__GFP_ZERO);
>>>>          if (!con)
>>>>                  return -ENOMEM;
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>>>
>>> --
>>> Daniel Vetter
>>> Software Engineer, Intel Corporation
>>> http://blog.ffwll.ch
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

