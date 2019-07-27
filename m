Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BF4C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 00:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394A922BF5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 00:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seLQcuWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfG0Aiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 20:38:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfG0Aiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vX3HX++H8FmKlfKaZ9xE3OKPlAYHgui3BNbzlA6WfOg=; b=seLQcuWQ9l+ahJ/jJ2TW3xmNh
        8Fd8u4bC+a2yPgf1X9h7DGdfz5aKukAwbQ56fEWeWFKaQX5/debmR9XWEoLpFFpNDpl9+sH0joFjQ
        JnacKLuSYm1Sg7A6gpvQYt6mK/aPakD1pHE/JlEp1zNtGDotoemVv3jHEX+NsYwmUKwth+cAUcTf3
        zOs8gNyo88rzJacIINOX4ZKDI+WyAEVwm+mE+5JRGRmjU+CFfSfTMl+mHFMzQp7Cw8+FreQcZz8AX
        4S4B6nECv/VkG2VAjx9OuCPO6Us+aG7MLIWXfT2aeTf2Ml+k9vwu7UR2hZB3A6zcEmoT5g0jDFkDp
        TUiPBSwDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hrAjb-0007V1-Ak; Sat, 27 Jul 2019 00:38:51 +0000
Date:   Fri, 26 Jul 2019 17:38:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] mm: Make kvfree safe to call
Message-ID: <20190727003851.GJ30641@bombadil.infradead.org>
References: <20190726210137.23395-1-willy@infradead.org>
 <CAKgT0UcMND12oZ1869howDjcbvRj+KwabaMuRk8bmLZPWbJWcg@mail.gmail.com>
 <e4b0d323ed0bc159d863945251cf3f4c4064526c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b0d323ed0bc159d863945251cf3f4c4064526c.camel@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 05:25:03PM -0400, Jeff Layton wrote:
> On Fri, 2019-07-26 at 14:10 -0700, Alexander Duyck wrote:
> > On Fri, Jul 26, 2019 at 2:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Since vfree() can sleep, calling kvfree() from contexts where sleeping
> > > is not permitted (eg holding a spinlock) is a bit of a lottery whether
> > > it'll work.  Introduce kvfree_safe() for situations where we know we can
> > > sleep, but make kvfree() safe by default.
> > > 
> > > Reported-by: Jeff Layton <jlayton@kernel.org>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Luis Henriques <lhenriques@suse.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Carlos Maiolino <cmaiolino@redhat.com>
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > So you say you are adding kvfree_safe() in the patch description, but
> > it looks like you are introducing kvfree_fast() below. Did something
> > change and the patch description wasn't updated, or is this just the
> > wrong description for this patch?

Oops, bad description.  Thanks, I'll fix it for v2.

> > > +/**
> > > + * kvfree_fast() - Free memory.
> > > + * @addr: Pointer to allocated memory.
> > > + *
> > > + * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
> > > + * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
> > > + * you are certain that you know which one to use.
> > > + *
> > > + * Context: Either preemptible task context or not-NMI interrupt.  Must not
> > > + * hold a spinlock as it can sleep.
> > > + */
> > > +void kvfree_fast(const void *addr)
> > > +{
> > > +       might_sleep();
> > > +
> 
>     might_sleep_if(!in_interrupt());
> 
> That's what vfree does anyway, so we might as well exempt the case where
> you are.

True, but if we are in interrupt, then we may as well call kvfree() since
it'll do the same thing, and this way the rules are clearer.

> > > +       if (is_vmalloc_addr(addr))
> > > +               vfree(addr);
> > > +       else
> > > +               kfree(addr);
> > > +}
> > > +EXPORT_SYMBOL(kvfree_fast);
> > > +
> 
> That said -- is this really useful?
> 
> The only way to know that this is safe is to know what sort of
> allocation it is, and in that case you can just call kfree or vfree as
> appropriate.

It's safe if you know you're not holding any spinlocks, for example ...

