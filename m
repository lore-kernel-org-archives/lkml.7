Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAADC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514E20675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c//MCzmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCHDDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:03:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34685 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfCHDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:03:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so16171737lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 19:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOdoGoPqsBrpNR+sr6f/M0KLXQUMtWTZm9TpBp/xnVE=;
        b=c//MCzmWZjEMLa/ETbqKv4K5xOSGukyK1EuO0WPQRdOpZ19Elf6Dl1xbq1RjyPgOOs
         KQFkVDGyamEx4nam/ZOSAzD9ebRTOBLrrIvLwzXLq0nloCneuCoAsljmbHQMOE6jKACV
         rLEhjEFKbflhXSgqCCtcXv2/2ovenW69yG83AThl+FlrGfgw5DPab6dqmPe/qTz+2ncV
         S/TuawnXt+S5i+N2A72lQL7I9hDy2E8ZVAnixb7jNGSJWKmvkzrdtxDPdgUPtcd4uL6Y
         u6e4YJARy6xWa5MpFaJ5KMlyBT8tspQ6mZqv8WQXkJq0MyT4Oh+ATJR3MEislHBB3+j8
         9u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOdoGoPqsBrpNR+sr6f/M0KLXQUMtWTZm9TpBp/xnVE=;
        b=Er2But+xqbUPgrfQXTu6bz8YavbtcUbOmeknu28TJavILPpbsguD+ABCA1VYi7Jx0y
         WLNUHo5gZjLXpd+8BZS7wt8z/lIEHo51d1GGSG0RtnAS+mPxCnKdhypQXuOwUmCqOLl8
         r3OrFhwugTIZoEIpIYXQ0Dmbe7qsml+cLZ2dlloTGISP74L7CiFcUQOdP1NWV1dm6pUH
         UNbcfF8rT1r7g3JHs6np5EsM1i3RO7xSLHDvXCQpat0NmbIxn9N23eYUFT9voe95Mhz1
         zy4vFjvrZgNNLnV01j6oiWex8t7HTWKOPcHLlK0yDS5eGEpCO1rl/Xx3l/eb5f7xZgRY
         vx6A==
X-Gm-Message-State: APjAAAU3UiUq3wAFyj5WSMynpKT5jXnD28yj42JjreQJKcyodabqnPLZ
        J9qyHSk9jDPEanHbGv19gV9NKiTTpcza9G99k/4=
X-Google-Smtp-Source: APXvYqycao6IfUCpZdvTe04mJcr2kYiysV/ShktNMCsh8kRWFdG5H0a6c7txy6GZcZBkV093G0x1VyJK6H9MxlP5dVs=
X-Received: by 2002:a2e:8886:: with SMTP id k6mr8258223lji.43.1552014223831;
 Thu, 07 Mar 2019 19:03:43 -0800 (PST)
MIME-Version: 1.0
References: <1fa6fadf644859e8a6a8ecce258444b49be8c7ee.1551716733.git.andreyknvl@google.com>
 <67536e1d-2819-553d-521c-bae21a51e0f7@virtuozzo.com>
In-Reply-To: <67536e1d-2819-553d-521c-bae21a51e0f7@virtuozzo.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 8 Mar 2019 08:33:31 +0530
Message-ID: <CAFqt6zY387LVbo3sxBvDDvKMb+41KcLcmN-W+ncPJbrUm5STaw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix coccinelle warnings in kasan_p*_table
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kostya Serebryany <kcc@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 9:43 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 3/4/19 8:04 PM, Andrey Konovalov wrote:
> > kasan_p4d_table, kasan_pmd_table and kasan_pud_table are declared as
> > returning bool, but return 0 instead of false, which produces a coccinelle
> > warning. Fix it.
> >
> > Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
>
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>
>
> >  mm/kasan/init.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> > index 45a1b5e38e1e..fcaa1ca03175 100644
> > --- a/mm/kasan/init.c
> > +++ b/mm/kasan/init.c
> > @@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
> >  #else
> >  static inline bool kasan_p4d_table(pgd_t pgd)
> >  {
> > -     return 0;
> > +     return false;
> >  }
> >  #endif
> >  #if CONFIG_PGTABLE_LEVELS > 3
> > @@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
> >  #else
> >  static inline bool kasan_pud_table(p4d_t p4d)
> >  {
> > -     return 0;
> > +     return false;
> >  }
> >  #endif
> >  #if CONFIG_PGTABLE_LEVELS > 2
> > @@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
> >  #else
> >  static inline bool kasan_pmd_table(pud_t pud)
> >  {
> > -     return 0;
> > +     return false;
> >  }
> >  #endif
> >  pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
> >
>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
