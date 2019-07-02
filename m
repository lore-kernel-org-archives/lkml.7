Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E754C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE6520881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+IhI3EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfGBBRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:17:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32812 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:17:07 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so33303198iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 18:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGcgCNZM2Fneaix4f2ZBOZNpZLRiuOjV16Tk5yHyGgI=;
        b=E+IhI3EFrprAxwYz5XL+dCV+y22CzQKMuhlzlsky6+02t5cScdlAo3mb1JWWpTE8JK
         qOiH8sX9JUtanurv+qeY6OyoQdYIumvOrbXWbMONgeUsy3svK67NSEEVHLTUEnq3T93Z
         WjZDPGzT/Sm2ne1EOi9XJQs5bBTlLyY4StGuUgRBRl43AIlvqC//mFi9EXC7VsIo0Kh3
         jrQZCZJrfABLTciTv3tMxTQGTBUVHUWqVv938g1y0Q16KV5JwOslf+zytRH6fcmtncNz
         r6/n3C1dVWSPxwTP7ZDAaOUFkZcs4oCQFhYFOT3zAF2OLakwlo+vH3fKStApBz3cwpI7
         acHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGcgCNZM2Fneaix4f2ZBOZNpZLRiuOjV16Tk5yHyGgI=;
        b=uXp9f3FoTrpWEVgzkMNb/mW6hZjFzxw9cIXJf6NtEVr6VkyHZpCtuQl0KlFdFqIPA6
         xg/cAePAmHkJC3KHgoZbSnGE1TvBZaouK1Lbdvj6xapvUthwYQiJ/nGmIaJ84s4XYoKv
         bN0iut18ulYIzlrano/JJEGQ3BDj3bWmEmavCTZlf207SbuCW1ydX+COqK44YnZ3lGNB
         gRNDcAIqZpbzik97tyIumUSQhVHXLA9YC/bKeGo7xTvd4yiCfh3JqVVHj9pP6KZ3AgTp
         bVEf8GGdePr1NFqZano6rGgJQxWXUqQqjUowNP7Mb8bGNe1e6E87RIMeSJcA+DJHOS0E
         wiXA==
X-Gm-Message-State: APjAAAWe4zYWx/suB06aLxVO+D3ab614Gk54nfJc+fd9Vm6LNd44eDv+
        YhEno+J1xkzbUx+6pIrpBvKPQ5Xm68luCA2s76E3Hw==
X-Google-Smtp-Source: APXvYqy7+tj0nUROT403yhSxQDTNTeUEt7vFZMtJl4pXCrWO7ZosVUwEvdbmELi2qgFA1B4FJn4qM+P2QDcjSMHtJI4=
X-Received: by 2002:a05:6638:3d6:: with SMTP id r22mr31783750jaq.71.1562030226625;
 Mon, 01 Jul 2019 18:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com> <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
In-Reply-To: <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Mon, 1 Jul 2019 18:16:30 -0700
Message-ID: <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Jul 1, 2019 at 6:00 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Jul 1, 2019 at 5:51 PM Henry Burns <henryburns@google.com> wrote:
> >
> > __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> > lock the page. Following zsmalloc.c's example we call trylock_page() and
> > unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> > passed in locked, as documentation.
> >
> > Signed-off-by: Henry Burns <henryburns@google.com>
> > Suggested-by: Vitaly Wool <vitalywool@gmail.com>
> > ---
> >  Changelog since v1:
> >  - Added an if statement around WARN_ON(trylock_page(page)) to avoid
> >    unlocking a page locked by a someone else.
> >
> >  mm/z3fold.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index e174d1549734..6341435b9610 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -918,7 +918,10 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
> >                 set_bit(PAGE_HEADLESS, &page->private);
> >                 goto headless;
> >         }
> > -       __SetPageMovable(page, pool->inode->i_mapping);
> > +       if (!WARN_ON(!trylock_page(page))) {
> > +               __SetPageMovable(page, pool->inode->i_mapping);
> > +               unlock_page(page);
> > +       }
>
> Can you please comment why lock_page() is not used here?
Since z3fold_alloc can be called in atomic or non atomic context,
calling lock_page() could trigger a number of
warnings about might_sleep() being called in atomic context. WARN_ON
should avoid the problem described
above as well, and in any weird condition where someone else has the
page lock, we can avoid calling
__SetPageMovable().
>
> >         z3fold_page_lock(zhdr);
> >
> >  found:
> > @@ -1325,6 +1328,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
> >
> >         VM_BUG_ON_PAGE(!PageMovable(page), page);
> >         VM_BUG_ON_PAGE(!PageIsolated(page), page);
> > +       VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
> >
> >         zhdr = page_address(page);
> >         pool = zhdr_to_pool(zhdr);
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
