Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDABEC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D88206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQmmqup/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfG2SmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:42:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41161 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387980AbfG2SmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:42:22 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so118171266ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tfpxcMIOawO8s0nF6u5AxpRiYOClgINgvc5ma6ttZw=;
        b=IQmmqup/6r9M4vGzFNJ2eQeqgw7xlIoAUs5jeMBIFXwMw1/6E8KZwGF59gU1R/s1wr
         od8n0zVv12PnonheCchmyOFja2Rj5CqOQgVE6IuSCXp0atpMNpN4A4t4/7Vf5jI1f1tC
         bqmDTxp9EjXqdrgmgE7jOAMpjGGp01BzpAfRmS/bOjpScIYhwcfWKhJCbOf4mGM/MuOx
         kfDC4rfXTjw6TLq0kV/0cEZZi4Hv/UOPJ9FqlF/1RHxu+j97c80UihRGIktDhfVOQUtm
         u+Knabw655Ohtf9vz38yQiZVVGmgt0OllVIj/2aK5dgiGvZqqDwcxin29m4BabmpHLuu
         rFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tfpxcMIOawO8s0nF6u5AxpRiYOClgINgvc5ma6ttZw=;
        b=tGaHCJLMBl7hNuGXr4e1dJs7eYUbdo91MJ2igJ0HgW/B/VutQBDDkX+pBPsRTkby6n
         G1ZHR3+fSZrHAdRJ+Z4aeyUv4Dq03cqPh4S02MkSVd+gz+h1Yfr3zbq9RN69aE3rmX+5
         0wyVjDt839dATRkizYAlnpI44c78xIs871iddv8fIqMbULF6el1DKIpXNG9tJeGYCD66
         4Lac3uvrRM2wK61HvZxwsXFQEGTYR/jtuCg/0fAp+TPMg8m3q9F+CXLeKSB42k0kXc/g
         GztbIHdJCmfUvmYZ7MA4bOgG4KUgxMdzBTj0zPIpMVM+sIXs1DljImh4X3COFYpWpooj
         KJGw==
X-Gm-Message-State: APjAAAU4a0y4CPnzxAbcSJ/PcMT1yRWoQ/bw7EbZEtIsAYDynyzoRNdS
        G/o3ktOBXwRC9fggIQ+AlHtFiR3ljPhujH+MK4GnYw==
X-Google-Smtp-Source: APXvYqwjLiqzT6+l8biMGbT+ubzfDFZQP3pdxi7Bs2LEIu59aazQJHsn2226HIPI6J8GkYWgkqquogjLf6r6kCe70Dg=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr38575856iof.162.1564425741290;
 Mon, 29 Jul 2019 11:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com> <20190726224810.79660-2-henryburns@google.com>
 <CA+VK+GPC+akF0qGrKFivtNneweEfdC9uEx=QgmztB4M_xvMeKQ@mail.gmail.com>
In-Reply-To: <CA+VK+GPC+akF0qGrKFivtNneweEfdC9uEx=QgmztB4M_xvMeKQ@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Mon, 29 Jul 2019 11:41:45 -0700
Message-ID: <CAGQXPTi8+EanC2ygr4W7qDN1bnas_3utxFkSCj4Xdzo4H134nw@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() race condition
To:     Jonathan Adams <jwadams@google.com>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraint from the zpool use of z3fold_destroy_pool() is there
are no outstanding handles to memory (so no active allocations), but
it is possible for there to be outstanding work on either of the two
wqs in the pool.

Calling z3fold_deregister_migration() before the workqueues are drained
means that there can be allocated pages referencing a freed inode,
causing any thread in compaction to be able to trip over the bad
pointer in PageMovable().

Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")

Signed-off-by: Henry Burns <henryburns@google.com>

> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Jonathan Adams <jwadams@google.com>
>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/z3fold.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index 43de92f52961..ed19d98c9dcd 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -817,16 +817,19 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
> >  static void z3fold_destroy_pool(struct z3fold_pool *pool)
> >  {
> >         kmem_cache_destroy(pool->c_handle);
> > -       z3fold_unregister_migration(pool);
> >
> >         /*
> >          * We need to destroy pool->compact_wq before pool->release_wq,
> >          * as any pending work on pool->compact_wq will call
> >          * queue_work(pool->release_wq, &pool->work).
> > +        *
> > +        * There are still outstanding pages until both workqueues are drained,
> > +        * so we cannot unregister migration until then.
> >          */
> >
> >         destroy_workqueue(pool->compact_wq);
> >         destroy_workqueue(pool->release_wq);
> > +       z3fold_unregister_migration(pool);
> >         kfree(pool);
> >  }
> >
> > --
> > 2.22.0.709.g102302147b-goog
> >
