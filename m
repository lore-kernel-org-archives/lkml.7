Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C3C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEEF21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye/pTVYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfJBNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:44:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfJBNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:44:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so19737494wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=swletV/9Ea56z3ErdxOJ1Fe6ppq+ypIuhlo7LrZAw5c=;
        b=Ye/pTVYQXw0AJTkJOM/7eWunxdVfn+VJBs+aoSIrLsjH37amOhRXQKPOAfPqAiSEwS
         fnX+0VGR7GNJhVkHUcwZfFRQ0GH21d5pbZyKi14d5T3IK9JNUbopSmrSOMBmlw1W18Fh
         4ur8+qPD/INvDydn/E3apOl4MyGPUoWnGX17W7nNUBYg1qrrSaVvGbGymwGvz0Gnd0V7
         Ds2CdaKAx7XloBIGaNYR0n4+aYRK5UAmJNRcUeGvQfnswWt36doe450Rc3XtuwWVzeSn
         q4wdIOh3j2ZzDGG/tVeeqnc4iCb8K8+mfDTSoZh3w4aboySiXWFiEZHifXeVTy+g5kO/
         t0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=swletV/9Ea56z3ErdxOJ1Fe6ppq+ypIuhlo7LrZAw5c=;
        b=bJfqCQxMdap5/fWNO2M14m7hC5gAWSkuj1goHGUcI5umSdvlcL4ehM1V8kyTSNrOOG
         NHZejF5Cz+F5V0OfenC6VlgMylYBerEi/rScc3ts0KghZgQeE3ZCkx4UCgJ9t0SBpbbC
         m2Gyj6cXY7ONwUNXe7U/2m2+8RHNbo4MPdfAppSStgsacRT5z7bzU0XGS4z+EA2h6yfF
         pLM0PlG5PygUclzjX3rObfKiPKSubIsKSKpgLY9XLI1ZzCFNLmu//UmEEQKt207/+gRX
         Y8E/gHJErj+zEvik1SBHP0FRGC05MeC+Jnved49TSxco/jlGqXMAfbtu8T2sdJxKXX0w
         pq4Q==
X-Gm-Message-State: APjAAAW/RPaiGOLvXN0BtuU8d2cWol1JDCrTamAHbQZs89ZsWrjrDyE1
        gNs3aX6c4QRH9CPpgIkHySQeu96H/EbillH6/iBAnQ==
X-Google-Smtp-Source: APXvYqxKTxhnpg2AyMrL2X4XJUMdK2yC+342yEmFWr4ij0AFYB9EWXT7uvSApKEavuLbpY+9fKxm56f7a1bxynvf9nQ=
X-Received: by 2002:adf:f287:: with SMTP id k7mr2961045wro.206.1570023883610;
 Wed, 02 Oct 2019 06:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <1569760723-119944-1-git-send-email-yukuai3@huawei.com>
In-Reply-To: <1569760723-119944-1-git-send-email-yukuai3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 09:44:31 -0400
Message-ID: <CADnq5_N9a+s5stOOX8QaMZXWJ680povytY975QvO0Eu7Y=UBYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove set but not used variable 'pipe'
To:     yu kuai <yukuai3@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, yi.zhang@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, zhengbin13@huawei.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 3:03 AM yu kuai <yukuai3@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> rivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
> =E2=80=98amdgpu_gfx_graphics_queue_acquire=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:234:16: warning:
> variable =E2=80=98pipe=E2=80=99 set but not used [-Wunused-but-set-variab=
le]
>
> It is never used, so can be removed.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index f9bef31..c1035a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -231,12 +231,10 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu=
_device *adev)
>
>  void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
>  {
> -       int i, queue, pipe, me;
> +       int i, queue, me;
>
>         for (i =3D 0; i < AMDGPU_MAX_GFX_QUEUES; ++i) {
>                 queue =3D i % adev->gfx.me.num_queue_per_pipe;
> -               pipe =3D (i / adev->gfx.me.num_queue_per_pipe)
> -                       % adev->gfx.me.num_pipe_per_me;
>                 me =3D (i / adev->gfx.me.num_queue_per_pipe)
>                       / adev->gfx.me.num_pipe_per_me;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
