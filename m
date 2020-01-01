Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D26C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E772072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 09:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRVfiwLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgAAJkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 04:40:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41505 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgAAJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 04:40:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so20633000pfw.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 01:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/6Fruq4L+is5MAGLCLnDa2kYoz3ypv5Xq87O+YG7dw=;
        b=TRVfiwLpS3gBwr93EH1UC3q2CxlOD58tSPzLvZyvXX08YQj/2dWxxs63GU/pHCXrbV
         kwuz/0wDEhp3dtMDLp9MRgdrGluIn7juafSYST1o7O8frJrRr7lGYYMiCTj9s/39m2Ou
         PD5plYGQ9VsjT9uA4UXBRjo80RbiLCmD04P7qHggegZ755PppHr5+FWdwuNYkBErfSac
         eI0DRWFPGZiLijig2z6G/Tam345Q+wzmbuXzfrGwqXd/23GOnqTiGrrV9nAiF7Ra0f7b
         o06GNBOJ/F4VjxjwPHeLmVIjwjAxS63ts4puy3Ah+5+H2srZ7PCs6n8KodcoXLtXR3lY
         lnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=H/6Fruq4L+is5MAGLCLnDa2kYoz3ypv5Xq87O+YG7dw=;
        b=t4x3exWsqWe8A9/6siJAyEoLmVXnb+eoMgHKgWXhHlYYARkwK/x2ZfxSAhEfmmL9s1
         7XzYhZvocuja+m4Rf1WD76u4pvdhM7PZGX4U70Z8w74PPm2wxLUak2dXZJWGTulAclTp
         /00HdoXAwly4rDnnnQNmD/ilLb9vH1ooEBGWWg+NZ/LP+JW8U1hUEPDwsocu+SaDuetP
         3HDKfMfBAL9N3DeLqpvhApHXTvBtqal/jhlFVE7n/HNO9D81iwoRHGO5cyP2ZuhCYfvp
         LmzWrQrY0ezfvTCSSOxb0QYahQs1Sc/UdavNjSZPHTJB8RY1h8k2msf0Kw7Zcs6sPpUw
         ISOw==
X-Gm-Message-State: APjAAAWT5ZhSj84QdElb5WKbCyHIOSZpsqAy5652b5aXXrvHhajwgXQk
        xS1TrxOByl9cXdYvabGy1Tk=
X-Google-Smtp-Source: APXvYqzc9owyZiEIkTs7gOcA6/mNU6W029/LpmhwbeZvUlJfeH3ec+8FXxZztntc3uJzsrtjhPjtbA==
X-Received: by 2002:a63:3196:: with SMTP id x144mr83100783pgx.319.1577871616059;
        Wed, 01 Jan 2020 01:40:16 -0800 (PST)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id r14sm59314953pfh.10.2020.01.01.01.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 01:40:15 -0800 (PST)
Date:   Wed, 1 Jan 2020 12:40:03 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/nouveau: declare constants as unsigned long.
Message-ID: <20200101094003.GA5673@wambui>
Reply-To: CAKb7Uvii6RTp3FsX6z+4VuX6xcS9_SQ+CMC-UBOHVJY5BeWgew@mail.gmail.com
References: <20191231205345.32615-1-wambui.karugax@gmail.com>
 <CAKb7Uvii6RTp3FsX6z+4VuX6xcS9_SQ+CMC-UBOHVJY5BeWgew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7Uvii6RTp3FsX6z+4VuX6xcS9_SQ+CMC-UBOHVJY5BeWgew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 06:53:55PM -0500, Ilia Mirkin wrote:
> Probably want ULL for 32-bit arches to be correct here too.
> 
Okay, I can convert them to ULL and send a v2.

Thanks,
wambui.

> On Tue, Dec 31, 2019 at 3:53 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
> >
> > Explicitly declare constants are unsigned long to address the following
> > sparse warnings:
> > warning: constant is so big it is long
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
> > index ac87a3b6b7c9..506b358fcdb6 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
> > @@ -655,7 +655,7 @@ gf100_ram_new_(const struct nvkm_ram_func *func,
> >
> >  static const struct nvkm_ram_func
> >  gf100_ram = {
> > -       .upper = 0x0200000000,
> > +       .upper = 0x0200000000UL,
> >         .probe_fbp = gf100_ram_probe_fbp,
> >         .probe_fbp_amount = gf100_ram_probe_fbp_amount,
> >         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
> > index 70a06e3cd55a..3bc39895bbce 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
> > @@ -43,7 +43,7 @@ gf108_ram_probe_fbp_amount(const struct nvkm_ram_func *func, u32 fbpao,
> >
> >  static const struct nvkm_ram_func
> >  gf108_ram = {
> > -       .upper = 0x0200000000,
> > +       .upper = 0x0200000000UL,
> >         .probe_fbp = gf100_ram_probe_fbp,
> >         .probe_fbp_amount = gf108_ram_probe_fbp_amount,
> >         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> > index 456aed1f2a02..d01f32c0956a 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> > @@ -1698,7 +1698,7 @@ gk104_ram_new_(const struct nvkm_ram_func *func, struct nvkm_fb *fb,
> >
> >  static const struct nvkm_ram_func
> >  gk104_ram = {
> > -       .upper = 0x0200000000,
> > +       .upper = 0x0200000000UL,
> >         .probe_fbp = gf100_ram_probe_fbp,
> >         .probe_fbp_amount = gf108_ram_probe_fbp_amount,
> >         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
> > index 27c68e3f9772..e24ac664eb15 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
> > @@ -33,7 +33,7 @@ gm107_ram_probe_fbp(const struct nvkm_ram_func *func,
> >
> >  static const struct nvkm_ram_func
> >  gm107_ram = {
> > -       .upper = 0x1000000000,
> > +       .upper = 0x1000000000UL,
> >         .probe_fbp = gm107_ram_probe_fbp,
> >         .probe_fbp_amount = gf108_ram_probe_fbp_amount,
> >         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
> > index 6b0cac1fe7b4..17994cbda54b 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
> > @@ -48,7 +48,7 @@ gm200_ram_probe_fbp_amount(const struct nvkm_ram_func *func, u32 fbpao,
> >
> >  static const struct nvkm_ram_func
> >  gm200_ram = {
> > -       .upper = 0x1000000000,
> > +       .upper = 0x1000000000UL,
> >         .probe_fbp = gm107_ram_probe_fbp,
> >         .probe_fbp_amount = gm200_ram_probe_fbp_amount,
> >         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> > index adb62a6beb63..7a07a6ed4578 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> > @@ -79,7 +79,7 @@ gp100_ram_probe_fbpa(struct nvkm_device *device, int fbpa)
> >
> >  static const struct nvkm_ram_func
> >  gp100_ram = {
> > -       .upper = 0x1000000000,
> > +       .upper = 0x1000000000UL,
> >         .probe_fbp = gm107_ram_probe_fbp,
> >         .probe_fbp_amount = gm200_ram_probe_fbp_amount,
> >         .probe_fbpa_amount = gp100_ram_probe_fbpa,
> > --
> > 2.17.1
> >
