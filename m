Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB63C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73349214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2Ew9GMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKRf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:35:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:35:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so15586751wrx.3;
        Mon, 11 Nov 2019 09:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Hr0XZ+W95Fq8mqP7g5xaelC6Vx3m15yqOwH0Jnse00=;
        b=e2Ew9GMfSUxRzx7YWxu6vGIT1uYNAUiOY9ivjlvAsecN6phDGzODfdsbD3pacZtgIq
         1TKhZPVClxclFXrKxi25zD6ZguKi/bxPme4O5nqEjs9Q/EuaddiWwchMpHQb4ojeFI/W
         +Z8KsqOocqbBsBqH/WUX8mpC/R2cj9PNBzLMkYizXe+M9L/QoTtzf4sJIFvMn3IUVcS8
         1EPUUP/83jBAkAMU+kWNau2TxKgnEBfFfMdmTTvesmByRZfObnz5YIBcC1VOeqr71tgR
         /dL6GhxmlSceWOMaL0mWSis4LnTwXehs8BaBwdsQw9+50FGstcjrZ07Acb24dJ41ZJhT
         i2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Hr0XZ+W95Fq8mqP7g5xaelC6Vx3m15yqOwH0Jnse00=;
        b=oFs5XNywttofbZGdEr82OmO+YVgyH3eFy43pVYvGYGy8dIyYBNpI7NOEO+xLdJpTO+
         llo4ED2f1CzaFptw84WEHOthphjvGKuKWy+38Stb5Jqqg7nmyEihrKZqnWwVFT1CquhC
         VGxRA8sH3xPFE867brYYKI4onxpLeq+LtiwwaLSuhMlfwMOd8Tm6NFDTTvBtZ5SF4LSf
         1HL58+Lh+vdGqEDSGC+VwjRbRxSprRyimpg5UOHkBwrqZ1yvkhPvPPlhbWqbqmQrGLuS
         jH27t4f0barDxnehHJWNBpa5KRcV4X7x0lIGPO1VCSkNXnqw3QfPsQCbK8uJ9ASabfVl
         fLaA==
X-Gm-Message-State: APjAAAW7aud6fWGop+++cOXDjF26a9f/gWtsfXrMEN8/P5BKDTAjYVK1
        m6xB6iOqwX7XhN/4uHIf0cZeLOeFbSf1+pbRr2g=
X-Google-Smtp-Source: APXvYqweEiabjLuuO8H9HV68rYsXJ4G5OK+vh51GktRkh2PtT8iyT8F9Kc+znoIEOavWyTstNfVv2xS3Cb9ocnbXU8Q=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr22736594wrr.50.1573493723544;
 Mon, 11 Nov 2019 09:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20191109154921.223093-1-colin.king@canonical.com> <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
In-Reply-To: <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 12:35:10 -0500
Message-ID: <CADnq5_MKFh3v+qnjO-bmpepTc_XTgEKTomP0PLRJu==_UBTkZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicated comparison expression
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 11, 2019 at 8:38 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2019-11-09 10:49 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is comparison expression that is duplicated and hence one
> > of the expressions can be removed.  Remove it.
> >
> > Addresses-Coverity: ("Same on both sides")
> > Fixes: 12e2b2d4c65f ("drm/amd/display: add dcc programming for dual plane")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Thanks!
>
> Nicholas Kazlauskas
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 1fdba13b3d0f..1fa255e077d0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -1491,7 +1491,6 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
> >       }
> >
> >       if (u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
> > -                     || u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
> >                       || u->plane_info->plane_size.chroma_pitch != u->surface->plane_size.chroma_pitch) {
> >               update_flags->bits.plane_size_change = 1;
> >               elevate_update_type(&update_type, UPDATE_TYPE_MED);
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
