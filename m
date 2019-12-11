Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D20AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93032073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgDqi25I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLKCdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:33:10 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39973 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfLKCdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:33:10 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so21043888iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 18:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GrAG6kLQMvFo2FrJr01O5T9GlO2dR89/UhNJQdzENU=;
        b=EgDqi25IbUwAwp7dwIJhuNEqwyNNOtC85pn5r70RBay5vcedNi9BB6aacz7YXTABx1
         wDSX3ggjnYQw/3Kgl72WpvAaNrOmq92b8OGHK4t9UxS051jmAHU1DciGdAuQDvrlsi+W
         qfSneVBUZgjr0xAS3HYgLC3l4xKXXx6Zm2yNy6Lzd8G7QRfRfz6QT03+PoJqwu960eSI
         BzGc85fwzHV/oDCv5TCHrCwKoTGqvmYsJXIGPdxM06JeDB1Xdu2sGDZI463+xpQPDYEt
         7wQK4x2QSNZcu8ejPlZCIZyE7hyF3v3iIds+A3rnpnYTztYybJ/0O4RMadNMlOfpfiUv
         WBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GrAG6kLQMvFo2FrJr01O5T9GlO2dR89/UhNJQdzENU=;
        b=GEeHiBmYgnC5A5PycrwPaW8giZNuyJkaW4qX4mZMYKjfHlQMq8hm7wclo0Rb8wPfar
         IDl+z/Kg1r7Y76y5d12iJGdWQUgD/Inhkjmp0PA2H4uVeFXbK76aAcp95yBohlDDMAzv
         1l31+YgLkKapB8CDHy14nouY0HSp9rCiUC4hNhS+ptoI3x/BVdMaJHBiKMLdwC1j8BAK
         r/V/KgZ7NHYKGFy4kEtpemQKueFuZaEa8kZK95KYtS7FT7bEdhZIKe77TnKlMpD/ST+M
         lCeVG/Q5Vax60hVaPEb4JDkZ4KFpObmG+jBxQGc1NutcQ/TklGkovAdKIqQVSbTYzpmh
         8bCg==
X-Gm-Message-State: APjAAAUM9JWeuf7LI1WSheMdIQbihO2Pt5zsabBi7pFt7X5X4iFVI7TV
        qkd635yPB8fWBTj2RYL5xuhjg4euRyL6ZspQT78=
X-Google-Smtp-Source: APXvYqyCaLIIOXPLUgXqGqbeH81ULEklvTw5RLv+9WPZZBso5Pi8eKoTJ2dHz6EXIBOrL/9X1WVoBRuzDrjHc7dKkEQ=
X-Received: by 2002:a6b:c3c2:: with SMTP id t185mr987251iof.252.1576031589271;
 Tue, 10 Dec 2019 18:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20191021211449.9104-1-navid.emamdoost@gmail.com>
 <CAEkB2ERA6Rx9fZiwXH+m8_OV8to0TuLJRVRiUKfKtSoeoT0uJw@mail.gmail.com> <CAEkB2ER4dof02PcH6BDQoFNhkkds=zrPf+5-rSygUh=XU8H0zQ@mail.gmail.com>
In-Reply-To: <CAEkB2ER4dof02PcH6BDQoFNhkkds=zrPf+5-rSygUh=XU8H0zQ@mail.gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 10 Dec 2019 20:32:58 -0600
Message-ID: <CAEkB2EQiJXmc6U9axYEg8cgh5L9vFtoD5x0byAey+GCc-WTwOA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Fix memory leak in nouveau_bo_alloc
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On Tue, Nov 26, 2019 at 11:50 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> ping...
>
> On Thu, Nov 21, 2019 at 12:09 PM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > On Mon, Oct 21, 2019 at 4:14 PM Navid Emamdoost
> > <navid.emamdoost@gmail.com> wrote:
> > >
> > > In the implementation of nouveau_bo_alloc() if it fails to determine the
> > > target page size via pi, then the allocated memory for nvbo should be
> > > released.
> > >
> > > Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> >
> > Would you please review this patch?
> >
> >
> > Thanks,
> > Navid.
> >
> > > ---
> > >  drivers/gpu/drm/nouveau/nouveau_bo.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > > index f8015e0318d7..18857cf44068 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > > @@ -276,8 +276,10 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 flags,
> > >                         break;
> > >         }
> > >
> > > -       if (WARN_ON(pi < 0))
> > > +       if (WARN_ON(pi < 0)) {
> > > +               kfree(nvbo);
> > >                 return ERR_PTR(-EINVAL);
> > > +       }
> > >
> > >         /* Disable compression if suitable settings couldn't be found. */
> > >         if (nvbo->comp && !vmm->page[pi].comp) {
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Navid.
>
>
>
> --
> Navid.



-- 
Navid.
