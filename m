Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02716C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9D420850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmvHUbjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEMXrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:47:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43161 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfEMXrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:47:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so20008942edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/sL33dE1k3b0W+fXhg7kN4jssHtknYRpY7S7fsd6x0M=;
        b=fmvHUbjqT1jE8kqLac2HGROZk7ZmL14Z+L5LXy03u5eq7OE8iFU1qHPh0m1PpoNhL/
         v6d98EdM4MG0sk/zvF+MaY0T6vgKBRLskupyv+ipTdgqoG3WdneKXAvC2BFFfjrqXuXC
         QaaafTS+VoMv0cqoSExLdHZPH8XvvkD4ELI5o4aj4wFrhEtM2avCEMO3txY6tL1cp5o3
         Kcq9U26j95iw2eudL/YQMypp+aEyIGi1HLZwreXQwCgaFAFp4k1s3fxDS1cNP8t+VWjD
         0j3gHTxkCqgWKJA7sCuVrOUapZfD/O3nTih3qiuNvM76GFQvzF8+DmecZoQFstVEm8xv
         PCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/sL33dE1k3b0W+fXhg7kN4jssHtknYRpY7S7fsd6x0M=;
        b=QFMhuZWYd2kBFgnY4y5VLPlcsMhHGMHDgl2x+x2F63BaR/artoGcCA7pEhoGk5N/b4
         5SS+99dlkpmgosGp/f5mKPlIdH0P7ZfD9mG474SBjh07FnfFsfR1/Az55eMpxPu0DLB/
         Kt3HE+idcoHDRuPAzAfm5SwHNljQ0XaIR2u72ZdccM7XSnl5N9Y9H3sYzZ1mN8AV6mtC
         zVA+DIOR1pyM2FdoSOGN4wu7Y56Nys9tfyI4YYXVYHq1px/n4sN0/lwBaEDXeH0w5gOI
         kWgEsYxVgUXLx8LkqjcnWDJW2M6PFwd61QRvWAPoomwdgfW+gEq5AWxBpl8g4VMA9XVZ
         q3Aw==
X-Gm-Message-State: APjAAAX7v5ScWTwOYr1tACjzoJwBj9bwazYu3BWakHt77v7RuksppHgj
        tOEMfYXZ3uTO2UfQpk/3r18=
X-Google-Smtp-Source: APXvYqxIiMBaAPEMj9aUgmDh3cBWLk82172zwDxE0yjC4yUw9xyhBpOVg2GEdSLChvDUaYn62irRFA==
X-Received: by 2002:a17:906:1146:: with SMTP id i6mr24533931eja.21.1557791240562;
        Mon, 13 May 2019 16:47:20 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id z10sm4097205edl.35.2019.05.13.16.47.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 16:47:19 -0700 (PDT)
Date:   Mon, 13 May 2019 16:47:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jordan Rupprecht <rupprecht@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, keescook@chromium.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathanchance@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
Message-ID: <20190513234717.GA1170@archlinux-i9>
References: <20190513222109.110020-1-ndesaulniers@google.com>
 <20190513232910.GA30209@archlinux-i9>
 <CABC7LbRp0EQUDuQP5oJN2a1iyHYAk34D6386eHomYgacwovuNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABC7LbRp0EQUDuQP5oJN2a1iyHYAk34D6386eHomYgacwovuNQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 04:38:54PM -0700, Jordan Rupprecht wrote:
> Nathan: is your version of llvm-objcopy later than r359639 (April 30)?
> 
> 
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Mon, May 13, 2019 at 4:29 PM
> To: Nick Desaulniers
> Cc: <keescook@chromium.org>, <clang-built-linux@googlegroups.com>,
> Nathan Chancellor, Jordan Rupprect, Arnd Bergmann, Greg Kroah-Hartman,
> <linux-kernel@vger.kernel.org>
> 
> > On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > > --rename-section=.text=.rodata
> > >
> > > Rather than support setting flags then renaming sections vs renaming
> > > then setting flags, it's simpler to just change both at the same time
> > > via --rename-section.
> > >
> > > This can be verified with:
> > > $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> > > ...
> > > Section Headers:
> > >   [Nr] Name              Type             Address           Offset
> > >        Size              EntSize          Flags  Link  Info  Align
> > > ...
> > >   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> > >        0000000000000004  0000000000000000   A       0     0     4
> > > ...
> > >
> > > Which shows in the Flags field that .text is now renamed .rodata, the
> > > append flag A is set, and the section is not flagged as writeable W.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/448
> > > Reported-by: Nathan Chancellor <nathanchance@gmail.com>
> >
> > This should be natechancellor@gmail.com (although I think I do own that
> > email, just haven't been into it for 10+ years...)
> >
> > > Suggested-by: Jordan Rupprect <rupprecht@google.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  drivers/misc/lkdtm/Makefile | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> > > index 951c984de61a..89dee2a9d88c 100644
> > > --- a/drivers/misc/lkdtm/Makefile
> > > +++ b/drivers/misc/lkdtm/Makefile
> > > @@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o    := n
> > >
> > >  OBJCOPYFLAGS :=
> > >  OBJCOPYFLAGS_rodata_objcopy.o        := \
> > > -                     --set-section-flags .text=alloc,readonly \
> > > -                     --rename-section .text=.rodata
> > > +                     --rename-section .text=.rodata,alloc,readonly
> > >  targets += rodata.o rodata_objcopy.o
> > >  $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
> > >       $(call if_changed,objcopy)
> > > --
> > > 2.21.0.1020.gf2820cf01a-goog
> > >
> >
> > I ran this script to see if there was any change for GNU objcopy and it
> > looks like .rodata's type gets changed, is this intentional? Otherwise,
> > this works for llvm-objcopy like you show.
> >
> > -----------
> >
> > 1c1
> > < There are 11 section headers, starting at offset 0x240:
> > ---
> > > There are 11 section headers, starting at offset 0x230:
> > 8c8
> > <   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> > ---
> > >   [ 1] .rodata           NOBITS           0000000000000000  00000040
> > 10c10
> >
> > -----------
> >
> > #!/bin/bash
> >
> > TMP1=$(mktemp)
> > TMP2=$(mktemp)
> >
> > git checkout next-20190513
> >
> > make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
> > readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP1}
> >
> > curl -LSs https://lore.kernel.org/lkml/20190513222109.110020-1-ndesaulniers@google.com/raw | git am -3
> >
> > make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
> > readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP2}
> >
> > diff ${TMP1} ${TMP2}

Hi Jordan,

Yes but that output was purely with GNU objcopy (checking section
headers before and after this patch). This is the section header
for llvm-objcopy after this patch:

  [ 1] .rodata           PROGBITS         0000000000000000  00000040
         0000000000000004  0000000000000000   A       0     0     4

Cheers,
Nathan
