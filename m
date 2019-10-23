Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDTH3vIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbfJWDyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:54:09 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35015 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:54:09 -0400
Received: by mail-il1-f195.google.com with SMTP id p8so7861715ilp.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LHGxMJgC9fsphY4M+7ir7vJgAGyj8pWVsdCiE4QA6o=;
        b=lDTH3vIpVKOT4cHUqTnhkivTQ/0ICLeWcMIrK5ZpKQrPpEFQiBap0C9/xiuuA7wMxu
         8qBj7L4RonbFjzmHvGBvSUy8aBkmXf57NlETXJkYp2JYk1Gs5XYFODyLJGmOygbbtq1n
         ZzoXTonLboEb9/AoN4tpBNFgcjkThTFUlluD+mVvTUlVccwdHYK0POuC2eN1/YMikfVZ
         oQhuvJhEVkSsPRc8/jRE4P2ZEt3qp1ejyR5m8zyHnDg0SuT6JavrrseUCrEJfdDrrMAp
         O16+zL3BDiIswbyFWElgVoRfqbC92XM2WGHKAz78vQqXUCUyWuZFD+jSb1/8B5eWe7Ue
         RRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LHGxMJgC9fsphY4M+7ir7vJgAGyj8pWVsdCiE4QA6o=;
        b=BudtZ0Bem5RGWCpiRr1vFA3I1XY3PnX8pOtLl2FW7NP/VqSVlU1rnlgRZCujdfyTlI
         B6g+khPNKATyUuEqcmG+delOmcPVCbrePyKhxrW0yRoOKYSG1NdCQeib9zBhd51Qy/G4
         o7jVxqcqqmcgwFM7EcHxcU1uvZNs1PYXvTRyx5ZjuX1OXvOdy24EYQs6UDHva4CEO8Fs
         zyWfz8nHkdQxmcoSPYhh8q++4e8/PIv7jCyQ+IOttinHyN1YNV7ktwgt6bpaYVl5SVvX
         kk1IUe4PsImme4bBMIXQnfoxk5qGQmY8MwUlKYeT1/ZW3k+p1aaQn6M1oAf69b3cN2BU
         zvig==
X-Gm-Message-State: APjAAAX1p/3n9+ebxirbsO3Em1jwYt/twlCOUq21q0hfdfJzuitcgOvn
        mpgMndwRN+Y7r/eeNx6Mco54CYTj0xSA8nZZi+oE9q9f
X-Google-Smtp-Source: APXvYqwrn/WBtVMHAFAqhmGHKKoxDT87Sr8DyCIRMO6XG644b9uQ571IH4gZTRLXpqfbcU/Odip8LocEhUk4d72c8Iw=
X-Received: by 2002:a92:4144:: with SMTP id o65mr35736635ila.172.1571802848526;
 Tue, 22 Oct 2019 20:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191021185250.26130-1-navid.emamdoost@gmail.com> <20191022093654.GF11828@phenom.ffwll.local>
In-Reply-To: <20191022093654.GF11828@phenom.ffwll.local>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 22 Oct 2019 22:53:57 -0500
Message-ID: <CAEkB2ETFM7u6YiUOT3fz4UQ3U_za9iM1arTnYNg-rjs5+wxOfw@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 4:36 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Oct 21, 2019 at 01:52:49PM -0500, Navid Emamdoost wrote:
> > In the impelementation of v3d_submit_cl_ioctl() there are two memory
> > leaks. One is when allocation for bin fails, and the other is when bin
> > initialization fails. If kcalloc fails to allocate memory for bin then
> > render->base should be put. Also, if v3d_job_init() fails to initialize
> > bin->base then allocated memory for bin should be released.
> >
> > Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/gpu/drm/v3d/v3d_gem.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> > index 5d80507b539b..19c092d75266 100644
> > --- a/drivers/gpu/drm/v3d/v3d_gem.c
> > +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> > @@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >
> >       if (args->bcl_start != args->bcl_end) {
> >               bin = kcalloc(1, sizeof(*bin), GFP_KERNEL);
> > -             if (!bin)
> > +             if (!bin) {
> > +                     v3d_job_put(&render->base);
>
> The job isn't initialized yet, this doesn't work.
Do you mean we have to release render via kfree() here?

>
> >                       return -ENOMEM;
> > +             }
> >
> >               ret = v3d_job_init(v3d, file_priv, &bin->base,
> >                                  v3d_job_free, args->in_sync_bcl);
> >               if (ret) {
> >                       v3d_job_put(&render->base);
>
> v3d_job_put will call kfree, if you chase the callchain long enough (in
> v3d_job_free). So no bug here, this would lead to a double kfree and
> crash.
Yes, v3d_job_put() takes care of render,

> -Daniel
>
> > +                     kfree(bin);
but how about leaking bin?

> >                       return ret;
> >               }
> >
> > --
> > 2.17.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Navid.
