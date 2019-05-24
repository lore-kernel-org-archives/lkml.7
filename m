Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879CC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE132175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SVznC4KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbfEXVEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:04:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45276 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfEXVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:04:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so8013020oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TZLUTKJ3F2aogiV4hxpY25KLHdygnyYYVAPTh5EB7PA=;
        b=SVznC4KCLx7YSAx2b6fQ+ZtJiZ6ujYdV9mSMxY84cZ56j+I/vr7lCZ/TTMGPqIrmG2
         n+MXhfhPC5SPlCZeuF2ieZOIOLtAiTxsv8dTJ3LY+T++Gx1kU0nnyQjXCoaVyIRN2139
         bNjLSLTnsM4vNLAE53uhz0BWJ5+IUfLiAbY/s+oxqkfDD+60ZakSOC4NcjsVb/AdikkC
         Ep3lJuX0jO9ltkpAJ7esLFb6M7WD0hEd9tkFPAhX3J2Jbb5HOcty+jYUuRdcBSREf+Rw
         JqYkgRMAVIy/x+dJaSnpwbW1LDzz1JAl9eng+iVqHCNf+jFOWorG+cxdGn6taPp9T4ya
         Clvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TZLUTKJ3F2aogiV4hxpY25KLHdygnyYYVAPTh5EB7PA=;
        b=QOQJMeffSueabnyqF9OS9QIVi73TMTSw3t9xPQ49lW3TS3I/vVkJ9tjroi4O8iSHPy
         YoLlqtnmCxvQ8fkDzMenY+USRdoi/MlYzYgNw8LzAFdIu8hUm2IneYlpm5WqQOEWhDn4
         TsjbxIdWyJafyqjqsDDhoA0e+upK94FnRZylIjkX8uD5NSu7ZY6OpzxTiI/3gDmBalDo
         42vpyoP6GRubAIaunhUUGBCC+XiybUP3Fx82CooCUd2GWHzLS2XmfdqoHU/EqN5fbziT
         jBMUC+zPvJRrj8dq8efud/yOiGCrlRkSlzcqz+59O6j4qfBTVORXcs4PY31mOd6H302Q
         NgIQ==
X-Gm-Message-State: APjAAAUCJThDe9vrzpfr9ME7Q1CsvHy6pTqycIrNeifWoQbVPdueOLxa
        kS3qcrUc8bL7RyxTRlvXK91/NeOKCOud3CrDfIDHSg==
X-Google-Smtp-Source: APXvYqxZIFyFGsR/pXREy00mCK+6RQ0bxehaezcZvJguGqHs6hXw7JjGal55rGe16XzZYEOCHBpbDovT+9fdeN+vXHk=
X-Received: by 2002:aca:b641:: with SMTP id g62mr7861089oif.149.1558731844633;
 Fri, 24 May 2019 14:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190523223746.4982-1-ira.weiny@intel.com> <CAPcyv4gYxyoX5U+Fg0LhwqDkMRb-NRvPShOh+nXp-r_HTwhbyA@mail.gmail.com>
In-Reply-To: <CAPcyv4gYxyoX5U+Fg0LhwqDkMRb-NRvPShOh+nXp-r_HTwhbyA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 24 May 2019 14:03:52 -0700
Message-ID: <CAPcyv4i7+AVR9_U+g8npO_ixJFz=5kEUJ9RaiD2aKBmBOo-PJA@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: Fix release_pages() when releasing devmap pages
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 8:58 PM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> On Thu, May 23, 2019 at 3:37 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Device pages can be more than type MEMORY_DEVICE_PUBLIC.
> >
> > Handle all device pages within release_pages()
> >
> > This was found via code inspection while determining if release_pages()
> > and the new put_user_pages() could be interchangeable.
> >
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  mm/swap.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 3a75722e68a9..d1e8122568d0 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -739,15 +739,14 @@ void release_pages(struct page **pages, int nr)
> >                 if (is_huge_zero_page(page))
> >                         continue;
> >
> > -               /* Device public page can not be huge page */
> > -               if (is_device_public_page(page)) {
> > +               if (is_zone_device_page(page)) {
> >                         if (locked_pgdat) {
> >                                 spin_unlock_irqrestore(&locked_pgdat->l=
ru_lock,
> >                                                        flags);
> >                                 locked_pgdat =3D NULL;
> >                         }
> > -                       put_devmap_managed_page(page);
> > -                       continue;
> > +                       if (put_devmap_managed_page(page))
>
> This "shouldn't" fail, and if it does the code that follows might get
> confused by a ZONE_DEVICE page. If anything I would make this a
> WARN_ON_ONCE(!put_devmap_managed_page(page)), but always continue
> unconditionally.

As discussed offline, I'm wrong here. It needs to fall through to
put_page_testzero() for the device-dax case, but perhaps a comment for
the next time I forget that subtlety.
