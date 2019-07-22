Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DEDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6EA2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dj43T+n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfGVSVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:21:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGVSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:21:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so17771325pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HTjPBTADUPMB5RaGA9y0UyTqoJ3Kfn/iq/tEhGgaR3M=;
        b=Dj43T+n6Vxg6cN3csQHecassw0CJtE++5r2L9ZQaygl4xXVA6mYVT88ZTYnI46lB+W
         UNIKPs2wU27c+wvDPegaFAoelU0c0duzUcGIdc9b/fPDUKuu5QlRlibQ/0HLFnvruEZ9
         RY9iOqCmvHk4MAaJgioF+tjnWh1lxA7mBoapM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HTjPBTADUPMB5RaGA9y0UyTqoJ3Kfn/iq/tEhGgaR3M=;
        b=Ju/IQsEWS1zH/AuhhzJeq/wsIEf2+8qzzLzoKBwmSjIwR50ZYaZO0XKNjGpwDlYSjM
         9VKtxMUP+P6wYYe/4Imla2zY1zjo6YUrOujb+Nqy3l9H4N9n3GncxONU1NYoC6CXJGt4
         jRNBe5rDsqVlkilQ54vgGkLjJpuKcKpNdwO3o3bHwZKVQQTDabWCZaFgSC45UYWAsh09
         0iawgo6Ol3XPtHxiyowbpmrCzmKZ5fionhUgG539OA5zhUvK9Cu5odaqJRcwqIw9qcbQ
         Oc/4roGjr1Q3eV6pDYQIDyyx4f3XqpVY8GwS13wZYH5KOHfwDOQCoZaqTZ1hV4iZRSCD
         nSXA==
X-Gm-Message-State: APjAAAV6fiv5g17JcyTPvW9z4EiBhX1zdjygsGLhEeuUsEqhfDraDbvG
        OFT30lRfflxO8VEQro7r+ILRdVLZmQ8=
X-Google-Smtp-Source: APXvYqxd3ea3RMFRO/3G58OJVS+XLsxkndJ9CGsP8Y9p3sWvtvNRL3X4fkjIxQDOHpdZdeRpM3Xcbg==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr2771111pjb.135.1563819691252;
        Mon, 22 Jul 2019 11:21:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v184sm38171686pgd.34.2019.07.22.11.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 11:21:30 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:21:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nitin Gote <nitin.r.gote@intel.com>, akpm@linux-foundation.org,
        corbet@lwn.net, apw@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [RFC PATCH] string.h: Add stracpy/stracpy_pad (was: Re: [PATCH]
 checkpatch: Added warnings in favor of strscpy().)
Message-ID: <201907221119.9ECF3466@keescook>
References: <1562219683-15474-1-git-send-email-nitin.r.gote@intel.com>
 <f6a4c2b601bb59179cb2e3b8f4d836a1c11379a3.camel@perches.com>
 <d1524130f91d7cfd61bc736623409693d2895f57.camel@perches.com>
 <201907221031.8B87A9DE@keescook>
 <b9bb5550b264d4b29b2b20f7ff8b1b40d20def6a.camel@perches.com>
 <2c959c56c23d0052e5c35ecfa2f6051b17fb2798.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c959c56c23d0052e5c35ecfa2f6051b17fb2798.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:58:15AM -0700, Joe Perches wrote:
> On Mon, 2019-07-22 at 10:43 -0700, Joe Perches wrote:
> > On Mon, 2019-07-22 at 10:33 -0700, Kees Cook wrote:
> > > On Thu, Jul 04, 2019 at 05:15:57PM -0700, Joe Perches wrote:
> > > > On Thu, 2019-07-04 at 13:46 -0700, Joe Perches wrote:
> > > > > On Thu, 2019-07-04 at 11:24 +0530, Nitin Gote wrote:
> > > > > > Added warnings in checkpatch.pl script to :
> > > > > > 
> > > > > > 1. Deprecate strcpy() in favor of strscpy().
> > > > > > 2. Deprecate strlcpy() in favor of strscpy().
> > > > > > 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> > > > > > 
> > > > > > Updated strncpy() section in Documentation/process/deprecated.rst
> > > > > > to cover strscpy_pad() case.
> > > > 
> > > > []
> > > > 
> > > > I sent a patch series for some strscpy/strlcpy misuses.
> > > > 
> > > > How about adding a macro helper to avoid the misuses like:
> > > > ---
> > > >  include/linux/string.h | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > > 
> > > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > > index 4deb11f7976b..ef01bd6f19df 100644
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > > > @@ -35,6 +35,22 @@ ssize_t strscpy(char *, const char *, size_t);
> > > >  /* Wraps calls to strscpy()/memset(), no arch specific code required */
> > > >  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> > > >  
> > > > +#define stracpy(to, from)					\
> > > > +({								\
> > > > +	size_t size = ARRAY_SIZE(to);				\
> > > > +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> > > > +								\
> > > > +	strscpy(to, from, size);				\
> > > > +})
> > > > +
> > > > +#define stracpy_pad(to, from)					\
> > > > +({								\
> > > > +	size_t size = ARRAY_SIZE(to);				\
> > > > +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> > > > +								\
> > > > +	strscpy_pad(to, from, size);				\
> > > > +})
> > > > +
> > > >  #ifndef __HAVE_ARCH_STRCAT
> > > >  extern char * strcat(char *, const char *);
> > > >  #endif
> > > 
> > > This seems like a reasonable addition, yes. I think Coccinelle might
> > > actually be able to find all the existing strscpy(dst, src, sizeof(dst))
> > > cases to jump-start this conversion.
> > 
> > I did that.  It works.  It's a lot of conversions.
> > 
> > $ cat str.cpy.cocci
> > @@
> > expression e1;
> > expression e2;
> > @@
> > 
> > - strscpy(e1, e2, sizeof(e1))
> > + stracpy(e1, e2)
> > 
> > @@
> > expression e1;
> > expression e2;
> > @@
> > 
> > - strlcpy(e1, e2, sizeof(e1))
> > + stracpy(e1, e2)
> > 
> > > Devil's advocate: this adds yet more string handling functions... will
> > > this cause even more confusion?
> > 
> > Documentation is good.
> > Actual in-kernel use and examples better.
> 
> btw: I just ran this again and it produces:
> 
> $ spatch --in-place -sp-file str.cpy.cocci .
> $ git checkout tools/
> $ git diff --shortstat
>  958 files changed, 2179 insertions(+), 2655 deletions(-)

Cool. Well, assuming no one hates this, let's do it. :) Can you send a
more complete patch with docs, etc? Maybe Linus will take it for late
in the next merge window, perhaps?

-- 
Kees Cook
