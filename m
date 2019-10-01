Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22AEECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D40215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QniD9QaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfJAR0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:26:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32772 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfJAR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:26:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so10564271lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAR0RBwMbf2yyt8D3rJqoJgYmrjosHv6bX62EdF0aHA=;
        b=QniD9QaAWjm+PFvkAhLgEp+JmCaGfc9L+++eA6cvgfrtzln6dbAh1DopzqIXrJYDno
         iJjX+3FZ7VG4jsZZ2S4Q1Xzhvj6/K26wnRoBkuTnXfXam93Kah/mvgIxdUmJ2pQ2++rj
         SuQNl/5mC6Drterco79Hamu+DvUPLIsy5qp0EhUiDsdJev+sgvQ/YWeS/Yvqk7hkkKkp
         4G6prj3A8shDZIzfTgQR/Up2MqClVsDyWyn0qkgH9gR41txzc63h//HIGqbzkId9n4qx
         ltwnCQhJra0wJS9B7TLJ/QRkRQRu6+CnPI8fIHnwCjN5qMnR6KOJHFAFpQxmbDjCpz1r
         lR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAR0RBwMbf2yyt8D3rJqoJgYmrjosHv6bX62EdF0aHA=;
        b=nc+oLzKezlBc+5Xb+I1sHR7BmHQyCfMRFh6LMmXe0+HQMPFyqa8nfQKl42UCX+bD6F
         SA1JxI1rcwHCqh/xTiT7E8qmJNc8rTwcuxig6QoZ5WW/eVrDFCSj5ucanOISVW3zlc6A
         pNVy+Ij+rMmOZ4gOVBGeJXmtFGu2vK/xjHceZyGi2+b8M65c4LRa0k2qAa+UUdXHlQ2z
         kpkEov+NT2ewSZacQicKVcGp6+uWQn7IFGwwrxGVjEi1HBhH5flGhn6qU8jSTsJUCp2i
         b8TP6PklH/87m/ut8U0yLHRbmUnvKoAO0xuJ7WSrU9S/s5mTTHGTepDoSpLJMa6pFq2K
         kDDQ==
X-Gm-Message-State: APjAAAV0YNQaJlNpKCl0mYQkTJReyddLOly4i0+Y/G3AIsxAbagrhqSU
        XHdJMssYXzu9sEfTjG4cZgbuLc3YlBjK4ELeYdiyBw==
X-Google-Smtp-Source: APXvYqxkrtLIcIhxRpIths4HSf5I+CuSzZzYk6BCkkJ1+0Z9MpvyrHkpJeUiw4RGat+ob1R0C3ta/Qp+jujpzBj9LcU=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr15478422lfq.68.1569950809441;
 Tue, 01 Oct 2019 10:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191001121623.GA22532@ziepe.ca> <CABEDWGzsJR+YpX7eDrt_EerT0VEHjpBXSpc6Nzbbmvqc2OiR8Q@mail.gmail.com>
 <20191001171220.GF22532@ziepe.ca>
In-Reply-To: <20191001171220.GF22532@ziepe.ca>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 1 Oct 2019 10:26:38 -0700
Message-ID: <CABEDWGyDh6t2t9UXpw=tu1f6Sz=3YTMH6mG05cSTz74zyR9H+A@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 10:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 01, 2019 at 10:09:48AM -0700, Alan Mikhak wrote:
> > On Tue, Oct 1, 2019 at 5:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> > > > From: Alan Mikhak <alan.mikhak@sifive.com>
> > > >
> > > > Modify sg_miter_stop() to validate the page pointer
> > > > before calling PageSlab(). This check prevents a crash
> > > > that will occur if PageSlab() gets called with a page
> > > > pointer that is not backed by page struct.
> > > >
> > > > A virtual address obtained from ioremap() for a physical
> > > > address in PCI address space can be assigned to a
> > > > scatterlist segment using the public scatterlist API
> > > > as in the following example:
> > > >
> > > > my_sg_set_page(struct scatterlist *sg,
> > > >                const void __iomem *ioaddr,
> > > >                size_t iosize)
> > > > {
> > > >       sg_set_page(sg,
> > > >               virt_to_page(ioaddr),
> > > >               (unsigned int)iosize,
> > > >               offset_in_page(ioaddr));
> > > >       sg_init_marker(sg, 1);
> > > > }
> > > >
> > > > If the virtual address obtained from ioremap() is not
> > > > backed by a page struct, virt_to_page() returns an
> > > > invalid page pointer. However, sg_copy_buffer() can
> > > > correctly recover the original virtual address. Such
> > > > addresses can successfully be assigned to scatterlist
> > > > segments to transfer data across the PCI bus with
> > > > sg_copy_buffer() if it were not for the crash in
> > > > PageSlab() when called by sg_miter_stop().
> > >
> > > I thought we already agreed in general that putting things that don't
> > > have struct page into the scatter list was not allowed?
> > >
> > > Jason
> >
> > Thanks Jason for your comment.
> >
> > Cost of adding page structs to a large PCI I/O address range can be
> > quite substantial. Allowing PCI I/O pages without page structs may be
> > desirable. Perhaps it is worth considering this cost.
>
> This is generally agreed, but nobody has figured out a solution.
>
> > Scatterlist has no problem doing its memcpy() from pages without a
> > page struct that were obtained from ioremap(). It is only at
>
> Calling memcpy on pointers from ioremap is very much not allowed. Code
> has to use the iomem safe memcpy.
>
Is it in the realm of possible to add support for such PCI I/O pages
to scatterlist? Perhaps some solution is possible by adding a new
function, say sg_set_iomem_page(), and a new SG_MITER_IOMEM flag that
tells scatterlist to use iomem safe memcpy functions when the page is
not backed by page struct because it was obtained from ioremap(). This
flag can also be used at sg_miter_stop() to not call PageSlab() or
flush_kernel_dcache_page().

If supporting PCI I/O pages is not possible, would it be possible to
check for invalid page pointers in sg_set_page() and communicate the
requirement for a page struct backing in its description?

Alan
> Jason
