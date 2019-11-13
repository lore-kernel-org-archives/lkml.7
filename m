Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0350E206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsCPK9MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfKMTW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:22:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40795 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfKMTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:22:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so3709412wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 11:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qkdacaVdhS5V1JI0trEPqYF0NgGr5+r4W2AqnZo0b/g=;
        b=OsCPK9MBTPx/N1epP5ySwSXv8jXL9MBO2c6cgnFpGnQDrK4O9vJ4hYcWPMpOqMi5kS
         dNfvRjXyF0fJZMMczbekLSUUcDb9/XQL/y7urvRITxFB2vBreT4wHncx5ZNYi+Wne56q
         EvmYeZQ/WsChHCIqDsczY9KJ9vXp4p6/LHGs/CYJwPQLnZe7tux5ptPGNJY5pCna1Fwj
         3tyiFklfcNtEdJPhbd68gpiQtv/JQxa94pfL6cE7KfHVyd9dgJzB/jqaIP/2qsUqbwxx
         48FnxoP7P3GKjLRcKQpnhEclVI8NKS0k3hbCrBrlRX6ohiLmzgvFaV04iKxyDmje9gyp
         aSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qkdacaVdhS5V1JI0trEPqYF0NgGr5+r4W2AqnZo0b/g=;
        b=EKvzI7vQBrYTt6N74zx6Xe+No6bG8M/I+Pe14H7q2jvIuYW0UEgesS7ZnNTrrbO/gh
         d5MQtJL5XvxgAI9Qe3PU02Pr6lfG4crjW/DOu1kShPOj3C7S6Bw82AOhsXT0GOs1OsaK
         PsjICWLF+5yfIhtAEM9yKyKsAxhfyeLE0kPWY6THEwmJhpPoMTjlsl6X04GkzXAeYSnl
         ysThkVIzj5n3kTDcQHLXzGsjicoyORVTwERxKOavXQDDhjsn8sbtjP/dx+Br0tIxGzLk
         FDbj5w9AjrVN6iCyTjm58BvCnWVjMVJrPapfPfn94lbPi8KRBGMj7l62+36CZBG4UC7o
         As6w==
X-Gm-Message-State: APjAAAV0U0PVPufg4753vEE6wHzOeNf2v8vjPjdM4gC/M6bvnwpnSi+x
        419gbqFwIsMhFZRJyDY+RvKK3LwfXwkVRSwsszU=
X-Google-Smtp-Source: APXvYqyp9pkH+51iCa/hlQVEjIKtehxcBLsZVD0syYP6jy5OdSJfhR9kxXpI8hyUHS3wAiZs5PfUT1Wur+FcA2lhWwg=
X-Received: by 2002:adf:f010:: with SMTP id j16mr4582598wro.206.1573672942308;
 Wed, 13 Nov 2019 11:22:22 -0800 (PST)
MIME-Version: 1.0
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
 <1573649074-72589-2-git-send-email-yukuai3@huawei.com> <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
In-Reply-To: <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Nov 2019 14:22:10 -0500
Message-ID: <CADnq5_Pwc9U03+1=tKs2hxKVdqfwXOc14XRD=yeJCsc4=5NJtw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
To:     Joe Perches <joe@perches.com>
Cc:     yu kuai <yukuai3@huawei.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, zhengbin <zhengbin13@huawei.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:56 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-11-13 at 20:44 +0800, yu kuai wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: In function
> > =E2=80=98gfx_v6_0_constants_init=E2=80=99:
> > drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:1579:6: warning: variable
> > =E2=80=98mc_shared_chmap=E2=80=99 set but not used [-Wunused-but-set-va=
riable]
> []
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> []
> > @@ -1678,7 +1678,6 @@ static void gfx_v6_0_constants_init(struct amdgpu=
_device *adev)
> >
> >       WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WR=
ITE_EN_MASK);
> >
> > -     mc_shared_chmap =3D RREG32(mmMC_SHARED_CHMAP);
>
> I do not know the hardware but frequently hardware like
> this has read ordering requirements and various registers
> can not be read in a random order.
>
> Does removing this read have no effect on the hardware?

There is no dependency.  It's safe.  Same thing below.

Alex

>
> >       adev->gfx.config.mc_arb_ramcfg =3D RREG32(mmMC_ARB_RAMCFG);
> >       mc_arb_ramcfg =3D adev->gfx.config.mc_arb_ramcfg;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> []
> > @@ -4336,7 +4336,6 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu=
_device *adev)
> >               break;
> >       }
> >
> > -     mc_shared_chmap =3D RREG32(mmMC_SHARED_CHMAP);
> >       adev->gfx.config.mc_arb_ramcfg =3D RREG32(mmMC_ARB_RAMCFG);
> >       mc_arb_ramcfg =3D adev->gfx.config.mc_arb_ramcfg;
>
> Same question.
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
