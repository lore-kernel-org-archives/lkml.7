Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523552073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1luVdUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfKZLPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:15:09 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44685 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKZLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:15:09 -0500
Received: by mail-yb1-f196.google.com with SMTP id g38so7283077ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 03:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CPxUmxxrz0H0XB9WSkrGE01aU3KDlj9zInkoJCdSrwI=;
        b=V1luVdUV4XJZz94qiIBz2tJ7QVfajnWgLB+RPf3tuqosIVP4fSEVycsb7IB4jp1+gL
         e6Est8fUOmF044UlBzlpXdMYTwKU8j6IKv/CVD+8vMaLEus1ZXImDoWuh/Fl9fVnLF6q
         6qBxgWSIu7MdvCV+Rr8k227Eb08UChBSMQxyyX5nIeKzdaWetG1tT4QeoiaJ76xZQ5oB
         yhedQCP4+Y09aALzMARk6ZY93ngYyUDx7iCRPRC4HCQ9kh+rVHqW+T+CgOOjUpfAw8LD
         sSrVpC8rQQzzW0uZcyb5o76u3HM/8iSY3GePcHey9MUALWuFbioZ16N4w/oPuDHqI8yj
         79jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=CPxUmxxrz0H0XB9WSkrGE01aU3KDlj9zInkoJCdSrwI=;
        b=FWXoXDeaHqdoBshMexZcCfgsqL9y/+9Pw4rcUnMRJViZk1Wwn+a9Y9E+vH4mXs+Ypv
         kDltHbJiZo7bhDnyZ132zoIql0HceEg3NAiR0TLs2CwV2ts4Sx6VW0VI2L8+jqpW/9s8
         fdTr+7/xYBeYWTSRCQuLYLYkGuQlc8JbpxyG2HqXC+8vilSGJjlBaUIzsFOOgr+ZaT3S
         A2KBqhGii9GCkjRKgYqQ8F89VTuwKUxQSVBKZBOQiNrFfINHswPkuMB7C7L2NbECm/Oz
         bwYWkXK99a3SM9tfItHjbs8elunD+N3+9ojzfHx3zKGSXFD8tffkRtWURMPfM1Er0S+R
         yB6Q==
X-Gm-Message-State: APjAAAUu8VrHQQMn078BAopsLF1/IzWlirxVd3e8j6xuBREF/dDLkvvq
        hCLnY7SS4/+7IXUSGGtex94=
X-Google-Smtp-Source: APXvYqxUgfCnoVZSg2eIA2nU2DX4ldVW9HvmRj91bucSmqEaPetNMhcHB+9fveyReW4rS6qYnqxGXA==
X-Received: by 2002:a25:258a:: with SMTP id l132mr28132474ybl.227.1574766906377;
        Tue, 26 Nov 2019 03:15:06 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id j79sm5064019ywa.100.2019.11.26.03.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 03:15:05 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH v2 2/2] drm: share address space for dma bufs
To:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191122063749.27113-1-kraxel@redhat.com>
 <20191122063749.27113-3-kraxel@redhat.com>
 <CAKMK7uFz3hmPT3OE8UtUQwmv+tXsjazUWT2RVHLxAq47X+EaXA@mail.gmail.com>
 <CADnq5_MvOE1Fw7-0g+Fo3Vvvu-c=Z9u+pZUEstv2cVXNKKL2=g@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <805a875c-a43f-556d-db72-3af32e3061d6@gmail.com>
Date:   Tue, 26 Nov 2019 12:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MvOE1Fw7-0g+Fo3Vvvu-c=Z9u+pZUEstv2cVXNKKL2=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.11.19 um 19:21 schrieb Alex Deucher:
> On Fri, Nov 22, 2019 at 4:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Fri, Nov 22, 2019 at 7:37 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> Use the shared address space of the drm device (see drm_open() in
>>> drm_file.c) for dma-bufs too.  That removes a difference betweem drm
>>> device mmap vmas and dma-buf mmap vmas and fixes corner cases like
>>> dropping ptes (using madvise(DONTNEED) for example) not working
>>> properly.
>>>
>>> Also remove amdgpu driver's private dmabuf update.  It is not needed
>>> any more now that we are doing this for everybody.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> But I think you want at least an ack from amd guys for double checking here.
>> -Daniel
> Looks correct to me.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +---
>>>   drivers/gpu/drm/drm_prime.c                 | 4 +++-
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index d5bcdfefbad6..586db4fb46bd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -361,10 +361,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>>>                  return ERR_PTR(-EPERM);
>>>
>>>          buf = drm_gem_prime_export(gobj, flags);
>>> -       if (!IS_ERR(buf)) {
>>> -               buf->file->f_mapping = gobj->dev->anon_inode->i_mapping;
>>> +       if (!IS_ERR(buf))
>>>                  buf->ops = &amdgpu_dmabuf_ops;
>>> -       }
>>>
>>>          return buf;
>>>   }
>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>> index a9633bd241bb..c3fc341453c0 100644
>>> --- a/drivers/gpu/drm/drm_prime.c
>>> +++ b/drivers/gpu/drm/drm_prime.c
>>> @@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv)
>>>   struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>>>                                        struct dma_buf_export_info *exp_info)
>>>   {
>>> +       struct drm_gem_object *obj = exp_info->priv;
>>>          struct dma_buf *dma_buf;
>>>
>>>          dma_buf = dma_buf_export(exp_info);
>>> @@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>>>                  return dma_buf;
>>>
>>>          drm_dev_get(dev);
>>> -       drm_gem_object_get(exp_info->priv);
>>> +       drm_gem_object_get(obj);
>>> +       dma_buf->file->f_mapping = obj->dev->anon_inode->i_mapping;
>>>
>>>          return dma_buf;
>>>   }
>>> --
>>> 2.18.1
>>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

