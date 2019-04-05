Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D602C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB620700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PfGSLmem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfDEQZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:25:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3WvIIh71Jf+m/yxArRSdlThAUD6ygUgbn+vJRvbgDLU=; b=PfGSLmem03lp10otTY24vBlEV
        L/RxOo+Yp9vO0wW0uOp7YUWbT6ocfi22lmodqg8804W/EoUwUPG7EjIsMRcVzft7a3Jfuno+qba8p
        CwXr53OwrvhY9U917/bxrcQv39X1BBl5/6KPrgRDPNB1D8hI7fqjkC8V8ZhIWhRPaACMhd4Q0hw76
        A/x40qfeN70/sSAstcWzwAusXxPsd9rRjCYsbvu02rg6bvdjEousS8ghlzjdJZHl7eDQ2y4JpNvC8
        7aOucY3Wamt+I7tJY9O0YqaHnh15D4dyNQYaZrcSovfxZ3ci4eKEIaqV9z1Xkv7A5Q0MJpV1hvt4B
        nIp33o2+g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCReh-000647-M6; Fri, 05 Apr 2019 16:25:27 +0000
Date:   Fri, 5 Apr 2019 09:25:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
Message-ID: <20190405162527.GP22763@bombadil.infradead.org>
References: <20190405045711.30339-1-bp@alien8.de>
 <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
 <20190405075251.GC23348@zn.tnic>
 <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
 <20190405082447.GD23348@zn.tnic>
 <CAGXu5jK6+ZcJQqchySsMicEy-Kd=TFRTE1M_JdhX4TaJDAPiaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK6+ZcJQqchySsMicEy-Kd=TFRTE1M_JdhX4TaJDAPiaQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:13:24AM -0700, Kees Cook wrote:
> On Fri, Apr 5, 2019 at 1:24 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 05, 2019 at 10:09:31AM +0200, Rasmus Villemoes wrote:
> > > On 05/04/2019 09.52, Borislav Petkov wrote:
> > > > On Fri, Apr 05, 2019 at 08:26:45AM +0200, Rasmus Villemoes wrote:
> > >
> > > >> It computes a*b+c with overflow checking at each step. calc_size
> > > >> is way too generic and doesn't say anything at all about how the
> > > >> calc(ulation) is done.
> > > >
> > > > Ok, whatever.
> > > >
> > > > Then it would need at least a comment above it to state what it does. I
> > > > don't want to go and parse the macros each time.
> > >
> > > It's an internal helper, and struct_size is fully kernel-doc'ed. But
> > > yeah, a comment wouldn't hurt, and let's rename the parameters so they
> > > match the abc naming.
> > >
> > > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > > index 40b48e2133cb..6534a727cadb 100644
> > > --- a/include/linux/overflow.h
> > > +++ b/include/linux/overflow.h
> > > @@ -278,11 +278,15 @@ static inline __must_check size_t
> > > array3_size(size_t a, size_t b, size_t c)
> > >         return bytes;
> > >  }
> > >
> > > -static inline __must_check size_t __ab_c_size(size_t n, size_t size,
> > > size_t c)
> > > +/*
> > > + * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
> > > + * struct_size() below.
> > > + */
> 
> May as well make this kern-doc too?

I don't think that's a good idea; we should only document functions we
want other people to use.

> > > +static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)

I could also go for renaming this to __size_ab_plus_c.

For a bit of history ... the origins of this was a system which had
alloc_ab (a * b)
alloc_abc (a * b * c)
alloc_ab_c (a * b + c)
alloc_ab_cd (a * b + c * d)

In the process of getting it upstreamed, it changed from kmalloc_ab_c to
kmalloc(struct_size(...)) and we never bothered to change the name of
__ab_c_size().
