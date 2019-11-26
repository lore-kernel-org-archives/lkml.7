Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A96EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATWoCaDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKZRu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:50:57 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40327 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKZRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:50:57 -0500
Received: by mail-il1-f194.google.com with SMTP id v17so14560248ilg.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t54fAVQIi9k5/AbZql5pbL2ivaJ6crm1GO25m9MjvJc=;
        b=ATWoCaDTK3L62Ae6m3HNV6BKsPyvxBQuhyHHaO3QgvSSWyqbykVd4bX5NAIBjRvMio
         kLER7x38kNXm/78aAQD5HSJb0mAsWFcSkOF6txn5eWOPWmNF6bEpn1Y+ijU2c0ixBD2d
         zXol2/FurfuSesv7zr5bTxT+Z+bf0idq3SSf1/ekhPTSqbd11/HiKSUgGHn550ywg3IP
         SVdneLDrtS97GYycmry5pvAFNM0NQqSzN3GnJ94X3zA/7tnmLffKOKe+zLFLzLIoo4+B
         muMPEUw4KrHEh20uX9lRjQTtLEU9oGaCdZWkcxvYbZqKYd08cMN4Ol8cd8+MSJWH8lEU
         Fp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t54fAVQIi9k5/AbZql5pbL2ivaJ6crm1GO25m9MjvJc=;
        b=apxpRyUBKyqtg36Uu42fuNVSxZpaYOQ+CPC6qPf47VR4OSsl50sjnyoX/x9NPGFYPQ
         4cuvoxOisrMDlj/qPMGWZub4lI9Lc3YRfoGlYRCk5RLZe1xjEReUOD4L90y4wruFhfDj
         +ppZ39NbaSxbfxS5OIH6oWM8TXD0n1nh/48t0meCIRmv5BfIalnchXcoddt6WWD6ZUIm
         uqxsccKUe4xzqRdG1W29o4bNWrh9BNQoDGtJc0GAzV9/MjEt09krRp7oXwn6mONEKSVF
         hX4Uh7XGodPfWhV9y63RMMCz0sFPJeDV8je0IBAKnS6Ot9N6aSbfNbiqNtQ5qjwfmcaf
         JDWw==
X-Gm-Message-State: APjAAAV86ehFR7/UZZxjIpyNjKOZbqTdHRsU1BFRrFFd4ATWDEfvMHcl
        9ab0/w3R8noSmxKe2QCLaCKtX/ZhZh1Nax0kJJI=
X-Google-Smtp-Source: APXvYqzm+6ORS3XPlQiKQzGWc5cG6OGpwMxeH1DU1CV56GkeNnwJblQL5RnEH0Uzo1SDohsp1pKp20tjI2IdfLHxu5A=
X-Received: by 2002:a92:ca8b:: with SMTP id t11mr26640081ilo.227.1574790656094;
 Tue, 26 Nov 2019 09:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20191021211449.9104-1-navid.emamdoost@gmail.com> <CAEkB2ERA6Rx9fZiwXH+m8_OV8to0TuLJRVRiUKfKtSoeoT0uJw@mail.gmail.com>
In-Reply-To: <CAEkB2ERA6Rx9fZiwXH+m8_OV8to0TuLJRVRiUKfKtSoeoT0uJw@mail.gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 26 Nov 2019 11:50:44 -0600
Message-ID: <CAEkB2ER4dof02PcH6BDQoFNhkkds=zrPf+5-rSygUh=XU8H0zQ@mail.gmail.com>
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

ping...

On Thu, Nov 21, 2019 at 12:09 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> On Mon, Oct 21, 2019 at 4:14 PM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > In the implementation of nouveau_bo_alloc() if it fails to determine the
> > target page size via pi, then the allocated memory for nvbo should be
> > released.
> >
> > Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Would you please review this patch?
>
>
> Thanks,
> Navid.
>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_bo.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > index f8015e0318d7..18857cf44068 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > @@ -276,8 +276,10 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 flags,
> >                         break;
> >         }
> >
> > -       if (WARN_ON(pi < 0))
> > +       if (WARN_ON(pi < 0)) {
> > +               kfree(nvbo);
> >                 return ERR_PTR(-EINVAL);
> > +       }
> >
> >         /* Disable compression if suitable settings couldn't be found. */
> >         if (nvbo->comp && !vmm->page[pi].comp) {
> > --
> > 2.17.1
> >
>
>
> --
> Navid.



-- 
Navid.
