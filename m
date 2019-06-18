Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092A5C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8E42084A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mbMHRGKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfFRRNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:13:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43430 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:13:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8022229pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8dfHJTcLRV8CC1mU6B4Yjhb5Vh1wRhQVUvut0lc2uNw=;
        b=mbMHRGKIlQDxbHcba0Ej6Fw/3WXDqNBISRpyYauUMAwFrj9x3zRQ0crkJLJBmtD9SC
         e/XpkcddKgQfCxNWz9pWl3k0vJxjwAqWKq1Mxm7Gh+NM4U5Hcxp17f/sMWkxYTkPwgUv
         p9lUUjvxkAqHt/oYiRNGpEhGsjurbAYxwyG3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dfHJTcLRV8CC1mU6B4Yjhb5Vh1wRhQVUvut0lc2uNw=;
        b=MOhml2p8GEgy5cMRxBbt337Bu1KS2Lzz8usPHZzH8jnNMyWtzbDg44OYsVNxOYH2Ul
         nzh6VewzSJongD7B3q4a4892Mox75uQrGmUL4Ji7yiMfUK67Jm9oJU/A1C8UvFvM3QYA
         DF+P/UhtVau4oP+T99BbXUN4Ij2tasK+tAd0LA4PnMyF792R0yznoeUI7JceJJOR7+ft
         qgcRGgmkptpq3wxeZHPvvNclI1f0bkECpsSjw/av++2djyZrOgFIr+X0+DzFZYO7MfL2
         6/ui++sobOotRZYOoM5CSfcTgqhEm7AubMNo1Lz1cmYxK43/QM7LIqDeqv2PLSlkYqd8
         HPDg==
X-Gm-Message-State: APjAAAXXsaQJBynSBul1njFKeCVKY0fDZQ1Uu7R+OuqytH0ndokpLwq1
        hX9fKQYT6Cc8prY9CISyEdns7g==
X-Google-Smtp-Source: APXvYqxV8NKnUFLTcZUcTOBY3j1D9IobFFuP7NnutOUhZzEvenssp4iBrpo3lTyuwqKyPxfqoDBojg==
X-Received: by 2002:a17:90a:aa0d:: with SMTP id k13mr5949863pjq.53.1560877980386;
        Tue, 18 Jun 2019 10:13:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6sm2734002pjo.32.2019.06.18.10.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 10:12:59 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:12:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3 3/3] x86/asm: Pin sensitive CR0 bits
Message-ID: <201906181010.922CE96EC@keescook>
References: <20190618045503.39105-1-keescook@chromium.org>
 <20190618045503.39105-4-keescook@chromium.org>
 <CAG48ez37iY3pfTWn4wiqdt7zdkSPpOcvz3gtwjTWAYz9qKbBNA@mail.gmail.com>
 <20190618122430.GF3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618122430.GF3419@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 02:24:30PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 18, 2019 at 11:38:02AM +0200, Jann Horn wrote:
> > On Tue, Jun 18, 2019 at 6:55 AM Kees Cook <keescook@chromium.org> wrote:
> > > With sensitive CR4 bits pinned now, it's possible that the WP bit for
> > > CR0 might become a target as well. Following the same reasoning for
> > > the CR4 pinning, this pins CR0's WP bit (but this can be done with a
> > > static value).
> > >
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/x86/include/asm/special_insns.h | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> > > index c8c8143ab27b..b2e84d113f2a 100644
> > > --- a/arch/x86/include/asm/special_insns.h
> > > +++ b/arch/x86/include/asm/special_insns.h
> > > @@ -31,7 +31,20 @@ static inline unsigned long native_read_cr0(void)
> > >
> > >  static inline void native_write_cr0(unsigned long val)
> > >  {
> > 
> > So, assuming a legitimate call to native_write_cr0(), we come in here...
> > 
> > > -       asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
> > > +       unsigned long bits_missing = 0;
> 
> ^^^
> 
> > > +
> > > +set_register:
> > > +       asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> > 
> > ... here we've updated CR0...
> > 
> > > +       if (static_branch_likely(&cr_pinning)) {
> > 
> > ... this branch is taken, since cr_pinning is set to true after boot...
> > 
> > > +               if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> > 
> > ... this branch isn't taken, because a legitimate update preserves the WP bit...
> > 
> > > +                       bits_missing = X86_CR0_WP;
> 
> ^^^
> 
> > > +                       val |= bits_missing;
> > > +                       goto set_register;
> > > +               }
> > > +               /* Warn after we've set the missing bits. */
> > > +               WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
> > 
> > ... and we reach this WARN_ONCE()? Am I missing something, or does
> > every legitimate CR0 write after early boot now trigger a warning?
> 
> bits_missing will be 0 and WARN will not be issued.
> 
> > > +       }
> > >  }

Yup, as Peter points out, bits_missing is only non-zero when bits went
missing. The normal case will skip the WARN_ONCE() (which is also
internally wrapped in unlikely()). And I would have noticed the very
loud WARN at every boot if this wasn't true. ;)

-- 
Kees Cook
