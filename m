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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CD0C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79D02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkcRhCCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfEUCdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:33:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51428 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfEUCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:33:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id c77so1226683wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kd6dZtuJ+zXIoXi0n4Wghz44M25gXh6ZLX+Zm5Oue7o=;
        b=QkcRhCCxjWn7ooDTcuWtWeD4PwQRkjapE24t6b2y2+/FMNepC2urjqAcEfUEeaHLPg
         BkmnrJJK3srOj91fNZISPcEf1SeroEn26oxUJ/9jYp5OGFrD5QSg431lE5yZiXc3pGJi
         sbrGI1ooHvbIJXFFa0p0oSs6Xzs8wavTSCmp8gDqW3M519qmd2P9Fckvbf4Sr4Z/2DSF
         Ob/0wusSyie8A5rvkpy0RcH9SfXztzVdeJax9zlufiHZMS+kH4SjjUxhOtOn4s/5/8Hu
         /GQL7tuaXn9MtA6bh3UjSxa0CPw5UG3G/7OFL+jkZ7CEEtwyBNRMPLrs1tJFhGhLTaP3
         2LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kd6dZtuJ+zXIoXi0n4Wghz44M25gXh6ZLX+Zm5Oue7o=;
        b=Dswh2v/LWnIgHfqvbFz3VsRBKd/+YDyPrRLpgWTCNnTyWm5HZX0WxQUxo0ESOKnMxW
         rVu5bh+SZJDrVvpdzOXytxN4LkIEHDm5OPKI30pedTYntbKL2qRRQc/LWkep5akM0NpF
         RptQq0MAYqJH4RUBLEv4aK03fwHLVxcAJbJiq3INGZPiencDPJhij2XL8j6EgEPIrwRG
         yBiZudcu3cgdvgZ6BrJaW8pkUv4lmGm22DXSf+BWUB5kR64yp1XcC3twdqqFE0ogiJiq
         c7J3RhL3hLvD8AVQ8eS9kanCkalnE5RKXDTkFYE0hHP7mQFQwTFFFLcONxePW6ntFPDK
         cvJw==
X-Gm-Message-State: APjAAAWJUwchcgknzrz74J82JrJsn1oNcq0uVsukTJG4Fw0hIFAARsTn
        3+smIvs1eMGXEP6iRAihDIyY1ws41iJRqtjUZ/Y=
X-Google-Smtp-Source: APXvYqzU58B+S9LHz4pIUbyimpv6Pckn8KO/PCbUQXILGb6Ru4V304Tj4cXpG8ftONJXo9AShaQy9DZ/k6ldGQYvGIE=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr1359554wmb.110.1558405981000;
 Mon, 20 May 2019 19:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190520162807.GE21222@phenom.ffwll.local> <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB28007ED8F5C6838F2C25A9D587060@SN6PR12MB2800.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 May 2019 22:32:49 -0400
Message-ID: <CADnq5_O=PAK3qZJ-kHUX9jQDkmEYOX+iOhOX7gNaaXp+tC7nUg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
To:     "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, May 20, 2019 at 7:19 PM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
>
> Daniel, what you are talking about is totally wrong.
> 1) AFAIK, only one zero-size array can be in the end of a struct.
> 2) two struct_size will add up struct itself twice. the sum is wrong then=
.
>
> No offense. I can't help feeling lucky that you are in intel.

Xinhui,

Please keep things civil.  There is no need for comments like this.

Alex

>
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Daniel Vetter <daniel.vetter@ffwll.ch> =E4=
=BB=A3=E8=A1=A8 Daniel Vetter <daniel@ffwll.ch>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B45=E6=9C=8821=E6=97=A5 =
0:28
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Pan, Xinhui
> =E6=8A=84=E9=80=81: Deucher, Alexander; Koenig, Christian; Zhou, David(Ch=
unMing); airlied@linux.ie; daniel@ffwll.ch; Quan, Evan; xiaolinkui; amd-gfx=
@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.=
kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
>
> [CAUTION: External Email]
>
> On Fri, May 17, 2019 at 04:44:30PM +0000, Pan, Xinhui wrote:
> > I am going to put more members which are also array after this struct,
> > not only obj[].  Looks like this struct_size did not help on multiple
> > array case. Thanks anyway.  ________________________________
>
> You can then add them up, e.g. kmalloc(struct_size()+struct_size(),
> GFP_KERNEL), so this patch here still looks like a good idea.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Cheers, Daniel
>
> > From: xiaolinkui <xiaolinkui@kylinos.cn>
> > Sent: Friday, May 17, 2019 4:46:00 PM
> > To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airli=
ed@linux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; lin=
ux-kernel@vger.kernel.org; xiaolinkui@kylinos.cn
> > Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
> >
> > [CAUTION: External Email]
> >
> > Use struct_size() helper to keep code simple.
> >
> > Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index 22bd21e..4717a64 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
> >         if (con)
> >                 return 0;
> >
> > -       con =3D kmalloc(sizeof(struct amdgpu_ras) +
> > -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_C=
OUNT,
> > +       con =3D kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
> >                         GFP_KERNEL|__GFP_ZERO);
> >         if (!con)
> >                 return -ENOMEM;
> > --
> > 2.7.4
> >
> >
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
