Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D86C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E942087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564239277;
	bh=OFml/XqGHlHC7b5jUffn+v4QUcYFkjegmPDDGqlHo8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=AwVq3xeWMjFQpjxbshfs6AbPFKrGWapCq/i8Jy/yjvsfMYBjhRbAVnLv7QbbzUPul
	 2WPJFQuncFF7BdpuNjCpnBds0pgZ2wNauRqujghDOshJFdlvuE6xfwMF3DDPt6g8b9
	 tAARTWuy5Brxjbc0OezxZCBLCMuXSe78M1yWn5oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfG0Oyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfG0Oyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:54:35 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DFF2083B;
        Sat, 27 Jul 2019 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564239274;
        bh=OFml/XqGHlHC7b5jUffn+v4QUcYFkjegmPDDGqlHo8g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YJPTCKbr4Ms6+mTlfX3AzaUAsmqSPZePSXEInMcrDoOwcjVpVO4EoLNTTETt0KOW3
         c/KexHE2kD7jkwbIDWjgMddLq5lxV5Ym0HGJW64ymZ/p4FT+x6aHnsY0i+n3ZF545d
         OhRJRGj+wUQeaIYy/YurV2wMQqX++8u1BgZI1d98=
Message-ID: <b4d640c2cd65a87a380115aafb68b8b48df15788.camel@kernel.org>
Subject: Re: [PATCH] mm: Make kvfree safe to call
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Date:   Sat, 27 Jul 2019 10:54:32 -0400
In-Reply-To: <20190727003851.GJ30641@bombadil.infradead.org>
References: <20190726210137.23395-1-willy@infradead.org>
         <CAKgT0UcMND12oZ1869howDjcbvRj+KwabaMuRk8bmLZPWbJWcg@mail.gmail.com>
         <e4b0d323ed0bc159d863945251cf3f4c4064526c.camel@kernel.org>
         <20190727003851.GJ30641@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-26 at 17:38 -0700, Matthew Wilcox wrote:
> On Fri, Jul 26, 2019 at 05:25:03PM -0400, Jeff Layton wrote:
> > On Fri, 2019-07-26 at 14:10 -0700, Alexander Duyck wrote:
> > > On Fri, Jul 26, 2019 at 2:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > 
> > > > Since vfree() can sleep, calling kvfree() from contexts where sleeping
> > > > is not permitted (eg holding a spinlock) is a bit of a lottery whether
> > > > it'll work.  Introduce kvfree_safe() for situations where we know we can
> > > > sleep, but make kvfree() safe by default.
> > > > 
> > > > Reported-by: Jeff Layton <jlayton@kernel.org>
> > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Luis Henriques <lhenriques@suse.com>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Carlos Maiolino <cmaiolino@redhat.com>
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > So you say you are adding kvfree_safe() in the patch description, but
> > > it looks like you are introducing kvfree_fast() below. Did something
> > > change and the patch description wasn't updated, or is this just the
> > > wrong description for this patch?
> 
> Oops, bad description.  Thanks, I'll fix it for v2.
> 
> > > > +/**
> > > > + * kvfree_fast() - Free memory.
> > > > + * @addr: Pointer to allocated memory.
> > > > + *
> > > > + * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
> > > > + * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
> > > > + * you are certain that you know which one to use.
> > > > + *
> > > > + * Context: Either preemptible task context or not-NMI interrupt.  Must not
> > > > + * hold a spinlock as it can sleep.
> > > > + */
> > > > +void kvfree_fast(const void *addr)
> > > > +{
> > > > +       might_sleep();
> > > > +
> > 
> >     might_sleep_if(!in_interrupt());
> > 
> > That's what vfree does anyway, so we might as well exempt the case where
> > you are.
> 
> True, but if we are in interrupt, then we may as well call kvfree() since
> it'll do the same thing, and this way the rules are clearer.
> 
> > > > +       if (is_vmalloc_addr(addr))
> > > > +               vfree(addr);
> > > > +       else
> > > > +               kfree(addr);
> > > > +}
> > > > +EXPORT_SYMBOL(kvfree_fast);
> > > > +
> > 
> > That said -- is this really useful?
> > 
> > The only way to know that this is safe is to know what sort of
> > allocation it is, and in that case you can just call kfree or vfree as
> > appropriate.
> 
> It's safe if you know you're not holding any spinlocks, for example ...
> 

Fair points all around. You can add:

    Reviewed-by: Jeff Layton <jlayton@kernel.org>

The only real question then is whether we'll incur any extra overhead
when some of these kvfree sites suddenly start queueing these up. One
would hope it wouldn't matter much on most workloads.


