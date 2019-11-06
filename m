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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F62C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE541217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wue/yaUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfKFRXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:23:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44043 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfKFRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:23:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so17970750wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g2JUiV4cEMJ74EzA5CndgILOeZzbhz+aAeWFMe6S868=;
        b=Wue/yaUEyKPQr5wZetfab8vqI/MzdYXYoInZoTyhPJLpCYE/99obFndF7Ijg2299pI
         qApCkDaCbIpuu+bLWLuYrR1rnklZf6mp2lQ5KbVyQCwBpSSps9NStPbeZMAoYo9Z+BGX
         EyXL8v5yoqddilskkPETIFCNQf/ylZt+vDiJLAPwVdohUgaeCx2PsHyQbJx6gH10WDUw
         S/jyaAJw7WUXXTOKsXSSChRc9DJ2/lnRuWnsX2geUc6FCKDi8vvPEERMRU9JlmgcoEgJ
         iCfpuXOXOPcA6R4ZtBVe8uJaph/NvmK47Csb/8TMxj1PMsyOHTZO+IGcl8jraJMdrGRD
         EQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g2JUiV4cEMJ74EzA5CndgILOeZzbhz+aAeWFMe6S868=;
        b=gOE+vk5wunB05uQyUsSmUQslbLAMjI4aDJVLGhX3E2rMRKPzsWXnsg5NfbHP3agrpR
         pdFjgh24rzdrEqW39XqQB3/9vrSBB7vn15W85U1LeKqlQTFE/ZoT9JQ59TJLX1SnZXZW
         w+viT0hWO34J7wDDKRvUO3MNFfOYEqpwNGjJTBHba8OiWluM0PCVxC1yF0Dg6haUxK+w
         5Z/Oygo+sT7X09ocWeFq+OC7Bsb6G9OMmlnndfRr7jEiFC9jLrAbmyPJBescbjMndQ00
         Npsq7ImUBB/FmuE7Keb5tpWqEEkmXNUbj3rIYw6qbu3OYc92fNlooT+9+VUFpi0Oa3C/
         0oWQ==
X-Gm-Message-State: APjAAAUuLfFZespcZyRizApFtoyaBqr0pToLUj/fxB8g2QJXZW67Xh1i
        t3wsBYGPcSS265a3SDAMpg8CL70y8OREBvuPxlU=
X-Google-Smtp-Source: APXvYqyayQQbMyVmhEdowaJu+OzAwAXm3V5BG2Ss0sHIDjOI7FfL2E25/DMgXUkarNQ141qCBId2+p5LN2ULiVsCDTs=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3682762wre.11.1573061006001;
 Wed, 06 Nov 2019 09:23:26 -0800 (PST)
MIME-Version: 1.0
References: <1573040143-25820-1-git-send-email-bianpan2016@163.com> <a3b2cc0c-2c0a-fcae-3750-9e51da46b872@amd.com>
In-Reply-To: <a3b2cc0c-2c0a-fcae-3750-9e51da46b872@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Nov 2019 12:23:14 -0500
Message-ID: <CADnq5_Nmxt9W-+QG_xmFzfWmbLM8Pv2GGnnhiA_NC8fuyz70kA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix double reference dropping
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

On Wed, Nov 6, 2019 at 7:48 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 06.11.19 um 12:35 schrieb Pan Bian:
> > The reference to object fence is dropped at the end of the loop.
> > However, it is dropped again outside the loop. The reference can be
> > dropped immediately after calling dma_fence_wait() in the loop and
> > thus the dropping operation outside the loop can be removed.
> >
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Applied.  thanks!

Alex

> > ---
> > v2: fix the bug in a more concise way
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_benchmark.c
> > index 649e68c4479b..d1495e1c9289 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> > @@ -33,7 +33,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_dev=
ice *adev, unsigned size,
> >   {
> >       unsigned long start_jiffies;
> >       unsigned long end_jiffies;
> > -     struct dma_fence *fence =3D NULL;
> > +     struct dma_fence *fence;
> >       int i, r;
> >
> >       start_jiffies =3D jiffies;
> > @@ -44,16 +44,14 @@ static int amdgpu_benchmark_do_move(struct amdgpu_d=
evice *adev, unsigned size,
> >               if (r)
> >                       goto exit_do_move;
> >               r =3D dma_fence_wait(fence, false);
> > +             dma_fence_put(fence);
> >               if (r)
> >                       goto exit_do_move;
> > -             dma_fence_put(fence);
> >       }
> >       end_jiffies =3D jiffies;
> >       r =3D jiffies_to_msecs(end_jiffies - start_jiffies);
> >
> >   exit_do_move:
> > -     if (fence)
> > -             dma_fence_put(fence);
> >       return r;
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
