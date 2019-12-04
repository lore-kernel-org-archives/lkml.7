Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E630C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66678206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XofnVsh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfLDUu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:50:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33733 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:50:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id l63so691015ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq3LxKYOOomc+/QE33SRTklsyQdBe2jME5WH5NYH7Hk=;
        b=XofnVsh9JkrhplZ0OE7AUH7DsGvWdzLDYNfCfoxP0l7uUCOPFmiZWxdtwZzblCYEz8
         nzcH3SxfKhsCeer285czBZtVUVdiqAvyDPXXHbvpBPdshfdh4w4FF5Ng8H+oA31OjfUI
         vZPAxNhB2mjGDNunaPVs6r6Df+EF+XB70UgvdAQdXKp02x6VP+txnFgTTh5mY2PbTWBh
         aPKP8kNjSZ9Nvrd6ldUJWoy7jknWIGTYAA4U6EpTMVIIsriQ4TSB6X2dF7Rx8utkpo3r
         RjUET3r64LH2ttN2w9Ab+JOyQfISd+xC71qLWTi6TcfKwVeInFWLiTuMVy3Xo0/BLupS
         8Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq3LxKYOOomc+/QE33SRTklsyQdBe2jME5WH5NYH7Hk=;
        b=MA6l8HLgbcU+S72xdTUZ5x3gBPoTIypWBlvYrBtWHU9Jzjhzm8Ic3KEdRl1Y2mwYGW
         9IMK5+7LRdCWAVNYdCaTYrLL4dBwRwGlrYyJN29N3a7NlHhI7GBGIbKwrvdUC81FhdRY
         Q8NhijLDE/gjSWfVaqIW35lH+7yjNdo9pM3/27z8WQPq8b2PvsNhPeY7FMLT6wMtFMHw
         KGBSZEu35cC+i4KjRp3dJs9Dx4JjCdoCCJf4GtVUQcRju+8ZRq7lN1/Gxuz+XGdhyXs7
         u3vUyPn2hKz5hM0gIrB2D7kqRg8UlCM43fCjcoEcOZoXNPReKJ8kH96pRRCFjAplqpau
         H06w==
X-Gm-Message-State: APjAAAVapB7uZC/yMyp6MH6tUv2+d2N2pIV1lkovkxBSM4cWQUr2j9na
        c+vcgxr1dO6EVhlwqum6e8exVTap8n5B9r2F4PtTrQ==
X-Google-Smtp-Source: APXvYqwMdNLsGxvlCa1i0ErELJP4i0sWpocovAjl4xGOHiGed8ZySML2zMNhKfShRaQbEjYyznCmIueYA6VatjBeKCI=
X-Received: by 2002:a17:906:3798:: with SMTP id n24mr5230843ejc.15.1575492627075;
 Wed, 04 Dec 2019 12:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
 <20191127184453.229321-3-pasha.tatashin@soleen.com> <20191128145151.GB22314@lakrids.cambridge.arm.com>
In-Reply-To: <20191128145151.GB22314@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 4 Dec 2019 15:50:15 -0500
Message-ID: <CA+CK2bDPjLSECOeduZY7hVPreYYCTpgNMd4aTGSy=35E86W72Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: remove uaccess_ttbr0 asm macros from cache functions
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 9:51 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Nov 27, 2019 at 01:44:52PM -0500, Pavel Tatashin wrote:
> > We currently duplicate the logic to enable/disable uaccess via TTBR0,
> > with C functions and assembly macros. This is a maintenenace burden
> > and is liable to lead to subtle bugs, so let's get rid of the assembly
> > macros, and always use the C functions. This requires refactoring
> > some assembly functions to have a C wrapper.
>
> [...]
>
> > +static inline int invalidate_icache_range(unsigned long start,
> > +                                       unsigned long end)
> > +{
> > +     int rv;
>
> Please make this 'ret', for consistency with other arm64 code. We only
> use 'rv' in one place where it's short for "Revision and Variant", and
> 'ret' is our usual name for a temporary variable used to hold a return
> value.

OK

>
> > +
> > +     if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
> > +             isb();
> > +             return 0;
> > +     }
> > +     uaccess_ttbr0_enable();
>
> Please place a newline between these two, for consistency with other
> arm64 code.

OK

>
> > +     rv = asm_invalidate_icache_range(start, end);
> > +     uaccess_ttbr0_disable();
> > +
> > +     return rv;
> > +}
> > +
> >  static inline void flush_icache_range(unsigned long start, unsigned long end)
> >  {
> >       __flush_icache_range(start, end);
> > diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> > index db767b072601..a48b6dba304e 100644
> > --- a/arch/arm64/mm/cache.S
> > +++ b/arch/arm64/mm/cache.S
> > @@ -15,7 +15,7 @@
> >  #include <asm/asm-uaccess.h>
> >
> >  /*
> > - *   flush_icache_range(start,end)
> > + *   __asm_flush_icache_range(start,end)
> >   *
> >   *   Ensure that the I and D caches are coherent within specified region.
> >   *   This is typically used when code has been written to a memory region,
> > @@ -24,11 +24,11 @@
> >   *   - start   - virtual start address of region
> >   *   - end     - virtual end address of region
> >   */
> > -ENTRY(__flush_icache_range)
> > +ENTRY(__asm_flush_icache_range)
> >       /* FALLTHROUGH */
> >
> >  /*
> > - *   __flush_cache_user_range(start,end)
> > + *   __asm_flush_cache_user_range(start,end)
> >   *
> >   *   Ensure that the I and D caches are coherent within specified region.
> >   *   This is typically used when code has been written to a memory region,
> > @@ -37,8 +37,7 @@ ENTRY(__flush_icache_range)
> >   *   - start   - virtual start address of region
> >   *   - end     - virtual end address of region
> >   */
> > -ENTRY(__flush_cache_user_range)
> > -     uaccess_ttbr0_enable x2, x3, x4
> > +ENTRY(__asm_flush_cache_user_range)
> >  alternative_if ARM64_HAS_CACHE_IDC
>
> It's unfortunate that we pulled the IDC alternative out for
> invalidate_icache_range(), but not here.

Good point. I will fix that in a separate patch.

Thank you,
Pasha
