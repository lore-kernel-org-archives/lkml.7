Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF14C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D506218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7Rj0jY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGCRTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:19:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43039 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:19:14 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so6569483ios.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGjByfD82DU0x9mX4FdRfeYlzBtivDKcJ0KQXu0Ie1I=;
        b=a7Rj0jY2QBIfViPNFUm76trGe/bKUY7mCjPwJbiaJ50x6pJNRBkPu+R1MM8mw6sOOU
         4B3aEJKjRb3+e7bU3IP1jFdb1YFmzDwlsN4MXd++Uf2Fp2Nzel29i8J9XQ22NojddDZB
         +Ulzkl67GjTVkp41624QkEl0E/s8o3qkxFuABwKgTE6kJYqMZA8jNskfHCbQOBk6pnzR
         NOpvtVVjeuJiet55kmS0P+X09nZ3dUpGlSld4TNhSinRaDzB2lEIW0iwUqau3LNF+c3h
         39nW6JLRT+JrNz8eQ83heezlELAfEDy8iT1ms460iBM6Lt5wffeg7MZ2w0nk/P0WI2Ur
         Z3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGjByfD82DU0x9mX4FdRfeYlzBtivDKcJ0KQXu0Ie1I=;
        b=ZkvgsD1zBF4IacxqmgUgLS3xV0pCOtSgiyf2noV5N4lCgT2llt+EP1KMsGxmqJa852
         Z1E2gYUa/P7cmyjJlSBRJfqekNSJhQrOWwb2nNZ1f/tqeVR+5lOSK6pQUGF9BVPpvXq8
         Pz6y6tCSVvSzfoM3SyF2JVXAdDoeazmQWFOUQctM9csxyNQcH1TDt0doV3LyxDDjd1oa
         llEgXIrIBwvdELRokgo6PuDNLkw5L9P3h9wcDqz1qKCL7WRo4c5ci1YdhCikCRxoCFaU
         LzEQkTC50EoIoz4g8ZNF8m629ypaWMp8Y74qsO7ghhSKiFi0YonDA+N+fi6ep7wG4K6H
         zQCg==
X-Gm-Message-State: APjAAAXzbjhbbfK9tHzBYfgVIOOGfQiqFSEhOJMJr8xfCf8BQpDR9tLh
        6SqoFtWWthy9gBZl1MlKPpDndbWIOBbOgqSfOGwHyQ==
X-Google-Smtp-Source: APXvYqyUr71sdXpi43QYYZjncftgBxdzVnH8D2CCeSrP2TVbacVB/SQkZJ/WcE7USxtw+O12qqHaCQkIyrNp/Rpqopk=
X-Received: by 2002:a5e:c207:: with SMTP id v7mr10360260iop.163.1562174353630;
 Wed, 03 Jul 2019 10:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190701173042.221453-1-henryburns@google.com>
 <CAMJBoFPbRcdZ+NnX17OQ-sOcCwe+ZAsxcDJoR0KDkgBY9WXvpg@mail.gmail.com>
 <CAGQXPTjX=7aD9MQAs2kJthFvPdd3x8Nh53oc=wZCXH_dvDJ=Vg@mail.gmail.com> <CAMJBoFMBLv9OpXtQkOAyZ-vw5Ktk1tYtvfT=GPPx8jnKBN01rg@mail.gmail.com>
In-Reply-To: <CAMJBoFMBLv9OpXtQkOAyZ-vw5Ktk1tYtvfT=GPPx8jnKBN01rg@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Wed, 3 Jul 2019 10:18:37 -0700
Message-ID: <CAGQXPThUgPA2gZkOiuFph43Qq_zFohbMcn_70dtjQZ_HxD41fQ@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold: Fix z3fold_buddy_slots use after free
To:     Vitaly Wool <vitalywool@gmail.com>
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

> > On Tue, Jul 2, 2019 at 12:45 AM Vitaly Wool <vitalywool@gmail.com> wrote:
> > >
> > > Hi Henry,
> > >
> > > On Mon, Jul 1, 2019 at 8:31 PM Henry Burns <henryburns@google.com> wrote:
> > > >
> > > > Running z3fold stress testing with address sanitization
> > > > showed zhdr->slots was being used after it was freed.
> > > >
> > > > z3fold_free(z3fold_pool, handle)
> > > >   free_handle(handle)
> > > >     kmem_cache_free(pool->c_handle, zhdr->slots)
> > > >   release_z3fold_page_locked_list(kref)
> > > >     __release_z3fold_page(zhdr, true)
> > > >       zhdr_to_pool(zhdr)
> > > >         slots_to_pool(zhdr->slots)  *BOOM*
> > >
> > > Thanks for looking into this. I'm not entirely sure I'm all for
> > > splitting free_handle() but let me think about it.
> > >
> > > > Instead we split free_handle into two functions, release_handle()
> > > > and free_slots(). We use release_handle() in place of free_handle(),
> > > > and use free_slots() to call kmem_cache_free() after
> > > > __release_z3fold_page() is done.
> > >
> > > A little less intrusive solution would be to move backlink to pool
> > > from slots back to z3fold_header. Looks like it was a bad idea from
> > > the start.
> > >
> > > Best regards,
> > >    Vitaly
> >
> > We still want z3fold pages to be movable though. Wouldn't moving
> > the backink to the pool from slots to z3fold_header prevent us from
> > enabling migration?
>
> That is a valid point but we can just add back pool pointer to
> z3fold_header. The thing here is, there's another patch in the
> pipeline that allows for a better (inter-page) compaction and it will
> somewhat complicate things, because sometimes slots will have to be
> released after z3fold page is released (because they will hold a
> handle to another z3fold page). I would prefer that we just added back
> pool to z3fold_header and changed zhdr_to_pool to just return
> zhdr->pool, then had the compaction patch valid again, and then we
> could come back to size optimization.

I see your point, patch incoming.
