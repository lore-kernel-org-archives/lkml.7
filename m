Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B36C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F2121670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ib8kP9oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfGISLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:11:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33542 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfGISLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:11:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so9866622pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9rTJgMykVUW5gRfUWEDbI//Knjbwf3ukGtodkxh/fo=;
        b=Ib8kP9oMyOKVcnaKmSIHd6rHEWZCy37dxMh2409gx7EBVJDKMAwFDcYqFqGzBgpUtZ
         VU8hhKl4BFnaWmKa6ZuW5qF8sd9KCpHVkOHJMmTkLfhRC67PlNc5QeHCwk1RKSFEZfhg
         RIws28WMU8JDV6IX16FkaPswhYoc/H3yTwv51VUTNW/xToHrf0cJ+lQF/kCxTkQ3oLru
         1331wGDxjru01KelnPfhqVbp+Jk7WxLFbKvp0CAftrysStSiwCWEBEfK0kixUwgKWX8B
         XmWENcr/vEpBA6wyJN9eviaR7xxJaZjog2JBokuUmPSG2cILj7vuJp8g+Q5Gk62Pxwd0
         HFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9rTJgMykVUW5gRfUWEDbI//Knjbwf3ukGtodkxh/fo=;
        b=a608mINhmSCjZs94SlikVbaYDIsa2HHjJHAldtk81S4eUvUzZsybz+uX58p0RFxIWh
         M3qDowQ2KjwoLikzL0iuyxznrRZKbBO98906J5vIRqcvKSB40jUzNBpUgDjetwKdDylg
         twgfkSkTGlsVqsNXwdfypFO0cNg800a/0g0pnzrsB43jBq/jbcUxgVrJFyVEZbtnUEQ/
         Cgca0ZZ6TgnJk44muhQHp8DbFqunbGSJgqa+EinNXj+B5aLrmN8ksC4Qc3FcDRMj/t0q
         I8e9ebQODm8O2FNaNN5dlyh4Es2FZvvSWpujZpTkiGGFp58psGDZvGSwYH7jXmKN/+Xs
         ID5w==
X-Gm-Message-State: APjAAAU3E+FDGo7/Oq+zn/QUs4DjLFOw+M2cRambYGQWewnwuiECoAhi
        BraQ983NL7fhf7hfAzG5/suzBAJwLZelxW8DMnsj3w==
X-Google-Smtp-Source: APXvYqyCzXINahX1VlGhs9c/oK3Wfch2QJxcoiaKsuMM7YX+ttAe/oQtJzp/cCY4PXLL09MpDinhSocxbmrKB1E0hCI=
X-Received: by 2002:a65:4087:: with SMTP id t7mr21641518pgp.10.1562695908809;
 Tue, 09 Jul 2019 11:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de> <CACRpkdZO6to2UsJ64FCYi3aOC79PEb9pxOBABBkgcmR_d82dYg@mail.gmail.com>
 <20190709122550.nau44z32valjd5ir@shell.armlinux.org.uk>
In-Reply-To: <20190709122550.nau44z32valjd5ir@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jul 2019 11:11:37 -0700
Message-ID: <CAKwvOdnbVFQZNFaZs7Yh4C=OnR8k3CyrRc=NQEQqFvPL=Qo9Vg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 5:26 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jul 09, 2019 at 02:17:58PM +0200, Linus Walleij wrote:
> > On Mon, Jul 8, 2019 at 10:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > -#define xip_iprefetch()        do { asm volatile (".rep 8; nop; .endr"); } while (0)
> > > +#define xip_iprefetch()        do {                                            \
> > > +        asm volatile ("nop; nop; nop; nop; nop; nop; nop; nop;");      \
> > > +} while (0)                                                            \
> >
> > This is certainly an OK fix since we use a row of inline nop at
> > other places.
> >
> > However after Russell explained the other nops I didn't understand I located
> > these in boot/compressed/head.S as this in __start:
> >
> >                 .rept   7
> >                 __nop
> >                 .endr
> > #ifndef CONFIG_THUMB2_KERNEL
> >                 mov     r0, r0
> > #else
> >
> > And certainly this gets compiled, right?
> >
> > So does .rept/.endr work better than .rep/.endr, is it simply mis-spelled?
> >
> > I.e. s/.rep/.rept/g
> > ?
> >
> > In that case we should explain in the commit that .rep doesn't work
> > but .rept does.
>
> According to the info pages for gas:
>
> 7.96 `.rept COUNT'
> ==================
>
> Repeat the sequence of lines between the `.rept' directive and the next
> `.endr' directive COUNT times.
>
> So yes, ".rep" is mis-spelled, and it brings up the obvious question:
> why isn't gas issuing an error for ".rep"?  There is no mention of
> ".rep" in the manual.

I swear I had looked this up somewhere and found that GNU as and
clang's integrated assembler supported alternative spellings for
assembly directives.  Just checked the manual
https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.html#SEC116
and indeed no mention of the alternatives...must have been looking at
the source...
-- 
Thanks,
~Nick Desaulniers
