Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BFC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77772089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBSEOeFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfGCAyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:54:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34076 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:54:17 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so817113iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytW0OWDzeMr1hdoz0EslmLVkCowQp/51ALwoyHUI2GI=;
        b=nBSEOeFp5wxsOc5nTyqZmSBLDUrnq1nUlE9LRL00bMxxQ1nC9cUrMJLQwOr63l7q1w
         o9YaaR5F4rYdFz2pUixfzkhj1Ip79oCTaPKe4HDDH0qjCAseTf5T7zRHqKjKVe4JBP52
         Nplnas64U+BD2r13HOt+d293Y7bvus/A0EwtMJ7gGxdYEIT2HQybaKmQ179ennlf2XSZ
         P6EnWzAwK0ddqKUQA6tNNS7uAB8KzxJBrrkpcaJmxWRhWrpG32OQ0nZ8w3cWEqUEqfgU
         pvwbgy6SkYP+RNRrBBdfM5woWRI2kb/sMj2nIfV0U8gXMGhqsq8dX9zL6WqQBWSM/+X8
         SLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytW0OWDzeMr1hdoz0EslmLVkCowQp/51ALwoyHUI2GI=;
        b=MwNFK1b4tCLy5GHejkOWNmSBqKrS5TvwpTOBqTV0/WVTzAB1qd1jAs6WjsoKR1OXRQ
         3Ae4+T82gDZU6sVYVcWR3Y/GQHIUCnEpZOZPoaFELIsg+mpUH7rKugLeKRwdfyhOZmjk
         3J5kheAucZRCm0zlHSY4eOp8sI874VIcozzB7WbAqZeOX64mRgVsezeAkMUcLV8xjDLz
         clTXSLLcTrRi8GUbnltQ0a6VSHV8zlnD/Qy6A6WqYL/ldW2V4qm9KUsAH4ieKdWp7e5w
         LoOOiTKodQ6ND7wX614AfT2x1EXBvQ7GYiQr0noh1ddkURR1KFO7UUgyOPURNJuD2MJ7
         rtSQ==
X-Gm-Message-State: APjAAAWmvIzEiH0YcdiDF8BAvA+0rOwEBLPXbbmJ+8qIdnVQx5yQIxwC
        wc45NtCzYDMXnYn9wXl0DlbiUIQYlRujERR8hEhDLampEYE=
X-Google-Smtp-Source: APXvYqwBBwXRA2xJcuG7FSTjOiKfMXmkSt9uttUFKGDIkknV+eIWIcBpxOKHmkhjU9BiyBByxx0pOLNOMy5nTlfTNp0=
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr37908229jai.39.1562105903431;
 Tue, 02 Jul 2019 15:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com> <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
 <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com> <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org>
In-Reply-To: <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org>
From:   Henry Burns <henryburns@google.com>
Date:   Tue, 2 Jul 2019 15:17:47 -0700
Message-ID: <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 2:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 1 Jul 2019 18:16:30 -0700 Henry Burns <henryburns@google.com> wrote:
>
> > Cc: Vitaly Wool <vitalywool@gmail.com>, Vitaly Vul <vitaly.vul@sony.com>
>
> Are these the same person?
I Think it's the same person, but i wasn't sure which email to include
because one was
in the list of maintainers and I had contacted the other earlier.
>
> > Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
> > Date: Mon, 1 Jul 2019 18:16:30 -0700
> >
> > On Mon, Jul 1, 2019 at 6:00 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Mon, Jul 1, 2019 at 5:51 PM Henry Burns <henryburns@google.com> wrote:
> > > >
> > > > __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> > > > lock the page. Following zsmalloc.c's example we call trylock_page() and
> > > > unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> > > > passed in locked, as documentation.
>
> The changelog still doesn't mention that this bug triggers a
> VM_BUG_ON_PAGE().  It should do so.  I did this:
>
> : __SetPageMovable() expects its page to be locked, but z3fold.c doesn't
> : lock the page.  This triggers the VM_BUG_ON_PAGE(!PageLocked(page), page)
> : in __SetPageMovable().
> :
> : Following zsmalloc.c's example we call trylock_page() and unlock_page().
> : Also make z3fold_page_migrate() assert that newpage is passed in locked,
> : as per the documentation.
>
> I'll add a cc:stable to this fix.
>
> > > > Signed-off-by: Henry Burns <henryburns@google.com>
> > > > Suggested-by: Vitaly Wool <vitalywool@gmail.com>
> > > > ---
> > > >  Changelog since v1:
> > > >  - Added an if statement around WARN_ON(trylock_page(page)) to avoid
> > > >    unlocking a page locked by a someone else.
> > > >
> > > >  mm/z3fold.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > > > index e174d1549734..6341435b9610 100644
> > > > --- a/mm/z3fold.c
> > > > +++ b/mm/z3fold.c
> > > > @@ -918,7 +918,10 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
> > > >                 set_bit(PAGE_HEADLESS, &page->private);
> > > >                 goto headless;
> > > >         }
> > > > -       __SetPageMovable(page, pool->inode->i_mapping);
> > > > +       if (!WARN_ON(!trylock_page(page))) {
> > > > +               __SetPageMovable(page, pool->inode->i_mapping);
> > > > +               unlock_page(page);
> > > > +       }
> > >
> > > Can you please comment why lock_page() is not used here?
>
> Shakeel asked "please comment" (ie, please add a code comment), not
> "please comment on".  Subtle ;)
>
> > Since z3fold_alloc can be called in atomic or non atomic context,
> > calling lock_page() could trigger a number of
> > warnings about might_sleep() being called in atomic context. WARN_ON
> > should avoid the problem described
> > above as well, and in any weird condition where someone else has the
> > page lock, we can avoid calling
> > __SetPageMovable().
>
> I think this will suffice:
>
> --- a/mm/z3fold.c~mm-z3foldc-lock-z3fold-page-before-__setpagemovable-fix
> +++ a/mm/z3fold.c
> @@ -919,6 +919,9 @@ retry:
>                 set_bit(PAGE_HEADLESS, &page->private);
>                 goto headless;
>         }
> +       /*
> +        * z3fold_alloc() can be called from atomic contexts, hence the trylock
> +        */
>         if (!WARN_ON(!trylock_page(page))) {
>                 __SetPageMovable(page, pool->inode->i_mapping);
>                 unlock_page(page);
>
> However this code would be more effective if z3fold_alloc() were to be
> told when it is running in non-atomic context so it can perform a
> sleeping lock_page() in that case.  That's an improvement to consider
> for later, please.
>

z3fold_alloc() can tell when its called in atomic context, new patch incoming!
I'm thinking something like this:

> > > > +       if (can_sleep) {
> > > > +               lock_page(page);
> > > > +               __SetPageMovable(page, pool->inode->i_mapping);
> > > > +               unlock_page(page);
> > > > +       } else {
> > > > +               if (!WARN_ON(!trylock_page(page))) {
> > > > +                       __SetPageMovable(page, pool->inode->i_mapping);
> > > > +                       unlock_page(page);
> > > > +               } else {
> > > > +                       pr_err("Newly allocated z3fold page is locked\n");
> > > > +                       WARN_ON(1);
> > > > +               }
> > > > +       }
