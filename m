Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE3BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D388D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X/LzmRNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKKRXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:23:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39362 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKKRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:23:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id 29so9849334pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yAajaC8HCWYzucX9F7lpdzKRK9O4DP5SS69z8MpuzC8=;
        b=X/LzmRNI+PAfGCx7iOXc7jITwTbPHloj6W9cE45iZE62pceyrxHDPEHiavfj9tEFm4
         3ssTDoHViE0PIaYRTxiES+N/vQ0V6XBCRSxJLkNHA5EmXVvGMUKq6TH0JVEbtbv7eJIs
         og7HVJoMSxXZSuRdEpfAiyzG2OcgsCx2ssepg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yAajaC8HCWYzucX9F7lpdzKRK9O4DP5SS69z8MpuzC8=;
        b=LOOafWwy3rVssb/U4UQErtDrpsBTytakKnZ5qeLqpOf6sRboZwyQho7x3rwHgO+Pa8
         wGm/WdQhUoLvuiVGGXYSUcMK5/DmbaZiEEt1IJFyPJdx8jeE7zwUPq1EYEQ5RPKg7Wr+
         jadP9MVkVO6JTFai1ba1xmJTOm+NKujH7HkZnfk+tYuTtH274sZ4JITld+owdVsdkhMQ
         Enematj9jCxhIFJmlA9sBpZ75iBzhVvo+1Vjpi9qo4RafeLmT0O8buC+8hxFjkItE0ul
         F7YN0umM5grC6lQSNDrM1e8bkrijeFP/xvKPnlBQL8pJiotlkWb+Y8LO5lB0IljmfGPE
         54Hg==
X-Gm-Message-State: APjAAAWXi+u08Z7sBS5M64rp1As0L3anREl08qVgDHDm8qHwwoj33ovX
        hnIXAO1HHa8MnA3yAol4FtJqLg==
X-Google-Smtp-Source: APXvYqyYRSzpwUPLuEiDxWQRl2mmu7HM3K81RSwKffyFA1Sp64Zbaq8qhH85VUnK4TNVxH3gOyo1gQ==
X-Received: by 2002:a17:90a:5d0e:: with SMTP id s14mr85161pji.55.1573492985697;
        Mon, 11 Nov 2019 09:23:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm22800000pgn.49.2019.11.11.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 09:23:04 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:23:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
Message-ID: <201911110922.17A2112B0@keescook>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-12-keescook@chromium.org>
 <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:58:06PM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Fri, Oct 11, 2019 at 2:07 AM Kees Cook <keescook@chromium.org> wrote:
> > There's no reason to keep the RODATA macro: replace the callers with
> > the expected RO_DATA macro.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/alpha/kernel/vmlinux.lds.S      | 2 +-
> >  arch/ia64/kernel/vmlinux.lds.S       | 2 +-
> >  arch/microblaze/kernel/vmlinux.lds.S | 2 +-
> >  arch/mips/kernel/vmlinux.lds.S       | 2 +-
> >  arch/um/include/asm/common.lds.S     | 2 +-
> >  arch/xtensa/kernel/vmlinux.lds.S     | 2 +-
> >  include/asm-generic/vmlinux.lds.h    | 4 +---
> >  7 files changed, 7 insertions(+), 9 deletions(-)
> 
> Somehow you missed:
> 
>     arch/m68k/kernel/vmlinux-std.lds:  RODATA
>     arch/m68k/kernel/vmlinux-sun3.lds:      RODATA

Argh. I've sent a patch; sorry and thanks for catching this. For my own
cross-build testing, which defconfig targets will hit these two linker
scripts?

-Kees

> 
> Leading to build failures in next-20191111:
> 
>     /opt/cross/kisskb/gcc-4.6.3-nolibc/m68k-linux/bin/m68k-linux-ld:./arch/m68k/kernel/vmlinux.lds:29:
> syntax error
>     make[1]: *** [/kisskb/src/Makefile:1075: vmlinux] Error 1
> 
> Reported-by: noreply@ellerman.id.au
> http://kisskb.ellerman.id.au/kisskb/buildresult/14022846/
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kees Cook
