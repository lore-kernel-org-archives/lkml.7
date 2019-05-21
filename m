Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369242173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RttiH3G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfEUHX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:23:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40341 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfEUHX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:23:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id u11so15400946otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DPQL8bz6Ge/eFLfJPuBWgxB/nSLqSz43ISfLIGw+Rn0=;
        b=RttiH3G67ThRjHMOpk4pcVI/VMZPc5TF2PsMtvOI1PMokcZqYS7EectW/z54H7FqiF
         ovukQ8zGr07qzNzAkQ482SUGOCpjq8+PKUV7PJmRe2njXqsuR3SkafzFpr77LyQTCbZD
         k3FpSMJ2zRic7PUIm4ogcRJ3+3tTAO/e1CK/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPQL8bz6Ge/eFLfJPuBWgxB/nSLqSz43ISfLIGw+Rn0=;
        b=qWRq4TCg2AFhzKARKv6/phuckwdnW/kBYlAB4SmUmLu8uohz5qlTU5nbFhhOQtH3Ep
         mTs3qeL4MGvkKjESCW8lRdmrVGCKrqRikuFYMKIUXVnAxRoTzAVxClKZUwpDGFkRvxO9
         sRRmMIe/iHqFmVBrFQiVVxXi5d+JwcfKTE45ICoG9cSoNA26blNTjEId8CPalZUxIwtI
         IAickqzZneAB+JDS62iKobq5wTR/59Fcc/d6/51RE4i6mN2jD6WSFBX/zhAVUXqOcmkl
         N0ELhiSNEd45RHrj1hRE4maoGzKZsRIrL+R9pNNqMWEd1v17L8oOOPobS5TkRCpL3rg7
         Iolg==
X-Gm-Message-State: APjAAAX1ogWZonD+cEa6UuQjXU8diuA93NMGEe7Zs8zc+rXMcJR7LKRv
        1XlWhcQllCmmiXxZiyG9Cb0uK/ILyRPwoqq/1CZslDzCViY=
X-Google-Smtp-Source: APXvYqwRwB1P5Gup3HP1MIlCSYyVyfn4YovUvZH/z6o7Bagy2HaHKKRr1LGuNbzUCTI0WsNWPs4SnLqkO/CCNIdY6Bk=
X-Received: by 2002:a9d:7395:: with SMTP id j21mr2061299otk.204.1558423406551;
 Tue, 21 May 2019 00:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190520162807.GE21222@phenom.ffwll.local> <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
 <CADnq5_O=PAK3qZJ-kHUX9jQDkmEYOX+iOhOX7gNaaXp+tC7nUg@mail.gmail.com>
In-Reply-To: <CADnq5_O=PAK3qZJ-kHUX9jQDkmEYOX+iOhOX7gNaaXp+tC7nUg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 21 May 2019 09:23:14 +0200
Message-ID: <CAKMK7uHS837L9Ze_K5q-AsFgOtAMD+n_i_Y404BX-_CwJeP08Q@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        xiaolinkui <xiaolinkui@kylinos.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 4:33 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, May 20, 2019 at 7:19 PM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
> >
> > Daniel, what you are talking about is totally wrong.
> > 1) AFAIK, only one zero-size array can be in the end of a struct.
> > 2) two struct_size will add up struct itself twice. the sum is wrong th=
en.
> >
> > No offense. I can't help feeling lucky that you are in intel.
>
> Xinhui,
>
> Please keep things civil.  There is no need for comments like this.

Yeah, this was over the line, thanks Alex for already taking care of
this. Please note that fd.o mailing lists operate under a CoC:

https://www.freedesktop.org/wiki/CodeOfConduct/

Wrt the technical comment: I know that you can only do one variable
sized array, and it must be at the end. But you can put multiple
structures all within the same allocation. Which is what I thought you
wanted to do. And my sketch would allow you to do that even if you
have multiple variable length structures you want to allocate. There's
plenty examples of this (but open-coded ones) in the kernel.

Except in really hot paths I personally think that that kind of
trickery isn't worth it.

Cheers, Daniel

>
> Alex
>
> >
> >
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Daniel Vetter <daniel.vetter@ffwll.ch> =E4=
=BB=A3=E8=A1=A8 Daniel Vetter <daniel@ffwll.ch>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B45=E6=9C=8821=E6=97=
=A5 0:28
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Pan, Xinhui
> > =E6=8A=84=E9=80=81: Deucher, Alexander; Koenig, Christian; Zhou, David(=
ChunMing); airlied@linux.ie; daniel@ffwll.ch; Quan, Evan; xiaolinkui; amd-g=
fx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vge=
r.kernel.org
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] gpu: drm: use struct_size() in kmalloc(=
)
> >
> > [CAUTION: External Email]
> >
> > On Fri, May 17, 2019 at 04:44:30PM +0000, Pan, Xinhui wrote:
> > > I am going to put more members which are also array after this struct=
,
> > > not only obj[].  Looks like this struct_size did not help on multiple
> > > array case. Thanks anyway.  ________________________________
> >
> > You can then add them up, e.g. kmalloc(struct_size()+struct_size(),
> > GFP_KERNEL), so this patch here still looks like a good idea.
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Cheers, Daniel
> >
> > > From: xiaolinkui <xiaolinkui@kylinos.cn>
> > > Sent: Friday, May 17, 2019 4:46:00 PM
> > > To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); air=
lied@linux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan
> > > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; l=
inux-kernel@vger.kernel.org; xiaolinkui@kylinos.cn
> > > Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
> > >
> > > [CAUTION: External Email]
> > >
> > > Use struct_size() helper to keep code simple.
> > >
> > > Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ras.c
> > > index 22bd21e..4717a64 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
> > >         if (con)
> > >                 return 0;
> > >
> > > -       con =3D kmalloc(sizeof(struct amdgpu_ras) +
> > > -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK=
_COUNT,
> > > +       con =3D kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT=
),
> > >                         GFP_KERNEL|__GFP_ZERO);
> > >         if (!con)
> > >                 return -ENOMEM;
> > > --
> > > 2.7.4
> > >
> > >
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
