Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512EFC47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262E8218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+rwUzEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfKFRT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:19:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37229 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfKFRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:19:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so20931489wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VEFt1uDyCOf9byzc/+I2oUmCLLbN+yoaKtpp3kXStiQ=;
        b=f+rwUzELPTt1/uRn0Z+NUjCwrKfI2KUgy6g4XjIOGJ7T5sRnNKQBsH/l0W5gHHQ79l
         KDRyJNWaDGGvaIQhHmtmUqE5m+CYEdkIYUyNM81xIQiIKiOypKsYybX50uGFCxNihVTV
         YXES3vtJz/ijYeJgc8VkfvdQoordEo2J83rziwHcCmnnyoxoO1SlZKvdeNrUoOJsoac1
         0RT5WZIRU7gbRHLeOVnX/RRoX7lTqPIVh4yRRTqJPArPzU3i5WqPNa5fkWjJ4AaRT2b6
         yqgksH4yvFJEnPu2jHwcBI7oNAU/PPX7p8/ZWlhIDZMUt+ich7OSagC0J9OcHzAE/18V
         PN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VEFt1uDyCOf9byzc/+I2oUmCLLbN+yoaKtpp3kXStiQ=;
        b=nL9nP3AKlIDKXhi9b6IzWm02phMbgTF0CruokMTcBU2lm3FqBoIxxxoCsAHfoiYqX7
         CP6Jr2LQ7CwmcaAz4t+Fa2Dtj5BMfPlypTTjnXn2Ti08y0WR61TEsleSDsm+BAsls5lK
         /rLLWa3qqY07qg6NwCv047+etA6VLPsPyXJM8F1GVVWGQLB8LOLZBlHDeegPSNlS2yez
         eVK7nECpZgmkqUjBB6NSGEyfaFg+TtwBUnysBTgKqg4y1Oqe9evkzAmXr3SWyU8TalDB
         Dx1KqHfnD/RNzzxrcFv0mk7DSAecnNYoR8fjMHh+qcp+thBeOMnSTXkJ6G4ZnPU+y6mr
         IsFw==
X-Gm-Message-State: APjAAAUi9N6YVwevutHXYlL812yr2feLqeZGEKe6FPlPJpZYblJYRxQ+
        Q/WHHUO7ze/KqK+UAiQQNEBaN8fSbfGsHYMuncA=
X-Google-Smtp-Source: APXvYqxQDizOvsmqJu2teV0euv/pULrxf7co2fHWEzPJyNf1zIY7VU9n8EzZ9MflQsAg2oZCeCMFZG7HKHm9BnivS10=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr3712583wrq.40.1573060796240;
 Wed, 06 Nov 2019 09:19:56 -0800 (PST)
MIME-Version: 1.0
References: <1573031685-25969-1-git-send-email-bianpan2016@163.com> <52555cc3-b8ea-63c0-1c8c-ae8318c4f469@amd.com>
In-Reply-To: <52555cc3-b8ea-63c0-1c8c-ae8318c4f469@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Nov 2019 12:19:43 -0500
Message-ID: <CADnq5_NogpdgxHhm-QnJmLBiVFOrjVRSAzfAr1U1YVuSz5CyOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix potential double drop fence reference
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Pan Bian <bianpan2016@163.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:39 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 06.11.19 um 10:14 schrieb Pan Bian:
> > The object fence is not set to NULL after its reference is dropped. As =
a
> > result, its reference may be dropped again if error occurs after that,
> > which may lead to a use after free bug. To avoid the issue, fence is
> > explicitly set to NULL after dropping its reference.
> >
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Applied.  thanks!

Alex

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_test.c
> > index b66d29d5ffa2..b158230af8db 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> > @@ -138,6 +138,7 @@ static void amdgpu_do_test_moves(struct amdgpu_devi=
ce *adev)
> >               }
> >
> >               dma_fence_put(fence);
> > +             fence =3D NULL;
> >
> >               r =3D amdgpu_bo_kmap(vram_obj, &vram_map);
> >               if (r) {
> > @@ -183,6 +184,7 @@ static void amdgpu_do_test_moves(struct amdgpu_devi=
ce *adev)
> >               }
> >
> >               dma_fence_put(fence);
> > +             fence =3D NULL;
> >
> >               r =3D amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
> >               if (r) {
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
