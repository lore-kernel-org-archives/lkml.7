Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DF7C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2A721850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsd+hhLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGCUOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:14:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36222 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:14:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so2045381qtc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYUsHMTWauYHWqlo9ty/zJzUyUz6zmCJ5iqAlMLp6F0=;
        b=hsd+hhLlxEGDdvpWo6KHr+7ipbRO0Tpjqi/yfrTH9FDKheJ6fGdXTYEiCj28seOz2l
         g/TjkEb8Td3Ga7v6D+piUUejHsLAcijpARYZtwoW1RJSMUvPf87zMGya0KxPrJfVVMWv
         bXN+jQ3JwVWQpc3OowW7OKFslKmEJjOjFAwKepBGD6x1bI92iSiEiEc1IqRS7HLfsJqv
         3CzASWm+KFGMCY4sGVmn2d4Mnx8RYBGNFlTkPLYn2M151gj70N1GzxuERCluhe1sltCG
         abC0A5AraypsRtqrGUvR75f67LBlDm4d9i1Fj6ak8cbxNRGsLcYvu/UsFwm7fSvt8JBx
         TGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYUsHMTWauYHWqlo9ty/zJzUyUz6zmCJ5iqAlMLp6F0=;
        b=B0d65Qa8l8nLkhLH6sJarEWM9zBQI0nRKH/QcfFGWkXU1+777JDsL4NDvz5NiLz4va
         cs9ALhVDsEHrF+E4UMAgFrXy9glmWCEjCHh2N7XRoxCqwDIsUgAq3NfXQvWoDLO+Cqpq
         wn4O7SzjokmeWxD+Lij0zqnXOMWUDIw0ODJKopWDdzBTD1LV92zWsyz3GwsjU4irpkZ3
         oKe20PShAif9gjq0iwcsCpzazlAht/cZh70xicYfg91utcEsnwJwMvJVuKWcYTibnWBy
         4m9kDVktPJXSvE7OfRKnNgou7fsdx6wPpKWcPf05sSDIrxzcKtLkO9L9pM9HzdxlA16Q
         YQxg==
X-Gm-Message-State: APjAAAUN9Zyy4sKbqHF34VBP4VUFipG4CyLNzSQEOz5/stc8z2B9+Ktw
        IVJdUgDozdEn3ZokkkM88MqZBFlFHnP7VUnvt0547w==
X-Google-Smtp-Source: APXvYqxvm9RgE3mf6qJxv+IRH8IDppVFvJ1B6dViHCGIkkaRWjJXhzPOE5ckkXEYd2b2JX5VDQHFb3tCF7/zEqxZw4U=
X-Received: by 2002:a81:4c44:: with SMTP id z65mr23892003ywa.4.1562184885658;
 Wed, 03 Jul 2019 13:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190701173042.221453-1-henryburns@google.com>
 <CAMJBoFPbRcdZ+NnX17OQ-sOcCwe+ZAsxcDJoR0KDkgBY9WXvpg@mail.gmail.com>
 <CAGQXPTjX=7aD9MQAs2kJthFvPdd3x8Nh53oc=wZCXH_dvDJ=Vg@mail.gmail.com> <CAMJBoFMBLv9OpXtQkOAyZ-vw5Ktk1tYtvfT=GPPx8jnKBN01rg@mail.gmail.com>
In-Reply-To: <CAMJBoFMBLv9OpXtQkOAyZ-vw5Ktk1tYtvfT=GPPx8jnKBN01rg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 3 Jul 2019 13:14:34 -0700
Message-ID: <CALvZod57CZ20SG0eYu95=PDqJ+adoiUErdgAmhc_+qxDo68GoA@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold: Fix z3fold_buddy_slots use after free
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Henry Burns <henryburns@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 11:03 PM Vitaly Wool <vitalywool@gmail.com> wrote:
>
> On Tue, Jul 2, 2019 at 6:57 PM Henry Burns <henryburns@google.com> wrote:
> >
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
>

By adding pool pointer back to z3fold_header, will we still be able to
move/migrate/compact the z3fold pages?
