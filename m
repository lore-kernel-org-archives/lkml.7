Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11132C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A6B22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564176308;
	bh=ZMdUsOA413NREipWgNGiUNHEV337/SQnp+du76ZZxss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=2Ok/qmXzc8DGk/faBvWx74Hghqeme8LUQ50tg88y/chGeP/BK/wpbCQVgKL+eimrj
	 NXVDM7KKpIW4dRYQlx9tLe3nEsnxZrSfgAK61r0C1pgJN1KS4TBeEBp3Q6ncgi/HP6
	 S3Oj3SRKDiirXn4mqj50ITwz3nyL+jM9OmYVxYSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfGZVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfGZVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:25:07 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8DA2083B;
        Fri, 26 Jul 2019 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564176306;
        bh=ZMdUsOA413NREipWgNGiUNHEV337/SQnp+du76ZZxss=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SgoM4QTyfOezHqndzroxeVQLXZc50SrbGADq3WK34Po2ZYwAgUgtDk2BWLI8WUPDS
         QT+w4eRLC0ER0mBGJpRzxSzzYrouBUJ0OCJZJNck2mCYD7WvsZJek9KOkB8Nph03Rr
         tS+sH0DqV/9miLNPM2lwhKLFafryPhYtnKl8aJcM=
Message-ID: <e4b0d323ed0bc159d863945251cf3f4c4064526c.camel@kernel.org>
Subject: Re: [PATCH] mm: Make kvfree safe to call
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Date:   Fri, 26 Jul 2019 17:25:03 -0400
In-Reply-To: <CAKgT0UcMND12oZ1869howDjcbvRj+KwabaMuRk8bmLZPWbJWcg@mail.gmail.com>
References: <20190726210137.23395-1-willy@infradead.org>
         <CAKgT0UcMND12oZ1869howDjcbvRj+KwabaMuRk8bmLZPWbJWcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-26 at 14:10 -0700, Alexander Duyck wrote:
> On Fri, Jul 26, 2019 at 2:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Since vfree() can sleep, calling kvfree() from contexts where sleeping
> > is not permitted (eg holding a spinlock) is a bit of a lottery whether
> > it'll work.  Introduce kvfree_safe() for situations where we know we can
> > sleep, but make kvfree() safe by default.
> > 
> > Reported-by: Jeff Layton <jlayton@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Luis Henriques <lhenriques@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Carlos Maiolino <cmaiolino@redhat.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> So you say you are adding kvfree_safe() in the patch description, but
> it looks like you are introducing kvfree_fast() below. Did something
> change and the patch description wasn't updated, or is this just the
> wrong description for this patch?
> 
> > ---
> >  mm/util.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/util.c b/mm/util.c
> > index bab284d69c8c..992f0332dced 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -470,6 +470,28 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
> >  }
> >  EXPORT_SYMBOL(kvmalloc_node);
> > 
> > +/**
> > + * kvfree_fast() - Free memory.
> > + * @addr: Pointer to allocated memory.
> > + *
> > + * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
> > + * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
> > + * you are certain that you know which one to use.
> > + *
> > + * Context: Either preemptible task context or not-NMI interrupt.  Must not
> > + * hold a spinlock as it can sleep.
> > + */
> > +void kvfree_fast(const void *addr)
> > +{
> > +       might_sleep();
> > +

    might_sleep_if(!in_interrupt());

That's what vfree does anyway, so we might as well exempt the case where
you are.

> > +       if (is_vmalloc_addr(addr))
> > +               vfree(addr);
> > +       else
> > +               kfree(addr);
> > +}
> > +EXPORT_SYMBOL(kvfree_fast);
> > +

That said -- is this really useful?

The only way to know that this is safe is to know what sort of
allocation it is, and in that case you can just call kfree or vfree as
appropriate.

> >  /**
> >   * kvfree() - Free memory.
> >   * @addr: Pointer to allocated memory.
> > @@ -478,12 +500,12 @@ EXPORT_SYMBOL(kvmalloc_node);
> >   * It is slightly more efficient to use kfree() or vfree() if you are certain
> >   * that you know which one to use.
> >   *
> > - * Context: Either preemptible task context or not-NMI interrupt.
> > + * Context: Any context except NMI.
> >   */
> >  void kvfree(const void *addr)
> >  {
> >         if (is_vmalloc_addr(addr))
> > -               vfree(addr);
> > +               vfree_atomic(addr);
> >         else
> >                 kfree(addr);
> >  }
> > --
> > 2.20.1
> > 

-- 
Jeff Layton <jlayton@kernel.org>

