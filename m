Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA828ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913582070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jpLjP0sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbfJAPsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:48:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45840 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389634AbfJAPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:48:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so8269929pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aHMpO9J+CUbgrwJq2FPC5hQWPjIgrqNx/lVINe55yAg=;
        b=jpLjP0sVOqJ1io2GkUXKgc45cxfb7B1taqxOFsmCAMNJmlj5/fV9ZG/T16NITs4W9q
         cvbqYDNjPkgubuNgZtxJd+JdNRYNQcuTsRwBP+njU1INPXE7gYMZOi6b7xlFMKDrD14J
         DKcbIR540vNINUnM0FJ0c/BvYD5Gp0RtEXiDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHMpO9J+CUbgrwJq2FPC5hQWPjIgrqNx/lVINe55yAg=;
        b=Gy7LLPE1qIw7qIAmtrgB17trV4BxoWSfG7CLzKTvbo3Hddw053uzckJqc9er5q0kMx
         mM114bDcx13072erb8fWankOQLNymaW5YXVVbiLevfXmGDMAcNf8Z4mZRliQmN1ZPXu+
         AG4yFmestVHPuwX1ag9f7pEolpFlq48UYmkUB9dFsXR2G4h7Sc1Gzo0yX8iZkr3CIlPQ
         KiNCDWpVhu8HMWFbLnoKULpoS5UKd0IxwZ4AdExXEdyfWh4tf7YxQrywUnwz0kT6Baec
         MfYY6W48t1UwmFYVrUNdYVc8XS6X0VhlzkZ6YRFzaoBsuhX47XKPCGVJCCRtfa5ikB1g
         Hp8A==
X-Gm-Message-State: APjAAAXKwXD3uNGr6jDVF4+uc7GmBDKrmR9B8IrKZdSf14HiZ3t1ETln
        4YLYdQF9esYLvpaUHY6fxFJJ/g==
X-Google-Smtp-Source: APXvYqyO5jsKdDXhDO3bZGk1Keogaj2M/8EIIuQkcNmk5YSzFsJ5w0LY+0szmD2PzpB1320gFGeS9A==
X-Received: by 2002:a62:14c2:: with SMTP id 185mr27818394pfu.47.1569944893417;
        Tue, 01 Oct 2019 08:48:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm1559678pge.76.2019.10.01.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 08:48:12 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:48:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/29] arm64: Move EXCEPTION_TABLE to RO_DATA segment
Message-ID: <201910010846.D0712C1@keescook>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-19-keescook@chromium.org>
 <20191001090355.blnaqlf4rfzucpb2@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001090355.blnaqlf4rfzucpb2@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:03:56AM +0100, Will Deacon wrote:
> Hi Kees,
> 
> On Thu, Sep 26, 2019 at 10:55:51AM -0700, Kees Cook wrote:
> > The EXCEPTION_TABLE is read-only, so collapse it into RO_DATA.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/kernel/vmlinux.lds.S | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 81d94e371c95..c6ba2eee0ee8 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -5,6 +5,8 @@
> >   * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
> >   */
> >  
> > +#define RO_DATA_EXCEPTION_TABLE_ALIGN	8
> > +
> >  #include <asm-generic/vmlinux.lds.h>
> >  #include <asm/cache.h>
> >  #include <asm/kernel-pgtable.h>
> > @@ -135,8 +137,8 @@ SECTIONS
> >  	. = ALIGN(SEGMENT_ALIGN);
> >  	_etext = .;			/* End of text section */
> >  
> > -	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
> > -	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
> > +	/* everything from this point to __init_begin will be marked RO NX */
> > +	RO_DATA(PAGE_SIZE)
> >  
> >  	. = ALIGN(PAGE_SIZE);
> 
> Do you reckon it would be worth merging this last ALIGN directive into the
> RO_DATA definition too? Given that we want to map the thing read-only, it
> really has to be aligned either side.

Actually, taking a closer look, this appears to be redundant: RO_DATA()
ends with:

	. = ALIGN(align)

(where "align" is the "PAGE_SIZE" argument to RO_DATA())

> Anyway, that's only a nit, so:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

> P.S. Please CC the arm64 maintainers on arm64 patches -- I nearly missed
> this one!

Okay, I can re-expand my list. I originally had done this but it was
getting to be a rather large set of people. :)

-- 
Kees Cook
