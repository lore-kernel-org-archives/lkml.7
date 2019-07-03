Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F921871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFhq5S64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfGCGDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:03:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35580 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGCGDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:03:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so1050419ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 23:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR83koGSfN8f4T21Djb6M4JozxiegfBiW4pc4sENEhU=;
        b=PFhq5S64bGYOvM9RVa2rbe3BMe23mBxegax68A5oboVVYkj9yac+DYKBsUV8TIxm82
         dCGgip+iJTAtzeueMH8rXwQ45n2SYFC+AJILLZRa9Dtx/5PVB/eM9wPnNOm1KyaDPc5B
         WpCwcuNCvEEkNPlwFbk1fJwDnjI9sMF3ObMHbhpCS5nEdkC8ViFucYBJDVa7o8JsLEJu
         w30fTQ8+s+plIIDzeJmOF+FLYOHg3mjz3cKsMggoNq3CRop9fr8LgDofeAmZDUYJq/Zc
         K1IcZ1OxyF73JiC5QitC8o0m7qWFaaci8gL35lYByRCuUNfS0IorVlFmxBZz6UOfcPyx
         My2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR83koGSfN8f4T21Djb6M4JozxiegfBiW4pc4sENEhU=;
        b=j4eDYrJkUd7A3op5wiGFnv5t3PMZHwKjp340xoSz+C9V1Tu20gOLHdsE4D+XPvT1Mg
         R9cwYXmjqpXREvUIAnZ/Bfyodp53kBAwlQtgvyVAJYDtSWC/ChZJgxc7aX4I1yVJniBx
         cCYI/1BwZc5wMbKd0sqGJpYP2qUzyqHRq6J3WvEbmstyrYl3X7OU6iXjJUHlVs8r6UrG
         aV+h6rx5KLU+A2IgzNlq5zhBPN7hP41wKWAly76c7+sLKh2t2G1FHynRbBhVwjj4LE38
         5tZ6c8Ak6Z7aHhx4wcrTDAVhP5+NqrTpdPaYr+BQVWhzk8r7btzuiPasGlBYtMPEH+kz
         o3zg==
X-Gm-Message-State: APjAAAWZbkn7zY0pdBeCZOgeUj02bmqOBXYbGKTVRbWScXsuQDmc4fs5
        03nDtJy0X61fCBM/vAoZY+UVJ6/gj78js1ECvJg=
X-Google-Smtp-Source: APXvYqzdUgWzjHttmuz/N8FCiFoagx183/BYjJRUjTIJAQZZEoLGL5Q9E3sSA0IdUXaoNAmAWERsIXlbn3793c0uRIc=
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr5360976ljg.168.1562133809409;
 Tue, 02 Jul 2019 23:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190701173042.221453-1-henryburns@google.com>
 <CAMJBoFPbRcdZ+NnX17OQ-sOcCwe+ZAsxcDJoR0KDkgBY9WXvpg@mail.gmail.com> <CAGQXPTjX=7aD9MQAs2kJthFvPdd3x8Nh53oc=wZCXH_dvDJ=Vg@mail.gmail.com>
In-Reply-To: <CAGQXPTjX=7aD9MQAs2kJthFvPdd3x8Nh53oc=wZCXH_dvDJ=Vg@mail.gmail.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Wed, 3 Jul 2019 08:02:31 +0200
Message-ID: <CAMJBoFMBLv9OpXtQkOAyZ-vw5Ktk1tYtvfT=GPPx8jnKBN01rg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold: Fix z3fold_buddy_slots use after free
To:     Henry Burns <henryburns@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 6:57 PM Henry Burns <henryburns@google.com> wrote:
>
> On Tue, Jul 2, 2019 at 12:45 AM Vitaly Wool <vitalywool@gmail.com> wrote:
> >
> > Hi Henry,
> >
> > On Mon, Jul 1, 2019 at 8:31 PM Henry Burns <henryburns@google.com> wrote:
> > >
> > > Running z3fold stress testing with address sanitization
> > > showed zhdr->slots was being used after it was freed.
> > >
> > > z3fold_free(z3fold_pool, handle)
> > >   free_handle(handle)
> > >     kmem_cache_free(pool->c_handle, zhdr->slots)
> > >   release_z3fold_page_locked_list(kref)
> > >     __release_z3fold_page(zhdr, true)
> > >       zhdr_to_pool(zhdr)
> > >         slots_to_pool(zhdr->slots)  *BOOM*
> >
> > Thanks for looking into this. I'm not entirely sure I'm all for
> > splitting free_handle() but let me think about it.
> >
> > > Instead we split free_handle into two functions, release_handle()
> > > and free_slots(). We use release_handle() in place of free_handle(),
> > > and use free_slots() to call kmem_cache_free() after
> > > __release_z3fold_page() is done.
> >
> > A little less intrusive solution would be to move backlink to pool
> > from slots back to z3fold_header. Looks like it was a bad idea from
> > the start.
> >
> > Best regards,
> >    Vitaly
>
> We still want z3fold pages to be movable though. Wouldn't moving
> the backink to the pool from slots to z3fold_header prevent us from
> enabling migration?

That is a valid point but we can just add back pool pointer to
z3fold_header. The thing here is, there's another patch in the
pipeline that allows for a better (inter-page) compaction and it will
somewhat complicate things, because sometimes slots will have to be
released after z3fold page is released (because they will hold a
handle to another z3fold page). I would prefer that we just added back
pool to z3fold_header and changed zhdr_to_pool to just return
zhdr->pool, then had the compaction patch valid again, and then we
could come back to size optimization.

Best regards,
   Vitaly
