Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E5FECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A3B215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fLi7Mwz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfJARqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:46:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44285 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJARqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:46:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id q11so10562809lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFxvzQ868XnHaCbPvW/MGK7d5M5xYPEHW1JZKRblTE4=;
        b=fLi7Mwz4uSSLCO81FntkOs5IGkwiPM3NHkCP+7Rl7Etd3mbuSZCy4JCTYBlwtPvJ7a
         yXOOWH+Jja9PT8cCaSsLl7V7nPe0jd7CcicTB5NMx+rHe+sEAhl7mjLJOx0li9+zl6zB
         eMRcw9s01k46/gg8JvAvP/XrqwDCSV+Mai83OFeIBI0N8FHznKkJrUqmewaf9bhCedd3
         Vga1/puh1H8HbGHm0ov8SJVuGTnTDxdMTCKycKF7Sgj0EYQW18FVt+Cl4RBArnGTPMWB
         L+nQjjt7ThpRh27oerCtp6c9V+gEPZUkuvcV/h0n4zSuQBn6ghlQQ3plaGlsB4rUj4LD
         3GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFxvzQ868XnHaCbPvW/MGK7d5M5xYPEHW1JZKRblTE4=;
        b=XwFqQ7HOrNBfRfTZsLnN+m65GvjEvwfF4j/xi9AMCsj0tBjmVR1NYphqAnR4UlrGU8
         8/AnKXxMAYQSlQFUQFZTOqAGWMh0VQ2/89sQm8LCzB+sZjkgxsYEjwoyWcAmo0ySyx3+
         UX9CypKuU0qYRZB03u8yQ6ez4nop64hrWzJM63IqnPYCT27st16jRfljk/kZeHlpihny
         qnVy6nfduN18EaxbYGR176PBiqt1tRpZYHVY5Y3GMZ7M1wqvZz8aQog40URz96t+LTba
         HZOohGJvy8uA6ugYVP/HetCKT24JsIqfYQISEzhp2mooY45fqPFh49SytVdbzBM3lk/S
         k3ow==
X-Gm-Message-State: APjAAAUzCBBq6gLCjKgZE3PmhykCFPliEZBT8zJ6IoeTbfqYEoGC7tPa
        cOfG3bVv/l4Ky0g1o9a1+kbZH+0Htsq+Ba+hBl7Tsg==
X-Google-Smtp-Source: APXvYqxbk2zkBDBOfOhi9snvaVoRVLfFmGRqcT3LEo7ASDekjNqlwIWyMpxirk4hCy0ams0VFRIhgZ3G2gQuDfaxfso=
X-Received: by 2002:a19:8a0b:: with SMTP id m11mr15781955lfd.4.1569951991954;
 Tue, 01 Oct 2019 10:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191001121623.GA22532@ziepe.ca> <CABEDWGzsJR+YpX7eDrt_EerT0VEHjpBXSpc6Nzbbmvqc2OiR8Q@mail.gmail.com>
 <20191001171220.GF22532@ziepe.ca> <CABEDWGyDh6t2t9UXpw=tu1f6Sz=3YTMH6mG05cSTz74zyR9H+A@mail.gmail.com>
 <20191001174358.GG22532@ziepe.ca>
In-Reply-To: <20191001174358.GG22532@ziepe.ca>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 1 Oct 2019 10:46:21 -0700
Message-ID: <CABEDWGwTd1N5897kZKcfOWSFNxS67QHKFU6uiwHBp0BFJBDFtg@mail.gmail.com>
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

On Tue, Oct 1, 2019 at 10:44 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 01, 2019 at 10:26:38AM -0700, Alan Mikhak wrote:
>
> > > > Cost of adding page structs to a large PCI I/O address range can be
> > > > quite substantial. Allowing PCI I/O pages without page structs may be
> > > > desirable. Perhaps it is worth considering this cost.
> > >
> > > This is generally agreed, but nobody has figured out a solution.
> > >
> > > > Scatterlist has no problem doing its memcpy() from pages without a
> > > > page struct that were obtained from ioremap(). It is only at
> > >
> > > Calling memcpy on pointers from ioremap is very much not allowed. Code
> > > has to use the iomem safe memcpy.
> >
> > Is it in the realm of possible to add support for such PCI I/O pages
> > to scatterlist? Perhaps some solution is possible by adding a new
> > function, say sg_set_iomem_page(), and a new SG_MITER_IOMEM flag that
> > tells scatterlist to use iomem safe memcpy functions when the page is
> > not backed by page struct because it was obtained from ioremap(). This
> > flag can also be used at sg_miter_stop() to not call PageSlab() or
> > flush_kernel_dcache_page().
>
> People have tried many different things so far, it is more comple than
> just the copy functions as there is also sg_page to worry about.
>
> > If supporting PCI I/O pages is not possible, would it be possible to
> > check for invalid page pointers in sg_set_page() and communicate the
> > requirement for a page struct backing in its description?
>
> Clarifying the comments seems reasonable to me.
>
> Jason

Thanks Jason. I'll submit a patch to communicate the requirement in
the description of sg_set_page().

Alan
